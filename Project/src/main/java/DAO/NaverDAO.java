package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import VO.NaverLoginVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class NaverDAO {
	
	private Connection con;	
	private PreparedStatement pstmt;	
	private ResultSet rs;
	private DataSource dataSource;
	
	
	public NaverDAO() {
	
		try {
			Context ctx = new InitialContext();
			
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			
			dataSource = (DataSource) envContext.lookup("jdbc/oracle");
			
		} catch (Exception e) {
			System.out.println("DataSouce커넥션풀 객체 얻기 실패  : " + e);
		}
	
	}// PantsDao()
	
	// 카카오 아이디 있을 시, DB 등록 후 자동 로그인
	public NaverLoginVO NaverLogin(NaverLoginVO naverUserVo) {
		
		String sql = null;
		NaverLoginVO naverUserVo1 = null;
		
		try {
			con = dataSource.getConnection();
			
					//NULL 허용 비허용 문제로 비밀번호, 주소, 관리자 값 강제로 집어넣어야 하는 문제
			sql = "INSERT INTO tbl_member VALUES(?, '1234', ?, ?, ?, sysdate, ?, '쌍문동', sysdate, '2')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, naverUserVo.getId());
			pstmt.setString(2, naverUserVo.getName());
			pstmt.setString(3, naverUserVo.getEmail());
			pstmt.setString(4, naverUserVo.getMobile());
			
			
			
			
			pstmt.executeUpdate();
			
			sql = "select * from tbl_member where m_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, naverUserVo.getId());
			rs = pstmt.executeQuery();
			
			if(rs.next()) {
				naverUserVo1 = new NaverLoginVO();
				naverUserVo1.setId(rs.getString("m_id"));
				naverUserVo1.setEmail(rs.getString("m_email"));
			}
			
		} catch (Exception e) {
			System.out.println("NaverDao / NaverLogin : " + e);
			e.printStackTrace();
		}finally {
			ResourceClose();
		}
		
		return naverUserVo1;
	}// kakaoLogin()
	

	// id 값이 테이블에 존재하는지 여부 확인
	public NaverLoginVO checkId(String id) {
		
		log.debug("DAO checkId(id) : {}", id);
		
		NaverLoginVO naverUserVo1 = new NaverLoginVO();
		
		String sql = null;
		
		try {
			con = dataSource.getConnection();
			
			sql = "select * from users where user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			
			rs = pstmt.executeQuery();
			if(rs.next()) {
				naverUserVo1.setId(rs.getString("user_id"));
			}
		} catch (Exception e) {
			System.out.println("NaverDao / checkId : " + e);
			e.printStackTrace();
		}finally {
			ResourceClose();
		}
		return naverUserVo1;
		
	}//checkId()
	
	
	//DB작업관련 객체 메모리들 자원해제 하는 메소드 
	public void ResourceClose() {	
		try {
			if(pstmt != null) {
				pstmt.close();
			}
			if(rs != null) {
				rs.close();
			}
			if(con != null) {
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}// ResourceClose()

	



}	
	