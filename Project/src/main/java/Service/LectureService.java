package Service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import org.slf4j.Logger;

import DAO.CourseDAO;
import DAO.LectureDAO;
import VO.CourseVO;
import VO.LectureVO;
import api.YoutubeAPI;
import lombok.extern.java.Log;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class LectureService {

	private LectureDAO lectureDAO;

	public LectureService() {
		lectureDAO = new LectureDAO();
	}
	// 강의 하나하나의 정보들을 받아오는 메소드
	public List<LectureVO> getLecturesInfo(int courseId) {
		List<LectureVO> lectureList = new ArrayList<>();
		lectureList = lectureDAO.getLecturesInfo(courseId); 
		return lectureList; 
	}

	public String getVideoLink(int courseId, int lectureId) { //video링크에 대한 추가 작업이 필요해 getLectureInfo에서 말고 따로 받아옴 
		String videoLink = lectureDAO.getVideoLink(courseId, lectureId);
		// 일반 youtube url을 비디오로 실행할 수 있는 url로 변경
		// embed responsively를 이용해 반응형 iframe 생성하고 유튜브 영상 주소를 외부에서 사용할 수 있는 주소로 변경
		videoLink = videoLink.replace("/watch?v=", "/embed/");
		log.debug("videoLink ={}",videoLink);
		return videoLink;
	}
	 //lectureId 로 특정 강의에 대한 정보만 가져오는 메소드 
	public LectureVO getLectureInfo(int lectureId) {
		LectureVO lectureInfo = new LectureVO();
		lectureInfo = lectureDAO.getLectureInfo(lectureId);
		return lectureInfo;
	}
	
	//강의 등록 후 상세 강의 내용을 인서트하는 메소드(1강,2강,3강,...) 
		public List<LectureVO> registration(HttpServletRequest request) {
				int courseId =  Integer.parseInt(request.getParameter("courseId"));
				int lectureNumber = Integer.parseInt(request.getParameter("lectureNumber"));
				String lectureTitle = request.getParameter("lectureTitle");
				String lectureSummary = request.getParameter("lectureSummary"); 
				String videoLink = request.getParameter("videoLink");
				String imgpath = request.getParameter("imgpath");
				YoutubeAPI youtube = new YoutubeAPI(videoLink);
				String videoId = youtube.getVideoId();
				String jsonData = youtube.getData(videoId);
				String unformattedDuration = youtube.getDuration(jsonData);
				String duration = youtube.formatDuration(unformattedDuration);
			
			return lectureDAO.registration(courseId,lectureNumber,duration,lectureTitle,lectureSummary,videoLink,imgpath);
		}
		// 강의 수정 하는 로직 
		public List<LectureVO> modifyLecture(HttpServletRequest request) {
			int courseId = Integer.parseInt(request.getParameter("courseId"));
			int lectureId = Integer.parseInt(request.getParameter("lectureId")) ;
			int lectureNumber = Integer.parseInt(request.getParameter("lectureNumber"));
			String lectureTitle = request.getParameter("lectureTitle");
			String lectureSummary = request.getParameter("lectureSummary");
			String imgPath = request.getParameter("imgPath");
			String videoLink = request.getParameter("videoLink");
			return lectureDAO.modifyLecture(lectureId,lectureNumber,lectureTitle, lectureSummary, imgPath, videoLink,courseId);
		}
		public void deleteLecture(HttpServletRequest request) {
			int lectureId = Integer.parseInt(request.getParameter("lectureId"));
			lectureDAO.deleteLecture(lectureId);
		} 
		// user_id가 id 인 회원이 등록한 강의를 조회 
		public List<CourseVO> getCoursesListById(String id) {
			CourseDAO courseDAO = new CourseDAO();
			return courseDAO.getCourseListById(id); // 여기부터
		}

	
	
	
	
}
