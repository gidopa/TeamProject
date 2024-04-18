package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.EnrollService;
import Service.PayService;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/Enroll/*")
public class EnrollController extends HttpServlet{
	private EnrollService enrollService;
	private PayService payService;
	
	@Override
	public void init() throws ServletException{
		enrollService=new EnrollService();
		payService=new PayService();
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
		String main="/project1/main.jsp";
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		
		HttpSession session=request.getSession();
		String nextPage = null;
		String action = request.getPathInfo();
		log.debug("action = {}",action);
		
		if(action.equals("/roadMap")){
			String id = (String)session.getAttribute("id");
			payService.insertEnrollTable(request, id);
			enrollService.enrollRoadMap(request, id);
			nextPage=main;
		}else { //getPathInfo 한 action 변수가 조건 아무것도 못타면 예외 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			throw new IllegalArgumentException("doHandle에서 유효하지 않은 value: " + action);
		}
		
		RequestDispatcher dispatcher = request.getRequestDispatcher(nextPage);
		dispatcher.forward(request, response);
	}
}