package Service;

import java.util.ArrayList;
import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DAO.CourseDAO;
import VO.CourseVO;
import VO.LectureVO;

public class CourseService {
	
	private CourseDAO courseDAO;
	
	public CourseService() {
		courseDAO = new CourseDAO();
		
	} 
	
	
	// request에서 쿼라파라미터 추출 후 DAO에 DB작업 요청
	public List<CourseVO> getCourseList(HttpServletRequest request) {
		List<CourseVO> list = new ArrayList<>();
		// category가 1-백엔드 , 2- 프론트엔드, 3-AI 
		String category = request.getParameter("category");
		list = courseDAO.getCourseList(category);
		return list;
	}

	//상세페이지 뿌려주기 위해 강의데이터 조회 요청
	public CourseVO getDetail(HttpServletRequest request) {
		
		return courseDAO.getDetail(Integer.parseInt(request.getParameter("courseId")));
	}

// 로그인한 id를 매개변수로 받아서 구매한 강의 정보 받아오는 메소드
	public List<CourseVO> getCoursePurchased(String id) {
		List<CourseVO> list = new ArrayList<>();
		System.out.println(id);
		list = courseDAO.getCoursePurchased(id);
		return list;
	}


	public LectureVO getLectureInfo(String courseId) {
		
		return null;
	}
	
	public CourseVO registration(HttpServletRequest request, HttpSession session) {
		String userId = (String)session.getAttribute("id");
		int coursePrice =  Integer.parseInt(request.getParameter("price"));
		String courseCategory = request.getParameter("category");
		String courseTitle = request.getParameter("title");
		String courseDescription = request.getParameter("description");
		String imgPath = request.getParameter("img");
		
		return courseDAO.registration(userId,coursePrice,courseCategory,courseTitle,courseDescription,imgPath);
	}


	public String getInstructorNameById(String id) {
		return courseDAO.getInstructorNameById(id);
	}


	
}
