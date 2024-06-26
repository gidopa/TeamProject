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
// 강사의 
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
// 강좌의 카테고리, 제목을 얻음
	public CourseVO getTitleAndCategory(int courseId) {
		CourseVO vo = new CourseVO();
		try {
			con = dataSource.getConnection();
			String sql = "select * from courses where course_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, courseId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
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
// 강좌 조회
	public List<CourseVO> modifyCourseList(String userId) {
		List<CourseVO> list = new ArrayList<CourseVO>();

		String sql = "";

		try {
			sql = "select * from courses where user_id=?";

			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
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
			log.error("CourseDAO의 modifyCourseList error : {}", e);
			e.printStackTrace();
		} finally {
			resourceRelease();
		}

		return list;
	}
// ?
	public CourseVO modifyCourse(String userId, int courseId) {

		String sql = "";

		try {
			sql = "select course_id, course_title, course_description, course_category, course_price, img_path "
					+ "from courses where user_id=? and course_id=?";

			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userId);
			pstmt.setInt(2, courseId);
			rs = pstmt.executeQuery();
			if (rs.next()) {
				courseVO = new CourseVO();
				courseVO.setCourseId(rs.getInt("course_id"));
				courseVO.setCourseTitle(rs.getString("course_title"));
				courseVO.setCourseDescription(rs.getString("course_description"));
				courseVO.setCoursePrice(rs.getInt("course_price"));
				courseVO.setCourseCategory(rs.getString("course_category"));
				courseVO.setImgPath(rs.getString("img_path"));
			}

		} catch (Exception e) {
			log.error("CourseDAO의 modifyCourse error : {}", e);
			e.printStackTrace();
		} finally {
			resourceRelease();
		}

		return courseVO;
	}
// 강좌 수정
	public int reqModCourse(int courseId, String courseTitle, String courseDescription, String imgPath,
			int coursePrice) {
		String sql = "";
		int update = 0;
		try {
			sql = "update courses set course_title = ?, " + "course_description = ?, " + "img_path = ?, "
					+ "course_price = ?" + "where course_id = ?";
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);

			pstmt.setString(1, courseTitle);
			pstmt.setString(2, courseDescription);
			pstmt.setString(3, imgPath);
			pstmt.setInt(4, coursePrice);
			pstmt.setInt(5, courseId);

			update = pstmt.executeUpdate();

		} catch (Exception e) {
			log.error("CourseDAO의 reqModCourse error : {}", e);
			e.printStackTrace();
		} finally {
			resourceRelease();
		}

		return update;
	}
// 강좌 삭제
	public int delCourse(int courseId) {
		String sql = "";
		int update = 0;
		try {
			sql = "delete from courses where " + "course_id = ?";
			con = dataSource.getConnection();
			pstmt = con.prepareStatement(sql);

//			pstmt.setString(1, userId);
			pstmt.setInt(1, courseId);

			update = pstmt.executeUpdate();

		} catch (Exception e) {
			log.error("CourseDAO의 delCourse error : {}", e);
			e.printStackTrace();
		} finally {
			resourceRelease();
		}
		return update;
	}
// 등록한 강의 조회
	public List<CourseVO> getEnrollCoursesListById(String id) { // 여기부터 자기가 등록한 강의를 조회할 수 있도록 join 해서 가져와야함
		List<CourseVO> list = new ArrayList<CourseVO>();
		CourseVO vo = null;
		try {
			con = dataSource.getConnection();
			String sql = "select * from enrollments inner join courses on enrollments.course_id = courses.course_id where student_id = ?";
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

	// 강의 등록을 할때 강의제목열의 값이 DB에 중복되어있을경우 유효성검사
	public boolean coursesTitleCheck(String courseTitle) {
		boolean result = false;
		try {
			con = dataSource.getConnection();
			String sql = "select  decode(count(*), 1, 'true', 'false') as result from courses where COURSE_TITLE=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, courseTitle);
			rs = pstmt.executeQuery();
			rs.next();
			String value = rs.getString("result");
			result = Boolean.parseBoolean(value);
		} catch (Exception e) {
			log.debug("coursesTitleCheck error : {}", e);
		} finally {
			resourceRelease();
		}
		return result;
	}
// 로드맵에 저장되어 있는 강좌 중 이미 구매한 강좌들
	public List<CourseVO> getCourseListInRoadMap(String id) {
		List<CourseVO> list = new ArrayList<CourseVO>();
		try {
			con = dataSource.getConnection();
			String sql = "SELECT c.*, c.course_id AS ccid FROM courses c JOIN enrollments e ON e.roadmap_id = c.roadmap_id AND e.student_id = ? "
					+ "LEFT JOIN enrollments ec ON ec.course_id = c.course_id AND ec.student_id = ? WHERE ec.course_id IS NULL";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);
			pstmt.setString(2, id);
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
			log.error("getCourseListInRoadMap error : {}", e);
		} finally {
			resourceRelease();
		}
		return list;
	}
// 로드맵의 강의중 이미 구매한 강의를 제외한 나머지의 가격을 추출하기 위한 메소드
	public List<CourseVO> getCourseListToPurchase(int roadMapId, String user_id) {
		List<CourseVO> list = new ArrayList<CourseVO>();
		try {
			con = dataSource.getConnection();
			String sql = "SELECT * FROM Courses c WHERE c.roadmap_id = ? AND NOT EXISTS ( SELECT 1 FROM Enrollments e WHERE e.student_id = ? AND (e.course_id = c.course_id or e.roadmap_id = c.roadmap_id))";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, roadMapId);
			pstmt.setString(2, user_id);
			rs = pstmt.executeQuery();
			while(rs.next()) {
				courseVO = new CourseVO();
				courseVO.setCoursePrice(rs.getInt("course_price"));
				list.add(courseVO);
			}
		} catch (Exception e) {
			log.error("getCourseListToPurchase error : {}", e);
		} finally {
			resourceRelease();
		}
		return list;
	}
}
