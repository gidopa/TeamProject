package Service;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;

import DAO.UsersDAO;
import VO.UsersVO;

public class UsersService {
	private UsersDAO usersDAO;

	
	public UsersService() {
		usersDAO = new UsersDAO();

	}
	
	public int serviceOverLappedId(HttpServletRequest request) {
		String id = request.getParameter("id");
		
		return usersDAO.overlappedId(id);
	}
	
	//회원가입 중앙 화면 VIEW주소 얻어서 MemberController에 반환 (비즈니스로직 처리)
	public String serviceJoinName(HttpServletRequest request) {
		
		return request.getParameter("center");
	}

	public void serviceInsertUser(HttpServletRequest request) {
		String id = request.getParameter("id");
		String name = request.getParameter("name");
		String email = request.getParameter("email");
		String password = request.getParameter("pwd");
		String phone_number = request.getParameter("tel");
		String address = request.getParameter("addr");
		
//		String job = request.getParameter("job");
		
		UsersVO usersVO = new UsersVO(id, name, email, password, phone_number, address);
		usersDAO.insertUser(usersVO);
		
		
	}

	public int serviceUserCheck(HttpServletRequest request) {
		
		String login_id = request.getParameter("id");
		String login_pwd = request.getParameter("pwd");
		
		int check = usersDAO.userCheck(login_id, login_pwd);	// 아이디 비밀번호 일치여부 확인할 값
		
		if(check == 1) {
			HttpSession session = request.getSession();
			session.setAttribute("id",login_id);
		}
		
		return check;
	}
	
	

	public void serviceLogOut(HttpServletRequest request) {
		HttpSession session = request.getSession();
		session.invalidate();
	}
}
