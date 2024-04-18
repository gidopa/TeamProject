package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.sql.DataSource;

import VO.UsersVO;
import lombok.extern.slf4j.Slf4j;

@Slf4j
public class PayDAO {
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

	public PayDAO() {
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
// 결제완료후 결제 정보 insert
	public void insertPayTable(HttpServletRequest request, String id) {
		String userId = id;
		String paymentId = request.getParameter("payment_id");
		String userName = request.getParameter("userName");
		String paymentDate = request.getParameter("payment_date");
		String paymentAmount = request.getParameter("payment_amount");
		String paymentStatus = request.getParameter("payment_status");
		String courseTitle = request.getParameter("courseTitle");
		String phoneNumber = request.getParameter("phone_number");
		String email = request.getParameter("email");
		int courseId = Integer.parseInt( request.getParameter("courseId"));
		try {
			con = dataSource.getConnection();
			String sql = "insert into payments (payment_id, user_id, course_id, payment_date, payment_amount, payment_status, user_name,phone_number,email,roadmap_id)"
												+ " values (?,?,?,sysdate, ?,?,?,?,?,null)";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, paymentId);
			pstmt.setString(2, userId);
			pstmt.setInt(3, courseId);
			pstmt.setString(4, paymentAmount);
			pstmt.setString(5, paymentStatus);
			pstmt.setString(6, userName);
			pstmt.setString(7, phoneNumber);
			pstmt.setString(8, email);
			pstmt.executeUpdate();

		} catch (Exception e) {
			log.error("insertPayTable error : {}", e);
		} finally {
			ResourceClose();
		}

	}
	
	//로드맵을 사면 강의 여러개를 한번에 사는거니까 해시맵이나 리스트에 담아서 와야 하는건가?
		public void insertEnrollTable(HttpServletRequest request, String id) {
			String userId = id;
			String paymentId = request.getParameter("payment_id");
			String userName = request.getParameter("userName");
			log.debug("userName : {}",userName);
			String phoneNumber = request.getParameter("phone_number");
			String email = request.getParameter("email");
			String paymentDate = request.getParameter("payment_date");
			int paymentAmount = Integer.parseInt(request.getParameter("payment_amount"));
			String paymentStatus = request.getParameter("payment_status");
			int roadMapId=Integer.parseInt(request.getParameter("roadMapId"));
			try {
				con = dataSource.getConnection();
				String sql = "insert into payments (payment_id, user_id, course_id, payment_date,"
						+ " payment_amount, payment_status, user_name, phone_number, email,"
						+ " roadmap_id) values(?,?,null,sysdate,?,?,?,?,?,?)";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, paymentId);
				pstmt.setString(2, userId);
				pstmt.setInt(3, paymentAmount);
				pstmt.setString(4, paymentStatus); 
				pstmt.setString(5, userName);
				pstmt.setString(6, phoneNumber);
				pstmt.setString(7, email);
				pstmt.setInt(8, roadMapId);
				pstmt.executeUpdate();
			} catch (Exception e) {
				log.error("insertEnrollTable error : {}", e);
			} finally {
				ResourceClose();
			}
		}
}
