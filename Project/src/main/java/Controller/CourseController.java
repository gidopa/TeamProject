package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.HashSet;
import java.util.List;
import java.util.Set;

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
import Service.UsersService;
import VO.CourseVO;
import VO.LectureVO;
import VO.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/Courses/*")
public class CourseController extends HttpServlet {
	
	private CourseService courseService;
	private UsersService userService;
	
	@Override
	public void init() throws ServletException {
		courseService = new CourseService();
		userService = new UsersService();
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
			UsersVO userVO = userService.getUserInfo(request);
			request.setAttribute("courseVO", courseVO);
			request.setAttribute("userVO",userVO);
			request.setAttribute("center", "CourseDetail.jsp");
			nextPage=main;
			// 회원이 구매한 강의들 조회
		}else if(action.equals("/lecture")) {
			String id = (String)session.getAttribute("id");
//			String id = "user01";
			List<CourseVO> courselist = new ArrayList<>(); 
			List<CourseVO> courseListInRoadMap = new ArrayList<CourseVO>();
			// 로드맵중에서 이미 구매한 강좌를 제외한 강좌들의 정보가 있는 List
			courseListInRoadMap = courseService.getCourseListInRoadMap(id);
			log.debug("CourseListInRoadMap size : {}", courseListInRoadMap.size());
			for(CourseVO vo : courseListInRoadMap) {
				log.debug("courseListInRoadMap id : {}",vo.getCourseId()); 
			}
			// 회원이 구매한 강좌를 받아올 메소드
			courselist = courseService.getCoursePurchased(id);
			for(CourseVO vo : courselist) {
				log.debug("courselist id : {}",vo.getCourseId()); 
			}
			// 중복을 피하기 위해 HashSet에 List를 담은다음 다시 List로 반환
			Set<CourseVO> set = new HashSet<>(courselist);
			set.addAll(courseListInRoadMap); // 중복된 요소는 자동으로 제거됨
			List<CourseVO> list = new ArrayList<>(set);
			log.debug("list size : {}",list.size());
			for(CourseVO vo : list) {
				log.debug("강좌 id : {}",vo.getCourseId()); 
			}
					
			request.setAttribute("list", list);
			request.setAttribute("center", "SelectCourse.jsp");
			nextPage=main;
		}else if(action.equals("/myPage")) {
			String id = (String)session.getAttribute("id");
			System.out.println("현재 id" + id);
			LectureService lectureService = new LectureService();
//			String id = "user01";
			List<CourseVO> purchasedList = new ArrayList<>(); 
			// 회원이 구매한 강좌 리스트를 받아올 메소드
			purchasedList = courseService.getCoursePurchased(id);
			// 회원이 구매한 강좌의 강사 명을 select 해옴
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
		}else if(action.equals("/ModCoursesList")) {
			
			List<CourseVO> list = new ArrayList<>(); 
			list = courseService.modifyCourseList(request, session);
			request.setAttribute("list", list);
			nextPage="/project1/CourseModifyList.jsp";
		
			
			// 본 수정화면 띄워줌
		} else if(action.equals("/CourseMod")) {
			int courseId = Integer.parseInt(request.getParameter("courseId"));
			
			CourseVO courseVO = courseService.modifyCourse(request, session);
			request.setAttribute("center", "CourseModify.jsp");
			request.setAttribute("vo", courseVO);
			
			request.setAttribute("courseId", courseId);
//			System.out.println("CourseController에서 호출한 courseId : " + courseId);
			nextPage=main;
			
		} else if(action.equals("/ReqModCourse")) {
			int update = courseService.reqModCourse(request);
			
			System.out.println("update변수 : " +update);
			
			PrintWriter out = response.getWriter();
			
			if(update == 1) {
				out.print("<script>");
				out.print("alert('강좌 수정에 성공하였습니다.');");
				out.print("location.href='/Project/project1/main.jsp'");
				out.print("</script>");
				return;
			} else {
				out.print("<script>");
				out.print("alert('강좌 수정에 실패하였습니다.');");
				out.print("history.go(-1);");
				out.print("</script>");
				return;
			}
			

		} else if(action.equals("/deleteCourse")) {
//			session = request.getSession();
			int update = courseService.delCourse(request);
			PrintWriter out = response.getWriter();
			
			if(update == 1) {
				out.print("<script>");
				out.print("alert('강좌가 삭제되었습니다.');");
				out.print("location.href='/Project/user/myPage.jsp'");
				out.print("</script>");
				return;
			} else {
				out.print("<script>");
				out.print("alert('강좌 삭제에 실패하였습니다. 다시 확인해주세요.');");
				out.print("history.go(-1);");
				out.print("</script>");
				return;
			}
			//강의 등록을 할때 강의제목열의 값이 DB에 중복되어있을경우 유효성검사     //0417추가
		}else if(action.equals("/coursesTitleCheck")) {
			   //true -> 중복, fasle -> 중복아님   둘중 하나를 반환 받음 
			   boolean result = courseService.coursesTitleCheck(request);
			   
			   System.out.println(result);
			   
			  PrintWriter out = response.getWriter();
			   if(result == true) { //중복			   
				   out.write("not_usable");
				   return;
			   }else if(result == false){//중복아님
				   out.write("usable");
				   return;
			   }
			
			}
		else { // getPathInfo 한 action 변수가 조건 아무것도 못타면 예외 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			throw new IllegalArgumentException("doHandle .Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
	
	
	
	
	
}
