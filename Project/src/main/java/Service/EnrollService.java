package Service;

import javax.servlet.http.HttpServletRequest;

import DAO.EnrollDAO;

public class EnrollService {
	private EnrollDAO enrollDAO;
	
	public EnrollService() {
		enrollDAO=new EnrollDAO();
	}

	public void enrollRoadMap(HttpServletRequest request, String id) {
		enrollDAO.enrollRoadMap(request, id);
	}
}