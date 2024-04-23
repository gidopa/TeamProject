package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.sql.DataSource;

import VO.UsersVO;
import lombok.extern.java.Log;
import lombok.extern.log4j.Log4j;

public class UsersDAO {
	// 위 4가지 접속 설정값을 이용해서 오라클 DB와 접속한 정보를 지니고 있는 Connection객체를 저장할 참조변수 선언
	private Connection con;
	// DB와 연결 후 우리 개발자가 만든 SQL문장을 오라클 DB의 테이블에 전송하여 실행할 역할을 하는 Statement실행객체의 주소를
	// 저장할 참조변수 선언
	// private Statement stmt;
	private PreparedStatement pstmt;
	// SELECT문을 실행한 검색결과를 임시로 저장해 놓은 ResultSet객체의 주소를 저장할 참조변수 선언
	private ResultSet rs;
	// DataSouce커넥션풀 역할을 하는 객체의 주소를 저장할 참조변수
	private DataSource dataSource;

	public UsersDAO() {
		try {
			// 1.톰캣서버가 실행되면 context.xml파일에 적은 <Resouce>태그의 설정을 읽어와서
			// 톰캣서버의 메모리에 <Context>태그에 대한 Context객체들을 생성하여 저장해 둡니다.
			// 이때 InitialContext객체가 하는 역할은 톰캣서버 실행시 context.xml에 의해서 생성된
			// Context객체들에 접근하는 역할을 하기때문에 생성합니다.
			Context ctx = new InitialContext();

			// 2.JNDI기법(key를 이용해 값을 얻는 기법)으로 접근하기 위해 기본경로(java:/comp/env)를 지정합니다.
			// lookup("java:/comp/env"); 는 그중 톰캣서버의 환경설정에 관련된 Context객체들에 접근하기 위한 기본 경로 주소를
			// 설정하는 것입니다
			Context envContext = (Context) ctx.lookup("java:/comp/env");

			// 3.그런후 다시 톰캣서버는 context.xml에 설정한 <Resouce name="jdbc/oracle"....../>태그의
			// name속성값 "jdbc/oracle"(JNDI기법을 사용하기위한 key)를 이용해 톰캣 서버가 미리연결을 맺은 Connection객체들을
			// 보관하고 있는
			// DataSouce커넥션풀 객체를 찾아서 반환해 줍니다.
			dataSource = (DataSource) envContext.lookup("jdbc/oracle");

		} catch (Exception e) {
			System.out.println("DataSouce커넥션풀 객체 얻기 실패  : " + e);
		}
	}

