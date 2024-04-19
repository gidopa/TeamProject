package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import VO.KakaoLoginVO;

public class KakaoLoginDAO {
	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource dataSource;

	public KakaoLoginDAO() {

		try {
			Context ctx = new InitialContext();

			Context envContext = (Context) ctx.lookup("java:/comp/env");

			dataSource = (DataSource) envContext.lookup("jdbc/oracle");

		} catch (Exception e) {
			System.out.println("DataSouce커넥션풀 객체 얻기 실패  : " + e);
		}

	}

	// DB작업관련 객체 메모리들 자원해제 하는 메소드
	public void ResourceClose() {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (rs != null) {
				rs.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	public int checkId(long userId) {
		int resultInt = 0;
		String sql = null;
		
		try {
			con = dataSource.getConnection();
			
			sql = "select * from users where user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, String.valueOf(userId));
			
			rs = pstmt.executeQuery();
			
			while(rs.next()) {
				resultInt++;
			}
			
			
		} catch (Exception e) {
			System.out.println("KakaoLoginDAO / checkId : " + e);
			e.printStackTrace();
		}finally {
			ResourceClose();
		}
		return resultInt;
	}

	public KakaoLoginVO kakaoLogin(KakaoLoginVO kakaoLoginVO) {
		String sql = null;
		KakaoLoginVO kakaoLoginVO1 = null;
		String m_id = String.valueOf(kakaoLoginVO.getUserId());

		try {
			con = dataSource.getConnection();

			sql = "INSERT INTO users (user_id, user_name, email, password, phone_number, address) values(?,?,?,' ',?,' ')";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);
			pstmt.setString(2, kakaoLoginVO.getName());
			pstmt.setString(3, kakaoLoginVO.getEmail());
			pstmt.setString(4, kakaoLoginVO.getPhoneNumber());
//			pstmt.setString(5, kakaoLoginVO.getAddress());
			

			pstmt.executeUpdate();

			sql = "select * from users where user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, m_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {
				kakaoLoginVO1 = new KakaoLoginVO();
				kakaoLoginVO1.setUserId(rs.getLong("user_id"));
//				kakaoLoginVO1.setNickname(rs.getString("m_name"));
				kakaoLoginVO1.setEmail(rs.getString("email"));
			}

		} catch (Exception e) {
			System.out.println("KakaoLoginDAO / kakaoLogin : " + e);
			e.printStackTrace();
		} finally {
			ResourceClose();
		}

		return kakaoLoginVO1;
	}

}
