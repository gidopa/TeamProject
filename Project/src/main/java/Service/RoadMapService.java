package Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

import DAO.LectureDAO;
import DAO.RoadMapDAO;
import VO.RoadMapVO;

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
	
	
}
