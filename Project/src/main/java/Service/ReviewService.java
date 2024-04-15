package Service;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DAO.ReviewDAO;
import DAO.UsersDAO;
import VO.ReviewVO;
import VO.UsersVO;

public class ReviewService {
	private ReviewDAO reviewDAO;

	public ReviewService() {
		reviewDAO = new ReviewDAO();
	}

	public List<ReviewVO> getAllReviewList() {
		
		return reviewDAO.getAllReviewList();
	}

	public void insertComment(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		String content = request.getParameter("commentText");
		int courseId = Integer.parseInt(request.getParameter("courseId")) ;
		double courseRating = Double.parseDouble(request.getParameter("rating"));
		reviewDAO.insertComment(id,content,courseId,courseRating);
		
		
	}

}
