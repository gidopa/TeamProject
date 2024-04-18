package Controller;

import java.io.IOException;
import java.io.PrintWriter;
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
import VO.UsersVO;
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
		// 로드맵 조회
		case "/":
			List<RoadMapVO> list = new ArrayList<RoadMapVO>();
			list = roadMapService.getRoadMapList();
			request.setAttribute("roadMapList", list);
			request.setAttribute("center", "RoadMapList.jsp");
			nextPage = main;
			break;
			// 특정 로드맵 클릭했을때 로드맵 세부 내용을 조회
		case "/detail":
			int roadMapId = Integer.parseInt(request.getParameter("roadMapId")) ;
			String user_id= (String)session.getAttribute("id") ;
			RoadMapVO roadMapVO = new RoadMapVO();
			List<CourseVO> courseVOList = new ArrayList<>();
			Map<String, Object> map  = new HashMap<String, Object>();
			map = roadMapService.getRoadMapDetail(roadMapId);
			// HashMap으로 받아온 값들을 꺼내서 바인딩 jsp에서 꺼내는것보다 여기서 하는게 편할것같아서 ,,,
			roadMapVO = (RoadMapVO)map.get("roadMapVO");
			courseVOList = (List<CourseVO>)map.get("courseVO");
			UsersVO userList = new UsersVO();
			userList=roadMapService.getPayDetail(user_id);
			log.debug("roadMapVO : {}", roadMapVO.getRoadMapTitle());
			log.debug("list : {}", courseVOList.size());
			for(CourseVO vo : courseVOList) {
				System.out.println(vo.getCourseTitle());
			}
			System.out.println("왜 널이지 ?? : "+userList.getUser_name());
			request.setAttribute("roadMapVO", roadMapVO);
			request.setAttribute("courseVOList", courseVOList);
			request.setAttribute("userVO", userList);
			request.setAttribute("center", "RoadMapDetail.jsp");
			nextPage=main;
			break;
		case "/addRoadMap"	:
			request.setAttribute("center", "addRoadMap.jsp");
			nextPage=main;
			break;
			
		//로드맵 정보 넣고 등록하기 눌러서 DB에 인서트하는 메소드	+courses테이블의 roadMap_id값이 null인값만 보여주기		
		case "/roadMapPlus" :
			roadMapId = roadMapService.registerRoadMap(request);
			ArrayList<CourseVO> arrayList = (ArrayList<CourseVO>)roadMapService.registerRoadMapList(request);
			request.setAttribute("roadMapId", roadMapId);
			request.setAttribute("arrayList", arrayList);
			request.setAttribute("center", "registerRoadMapList.jsp");
			nextPage=main;
			break;
			
		//로드맵에 등록할 강의 리스트를 클릭후에 DB에 CouresId와 RoadMapID를 맞추는 작업			
		case "/postRoadMap" :
			roadMapService.postRoadMap(request);
	
			request.setAttribute("center", "RoadMapList.jsp");
			nextPage="/RoadMap/";
			
			break;
			
		//로드맵 수정/삭제 버튼을 눌렀을때 내 로드맵을 보여주기위한 화면			
		case "/MyRoadMapList" :
				list =  roadMapService.MyRoadMapList(request);
			request.setAttribute("list", list);
			request.setAttribute("center", "MyRoadMapList.jsp");
			nextPage=main;
		break;	
		
		//로드맵 수정 버튼을 눌렀을때 강의 조회 해서 가져오는 메소드
		case "/updateRoadMap" : 
			arrayList = (ArrayList<CourseVO>)roadMapService.updateRoadMap(request);
			request.setAttribute("RoadMap_RoadMapId", request.getParameter("roadMapId"));
			request.setAttribute("arrayList", arrayList);
			request.setAttribute("center", "updateRoadMap.jsp");
			nextPage=main;
			break;
			
		//로드맵에 등록할 강의 목록을 체크후 수정버튼을 누르면 DB에 RoadMap_id를 업데이트
		case "/updateRoadMapInsert" :
			roadMapService.updateRoadMapInsert(request);
			request.setAttribute("center", "RoadMapList.jsp");
			nextPage="/RoadMap/";
			break;
			
		//로드맵리스트에서 삭제 버튼을 눌러 DB에 저장된 로드맵을 삭제하는 메소드
		case "/deleteRoadMap":
			roadMapService.deleteRoadMap(request);
			
			request.setAttribute("center", "RoadMapList.jsp");
			nextPage="/RoadMap/";
			break;
			
		//로드맵 등록시 Title 값이 DB에 존재하는지 유효성검사	
		case "/checkRoadMapTitle":	
			 //true -> 중복, fasle -> 중복아님   둘중 하나를 반환 받음 
			   boolean result = roadMapService.checkRoadMapTitle(request);
			  PrintWriter out = response.getWriter();
			   if(result == true) { //중복			   
				   out.write("exists");
				   return;
			   }else if(result == false){//중복아님
				   out.write("usable");
				   return;
			   }
			break;
		default:
			throw new IllegalArgumentException("RoadMapController Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
}
