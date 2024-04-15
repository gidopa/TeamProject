package DAO;

import java.io.File;
import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.sql.DataSource;

import org.apache.commons.fileupload.FileItem;
import org.apache.commons.fileupload.disk.DiskFileItemFactory;
import org.apache.commons.fileupload.servlet.ServletFileUpload;

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
			log.error("getCourseList Error : {}", e);
		} finally {
			resourceRelease();
		}
		return list;
	}

	// 강의 상세페이지 뿌려주기위해 조회
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
			log.error("getDetail Error : {}", e);
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
			String sql = "select * from courses inner join enrollments on enrollments.course_id = courses.course_id where enrollments.student_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
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
			log.error("getCoursePurchased error : {}", e);
		} finally {
			resourceRelease();
		}
		return list;
	}

// 강의 등록하면서 입력한 내용들로 DB에 insert
	public CourseVO registration(String userId, int coursePrice, String courseCategory, String courseTitle,
			String courseDescription, String imgPath) {
		String sql;
		try {
			con = dataSource.getConnection();
			sql = "insert into courses(course_id," + "user_id," + "COURSE_PRICE," + "COURSE_CATEGORY," + "COURSE_TITLE,"
					+ "COURSE_DESCRIPTION," + "IMG_PATH," + "REGISTRATION_DATE," + "ENROLLMENT_COUNT)"
					+ " values(Courses_course_id.nextVal,?,?,?,?,?,?,sysdate,0)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, coursePrice);
			pstmt.setString(3, courseCategory);
			pstmt.setString(4, courseTitle);
			pstmt.setString(5, courseDescription);
			pstmt.setString(6, imgPath);
			pstmt.executeUpdate();
			sql = "select * from courses where user_id=? and course_title=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setString(2, courseTitle);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				courseVO = new CourseVO();
				courseVO.setCourseId(rs.getInt("course_id"));
				courseVO.setCourseCategory(rs.getString("course_category"));
				courseVO.setCourseTitle(rs.getString("course_title"));
			}
		} catch (Exception e) {
			log.error("CourseDAO의 registration error : {}", e);
			e.printStackTrace();
		} finally {
			resourceRelease();
		}
		return courseVO;
	}

// 로그인한 id로 어떤 course를 등록했는지 조회
	public List<CourseVO> getCourseListById(String id) {
		List<CourseVO> list = new ArrayList<CourseVO>();
		CourseVO vo = null;
		try {
			con = dataSource.getConnection();
			String sql = "select * from courses where user_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo = new CourseVO();
				vo.setCourseCategory(rs.getString("course_category"));
				vo.setCourseId(rs.getInt("course_id"));
				vo.setCourseTitle(rs.getString("course_title"));
				vo.setEnrollCount(rs.getInt("enrollment_count"));
				list.add(vo);
			}
		} catch (Exception e) {
			log.debug("getCourseListById error : {}", e);
		} finally {
			resourceRelease();
		}

		return list;
	}

	public String getInstructorNameById(String id) {
		String name = null;
		try {
			con = dataSource.getConnection();
			String sql = "SELECT U.user_name " + "FROM Enrollments E " + "JOIN Courses C ON E.course_id = C.course_id "
					+ "JOIN Users U ON C.user_id = U.user_id " + "WHERE E.student_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				name = rs.getString("user_name");
			}
		} catch (Exception e) {
			log.error("getNameById error : {}", e);
		} finally {
			resourceRelease();
		}

		return name;
	}

	public CourseVO getTitleAndCategory(int courseId) {
		CourseVO vo = new CourseVO();
		try {
			con = dataSource.getConnection();
			String sql = "select * from courses where course_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, courseId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo.setCourseCategory(rs.getString("course_category"));
				vo.setCourseTitle(rs.getString("course_title"));
			}
		} catch (Exception e) {
			log.error("getTitleAndCategory error : {}", e);
		} finally {
			resourceRelease();
		}
		return vo;
	}
}
