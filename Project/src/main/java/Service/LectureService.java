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
	public List<LectureVO> getLectureInfo(int courseId) {
		List<LectureVO> lectureList = new ArrayList<>();
		lectureList = lectureDAO.getLecturesInfo(courseId);
		return lectureList;
	}

	public String getVideoLink(int courseId, int lectureId) {
		String videoLink = lectureDAO.getVideoLink(courseId, lectureId);
		// 일반 youtube url을 비디오로 실행할 수 있는 url로 변경
		videoLink = videoLink.replace("/watch?v=", "/embed/");
		log.debug("videoLink ={}",videoLink);
		return videoLink;
	}
	
	
	
	
}
