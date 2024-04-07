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
			// 쿼리 파라미터로 어떤 강의 인지 넘겨주고 해당 강의에 대한 정보를 coursemodules 테이블에서 받아와서 템플릿 만들고 뿌려줘야함 
			List<LectureVO> lectureList = new ArrayList<>();
			// 특정 강의에 대한 세부 강의 정보를 받아오는 메소드
			lectureList = lectureService.getLectureInfo(courseId);
			request.setAttribute("courseId", courseId);
			request.setAttribute("lectureList", lectureList);
			request.setAttribute("center", "SelectLecture.jsp");
			nextPage = main; // 세부 강의 정보에서 duration의 시간 정보를 유튜브 API로 어떻게 받아오는지 알아보기 
		}else if(action.equals("/play")){ // 강의 선택했을때 실행시켜줄 화면 만들고 db에서 링크 받아와서 켜줘야함
			// iframe 링크 어떻게 파싱할지 생각
			String videoLink = null;
			int courseId = Integer.parseInt(request.getParameter("courseId"));
			int lectureId = Integer.parseInt(request.getParameter("lectureId"));
			videoLink = lectureService.getVideoLink(courseId, lectureId);
			request.setAttribute("videoLink", videoLink);
			request.setAttribute("center", "LecturePlay.jsp"); 
			nextPage = main;
		}else {
			throw new IllegalArgumentException("LectureController doHandle .Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
}