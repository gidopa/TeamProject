package Controller;

import java.io.IOException;
import java.io.PrintWriter;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;

import Service.UsersService;

@WebServlet("/users/*")
public class UsersController extends HttpServlet {

	private UsersService usersService;

	// 변수값 초기화
	public void init(ServletConfig config) throws ServletException {

		usersService = new UsersService(); // 부장

	}

	protected void doGet(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response)
			throws ServletException, IOException {
		// 한글처리
		request.setCharacterEncoding("UTF-8");
		// 웹브라우저로 응답할 MIME-TYPE설정
		response.setContentType("text/html;charset=utf-8");
		// 출력 스트림 생성
		PrintWriter out = response.getWriter();

		// 재요청할 VIEW 또는 서블릿 주소 저장할 변수
		String nextPage = null;
		// 요청한 중앙화면 VIEW 주소를 저장할 변수
		String center = null;

		// 클라이언트가 요청한 전체 주소 중에서 2단계 요청 주소 얻기
		String action = request.getPathInfo();

		
		// /usersregisterPro.me <- 회원가입 2단계 요청 주소	
		switch (action) {
		// 회원가입시 입력하는 화면 요청이 들어옴
//			case "/register.jsp":
//				
//				center = usersService.serviceJoinName(request);
//				request.setAttribute("center", center);
//				nextPage = "/main.jsp";
//				break;

		// 회원가입 요청이 들 어옴
		case "/usersregisterPro.me":
			// 가입할 회원정보들이 저장된 request메모리를 Memberservice에게 전달함
			usersService.serviceInsertUser(request);
			request.setAttribute("center", "center.jsp");
			nextPage = "/project1/main.jsp";
			break;

		// 로그인 요청 들어옴
		case "/loginPro.me":

			// check변수값이 1이면 아이디, 비밀번호 맞음
			// 0이면 아이디맞음, 비밀번호 틀림
			// -1이면 아이디틀림
			int check = usersService.serviceUserCheck(request);

			if (check == 0) { // 아이디 맞고 비밀번호 틀림
				out.print("<script>");
				out.print("window.alert('비밀번호가 틀렸습니다.');");
				out.print("history.go(-1);");
				out.print("</script>");
				return; // doHandle메소드 빠져 나가서 디스패처방식 포워딩 하지 말자
			} else if (check == -1) {// 아이디 틀림
				out.print("<script>");
				out.print("window.alert('아이디가 틀렸습니다.');");
				out.print("history.go(-1);");
				out.print("</script>");
				return; // doHandle메소드 빠져 나가서 디스패처방식 포워딩 하지 말자
			}

			nextPage = "/project1/main.jsp";
			break;

		case "/logout.me": // 로그아웃 요청 들어옴

			usersService.serviceLogOut(request);

			nextPage = "/project1/main.jsp";
			break;

		case "/joinIdCheck.me": // 아이디 중복확인 요청 들어옴

			int result = usersService.serviceOverLappedId(request);

			if (result == 1) {
				out.write("not_usable");
				return;
			} else if (result == 0) {
				out.write("usable");
				return;
			} else {
				out.write("none");
				return;
			}

		case "/modPwdCheck.me":

			int result2 = usersService.serviceOverLappedPwd(request);

			if (result2 == 1) { // 아이디가 일치하고 기존 비밀번호와 일치하면
				out.write("usable");
				return;
			} else if (result2 == 0) { // 아이디가 일치하지 않거나 기존 비밀번호와 일치하지 않으면
				out.write("not_usable");
				return;
			}

		case "/modUserPro.me":

			usersService.serviceModUser(request);

			nextPage = "/project1/main.jsp";
			break;
		case "/aboutus":
			request.setAttribute("center", "KakaoMap.jsp");
			nextPage = "/project1/main.jsp";
			break;

		// --------------------------------------------------
		case "/registerTeacher.me": // 강사 등록하기 버튼 눌렀을 때

			int t = usersService.serviceRegTeacher(request);
			// alert창 구현중!!!!!
			if (t == 1) {
				out.print("<script>");
				out.print("window.alert('강사등록에 성공하였습니다.');");
				out.print("history.go(-1);");
				out.print("</script>");
				return;
				
			} else if (t == 0){
				out.print("<script>");
				out.print("window.alert('이미 강사 등록된 계정입니다.');");
				out.print("history.go(-1);");
				out.print("</script>");
				return;
			}
			break;
		
		case "/delUser.me":		// 회원 탈퇴하기 눌렀을때
			
			int del = usersService.deleteUser(request);
			
			if (del == 1) {
				out.print("<script>");
				out.print("window.alert('회원탈퇴 하였습니다.');");
				out.print("location.href='/Project/project1/main.jsp'");
				out.print("</script>");
				return;
				
			} else if (del == 0){
				out.print("<script>");
				out.print("window.alert('회원탈퇴에 실패하였습니다.');");
				out.print("history.go(-1);");
				out.print("</script>");
				return;
			}
			break;
			
		default:
			throw new IllegalArgumentException("UsersController Unexpected value: " + action);
		}

		// 포워딩 (디스패처 방식)
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);
		dispatch.forward(request, response);
	}

}
