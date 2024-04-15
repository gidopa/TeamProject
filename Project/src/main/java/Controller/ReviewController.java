package Controller;

import java.io.IOException;
import java.io.PrintWriter;
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
			String contextPath = request.getContextPath();
			reviewService.insertComment(request);
		    String courseTitle = request.getParameter("courseTitle"); // 예시 파라미터, 실제 구현에 맞게 조정 필요
		    String reviewContent = request.getParameter("commentText");
		    int reviewScore = Integer.parseInt(request.getParameter("rating"));
		    String reviewDate = new SimpleDateFormat("yyyy-MM-dd").format(new java.util.Date());
		    // HTML 응답 구성
		    PrintWriter out = response.getWriter();
		    out.println("<div class=\"card mb-3\">");
		    out.println("<div class=\"card-body\">");
		    out.println("<h5 class=\"card-title\">" + courseTitle + " - 평점: " + reviewScore + "</h5>");
		    out.println("<p class=\"card-text\">" + reviewContent + "</p>");
		    out.println("<p class=\"card-text\"><small class=\"text-muted\">작성자: " + id + " 작성 시간: " + reviewDate + "</small></p>");
		    out.println("</div>");
		    out.println("</div>");

			return;
		default:
			throw new IllegalArgumentException("ReviewController Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}   
}
