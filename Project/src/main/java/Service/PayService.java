package Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DAO.EnrollDAO;
import DAO.PayDAO;
import DAO.UsersDAO;
import VO.UsersVO;

public class PayService {
	private PayDAO payDAO;
	private EnrollDAO enrollDAO;

	
	public PayService() {
		payDAO = new PayDAO();
		enrollDAO = new EnrollDAO();
	}


	public void insertPayTale(HttpServletRequest request, String id) {
		String userId = id; 
//		String paymentId = request.getParameter("payment_id");
//		String userName = request.getParameter("userName");
//		String paymentDate = request.getParameter("payment_date");
//		String paymentAmount = request.getParameter("payment_amount");
//		String paymentStatus = request.getParameter("payment_status");
//		String courseTitle = request.getParameter("courseTitle");
//		String phoneNumber = request.getParameter("phone_number");
//		String email = request.getParameter("email");
		payDAO.insertPayTable(request,userId);
		enrollDAO.updatePurchase(request,userId);
	}
	
	
	
	
}
