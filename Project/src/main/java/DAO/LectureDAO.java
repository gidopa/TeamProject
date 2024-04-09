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
import VO.LectureVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LectureDAO {

	private Connection con;
	private PreparedStatement pstmt;
	private ResultSet rs;
	private DataSource dataSource;
	private CourseVO courseVO = null;
	private LectureVO lectureVO = null;
	public LectureDAO() {
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
	// DB의 강좌 하나하나의 정보들을 list로 받아옴
	public List<LectureVO> getLecturesInfo(int courseId) {
		List<LectureVO> lectureList = new ArrayList<LectureVO>();
		try {
		con = dataSource.getConnection();
		String sql = "select * from lectures where course_Id = ?";
		pstmt = con.prepareStatement(sql); 
		pstmt.setInt(1, courseId);
		rs = pstmt.executeQuery();
		while(rs.next()) {
			lectureVO = new LectureVO();
			lectureVO.setCourseId(courseId);
			lectureVO.setDuration(rs.getString("duration"));
			lectureVO.setLectureId(rs.getInt("lecture_id"));
			lectureVO.setLectureNumber(rs.getInt("lecture_number"));
			lectureVO.setLectureTitle(rs.getString("lecture_title"));
			lectureVO.setLectureSummary(rs.getString("lecture_summary"));
			lectureVO.setVideoLink(rs.getString("video_link"));
			lectureVO.setImgPath(rs.getString("img_path"));
			lectureList.add(lectureVO);
		}
		}catch (Exception e) {
			log.error("getLecturesInfo error : {}",e);
		}finally{
			resourceRelease();
		}
		return lectureList;
	}
// DB의 강의의 videoLink를 받아옴
	public String getVideoLink(int courseId, int lectureId) {
		String videoLink = null;
		try {
			con = dataSource.getConnection();
			String sql = "select video_link from lectures where course_Id = ? and lecture_id= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, courseId);
			pstmt.setInt(2, lectureId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				videoLink = rs.getString("video_link");
			}
		}catch(Exception e) {
			log.error("getVideoLink error : {}", e);
		}finally {
			resourceRelease();
		}
		return videoLink;
	}
	// DB에서 courseId와 lectureId 로 특정 강의에 대한 정보만 가져오는 메소드 
	public LectureVO getLectureInfo(int courseId, int lectureId) {
		LectureVO lectureInfo = new LectureVO();
		try {
			con = dataSource.getConnection();
			String sql = "select * from lectures where course_Id = ? and lecture_id= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, courseId);
			pstmt.setInt(2, lectureId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lectureInfo.setLectureNumber(rs.getInt("lecture_number"));
				lectureInfo.setLectureTitle(rs.getString("lecture_title"));
				lectureInfo.setLectureSummary(rs.getString("lecture_summary"));
				lectureInfo.setCourseId(rs.getInt("course_id"));
			}
		}catch(Exception e) {
			log.error("getLectureInfo 하나만 찾는 메소드 error : {}", e);
		}finally {
			resourceRelease();
		}
		return lectureInfo;
	}

	public List<LectureVO> registration(int courseID, int lectureNumber, String duration, String lectureTitle, String lectureSummary,
			String videoLink, String imgpath) {
	String sql=null;    
	List<LectureVO> lectureList = new ArrayList<LectureVO>();	
	try {
		con = dataSource.getConnection();
		sql="insert into lectures(lecture_id,"
		 			+ "course_id,"
					+ "lecture_number,"
					+ "lecture_title,"
					+ "lecture_summary," 
					+ "video_link,"
					+ "duration,"
					+ "img_path)"
					+ " values(Lectures_lecture_id.nextVal,?,?,?,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
			pstmt.setInt(1 ,courseID);
			pstmt.setInt(2,lectureNumber);
			pstmt.setString(3,lectureTitle);
			pstmt.setString(4,lectureSummary);
			pstmt.setString(5,videoLink);
			pstmt.setString(6,duration);
			pstmt.setString(7,imgpath);
		 pstmt.executeUpdate();
			
	    sql = "select * from lectures where course_id=?";
		    pstmt = con.prepareStatement(sql);
		    pstmt.setInt(1, courseID);
		    	rs = pstmt.executeQuery();
		    	while(rs.next()) {
					lectureVO = new LectureVO();
					lectureVO.setCourseId(courseID);
					lectureVO.setDuration(rs.getString("duration"));
					lectureVO.setLectureId(rs.getInt("lecture_id"));
					lectureVO.setLectureNumber(rs.getInt("lecture_number"));
					lectureVO.setLectureTitle(rs.getString("lecture_title"));
					lectureVO.setLectureSummary(rs.getString("lecture_summary"));
					lectureVO.setVideoLink(rs.getString("video_link"));
					lectureVO.setImgPath(rs.getString("img_path"));
					lectureList.add(lectureVO);
				}
			
			
		}catch (Exception e) {
			log.error("LectureDAO의 registration error : {}",e);
			e.printStackTrace();
		}finally {
			resourceRelease();
		}
	return lectureList;
}
	
	
	

}
