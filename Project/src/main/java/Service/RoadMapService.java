package Service;

import java.util.ArrayList;
import java.util.List;

import DAO.LectureDAO;
import DAO.RoadMapDAO;
import VO.RoadMapVO;

public class RoadMapService {
	private RoadMapDAO roadMapDAO;

	public RoadMapService() {
		roadMapDAO = new RoadMapDAO();
	}


	public List<RoadMapVO> getRoadMapList() {
		List<RoadMapVO> list = new ArrayList<RoadMapVO>();
		list = roadMapDAO.getRoadMapList();
		return list;
	}
	
	
}
