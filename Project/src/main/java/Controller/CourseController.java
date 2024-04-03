package Controller;

import java.io.IOException;
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
import VO.CoursesVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j

@WebServlet("/Courses/*")
public class CourseController extends HttpServlet {
	
	private CourseService courseService;
	
	@Override
	public void init() throws ServletException {
		courseService = new CourseService();
		log.debug("courseService : {}",courseService);
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
		String nextPage = null;
		String action = request.getPathInfo();
		log.debug("action = {}",action);
		if(action.equals("/main")) {
			nextPage=main;
		}else if(action.equals("/backend")) {
			// 서비스에 비즈니스 로직 요청
			List<CoursesVO> list = courseService.getCourseList(request);
			request.setAttribute("list", list);
			request.setAttribute("center", "moving.jsp");
			nextPage=main;
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
	
	
	
	
	
}
