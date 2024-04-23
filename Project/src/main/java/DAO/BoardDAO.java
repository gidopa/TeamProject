package DAO;

import java.sql.Connection;
import java.sql.PreparedStatement;
import java.sql.ResultSet;
import java.util.ArrayList;
import java.util.Vector;

import javax.naming.Context;
import javax.naming.InitialContext;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpSession;
import javax.sql.DataSource;

import VO.BoardVO;
import VO.UsersVO;

public class BoardDAO {

	//위 4가지 접속 설정값을 이용해서 오라클 DB와 접속한 정보를 지니고 있는 Connection객체를 저장할 참조변수 선언
	private Connection con;	
	//DB와 연결 후 우리 개발자가 만든 SQL문장을 오라클 DB의 테이블에 전송하여 실행할 역할을 하는 Statement실행객체의 주소를 저장할 참조변수 선언
	//private Statement stmt;
	private PreparedStatement pstmt;	
	//SELECT문을 실행한 검색결과를 임시로 저장해 놓은 ResultSet객체의 주소를 저장할 참조변수 선언
	private ResultSet rs;
	//DataSouce커넥션풀 역할을 하는 객체의 주소를 저장할 참조변수
	private DataSource dataSource;
	
	//CarDAO클래스의 기본생성자
	//역할 : new CarDAO(); 객체 생성시 호출되는 생성자로 !!
	//     생성자 내부에서 커넥션풀 역할을 하는 DataSouce객체를 얻는 작업을 하게 됩니다.
	public BoardDAO() {
	
		try {
			//1.톰캣서버가 실행되면 context.xml파일에 적은 <Resouce>태그의 설정을 읽어와서
			//  톰캣서버의 메모리에 <Context>태그에 대한 Context객체들을 생성하여 저장해 둡니다.
			// 이때 InitialContext객체가 하는 역할은  톰캣서버 실행시 context.xml에 의해서 생성된 
			// Context객체들에 접근하는 역할을 하기때문에 생성합니다.
			Context ctx = new InitialContext();
			
			//2.JNDI기법(key를 이용해 값을 얻는 기법)으로 접근하기 위해 기본경로(java:/comp/env)를 지정합니다.
			// lookup("java:/comp/env"); 는 그중 톰캣서버의 환경설정에 관련된 Context객체들에 접근하기 위한 기본 경로 주소를 설정하는 것입니다
			Context envContext = (Context) ctx.lookup("java:/comp/env");
			
			//3.그런후 다시 톰캣서버는  context.xml에 설정한 <Resouce name="jdbc/oracle"....../>태그의
			// name속성값  "jdbc/oracle"(JNDI기법을 사용하기위한 key)를 이용해 톰캣 서버가 미리연결을 맺은 Connection객체들을 보관하고 있는
			// DataSouce커넥션풀 객체를 찾아서 반환해 줍니다.
			dataSource = (DataSource) envContext.lookup("jdbc/oracle");
			
		} catch (Exception e) {
			System.out.println("DataSouce커넥션풀 객체 얻기 실패  : " + e);
		}
	
	}
	
	
	//DB작업관련 객체 메모리들 자원해제 하는 메소드 
	public void ResourceClose() {	
		try {
			if(pstmt != null) {
				pstmt.close();
			}
			if(rs != null) {
				rs.close();
			}
			if(con != null) {
				con.close();
			}
		} catch (Exception e) {
			e.printStackTrace();
		}
	}

