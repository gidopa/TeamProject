package Service;

import java.util.ArrayList;
import java.util.List;

import org.slf4j.Logger;

import DAO.CourseDAO;
import DAO.LectureDAO;
import VO.LectureVO;
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
		videoLink = videoLink.replace("/watch?v=", "/embed/");
		log.debug("videoLink ={}",videoLink);
		return videoLink;
	}
	 //lectureId 로 특정 강의에 대한 정보만 가져오는 메소드 
	public LectureVO getLectureInfo(int courseId,int lectureId) {
		LectureVO lectureInfo = new LectureVO();
		lectureInfo = lectureDAO.getLectureInfo(courseId,lectureId);
		return lectureInfo;
	}
	
	
	
	
}
