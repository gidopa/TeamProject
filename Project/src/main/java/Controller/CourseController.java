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
import Service.LectureService;
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
			// 회원이 구매한 강의들 조회
		}else if(action.equals("/lecture")) {
			String id = (String)session.getAttribute("id");
//			String id = "user01";
			List<CourseVO> list = new ArrayList<>(); 
			// 회원이 구매한 강의를 받아올 메소드
			list = courseService.getCoursePurchased(id);
			request.setAttribute("list", list);
			request.setAttribute("center", "SelectCourse.jsp");
			nextPage=main;
		}else if(action.equals("/myPage")) {
			String id = (String)session.getAttribute("id");
			System.out.println("현재 id" + id);
			LectureService lectureService = new LectureService();
//			String id = "user01";
			List<CourseVO> purchasedList = new ArrayList<>(); 
			// 회원이 구매한 강의를 받아올 메소드
			purchasedList = courseService.getCoursePurchased(id);
			// 회원이 구매한 강의의 강사 명을 select 해옴
			String name = courseService.getInstructorNameById(id);
			List<CourseVO> registeredList = new ArrayList<CourseVO>();
			// 회원이 등록한 강좌 리스트를 받아옴
			registeredList = lectureService.getCoursesListById(id);
			System.out.println(purchasedList.toString());
			request.setAttribute("purchasedList", purchasedList);
			request.setAttribute("registeredList", registeredList);
			request.setAttribute("name", name);
			nextPage = "/user/myPage.jsp";
		}else if(action.equals("/enroll")) {//강의등록하는 메뉴 클릭시 보여줄 화면
			request.setAttribute("center", "courseRegistration.jsp");
			nextPage=main;
		}else if(action.equals("/registration")){
			 //강의 등록 내용을 인서트할 메소드
			 CourseVO vo = courseService.registration(request,session);
			 request.setAttribute("center", "lectureRegistration.jsp");
			 request.setAttribute("vo",vo);
			 nextPage=main;
		}
		else { // getPathInfo 한 action 변수가 조건 아무것도 못타면 예외 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			throw new IllegalArgumentException("doHandle .Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
	
	
	
	
	
}