	//현재 board테이블 에 저장된 모든 글을 조회하는 메소드
	public ArrayList boardListAll() {
		
		ArrayList list = new ArrayList();
		
		try {
			  con = dataSource.getConnection(); //DB의 테이블과 연결 
			  
			  pstmt = con.prepareStatement("select * from board order by b_group asc");
			  
			  rs = pstmt.executeQuery();
			  
			  //조회된 ResultSet의 정보를 한 행 단위로 꺼내서
			  //BoardVO객체에 한행씩 저장 후 BoardVO객체들을 ArrayList배열에 하나씩 추가해서 저장
			  while(rs.next()) {				  
				  BoardVO vo = new BoardVO(rs.getInt("b_idx"), 
						  				   rs.getInt("b_group"), 
						  				   rs.getInt("b_level"), 
						  				   rs.getInt("b_cnt"), 
						  				   rs.getString("b_id"), 
						  				   rs.getString("b_pw"), 
						  				   rs.getString("b_name"), 
						  				   rs.getString("b_email"), 
						  				   rs.getString("b_title"), 
						  				   rs.getString("b_content"), 
						  				   rs.getDate("b_date"));
				  list.add(vo);				           
			  }	
		} catch (Exception e) {
			System.out.println("BoardDAO의 boardListAll메소드 내부에서 오류 : " + e);
		} finally { 
			ResourceClose();//자원해제
		}
		return list;
	}
	
	
	//현재 board테이블에 저장된 총 글의 갯수 조회후 반환 하는 메소드 
	public int getTotalRecord() {
		//조회된 글 갯수 저장할 변수
		int total = 0;		
		try {
			con = dataSource.getConnection();
			pstmt = con.prepareStatement("select count(*) as cnt from board");
			rs = pstmt.executeQuery();
			if(rs.next()) {
				total = rs.getInt("cnt");
			}
		} catch (Exception e) {
			System.out.println("BoardDAO의 getTotalRecord메솓 내부에서 오류 : " + e);
		} finally {
			ResourceClose();//자원해제 
		}
		return total;
	}
	
	//입력한 새글 정보를 DB의 board테이블에 추가 하는 메소드
	public int insertBoard(VO.BoardVO vo) {
		//새글 추가에 성공하거나 실패하면   1 또는 0을 저장할 변수
		int result = 0;
		String sql = null;
		try {
			//DB연결
			con = dataSource.getConnection();
			
//주글 달기 규칙2. 두번쨰로 입력되는 주글이면 기존에 insert되었던 주글의 b_group(pos)열의 값을 1증가 시킨다
			sql = "update board set b_group = b_group + 1";
			pstmt = con.prepareStatement(sql);
			pstmt.executeUpdate();
			
//주글 달기규칙3. 주글을 insert할때 b_group(pos)열의 값과, b_level(depth)열의 값을 무조건 0 0 으로 insert한다 			
			//insert SQL문 만들기 
			sql = "insert into board (b_idx, b_id, b_pw, b_name, b_email, b_title, b_content, b_group,  b_level, b_date, b_cnt) "
				+ " values(border_b_idx.nextVal,?,    ?,      ?,       ?,       ?,         ?,       0,        0, sysdate,   0 )";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, vo.getB_id());
			pstmt.setString(2, vo.getB_pw());
			pstmt.setString(3, vo.getB_name());
			pstmt.setString(4, vo.getB_email());
			pstmt.setString(5, vo.getB_title());
			pstmt.setString(6, vo.getB_content());
			
			result = pstmt.executeUpdate();
				
		} catch (Exception e) {
			System.out.println("BoardDAO의 insertBoard메소드 내부에서 오류:" + e);
		} finally {
			ResourceClose();
		}
		