	// DB작업관련 객체 메모리들 자원해제 하는 메소드
	public void ResourceClose() {
		try {
			if (pstmt != null) {
				pstmt.close();
			}
			if (rs != null) {
				rs.close();
			}
			if (con != null) {
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	// 아이디 중복여부를 판단하는 메소드(true: 중복, false: 중복아님)
	public int overlappedId(String id) {

		int result = 0;

		try {
			if (id.equals("")) {
				result = -1;
			} else {
				// db접속
				con = dataSource.getConnection();
				// 오라클의 decode함수를 이용해서
				// 서블릿에서 전달되는 입력한 ID에 해당하는 행데이터를 검색하여 검색한 행갯수가 1이면 'true'반환
				// 1이 아니면 'false'문자열을 반환해서 조회결과를 얻습니다.
				String sql = "select decode(count(*), 1, '1', '0') as result from users where user_id=?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);

				rs = pstmt.executeQuery();

				rs.next(); // 조회된 줄의 위치를 한 줄 내려줌
				String value = rs.getString("result");

				result = Integer.parseInt(value);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ResourceClose();
		}

		return result;
	}

	public void insertUser(UsersVO usersVO) {

		try {
			con = dataSource.getConnection();

			String sql = "insert into users(user_id, user_name, email, password, phone_number, address, interest)"
					+ " values(?,?,?,?,?,?,?)";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, usersVO.getUser_id());
			pstmt.setString(2, usersVO.getUser_name());
			pstmt.setString(3, usersVO.getEmail());
			pstmt.setString(4, usersVO.getPassword());
			pstmt.setString(5, usersVO.getPhone_number());
			pstmt.setString(6, usersVO.getAddress());
			pstmt.setString(7, usersVO.getInterest());

			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ResourceClose();
		}
	}

	public int userCheck(String login_id, String login_pwd) {
		int check = -1;

		try {
			con = dataSource.getConnection();
			// 매개변수 login_id로 받는 입력한 아이디에 해당되는 행을 조회 SELECT
			String sql = "select * from users where user_id=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, login_id);
			rs = pstmt.executeQuery();

			if (rs.next()) {// 입력한 아이디로 조회한 행이 있으면?(아이디가 저장되어 있으면?)
				// 입력한 비밀번호 또한 DB에 저장된 조회된 비밀번호와 같으면?
				if (login_pwd.equals(rs.getString("password"))) {

					check = 1; // 아이디 OK, 비밀번호 OK

				} else {// 아이디 OK, 비밀번호 NO
					check = 0;
				}
			} else {// 입력한 아이디로 조회되지 않으면?(아이디가 저장되어 있지 않음)
				check = -1; // 아이디 NO
			}
		} catch (Exception e) {
			System.out.println("MemberDAO의 userCheck메소드에서 오류 : " + e);
		} finally {
			ResourceClose();
		}
		return check;// 1 또는 0 또는 -1 을 반화
	}

	public UsersVO selectUser(String id) {
		UsersVO vo = null;

		try {
			con = dataSource.getConnection();

			String sql = "select * from users where user_id=?";

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			rs = pstmt.executeQuery();

			if (rs.next()) {
				vo = new UsersVO();

				vo.setUser_id(rs.getString("user_id"));
				vo.setUser_name(rs.getString("user_name"));
				vo.setPassword(rs.getString("password"));
				vo.setPhone_number(rs.getString("phone_number"));
				vo.setEmail(rs.getString("email"));
				vo.setAddress(rs.getString("address"));
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ResourceClose();
		}

		return vo;
	}

	public int overlappedPwd(String id, String pre_pwd) {
		int result = 0;

		try {
			if (id.equals("")) {
				result = 0;
			} else {
				// db접속
				con = dataSource.getConnection();
				// 오라클의 decode함수를 이용해서
				// 서블릿에서 전달되는 입력한 ID에 해당하는 행데이터를 검색하여 검색한 행갯수가 1이면 '1'반환
				// 1이 아니면 '0'문자열을 반환해서 조회결과를 얻습니다.
				String sql = "select decode(count(*), 1, '1', '0') as result from users where user_id=? and password=?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, id);
				pstmt.setString(2, pre_pwd);

				rs = pstmt.executeQuery();

				rs.next(); // 조회된 줄의 위치를 한 줄 내려줌
				String value = rs.getString("result");

				result = Integer.parseInt(value);
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ResourceClose();
		}

		return result;
	}

	public void ModUser(String name, String pwd, String phone_number, String email, String address, String interest,
			String id, String pre_pwd) {
		String sql = "";

		try {
			con = dataSource.getConnection();
			if (pwd.length() != 0 || !pwd.equals("")) {
				sql = "update users set user_name=?, email=?, password=?, phone_number=?, address=?, interest=? where user_id=? and password=?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, email);
				pstmt.setString(3, pwd);
				pstmt.setString(4, phone_number);
				pstmt.setString(5, address);
				pstmt.setString(6, interest);
				pstmt.setString(7, id);
				pstmt.setString(8, pre_pwd);
			} else {
				sql = "update users set user_name=?, email=?, phone_number=?, address=?, interest=? where user_id=? and password=?";

				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, name);
				pstmt.setString(2, email);
				pstmt.setString(3, phone_number);
				pstmt.setString(4, address);
				pstmt.setString(5, interest);
				pstmt.setString(6, id);
				pstmt.setString(7, pre_pwd);
			}
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ResourceClose();
		}
	}

	public int registerTeacher(String id) {
		String sql1 = "";
		String sql2 = "";
		int t = 0; // 삽입성공여부 확인할 정수
		try {
			con = dataSource.getConnection();
			// 먼저 강사에 등록되어 있는지 여부부터 확인
			sql1 = "select * from teachers where teacher_id=?";
			pstmt = con.prepareStatement(sql1);
			pstmt.setString(1, id);
			rs = pstmt.executeQuery();
			if (!rs.next()) { // 만약 강사에 등록되어 있지 않다면

				sql2 = "insert into teachers (teacher_id, teacher_name) select user_id, user_name from users where user_id = ?";

				pstmt = con.prepareStatement(sql2);
				pstmt.setString(1, id);

				t = pstmt.executeUpdate();
			} else { // 만약 강사에 등록되어 있다면
				t = 0;
			}
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ResourceClose();
		}

		return t;
	}

	public int deleteUser(String id) {
		int del = 0;
		String sql = "";
		try {
			sql = "delete from users where user_id=?";
			con = dataSource.getConnection();

			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, id);

			del = pstmt.executeUpdate();

		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ResourceClose();
		}
		return del;
	}

	public void NaverJoin(UsersVO userVO) {
		try {
			con = dataSource.getConnection();
			String sql = "INSERT INTO Users (user_id, user_name, email, password, phone_number, address, interest) VALUES (?, ?, ?, ?, ?, ?, ?)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, userVO.getUser_id());
			pstmt.setString(2, userVO.getUser_name());
			pstmt.setString(3, userVO.getEmail());
			pstmt.setString(4, userVO.getPassword());
			pstmt.setString(5, userVO.getPhone_number());
			pstmt.setString(6, userVO.getAddress());
			pstmt.setString(7, userVO.getInterest());
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		}finally {
			ResourceClose();
		}
	}
	
	public void KakaoJoin(UsersVO userVO) {
		try {
			con = dataSource.getConnection();
			String sql = "update Users set user_name=?, email=?, password=?, phone_number=?, address=?, interest=? where user_id = ?";
			pstmt = con.prepareStatement(sql);
			
			pstmt.setString(1, userVO.getUser_name());
			pstmt.setString(2, userVO.getEmail());
			pstmt.setString(3, userVO.getPassword());
			pstmt.setString(4, userVO.getPhone_number());
			pstmt.setString(5, userVO.getAddress());
			pstmt.setString(6, userVO.getInterest());
			pstmt.setString(7, userVO.getUser_id());
			
			pstmt.executeUpdate();
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ResourceClose();
		}
	}


	public UsersVO memberOne(String loginid) {
		UsersVO vo = null;
		try {
			con = dataSource.getConnection(); //DB와연결
			String sql = "select email, user_name from users where user_id=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, loginid);
			rs = pstmt.executeQuery();
			if(rs.next()) {
				vo = new UsersVO();
				vo.setEmail(rs.getString("email"));
				vo.setUser_name(rs.getString("user_name"));
				vo.setUser_id(loginid);
			}
		} catch (Exception e) {
			System.out.println("MemberDAO의  memberOne메소드 내부에서 오류 : " + e);
		} finally {
			ResourceClose();
		}
		return vo;
	}
	
}
