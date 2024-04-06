package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import DAO.CourseDAO;
import Service.CourseService;
import VO.CourseVO;
import VO.LectureVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/Courses/*")
public class CourseController extends HttpServlet {
	
	private CourseService courseService;
	
	@Override
	public void init() throws ServletException {
		courseService = new CourseService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override 
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		// 메인 페이지 경로
		String main = "/project1/main.jsp";
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		// 재요청할 VIEW 또는 서블릿 주소를 저장할 변수
		HttpSession session = request.getSession(); 
		LectureVO lecturesVO = null;
		String nextPage = null;
		String action = request.getPathInfo();
		log.debug("action = {}",action);
		if(action.equals("/main")) {
			nextPage=main;
		}else if(action.equals("/category")) {
			// 서비스에 비즈니스 로직 요청
			List<CourseVO> list = courseService.getCourseList(request);
			request.setAttribute("list", list);
			request.setAttribute("center", "moving.jsp");
			nextPage=main;
		}else if(action.equals("/detail")) {
			//상세페이지 보여주는 화면
			//강의 VO 받아오는 메소드
			CourseVO courseVO = courseService.getDetail(request);
			request.setAttribute("courseVO", courseVO);
			request.setAttribute("center", "CourseDetail.jsp");
			nextPage=main;
		}else if(action.equals("/lecture")) {
//			String id1 = (String)session.getAttribute("id");
			String id = "user01";
			List<CourseVO> list = new ArrayList<>(); 
			// 회원이 구매한 강의를 받아올 메소드
			list = courseService.getCoursePurchased(id);
			request.setAttribute("list", list);
			request.setAttribute("center", "SelectCourse.jsp");
			nextPage=main;
		}else if(action.equals("/lectures")) {
			
		
		}
		else { // getPathInfo 한 action 변수가 조건 아무것도 못타면 예외 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			throw new IllegalArgumentException("doHandle .Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
	
	
	
	
	
}
