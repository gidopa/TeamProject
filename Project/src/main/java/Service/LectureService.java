package Service;

import java.util.ArrayList;
import java.util.List;

import DAO.CourseDAO;
import DAO.LectureDAO;
import VO.LectureVO;

public class LectureService {

	private LectureDAO lectureDAO;

	public LectureService() {
		lectureDAO = new LectureDAO();
	}

	public List<LectureVO> getLectureInfo(int courseId) {
		List<LectureVO> lectureList = new ArrayList<>();
		lectureList = lectureDAO.getLecturesInfo(courseId);
		return lectureList;
	}
	
	
	
	
}
