package Controller;

import java.io.IOException;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.RoadMapService;
import VO.CourseVO;
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
		case "/detail":
			int roadMapId = Integer.parseInt(request.getParameter("roadMapId")) ;
			RoadMapVO roadMapVO = new RoadMapVO();
			List<CourseVO> courseVOList = new ArrayList<>();
			Map<String, Object> map  = new HashMap<String, Object>();
			map = roadMapService.getRoadMapDetail(roadMapId);
			// HashMap으로 받아온 값들을 꺼내서 바인딩 jsp에서 꺼내는것보다 여기서 하는게 편할것같아서 ,,,
			roadMapVO = (RoadMapVO)map.get("roadMapVO");
			courseVOList = (List<CourseVO>)map.get("courseVO");
			log.debug("roadMapVO : {}", roadMapVO.getRoadMapTitle());
			log.debug("list : {}", courseVOList.size());
			for(CourseVO vo : courseVOList) {
				System.out.println(vo.getCourseTitle());
			}
			request.setAttribute("roadMapVO", roadMapVO);
			request.setAttribute("courseVOList", courseVOList);
			request.setAttribute("center", "RoadMapDetail.jsp");
			nextPage=main; //RoadMapDetail.jsp 만져야함 
			break;
		default:
			throw new IllegalArgumentException("RoadMapController Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
}
