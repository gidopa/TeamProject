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

import VO.CoursesVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class CourseDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource dataSource;

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
	public List<CoursesVO> getCourseList(int category) {
		List<CoursesVO> list = new ArrayList<>();
		CoursesVO vo = null;
		try {
			con = dataSource.getConnection();
			String sql = "select * from courses where category_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, category);
			rs = pstmt.executeQuery();
			while (rs.next()) {
				vo = new CoursesVO();
				vo.setCourseId(rs.getInt("course_id"));
				vo.setCourseTitle(rs.getString("course_title"));
				vo.setCourseDescription(rs.getString("course_description"));
				vo.setInstrtuctorId(rs.getInt("instructor_id"));
				vo.setCoursePrice(rs.getInt("course_price"));
				vo.setRegistrtionDate(rs.getDate("registration_date"));
				vo.setEnrollCount(rs.getInt("enrollment_count"));
				vo.setCategoryId(rs.getInt("category_id"));
				vo.setImgPath(rs.getString("img_path"));
				list.add(vo);
			}
		} catch (Exception e) {
			log.error("CourseDAO getCourseList Error : {}",e);
		} finally {
			resourceRelease();
		}
		return list;
	}

	
	
	

}
