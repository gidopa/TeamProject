package Controller;

import java.io.IOException;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.PayService;
import VO.LectureVO;
import VO.PayVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
@WebServlet("/Pay/*")
public class PayController extends HttpServlet {

	private PayService payService;
	
	@Override
	public void init() throws ServletException {
		payService = new PayService();
	}

	@Override
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	@Override
	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}
	
	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		String main = "/project1/main.jsp";
		request.setCharacterEncoding("utf-8");
		response.setContentType("text/html;charset=utf-8");
		// 재요청할 VIEW 또는 서블릿 주소를 저장할 변수
		HttpSession session = request.getSession(); 
		PayVO payVO= null;
		String nextPage = null;
		String action = request.getPathInfo();
		log.debug("action = {}",action);
		if(action.equals("/payConfirm")) {
			String id = (String)session.getAttribute("id");
			payService.insertPayTale(request,id);
			nextPage=main;
		}else { // getPathInfo 한 action 변수가 조건 아무것도 못타면 예외 발생
			response.setStatus(HttpServletResponse.SC_NOT_FOUND);
			throw new IllegalArgumentException("doHandle .Unexpected value: " + action);
		}
		
		RequestDispatcher rd = request.getRequestDispatcher(nextPage);
		rd.forward(request, response);
	}
	
}
