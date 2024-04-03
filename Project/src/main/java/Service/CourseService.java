package Service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;

import DAO.CourseDAO;
import VO.CoursesVO;

public class CourseService {
	
	private CourseDAO courseDAO;
	
	public CourseService() {
		courseDAO = new CourseDAO();
	}
	
	
	// request에서 쿼라파라미터 추출 후 DAO에 DB작업 요청
	public List<CoursesVO> getCourseList(HttpServletRequest request) {
		List<CoursesVO> list = new ArrayList<>();
		// category가 1-백엔드 , 2- 프론트엔드, 3-AI 
		String category = request.getParameter("category");
		list = courseDAO.getCourseList(category);
		return list;
	}
	
}
