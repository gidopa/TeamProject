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

import DAO.LectureDAO;
import Service.LectureService;
import VO.CourseVO;
import VO.LectureVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/Lecture/*")
public class LectureController extends HttpServlet {
	
	private LectureService lectureService;
	
	@Override
	public void init() throws ServletException {
		lectureService = new LectureService();
	}
	

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		String main = "/project1/main.jsp";
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		HttpSession session = request.getSession(); 
		LectureVO lectureVO = null;
		String nextPage = null;
		String action = request.getPathInfo();
		log.debug("action = {}",action);
		if(action.equals("/lectures")) {
			int courseId = Integer.parseInt(request.getParameter("courseId")); 
			log.debug("courseId = {}",courseId); 
			// 쿼리 파라미터로 어떤 강좌 인지 넘겨주고 해당 강의에 대한 정보를 lecture 테이블에서 받아와서 템플릿 만들고 뿌려줘야함 
			List<LectureVO> lectureList = new ArrayList<>();
			// 특정 강좌에 대한 세부 강의 정보를 받아오는 메소드
			lectureList = lectureService.getLecturesInfo(courseId);
			request.setAttribute("courseId", courseId);
			request.setAttribute("lectureList", lectureList);
			request.setAttribute("center", "SelectLecture.jsp");
			nextPage = main; // 세부 강의 정보에서 duration의 시간 정보를 유튜브 API로 어떻게 받아오는지 알아보기 
		}else if(action.equals("/play")){
			String videoLink = null;
			LectureVO lectureInfo = new LectureVO();
			List<LectureVO> lectureList = new ArrayList<>();
			// 특정 강의에 대한 세부 정보를 받아오는 메소드
			int courseId = Integer.parseInt(request.getParameter("courseId"));
			int lectureId = Integer.parseInt(request.getParameter("lectureId"));
			// 강좌내에 있는 모든 강의들의 정보를 List로 받아오고
			lectureList = lectureService.getLecturesInfo(courseId);
			//  lectureId 모두 줘서 하나의 강의에 대한 정보를 LectureVO로 받아옴
			lectureInfo = lectureService.getLectureInfo(lectureId);
			videoLink = lectureService.getVideoLink(courseId, lectureId);
			request.setAttribute("lectureList", lectureList);
			request.setAttribute("lectureInfo", lectureInfo);
			request.setAttribute("videoLink", videoLink);
			request.setAttribute("center", "LecturePlay.jsp"); 
			nextPage = main;
		}else if(action.equals("/registraion")){
			//강의 등록 후 상세 강의 내용을 인서트하는 메소드(1강,2강,3강,...) 
			ArrayList<LectureVO> list = (ArrayList<LectureVO>)lectureService.registration(request);
			request.setAttribute("center", "lectureList.jsp");
			request.setAttribute("list", list);
			// 여기서부터 3줄 4.11 15:54분에 삽
			request.setAttribute("courseTitle", request.getParameter("courseTitle"));
			request.setAttribute("courseCategory", request.getParameter("courseCategory"));
			request.setAttribute("courseId", list.get(0).getCourseId());
			nextPage=main;
		}else if(action.equals("/modify")){
			int lectureId = Integer.parseInt(request.getParameter("lectureId")) ;
			LectureVO lecturevo = lectureService.getLectureInfo(lectureId);
			request.setAttribute("lectureVO", lecturevo);
			request.setAttribute("center", "LectureModify.jsp");
			nextPage = main;
		}else if(action.equals("/modifyPost")){
			List<LectureVO> lectureList = lectureService.modifyLecture(request);
			request.setAttribute("center", "lectureList.jsp");
			request.setAttribute("list", lectureList);
			nextPage=main;
		}else if(action.equals("/delete")){
			lectureService.deleteLecture(request);
			request.setAttribute("center", "lectureList.jsp");
			nextPage=main;
		}else if(action.equals("/addRegistraion")){
			request.setAttribute("courseId", Integer.parseInt(request.getParameter("courseId")));
			request.setAttribute("courseTitle",request.getParameter("courseTitle"));
			request.setAttribute("courseCategory",request.getParameter("courseCategory"));
			request.setAttribute("center", "addLectureRegistration.jsp");
	        nextPage=main;
		}else if(action.equals("/list")){
			String id = (String)session.getAttribute("id");
			List<CourseVO> courseList = lectureService.getCoursesList(id); // 여기
			request.setAttribute("courseList", courseList);
			request.setAttribute("center", "modLecture.jsp");
			nextPage="/project1/modLecture.jsp";
		}else if(action.equals("/myList")){
			int courseId = Integer.parseInt(request.getParameter("courseId")) ;
		    List<LectureVO> list = lectureService.getLecturesInfo(courseId);
		    request.setAttribute("list", list);
		    nextPage = "/project1/lectureList.jsp";
		}else { // lectureList.jsp를 확인해볼 수 있는 페이지가 필요함 지금은 강의등록완료후에 확인하는 거 말곤 방법이 없음
			throw new IllegalArgumentException("LectureController doHandle .Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
}