package Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DAO.LectureDAO;
import DAO.RoadMapDAO;
import VO.CourseVO;
import VO.RoadMapVO;
import VO.UsersVO;

public class RoadMapService {
	private RoadMapDAO roadMapDAO;

	public RoadMapService() {
		roadMapDAO = new RoadMapDAO();
	}

// 전체 로드맵 조회를 위해 List로 받아오는 메소드
	public List<RoadMapVO> getRoadMapList() {
		List<RoadMapVO> list = new ArrayList<RoadMapVO>();
		list = roadMapDAO.getRoadMapList();
		return list;
	}

// roadMapId로 로드맵 하나의 대한 정보를 vo로 받아오는 메소드
	public Map<String, Object> getRoadMapDetail(int roadMapId) {
		Map<String, Object> map  = new HashMap<String, Object>();
		map = roadMapDAO.getRoadMapDetail(roadMapId);
		return map;
	}
	
	//로드맵 등록하기 위해 DB에 Insert시키는 메소드
		public int registerRoadMap(HttpServletRequest request) {
				String userId = request.getParameter("userId");
				String roadMapTitle = request.getParameter("roadMapTitle");
				String roadMapDescription = request.getParameter("roadMapDescription");
				String imgPath = request.getParameter("imgPath");
			return roadMapDAO.registerRoadMap(userId,roadMapTitle,roadMapDescription,imgPath);
		}
		//userId로 내가 올린 강의 정보를 받아와 선택할수 있게 뿌려주는 메소드
		public List<CourseVO> registerRoadMapList(HttpServletRequest request) {
			String userId = request.getParameter("userId");
			return roadMapDAO.registerRoadMapList(userId);
		}
		//리스트로 받아온 정보를 RoadMap테이블의 roadmapid 맞춰주기
		public void postRoadMap(HttpServletRequest request) {

			roadMapDAO.postRoadMap(request);
			
		}
		//로드맵 수정/삭제 버튼을 눌렀을때 내 로드맵 리스트를 보여주기 위한 화면
		public List<RoadMapVO> MyRoadMapList(HttpServletRequest request) {
			HttpSession session = request.getSession(); 
			String id = (String)session.getAttribute("id");
			
			return roadMapDAO.MyRoadMapList(id);
		}
		//로드맵 수정 버튼을 눌렀을때 강의 조회 해서 가져오는 메소드
		public ArrayList<CourseVO> updateRoadMap(HttpServletRequest request) {
			String userId = request.getParameter("userId");
			int roadMapId = Integer.parseInt(request.getParameter("roadMapId"));
			return roadMapDAO.updateRoadMap(userId,roadMapId);
		}
		//로드맵안의 강의 목록 체크해서 DB courses테이블에 roadMapid업데이트 하는 메소드
		public void updateRoadMapInsert(HttpServletRequest request) {
			roadMapDAO.updateRoadMapInsert(request); 
		}
		//로드맵 리스트에서 삭제 버튼을 눌렀을때 DB의 로드맵테이블에서 삭제하는 메소드
		public void deleteRoadMap(HttpServletRequest request) {
			int roadMapId = Integer.parseInt(request.getParameter("roadMapId"));
			roadMapDAO.deleteRoadMap(roadMapId);
		}
		//로드맵 등록시 title값 유효성 검사
		public boolean checkRoadMapTitle(HttpServletRequest request) {
			//입력한 제목 얻기
			String roadMapTitle = request.getParameter("roadMapTitle");
			
			//true -> 중복,  false-> 중복아님    둘중 하나를 반환받음 
			return roadMapDAO.checkRoadMapTitle(roadMapTitle);
			
		}
		
		public UsersVO getPayDetail(String user_id){
			UsersVO list=new UsersVO();
			list=roadMapDAO.getPayDetail(user_id);
			return list;
		}
	
	
}
