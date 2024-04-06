package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.List;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import VO.CourseVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CourseDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource dataSource;
	private CourseVO courseVO = null;
	public CourseDAO() {
		try {
			Context ctx = new InitialContext();
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			dataSource = (DataSource) envContext.lookup("jdbc/oracle");
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	public void resourceRelease() {

		try {
			if (rs != null) {
				rs.close();
			}
			if (con != null) {
				con.close();
			}
			if (pstmt != null) {
				pstmt.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}

	}
//DB 작업 카테고리별 강의 조회
	public List<CourseVO> getCourseList(String category) {
		List<CourseVO> list = new ArrayList<>();
		
		try {
			con = dataSource.getConnection();
			String sql = "select * from courses where course_category = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, category);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				courseVO = new CourseVO();
				courseVO.setCourseId(rs.getInt("course_id"));
				courseVO.setCourseTitle(rs.getString("course_title"));
				courseVO.setCourseDescription(rs.getString("course_description"));
				courseVO.setUserId(rs.getString("user_id"));
				courseVO.setCoursePrice(rs.getInt("course_price"));
				courseVO.setRegistrtionDate(rs.getDate("registration_date"));
				courseVO.setEnrollCount(rs.getInt("enrollment_count"));
				courseVO.setCourseCategory(rs.getString("course_category"));
				courseVO.setImgPath(rs.getString("img_path"));
				list.add(courseVO);
			}
		} catch (Exception e) {
			log.error("getCourseList Error : {}",e);
		} finally { 
			resourceRelease();
		}
		return list;
	}

	//강의 상세페이지 뿌려주기위해 조회 
	public CourseVO getDetail(int courseId) {
				try {
					con = dataSource.getConnection();
					String sql = "select * from courses where course_Id = ?";
					pstmt = con.prepareStatement(sql);
					pstmt.setInt(1, courseId);
					rs = pstmt.executeQuery();
					if (rs.next()) {
						courseVO = new CourseVO();
						courseVO.setCourseId(rs.getInt("course_id"));
						courseVO.setCourseTitle(rs.getString("course_title"));
						courseVO.setCourseDescription(rs.getString("course_description"));
						courseVO.setUserId(rs.getString("user_id"));
						courseVO.setCoursePrice(rs.getInt("course_price"));
						courseVO.setRegistrtionDate(rs.getDate("registration_date"));
						courseVO.setEnrollCount(rs.getInt("enrollment_count"));
						courseVO.setCourseCategory(rs.getString("course_category"));
						courseVO.setImgPath(rs.getString("img_path"));
					}
				} catch (Exception e) {
					log.error("getDetail Error : {}",e);
				} finally { 
					resourceRelease();
				}
		return courseVO;
	}

	// 로그인한 id를 매개변수로 받아서 구매한 강의 정보 받아오는 메소드
	public List<CourseVO> getCoursePurchased(String id) {
		List<CourseVO> list = new ArrayList<>();
		try {
		con = dataSource.getConnection();
		String sql = "select * from courses where user_id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setString(1, id);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			courseVO = new CourseVO();
			courseVO.setCourseId(rs.getInt("course_id"));
			courseVO.setCourseTitle(rs.getString("course_title"));
			courseVO.setCourseDescription(rs.getString("course_description"));
			courseVO.setUserId(rs.getString("user_id"));
			courseVO.setCoursePrice(rs.getInt("course_price"));
			courseVO.setRegistrtionDate(rs.getDate("registration_date"));
			courseVO.setEnrollCount(rs.getInt("enrollment_count"));
			courseVO.setCourseCategory(rs.getString("course_category"));
			courseVO.setImgPath(rs.getString("img_path")); 
			list.add(courseVO);
		}
		}catch (Exception e) {
			log.error("getCoursePurchased error : {}",e);
		}finally {
			resourceRelease();
		}
		return list;
	}
		
	

	
	
	

}
