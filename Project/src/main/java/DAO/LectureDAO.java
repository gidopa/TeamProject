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
	public LectureVO getLectureInfo( int lectureId) {
		LectureVO lectureInfo = new LectureVO();
		try {
			con = dataSource.getConnection();
			String sql = "select * from lectures where  lecture_id= ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, lectureId);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				lectureInfo.setCourseId(rs.getInt("course_id"));
				lectureInfo.setLectureId(lectureId);
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

	public List<LectureVO> registration(int courseId, int lectureNumber, String duration, String lectureTitle, String lectureSummary,
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
					+ " values(lectures_lecture_id.nextval,?,?,?,?,?,?,?)";
		pstmt = con.prepareStatement(sql);
			pstmt.setInt(1 ,courseId);
			pstmt.setInt(2,lectureNumber);
			pstmt.setString(3,lectureTitle);
			pstmt.setString(4,lectureSummary);
			pstmt.setString(5,videoLink);
			pstmt.setString(6,duration);
			pstmt.setString(7,imgpath);
		     pstmt.executeUpdate();
			
	    sql = "select * from lectures where course_id=?";
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
			log.error("LectureDAO의 registration error : {}",e);
			e.printStackTrace();
		}finally {
			resourceRelease();
		}
	return lectureList;
}
	// 강의 수정하는 로직 
	public List<LectureVO> modifyLecture(int lectureId, int lectureNumber, String lectureTitle, String lectureSummary,
			String imgPath, String videoLink, int courseId) {
		int res = 0;
		List<LectureVO> lectureList = new ArrayList<LectureVO>();	
		try {
			//강의 DB에 update하고
			con = dataSource.getConnection();
			String sql="update lectures set lecture_number = ? , lecture_title = ?, lecture_Summary = ?, img_path=?, video_link=?"
					+ " where lecture_id = ?";
			pstmt = con.prepareStatement(sql);
			pstmt.setInt(1, lectureNumber);
			pstmt.setString(2, lectureTitle);
			pstmt.setString(3, lectureSummary);
			pstmt.setString(4, imgPath);
			pstmt.setString(5, videoLink);
			pstmt.setInt(6, lectureId);
			pstmt.executeUpdate();
			// 수정된 정보를 다시 뿌려주기 위해 강의 정보 전체 가져옴
			 sql = "select * from lectures where course_id=?";
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
			log.debug("modifyLecture error : {}",e);
		}finally {
			resourceRelease();
		}
		return lectureList;
	}
// DB에서 강의 정보 삭제
	public void deleteLecture(int lectureId) {
		try {
		con = dataSource.getConnection();
		String sql="delete from lectures where lecture_id = ?";
		pstmt = con.prepareStatement(sql);
		pstmt.setInt(1, lectureId);
		pstmt.executeUpdate();
		}catch (Exception e) {
			log.debug("deleteLecture error : {}",e);
		}finally {
			resourceRelease();
		}
	}
	
	
	

}
