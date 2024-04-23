package Service;

import java.util.ArrayList;

import javax.servlet.http.HttpServletRequest;

import DAO.BoardDAO;
import DAO.UsersDAO;
import VO.BoardVO;
import VO.UsersVO;

//부장
public class BoardService {

	private BoardDAO boarddao;
	private UsersDAO userDAO;
	
	public BoardService() {
		boarddao = new BoardDAO();
		userDAO = new UsersDAO();
	}
	//board테이블 에 저장된 모든 글 조회후 반환하는 메소드 
	public ArrayList serviceBoardListAll() {
		return boarddao.boardListAll();
	}
	
	//현재 board테이블에 저장된 글 갯수 조회후 반환하는 메소드
	public int getTotalRecord() {
		return boarddao.getTotalRecord();
	}
	
	//로그인한 회원아이디를 매개변수로 받아서 회원 조회후 반환하는 메소드 
	public UsersVO serviceMemberOne(String loginid) {
		
		return userDAO.memberOne(loginid);
	}
	
	//
	public int serviceInsertBoard(HttpServletRequest request) {
		//요청한 값들 얻기 (입력한 새글 정보들 얻기)
		String writer = request.getParameter("w");
		String email = request.getParameter("e");
		String title = request.getParameter("t");
		String content = request.getParameter("c");
		String pass = request.getParameter("p");
		String id = request.getParameter("i");
		
		//요청한 값들을 BoardVO객체의 각변수에 저장
		BoardVO vo = new BoardVO();
				vo.setB_name(writer);
				vo.setB_email(email);
				vo.setB_title(title);
				vo.setB_content(content);
				vo.setB_pw(pass);
				vo.setB_id(id);
		
		return boarddao.insertBoard(vo);
		
	}
	
	//선택한 option검색기준열과  입력한 검색어를 이용해 글목록 검색 요청이 들어옴 
	public ArrayList serviceBoardList(HttpServletRequest request) {
		

		//		ArrayList를 BoardController로 리턴 
		return boarddao.boardList(request.getParameter("keyField"), 
								  request.getParameter("keyWord"));
	}
	
	//선택한 opetion검색기준열과 입력한 검색어를 포함하고 있는 글갯수 검색 요청이 들어옴 
	public int  serviceGetTotalRecord(HttpServletRequest  request) {
		
		return boarddao.getTotalRecord(request.getParameter("keyField"),
				                       request.getParameter("keyWord"));
		
	}
	
	//글제목을 눌렀을때 글번호를 전달받아 글조회 하기 위해 BoardDAO객체의 boardRead메소드 호출하는 곳
	public BoardVO serviceBoardRead(String b_idx) {
		
		return boarddao.boardRead(b_idx);//BoardController에서 메소드 호출한 장소로 반환 
	}
	
	//
	public boolean servicePassCheck(HttpServletRequest request) {
		//요청한 값 2개 얻기 ( 글번호 , 입력한패스워드)
		String b_idx = request.getParameter("b_idx");
		String password = request.getParameter("pass");
		
			  //사원 BoardDAO야 ~ 니가 해라 전달해 줄게 하면서 메소드 호출합니다.
		return boarddao.passCheck(b_idx,password);
	}
	
	//글 수정 요청을 받았을떄 
	public int serviceUpdateBoard(HttpServletRequest request) {
		//수정을 위해 입력한 값 얻기 (요청한 값얻기)
		String idx_ = request.getParameter("idx");
		String email_ = request.getParameter("email");
		String title_ = request.getParameter("title");
		String content_ = request.getParameter("content");
		
				//사원 BoardDAO의 메소드를 호출해 DB작업(UPDATE작업)명령 합니다.
				//수정에 성공하면 1을 반환 받고 실패하면 0을 반환 받는다.
		return  boarddao.updateBoard(idx_, email_, title_, content_);
	}
	
	//글삭제 요청시 삭제할 글번호를 전달받아 사용 
	public String serviceDeleteBoard(HttpServletRequest request) {
		
			   //글삭제에 성공하면   "삭제성공" 메세지 반환,  실패하면 "삭제실패" 메세지 반환 
		return boarddao.deleteBoard(request.getParameter("b_idx"));
		 
	}
	
	//답변글을 board테이블에 insert
	public void serviceReplyInsertBoard(HttpServletRequest request) {
		
		//요청한 값 얻기 
		// 주글 (부모글) 글번호 + 작성한 답변글 내용 얻기
		String super_b_idx = request.getParameter("super_b_idx");//부모 글번호
		String reply_id = request.getParameter("id"); //답변글 작성자 아이디
		String reply_name = request.getParameter("writer"); //답변글 작성자 이름
		String reply_email = request.getParameter("email"); //답변글 작성자 이메일			
		String reply_title = request.getParameter("title"); //답변글 제목
		String reply_content = request.getParameter("content"); //답변글 내용
		String reply_pass = request.getParameter("pass"); //답변글 비밀번호
		
		//사원 BoardDAO의 메소드를 호출하면서 매개변수로 전달해 작성한 새로운 답변글 내요을 insert시킵니다.
		boarddao.replyInsertBoard(super_b_idx,
									reply_id,
									reply_name,
									reply_email,
									reply_title,
									reply_content,
									reply_pass
								  );
		
	}
	
	
	
	
}//BoardService 부장 
 

