		return result;		
	}

	//현재 게시판 board테이블에 저장된 글들을 조회
	//조건 :  선택한 검색 기준열과 입력한 검색어 단어가 포함된 내용이 있는 글들을 조회!
	public ArrayList boardList(String keyField, String keyWord) {
	
		String sql = null; //조건에 따라 select문장을 다르게 만들어서 저장할 용도 
		
		ArrayList<BoardVO>  list = new ArrayList<BoardVO>();//조회된 글들 저장 용도
		
		if( !keyWord.equals("")  ) { //검색어를 입력 했다면?
			
			if(keyField.equals("name")) {//검색 기준열이 (name)b_name열이면?
				
				sql = "select * from board "
					+ " where b_name like '%"+ keyWord + "%'"
					+ " order by b_group asc";	
						
			}else if(keyField.equals("subject")) {//검색 기준열이 (subject)b_title열이면?
				
				sql = "select * from board "
						+ " where b_title like '%"+ keyWord + "%'"
						+ " order by b_group asc";				
				
			}else {//검색 기준열이 (content)b_content열이면?
				
				sql = "select * from board "
						+ " where b_content like '%"+ keyWord + "%'"
						+ " order by b_group asc";				
				
			}
			
		}else {//검색어를 입력하지 않고 찾기 버튼을 눌렀을때
			//모든 글 조회
			//조건 -> b_idx열의 글번호 데이터들을 기준으로 내림차순 정렬 후 조회!
			sql = "select * from board order by b_group asc";
			
			//참고. 정렬 조회 -> order by 정렬기준열명  desc(내림차순) 또는 asc(오름차순);
		}
		//-----------------------------------------		
		try {
			  con = dataSource.getConnection(); //DB의 테이블과 연결 
			  
			  pstmt = con.prepareStatement(sql);
			  
			  rs = pstmt.executeQuery();
			  
			  //조회된 ResultSet의 정보를 한 행 단위로 꺼내서
			  //BoardVO객체에 한행씩 저장 후 BoardVO객체들을 ArrayList배열에 하나씩 추가해서 저장
			  while(rs.next()) {				  
				  BoardVO vo = new BoardVO(rs.getInt("b_idx"), 
						  				   rs.getInt("b_group"), 
						  				   rs.getInt("b_level"), 
						  				   rs.getInt("b_cnt"), 
						  				   rs.getString("b_id"), 
						  				   rs.getString("b_pw"), 
						  				   rs.getString("b_name"), 
						  				   rs.getString("b_email"), 
						  				   rs.getString("b_title"), 
						  				   rs.getString("b_content"), 
						  				   rs.getDate("b_date"));
				  list.add(vo);				           
			  }				
			
		} catch (Exception e) {
			System.out.println("BoardDAO클래스의 boardList메소드 내부에서 SQL실행 오류:" + e);		
		} finally {
			ResourceClose();
		}
		
		return list;//BoardService로 반환
	}


	public int getTotalRecord(String keyField, String keyWord) {
		
		String sql = null; //조건에 따라 select문장을 다르게 만들어서 저장할 용도 
		
		//조회된 글들의 갯수 저장
		int total = 0;
		
		if( !keyWord.equals("")  ) { //검색어를 입력 했다면?
			
			if(keyField.equals("name")) {//검색 기준열이 (name)b_name열이면?
				
				sql = "select count(*) as cnt from board "
					+ " where b_name like '%"+ keyWord + "%'"
					+ " order by b_group asc";	
						
			}else if(keyField.equals("subject")) {//검색 기준열이 (subject)b_title열이면?
				
				sql = "select count(*) as cnt from board "
						+ " where b_title like '%"+ keyWord + "%'"
						+ " order by b_group asc";				
				
			}else {//검색 기준열이 (content)b_content열이면?
				
				sql = "select count(*) as cnt from board "
						+ " where b_content like '%"+ keyWord + "%'"
						+ " order by b_group asc";				
				
			}
			
		}else {//검색어를 입력하지 않고 찾기 버튼을 눌렀을때
			//모든 글 조회
			//조건 -> b_idx열의 글번호 데이터들을 기준으로 내림차순 정렬 후 조회!
			sql = "select count(*) as cnt from board order by b_group asc";
			
			//참고. 정렬 조회 -> order by 정렬기준열명  desc(내림차순) 또는 asc(오름차순);
		}
		//-----------------------------------------		
		try {
			  con = dataSource.getConnection(); //DB의 테이블과 연결 
			  
			  pstmt = con.prepareStatement(sql);
			  
			  rs = pstmt.executeQuery();
			  
			  //조회된 ResultSet의 조회갯수를 한행 얻어 
			  if(rs.next()) {				  
				 total = rs.getInt("cnt");
			  }				
			
		} catch (Exception e) {
			System.out.println("BoardDAO클래스의 getTotalRecord메소드 내부에서 SQL실행 오류:" + e);		
		} finally {
			ResourceClose();
		}		
		return total;//BoardService로 반환
	}

	//글을 조회하면?
	//1.글조회수 증가  UPDATE  b_cnt열값 1증가  
	//2.글을 조회     SELECT
	public BoardVO boardRead(String b_idx) {
		
		BoardVO vo = null; //조회된 글정보 한줄 저장 용도 
		String sql = null; // UPDATE  구문 과 SELECT구문을 따로 저장하기 위한 용도 
		
		try {
			 con = dataSource.getConnection(); //DB연결
			 //UPDATE -> 현재 메소드의 매개변수 b_idx로 전달받은 글번호에 해당하는 글의 b_cnt열의 값을
			 //			 1증가 한 값으로 수정 하는 SQL문
			 sql = "update board set b_cnt=b_cnt+1  where  b_idx=?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setInt(1, Integer.parseInt(b_idx));
			 pstmt.executeUpdate();
			 
			 sql = "select * from board where b_idx=?";
			 pstmt = con.prepareStatement(sql);
			 pstmt.setInt(1, Integer.parseInt(b_idx));
			 rs = pstmt.executeQuery();
			 
			 if(rs.next()) {
				         vo = new BoardVO(rs.getInt("b_idx"), 
						  				   rs.getInt("b_group"), 
						  				   rs.getInt("b_level"), 
						  				   rs.getInt("b_cnt"), 
						  				   rs.getString("b_id"), 
						  				   rs.getString("b_pw"), 
						  				   rs.getString("b_name"), 
						  				   rs.getString("b_email"), 
						  				   rs.getString("b_title"), 
						  				   rs.getString("b_content"), 
						  				   rs.getDate("b_date"));
			 }	
		} catch (Exception e) {
			System.out.println("BoardDAO의 boardRead메소드 내부에서 오류 : " + e);
		} finally {
			ResourceClose();
		}
	
		return vo;//글제목을 눌렀을때 글번호에 해당되는 글조회수1증가 시키고 나서~
				  //글을 조회한 후 ~~ BoardVO객체에 담아 BoardService로 반환
	}

	//매개변수로 받은 글번호와 입력한 패스워드에 해당하는 정보를 board테이블에서 조회해서
	//입력한 패스워드가 board테이블에 존재하면 true를 반환, 존재하지 않으면 false반환 하는 메소드 
	public boolean passCheck(String b_idx, String password) {
		
		boolean result = false; //true또는 false저장 될것임 
		
		try {
			//커넥션풀(DataSource객체)에서 커넥션(Connection객체) 빌려오기 //DB연결
			con = dataSource.getConnection();//Connection객체 반환 받아 저장
											 //board테이블과 연결한 정보를 가지고 있는 객체 
			
			//매개변수로 받은 글번호와 입력한 패스워드에 해당하는 정보를 board테이블에서 조회 SELECT 문장을 
			//미리 PreparedStatement실행 객체메모리에 로딩후 
			//PreparedStatement실행 객체 메모리 자체를 반환 해옵니다.
			pstmt = con.prepareStatement("select * from board where b_idx=? and b_pw=? order by b_idx desc");
			//PreparedStatement실행 객체에 저장되어있는 전체 select문장중에 
			//?대신 들어갈값을 설정
			pstmt.setString(1, b_idx);
			pstmt.setString(2, password);
			
			//PreparedStatement실행객체 메모리에 저장된 전체 select문장을
			//board테이블에 전송해 실행합니다. 그러면 조회된 결과데이터들을 임시로 ResultSet메모리에 담아옵니다
			rs = pstmt.executeQuery();
			
			//ResultSet.next메소드를 호출하여 커서위치 조회된 줄로 내리고
			//조회된 줄이 존재하면 true반환 합니다.
			//그러므로 우리가 입력한 패스워드로 조회가 가능하니 board테이블에 입력한 패스워드가 저장되어 있다
			if(rs.next()) {
				result = true;
			}else {
				result = false;
			}
		} catch (Exception e) {
			System.out.println("BoardDAO의 passCheck메소드 내부에서 SQL문 실행 오류 :" + e);
		} finally {
			//자원해제 (connection객체 커넥션풀에 반납, ResultSet 삭제, PreparedStatment 삭제)
			ResourceClose();
		}
	
		return result;
	}


	//글수정 
	public int updateBoard(String idx_, String email_, String title_, String content_) {
		int result = 0; //수정 성공시 1저장 또는 실패시 0저장 하는 변수 
		try {
			con = dataSource.getConnection();//DB연결
			//예약한 아이디와 예약당시 입력했던 비밀번호와 일치하는 하나 레코드 정보 수정
			String sql = "update board set "
						+ " b_email=?, b_title=?, b_content=? "
						+ " where b_idx=?";
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, email_);
			pstmt.setString(2, title_);
			pstmt.setString(3, content_);
			pstmt.setString(4, idx_);

			result = pstmt.executeUpdate();//수정에 성공하면 수정에 성공한 레코드갯수1 반환
										   //     실패하면 레코드갯수0반환
					
		} catch (Exception e) {
			System.out.println("BoardDAO의 updateBoard메소드 내부에서 SQL문 실행 오류 : " + e);
			e.printStackTrace();//예외메시지 출력 
		} finally {
			ResourceClose();
		}
		return result;// 1또는 0을 BoardService로 반환 
	}

	//글 삭제 
	public String deleteBoard(String delete_idx) {
		String result = null;		
		try {
			con = dataSource.getConnection();
			
			String sql = "DELETE FROM board WHERE b_idx=?";
			
			pstmt = con.prepareStatement(sql);
			pstmt.setString(1, delete_idx);
		
			int val = pstmt.executeUpdate();
			
			if(val == 1) { result = "삭제성공";}
			else {result = "삭제실패";}
			
		}catch (Exception e) {
			System.out.println("BoardDAO의 deleteBoard메소드 내부에서 오류 :" + e);
			e.printStackTrace();
		}finally {
			ResourceClose();//자원해제
		}
		return result; //"삭제성공" 또는 "삭제실패" 반환
	}

	//답변글 내용을 DB의 board테이블에 insert추가하는 메소드 
	public void replyInsertBoard(String super_b_idx, String reply_id, 
								 String reply_name, String reply_email,
			                     String reply_title, String reply_content, 
			                     String reply_pass) {
		String sql = null;
		
		try {
				con = dataSource.getConnection();//DB연결
				
				//1. 부모글(주글)의 글번호를 이용해 b_group열의 값과 , b_level열의 값을 조회 
				sql = "select b_group, b_level from board where b_idx=?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, super_b_idx); //부모글(주글) 글번호 셋팅 
				rs = pstmt.executeQuery();
				rs.next();
				String b_group = rs.getString("b_group");//주글의 그룹번호
				String b_level = rs.getString("b_level");//주글의 들여쓰기정도값 
				
				//답변글 다는 규칙1.
				//주글(부모글)의 b_group열의 값보다 큰 값을 가지는 주글이 있다면
				//주글의 b_group을 1증가한 값으로 수정
				sql = "update board set b_group = b_group + 1 where b_group > ?";
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, b_group);
				pstmt.executeUpdate();
				
				//답변글 다는 규칙2
				//-> 답변글을  insert할떄 주글(부모글)의 b_group열의 값에 1더한값으로 insert
				//답변글 다는 규칙3
				//-> 답변글을 insert할떄 주글(부모글)의 b_level열의 값에 1더한 값으로 insert
				//답변글 insert SQL문 만들기
				sql = "insert into board (b_idx, b_id, b_pw, b_name, b_email, b_title, b_content, b_group,  b_level, b_date, b_cnt) "
			    + " values(border_b_idx.nextVal,    ?,    ?,      ?,       ?,       ?,         ?,       ?,        ?, sysdate,   0 )";
				
				pstmt = con.prepareStatement(sql);
				pstmt.setString(1, reply_id); //답변글을 작성하는 로그인된 사람의 아이디 
				pstmt.setString(2, reply_pass);//답글을 작성시 입력했던 답변글의 비밀번호 
				pstmt.setString(3, reply_name);//답변글 작성하는 사람 이름
				pstmt.setString(4, reply_email);//답변글 작성하는 사람 이메일주소 
				pstmt.setString(5, reply_title);//답변글 제목 
				pstmt.setString(6, reply_content);//답변글의 내용 
				pstmt.setInt(7, Integer.parseInt(b_group) + 1); //주글의 그룹값에 1더한값 추가 //규칙2.
				pstmt.setInt(8, Integer.parseInt(b_level) + 1); //주글의 레벨값에 1더한값 추가 //규칙3.
				pstmt.executeUpdate();
				
		} catch (Exception e) {
			System.out.println("BoardDAO의 replyInsertBoard메소드 내부에서 SQL문 실행 오류:" + e);
		} finally {
			ResourceClose();
		}
	}
	
	
}//BoardDAO클래스 




















