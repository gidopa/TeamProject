package Controller;

import java.io.IOException;
import java.io.PrintWriter;
import java.util.ArrayList;
import java.util.Vector;

import javax.servlet.RequestDispatcher;
import javax.servlet.ServletConfig;
import javax.servlet.ServletException;
import javax.servlet.annotation.WebServlet;
import javax.servlet.http.HttpServlet;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import javax.servlet.http.HttpSession;


import Service.BoardService;
import VO.BoardVO;
import VO.UsersVO;


//--- 사장  역할 

//게시판 관련 기능 요청이 들어 오면  호출되는 사장님(컨트롤러)
@WebServlet("/board/*")  
public class BoardController extends HttpServlet { //사장 
	
	private BoardService boardservice;
	
	//변수값 초기화 
	public void init(ServletConfig config) throws ServletException {
		
		boardservice = new BoardService();//부장 d

	}
	
	protected void doGet(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doPost(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		doHandle(request, response);
	}

	protected void doHandle(HttpServletRequest request, HttpServletResponse response) throws ServletException, IOException {
		
		String main = "/project1/main.jsp";
		//한글처리
		request.setCharacterEncoding("UTF-8");
		//웹브라우저로 응답할 MIME-TYPE설정
		response.setContentType("text/html;charset=utf-8");
		//출력 스트림 생성
		PrintWriter out = response.getWriter();
		
		
		//재요청할 VIEW 또는 서블릿 주소 저장할 변수
		String nextPage = null;
		//요청한 중앙화면 VIEW 주소를 저장할 변수 
		String center = null;
		
		
		//로그인 했는지 안했는지 판단을 위해 HttpSession얻기
		HttpSession  session_ = request.getSession();
		String loginid = (String)session_.getAttribute("id");//로그인시 입력한 아이디 얻기 
				
		BoardVO  vo = null;
		ArrayList list = null; //조회한 정보 저장할 용도 
		int count = 0; //조회한 글 갯수 저장할 용도 
		
		//클라이언트가 요청한 전체 주소 중에서 2단계 요청 주소 얻기 
		String action = request.getPathInfo();  
		System.out.println("action:"+ action);
		
		//2단계 요청주소 /list.bo <- board테이블에 저장된 글목록 조회 요청이 들어 왔을때 
		//2단계 요청주소 /write.bo <- 글쓰기 화면을 요청 했을떄
		//2단계 요청주소 /writePro.bo <- 입력한 새글 정보를 DB의 board테이블에 추가 요청 했을때 
		//2단계 요청주소 /seachlist.bo <- 검색 기준값과 검색어를 입력하고 검색어 단어가 포함된
		//								글목록을 board테이블에서 조회 요청이 들어 왔을떄 
		
		String nowPage = null;
		String nowBlock = null;
	
		switch (action) {
		
			case "/searchlist.bo": //검색 기준값과 검색어를 입력해서 검색요청이 들어 왔을때
				
				//부장 호출!
				//검색기준값과 입력한 검색어가 저장된 request를 전달해  글들을 조회 하게 메소드 호출!
				list = boardservice.serviceBoardList(request);
				//검색기준열의값과 입력한 검색어를 포함하고 있는 내용의 글들의 갯수 조회하게 메소드 호출!
				count = boardservice.serviceGetTotalRecord(request);
				
				nowPage = request.getParameter("nowPage"); //0 
				nowBlock = request.getParameter("nowBlock"); //0
								
				//중앙 VIEW화면 주소 request에 바인딩
				request.setAttribute("center", "/boarders/list.jsp");
				//조회된 글목록 정보가 저장된 ArrayList배열, 조회된 글 갯수 를 request에 바인딩
				request.setAttribute("list", list);
				request.setAttribute("count", count);
				
				//중앙화면 list.jsp에 검색한 목록보여주기 위해
				//nowPage 와 nowBlock을 reqeust에 바인딩
				request.setAttribute("nowPage", nowPage);
				request.setAttribute("nowBlock", nowBlock);
				
		
				//메인화면 재요청 주소
				nextPage = main;
				
				break;
		
			case "/list.bo": //게시판 모든 글 조회 요청  
				
				//부장 호출!
				list = boardservice.serviceBoardListAll(); //board테이블에 저장된 모든 글 조회 명령 
				count = boardservice.getTotalRecord();//board테이블에 저장된 모든 글 갯수 조회 
				
				//1.Top.jsp페이지에서 자유 게시판 메뉴 클릭했을때 또한 받느다.
				//2.list.jsp페이지의 페이징 처리 부분에서 
				//이전 또는 다음 또는 각페이지 번호를 클릭했을때 요청받는 값얻기 
				nowPage = request.getParameter("nowPage");
				nowBlock = request.getParameter("nowBlock");
				
				//조회된 글 목록을 보여줄 중앙화면 주소 request에 바인딩
			//	request.setAttribute("center", "boarders/list.jsp"); 
				//조회된 글목록 정보가 저장된 ArrayList배열, 조회된 글 갯수 를 request에 바인딩
				request.setAttribute("list", list);
				request.setAttribute("count", count);
				request.setAttribute("center", "/boarders/list.jsp");
				//로그인한 회원의 아이디 request에 바인딩
				request.setAttribute("id", loginid);
				//페이지번호를 누르거나 이전 다음을 눌렀을때 중앙화면 list.jsp에 검색한 목록보여주기 위해
				//nowPage 와 nowBlock을 reqeust에 바인딩
				request.setAttribute("nowPage", nowPage);
				request.setAttribute("nowBlock", nowBlock);
				
											
				//메인화면 VIEW주소 저장
				nextPage = main;
				
				break;
			
			case "/write.bo":	//새글 입력 하는 화면 요청!
				
				//부장 BoardService의 메소드를 호출 할때 회원아이디를 로그인한 회원아이디를 전달하여
				//아이디에 해당하는 회원 한사람을 조회 시킵니다.
				UsersVO membervo = boardservice.serviceMemberOne(loginid);
				
				//새글 입력하는 중앙 VIEW주소 request에 바인딩
				//request.setAttribute("center", "boarders/write.jsp");
											 
				//조회된 회원 정보를 request에 바인딩
				request.setAttribute("membervo", membervo);
				request.setAttribute("center", "/boarders/write.jsp");
				//새글 입력화면 요청시~~ 페이지번호, 페이지번호가 속한 블럭번호 또한 request에 바인딩
				
				//재요청할 /CarMain.jsp경로 nextPage변수에 저장
				nextPage = main;				
				break;

			case "/writePro.bo": //새글 추가 요청
				
				//부장
				//응답할 값 마련(DB에 새글 정보를 INSERT한후 성공하면 추가메세지 마련)
				//result = 1  -> DB에 새글 정보 추가 성공
				//result = 0 -> DB에 새글 정보 추가 실패 
				int result = boardservice.serviceInsertBoard(request);
				
				//1 -> "1"  ,  0 -> "0" 로 변환해서 저장
				String go = String.valueOf(result);
				
				//write.jsp로 ($.ajax()메소드 내부의 success:function(data)의 data매개변수로 전달)
				if( go.equals("1") ) {//insert 성공
					
					out.print(go);//"1"보냄
				
				}else {//insert 실패
				
					out.print(go);//"0"보님
				}
				
				return;
				
				
				
			case "/read.bo"://조회된 글목록에서 특정글의 글제목하나를 클릭했을때
							//글번호를 받아서 조회후 보여주는 boarders/read.jsp중앙화면 요청
				
				//list.jsp페이지에서 전달한 3개의 요청한 값 얻자
				String b_idx = request.getParameter("b_idx");
				       nowPage =  request.getParameter("nowPage");
				       nowBlock = request.getParameter("nowBlock");
				//-------------
				//부장 BoardService의 메소드 호출!
				//클릭한 글제목의 글에 대한 글번호를 전달 해서 글정보 하나 조회 명령
				vo = boardservice.serviceBoardRead(b_idx);
				
				request.setAttribute("center", "/boarders/read.jsp");//중앙 VIEW
				request.setAttribute("vo", vo);//응답할 Model 
				request.setAttribute("count", vo.getB_cnt());
				request.setAttribute("nowPage", nowPage);
				request.setAttribute("nowBlock", nowBlock);
				request.setAttribute("b_idx", b_idx);
				
				nextPage = main;
				break;     
			
			case "/password.do": //글수정화면을 비활성화에서 활성화 상태로 만들기 위해
								 //입력한 패스워드와 DB의 board테이블에 저장된 글의 패스워드와 
								 //비교후 같은지 다른지 판단 요청!
			    //부장 BoardService야 request객체 주소 전달할테니 니가 알아서 처리해라
				//패스워드 일치한지에 대한 결과를 반환받습니다.
				boolean resultPass = boardservice.servicePassCheck(request);
				
				if(resultPass == true) {
					out.write("비밀번호맞음");//read.jsp  $.ajax 메소드 호출한
										   // sucess:function(data) data매개변수로전달 
					
					return; //doHandle메소드 빠져나가  디스패처방식 포워딩 막자 
				}else {
					out.write("비밀번호틀림");
					return;
				}
			
			case "/updateBoard.do": //글수정 요청 주소를 받았을때
				
				//부장 BoardService의 메소드호출시 request객체주소를 전달해 
				//수정시 입력한 요청한 값들을 얻어 UPDATE구문 완성후 board테이블에 수정 해줘 명령
				int result_ = boardservice.serviceUpdateBoard(request);
				
				if(result_ == 1) {//수정 성공
					out.write("수정성공");  //read.jsp로 
					return;
				}else { //수정 실패
					out.write("수정실패");//read.jsp로 
					return;
				}
				
			case "/deleteBoard.bo"://삭제 요청을 받았을떄
				
				//-----
				//부장님 호출!!!
				//글삭제 요청!시 삭제할 글번호 전달
				//글삭제에 성공하면   "삭제성공" 메세지 반환,  실패하면 "삭제실패" 메세지 반환 
				String result__ = boardservice.serviceDeleteBoard(request);
				
				out.write(result__);//"삭제성공"  또는 "삭제실패"  가  ajax메소드로 간다 

				return;
			
			case "/reply.do": //답변글을 작성하는 화면 요청 				
			//요청한 값 얻기 
				//주글(부모글)의 글번호얻기 
				String b_idx__ = request.getParameter("b_idx");
				//주글(부모글)에 대한 답변글을 작성하는 로그인한 회원의 아이디 얻기
				String reply_id_ = request.getParameter("id");
							
				//부장 BoardService의 메소드를 호출하여 
				//로그인한 회원이 답변글을 작성할수 있도록하기 위해
				//로그인한 회원의 아이디를 전달하여 회원정보를 조회 함
				UsersVO reply_vo = boardservice.serviceMemberOne(reply_id_);
				
				//주글(부모글) 번호를 request에 바인딩
				request.setAttribute("b_idx", b_idx__);
				//조회한 답변글을 작성하는 사람 정보 request에 바인딩
				request.setAttribute("vo", reply_vo);
				//중앙 화면(답변글을 작성할수 있는 화면) View 주소 바인딩
				request.setAttribute("center","/boarders/reply.jsp");
				
				nextPage = main;
				break;
			
			case "/replyPro.do"://주글에 대한 답변글의 내용을 새롭게 board테이블에 insert추가 요청!
				
				//부장 BoardService의 특정메소드를 호출하면서 request객체 주소를 전달해 
				//답변글 추가 요청합니다
				boardservice.serviceReplyInsertBoard(request);
				
				
				//답변글 추가 성공후 
				//다시 전체글을 조회해서 보여주기 위해  조회요청주소를 저장
				nextPage = "/board/list.bo"; 
				
				break;
				
			default:
				break;
		
		}
		

		//포워딩 (디스패처 방식)
		RequestDispatcher dispatch = request.getRequestDispatcher(nextPage);		
		dispatch.forward(request, response);	
	
	}//doHandle메소드 끝	
	
	
}











