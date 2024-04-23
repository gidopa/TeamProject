package Service;

import java.sql.Date;
import java.time.LocalDate;

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
		String interest = request.getParameter("categories");	
		
//		String job = request.getParameter("job");
		
		UsersVO usersVO = new UsersVO(id, name, email, password, phone_number, address, interest);
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

	public int serviceOverLappedPwd(HttpServletRequest request) {
		String id = request.getParameter("id");
		String pre_pwd = request.getParameter("pre_pwd");
		
		return usersDAO.overlappedPwd(id, pre_pwd);
	}

	public void serviceModUser(HttpServletRequest request) {
		String name = request.getParameter("name");
		String pwd = request.getParameter("pwd");
		String phone_number = request.getParameter("tel");
		String email = request.getParameter("email");
		String address = request.getParameter("addr");
		String interest = request.getParameter("categories");
		
		String id = request.getParameter("id");
		String pre_pwd = request.getParameter("pre_pwd");
		usersDAO.ModUser(name,pwd,phone_number,email,address,interest,id,pre_pwd);
	}

	public int serviceRegTeacher(HttpServletRequest request) {	// 세션에서 아이디를 가져옴
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		int t = usersDAO.registerTeacher(id);
//		System.out.println("아이디 : " + id);
//		System.out.println("dao값 : " + t);
		return t;
	}

	public int deleteUser(HttpServletRequest request) {
		HttpSession session = request.getSession();
		
		String id = (String)session.getAttribute("id");
		
		int del = usersDAO.deleteUser(id);
//		System.out.println("deleteUser에서 id값 : " + id);
		session.invalidate();
		return del;
	}
	
	public UsersVO getUserInfo(HttpServletRequest request) {
		HttpSession session = request.getSession();
		String id = (String)session.getAttribute("id");
		UsersVO vo = usersDAO.selectUser(id);
		return vo;
	}

	public void naverlogin(HttpServletRequest request) {
		UsersVO userVO = new UsersVO();
		
		
		userVO.setUser_id(request.getParameter("m_id"));
		userVO.setPassword(request.getParameter("m_pass"));
		userVO.setUser_name(request.getParameter("m_name"));
		userVO.setEmail(request.getParameter("m_email"));
		userVO.setPhone_number(request.getParameter("m_hp"));
		userVO.setInterest(request.getParameter("m_admin"));
		userVO.setAddress(request.getParameter("address1")+" "+
				   		 request.getParameter("address2")+
				   		 request.getParameter("address3")+ ", " +
				   		 request.getParameter("address4")+
				   		 request.getParameter("address5")
						);
		usersDAO.NaverJoin(userVO);
		
		HttpSession session = request.getSession();
		session.setAttribute("id", request.getParameter("m_id"));
	}
	
	public void kakaoJoin(HttpServletRequest request) {
		UsersVO userVO = new UsersVO();
				
				
				userVO.setUser_id(request.getParameter("m_id"));
				userVO.setPassword(request.getParameter("m_pass"));
				userVO.setUser_name(request.getParameter("m_name"));
				userVO.setEmail(request.getParameter("m_email"));
				userVO.setPhone_number(request.getParameter("m_hp"));
				userVO.setInterest(request.getParameter("m_admin"));
				userVO.setAddress(request.getParameter("address1")+" "+
						   		 request.getParameter("address2")+
						   		 request.getParameter("address3")+ ", " +
						   		 request.getParameter("address4")+
						   		 request.getParameter("address5")
								);
				usersDAO.KakaoJoin(userVO);
				
				HttpSession session = request.getSession();
				session.setAttribute("id", request.getParameter("m_id"));
			}
	
}
