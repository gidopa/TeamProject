package Controller;

import java.io.IOException;
import java.sql.Date;
import java.text.SimpleDateFormat;
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

import com.google.gson.JsonObject;

import Service.CourseService;
import Service.LectureService;
import Service.ReviewService;
import Service.RoadMapService;
import VO.CourseVO;
import VO.LectureVO;
import VO.ReviewVO;
import VO.RoadMapVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/Review/*")
public class ReviewController extends HttpServlet {
	
	private ReviewService reviewService;
	private CourseService courseService;

	@Override
	public void init() throws ServletException {
		reviewService = new ReviewService();
		courseService = new CourseService();
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
		String id = (String)session.getAttribute("id");
		LectureVO lectureVO = null;
		String nextPage = null;
		String action = request.getPathInfo();
		log.debug("action = {}", action);
		switch (action) {
		// 로드맵 조회
		case "/":
			List<ReviewVO> reviewList = reviewService.getAllReviewList();
			List<CourseVO> courseList = courseService.getEnrollCoursesListById(id);
			request.setAttribute("comments", reviewList);
			request.setAttribute("center", "../review/reviewList.jsp");
			request.setAttribute("courseList", courseList);
			nextPage = main;
			break;
		case "/comment":
			reviewService.insertComment(request);
			return;
		default:
			throw new IllegalArgumentException("ReviewController Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}   
}
