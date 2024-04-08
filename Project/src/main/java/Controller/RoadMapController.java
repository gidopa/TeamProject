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

import Service.RoadMapService;
import VO.LectureVO;
import VO.RoadMapVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/RoadMap/*")
public class RoadMapController extends HttpServlet {
	
	private RoadMapService roadMapService;

	@Override
	public void init() throws ServletException {
		roadMapService = new RoadMapService();
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
		log.debug("action = {}", action);
		switch (action) {
		case "/":
			List<RoadMapVO> list = new ArrayList<RoadMapVO>();
			list = roadMapService.getRoadMapList();
			request.setAttribute("roadMapList", list);
			request.setAttribute("center", "RoadMapList.jsp");
			nextPage = main;
			break;
		default:
			throw new IllegalArgumentException("RoadMapController Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
}
