<%@page import="VO.BoardVO2"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- JSTL의 CORE 태그들을 사용하기 위해 주소를 통해서 불러오고 접두어 c 로 설정해서 c:으로 사용 --%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
//한글처리
	request.setCharacterEncoding("UTF-8");
	
	//컨텍스트주소 얻기
	String contextPath = request.getContextPath();
%>

<HTML>
<script>
	// 아래의 <select> option 에서 option하나를 선택하고 검색어를 입력해 
	//  검색 찾기를 눌렀을때 호출 되는 함수로 
	//  유효성 검사후 모두 입력하면 <form>의 전송이벤트를 실행시키는 함수 
	function fnSearch(){
		//입력한 검색어 값 얻기 
		let word = document.getElementById("word").value;
		
		//검색어를 입력하지 않았다면
		if(word == null || word == ""){
			alert("검색어를 입력하세요");
			//검색어를 입력할수 있는 <input>을 선택해서 포커스 강제로 설정
			document.getElementById("word").focus();
			//아래의 <form>태그로 false를 전달해서 onsubmit이벤트 차단
			return false;
		
		}else{//검색어를 입력 했다면
			
			//<form>을 선택해서 action속성에 적힌 서블릿으로 요청!(전송이벤트 실행!)
			//<form action="/board/searchlist.bo">
			//				1단계     2단계
			document.search.submit();
		}
	}
	
	
	//글제목 하나를 클릭했을때 글번호를 매개변수로 받아서 <form>로 
	//글번호에 해당되는 글의 정보를 DB로부터 조회 요청을 BoardController로 합니다.
	function  fnRead(val){		
		
		console.log(val);
		/*						BoardController로 조회요청 
		 <form name="frmRead" action="/board/read.bo">
				<input type="hidden" name="b_idx" value="val">  
				<input type="hidden" name="nowPage" value="nowPage">
				<input type="hidden" name="nowBlock" value="nowBlock">
		</form>		
		*/
		document.frmRead.action = "<%=contextPath%>/board2/read.bo";
		document.frmRead.b_idx.value = val;
		document.frmRead.submit();	
	}
</script>
<BODY>
<br><br><br>
<%
/*주제 : 페이징 처리 변수 선언후 계산 */
//[1]
	int totalRecord = 0;//조회된 총 글 갯수 저장될 변수 ---- [2] 가서 살펴보기  ok
	int numPerPage = 5; //페이지번호 하나당 보여질 글목록의 갯수 저장될 변수    ok
	int pagePerBlock = 3; // 하나의 블럭당 묶여질 페이지번호 갯수 저장될 변수  ok
				  //  1   2    3   <-  한블럭으로 묶음   3개 이겠죠?  
						  
    int totalPage = 0; //전체 총글의 갯수에 대한 총 페이지번호 갯수  저장될 변수 --  [4] 가서 살펴보기 ok
    int totalBlock = 0;//전체 총 페이지번호 갯수에 대한 총 블럭 갯수 저장될 변수 --  [5] 가서 살펴보기 ok 
    int nowPage = 0; //현재 사용자에게 보여지고 있는 페이지가 위치한 번호 저장(클릭한 페이지번호) -- [7] ok 
    int nowBlock = 0; //현재 사용자에게 보여지고 있는 페이지 번호가 속한 블럭 위치번호 저장 -- [8] ok
    int beginPerPage = 0; //각페이지마다 보여지는 시작 글번호(맨위의 글번호)저장 -- [9] ok
//------------------------[1] 끝   
    

	//조회된 글목록 얻기 
	//BoardController에서 재요청해서 전달한 request에 담긴 ArrayList배열 꺼내오기 	
	ArrayList list = (ArrayList)request.getAttribute("list");
  
	//[2] 조회된 총 글 갯수 얻기 
	totalRecord= (Integer)request.getAttribute("count");

	//[7]페이지 번호를 클릭했다면 클릭한 페이지 번호를 얻어 nowPage변수에 저장 
	if( request.getAttribute("nowPage") != null ){
		nowPage =  Integer.parseInt( request.getAttribute("nowPage").toString() );
	}
	//[8]클릭한 페이지번호가 속한 블럭 위치 번호 구하기 
	if( request.getAttribute("nowBlock") != null){
		nowBlock = Integer.parseInt( request.getAttribute("nowBlock").toString() );
	}	
	//[9] 각 페이지 번호에 보여지는 글목록의 가장위의 글에 대한 글번호 구하기 
	beginPerPage = nowPage *numPerPage;
	//				현재 클릭한 페이지번호 * 한페이지당 보여질 글목록개수 
	/*
		 beginPerpage변수 설명
		 예를 들어 한페이지당 보여질 글의 갯수가 6개라고 가정할떄
		 1번페이지 일 경우 1번에페이지에 보여질 시작 글번호는 6이다.
		 nowPage * numberPage;
		 1페이지번호 * 한페이지당 보여지는 글의 갯수6;   =  시작글번호 6 
	
		 --------------------------------
		 예를 들어 한페이지당 보여질 글의 갯수가 6개라고 가정할떄
		 2번페이지 일 경우 2번페이지에 보여질 시작 글번호는 12이다.
		 nowPage * numberPage;
		 2페이지번호 * 한페이지당 보여지는 글의 갯수6;   =   시작글번호 12 
		
	*/
	
	//[4] 총 글이 몇개인지에 따른  총 페이지 번호 갯수 구하기 
	//계산 공식-> 총페이지 번호 개수 =  총글의 갯수  / 한페이지당 보여질 글 갯수 
	//				totalPage =  totalRecord /	numPerPage		 
	//참고! 하나의 글이 더 오버할 경우 마지막페이지에 하나의 글을 보여줘야 하기 떄문에 올림 처리 
	/*
		예. board테이블에 저장된 전체 글의 갯수가 26개라고 가정했을때....
		   총페이지 번호 갯수는?  한페이지당 만약 5개의 글만 보여지게 한다면
		   총글의 갯수(26)를 한페이지당 보여질 글 갯수(5) 로 나눈 몫->  
				5페이지번호가 나와야 하고 나머지 1개글을 보여줄 페이지번호가 하나더 필요하다 	
		   
	(double)26 -> 26.0  /  5 =  5.2 가 나온다
	
	5.2를 소숫점 첫자리에서 올림처리해서 총 페이지번호 갯수 6으로 만들어 줍니다.
	
	Math.ceil(5.2);  -> 6.0  으로 만들어 줄것이다
	
	6.0 -> 6 으로 만들기 위해   (int)6.0  ->  6으로 만들어 줄수 있다. 
	*/
	totalPage =  (int)Math.ceil( (double)totalRecord / numPerPage );	
	
	
	//[5] 조회된 총글의 갯수의 총페이지번호갯수에 대한  총 블럭 갯수 구하기 
	//공식   총 블럭 갯수 =  총페이지번호갯수 / 한블럭당 묶여질 페이지번호의  갯수 
	/*
		게시판 모습 하단에 
		
		1   2   3  <---- 1블럭
		4   5   6  <-----2블럭
		7 <------3블럭 
	*/
	totalBlock =  (int)Math.ceil( (double)totalPage / pagePerBlock) ;
%>

<center>

<!-- 글제목 하나를 클릭했을때 BoardController로  글정보 조회 요청하는 <form> -->
<form name="frmRead">
	<input type="hidden" name="b_idx">  <%--글번호 --%>
	<input type="hidden" name="nowPage" value="<%=nowPage%>">
	<input type="hidden" name="nowBlock" value="<%=nowBlock%>">
</form>



<h2>자유 게시판</h2>

<table align=center border=0 width=80%>
<tr>
	<td align=left>Total :  Articles(
		<font color=red> <%=nowPage+1%> / <%=totalPage%> Pages </font>)
	</td>
</tr>
</table>

<table align=center width=80% border=0 cellspacing=0 cellpadding=3>
<tr>
	<td align=center colspan=2>
		<table border=0 width=100% cellpadding=2 cellspacing=0>
			<tr align=center bgcolor=#D0D0D0 height=120%>
				<td align="left">번호</td>
				<td align="left">제목</td>
				<td align="left">이름</td>
				<td align="left">날짜</td>
				<td align="left">조회수</td>
			</tr>
<%
//게시판 board테이블에서 조회된 글이 없다면?
	 if(list.isEmpty()){
%>		 
			<tr align="center">
				<td colspan="5">등록된 글이 없습니다.</td>
			</tr>
<%
}else{//게시판 board테이블에 조회된 글이 있다면?(BoardVO객체들이 ArrayList배열에 저장되어 있다면?)
		 
		for(int cnt=beginPerPage;   cnt<(beginPerPage+numPerPage);   cnt++){
	
	if(cnt == totalRecord){
		break;
	}
	  // [ BoardVO, BoardVO, BoardVO, BoardVO, BaordVO, BoardVO, BoardVO ]
	  //     0           1      2        3         4       5          6
	  
	//ArrayList배열에 저장된 BoardVO객체를 얻어 출력 
	BoardVO2 vo = (BoardVO2)list.get(cnt);
%>					
				<td align="left">
					<%=vo.getBoard_idx() %>
				</td>
				<td>
					<%-- 글제목 하나를 클릭했을때 글번호를 이용해 글하나조회하여 보여주자 --%>
					<a href="javascript:fnRead('<%=vo.getBoard_idx()%>')">
						<%=vo.getBoard_title()%>
					</a>
				</td>
				<td align="left"><%=vo.getBoard_name()%></td>
				<td align="left"><%=vo.getBoard_date()%></td>
				<td align="left"><%=vo.getBoard_cnt()%></td>
			</tr>
<%			
		}	 
	 }
%>				
		</table>
	</td>
</tr>
<tr>
	<td><BR><BR></td>
</tr>
<tr>
	<td align="left">Go to Page 
	<%
		if(totalRecord != 0){// 조회한 글갯수가 0이 아니라면?
			
			if(nowBlock > 0){// 조회한 글이 존재하면 페이지번호 또한 존재하며 
							//  페이지 번호가 존재하면 블럭 위치도 존재 하기 떄문에 0 보다 크다면?
	%>			
				<a href="<%=contextPath%>/board2/list.bo?nowBlock=<%=nowBlock-1%>&nowPage=<%=((nowBlock-1)*pagePerBlock)%>">
					◀ 이전 <%=pagePerBlock%>  개 
				</a>
	<%			
			}//if
			
			// 페이지 번호들 반복해서 출력하기 
			for(int i=0;  i<pagePerBlock;  i++){
				
	%>			
				&nbsp;&nbsp;
				<a href="<%=contextPath%>/board2/list.bo?nowBlock=<%=nowBlock%>&nowPage=<%=(nowBlock * pagePerBlock) + i%>">
					<%=(nowBlock * pagePerBlock) + 1 + i %>
					<% if((nowBlock * pagePerBlock) + 1 +i == totalPage) break; %>
				</a>
	<%			
			}//for 반복
			
			if(totalBlock > nowBlock + 1){
	%>			
				<a href="<%=contextPath%>/board2/list.bo?nowBlock=<%=nowBlock+1%>&nowPage=<%=(nowBlock+1)*pagePerBlock%>">
					▶ 다음 <%=pagePerBlock%>개 
			    </a>
	<%			
			}//안쪾 if		
		}//바깥쪽 if
	
	%>
		
	
	
	
	</td>
	<td align=right>
	<%
		//로그인 했으면 아래의 글쓰기 버튼이 보이게 처리 하고
		//로그인 안했으면 글쓰기 버튼 안보이게 숨기자 
		String id = (String)session.getAttribute("id");
		
		if(id == null){//미로그인시 (글쓰기 이미지 버튼 감춤)
	%>		
		<input type="image"
			   id="newContent"
			   src="<%=contextPath%>/boarders2/images/write.gif"
			   onclick="location.href='<%=contextPath%>/board2/write.bo'"
			   style="visibility: hidden;">	
	<%		
		}else{//로그인시 (글쓰기 이미지 버튼 노출)
	%>		
		<input type="image"
			   id="newContent"
			   src="<%=contextPath%>/boarders2/images/write.gif"
			   onclick="location.href='<%=contextPath%>/board2/write.bo'">		
	<%		
		}
	%>
		
	</td>
</tr>
</table>
<BR>

<%-- fnSearch()함수의 리턴값이 false이면  action속성에 적힌 컨트롤러 요청을 하지 않습니다. --%>
<form action="<%=contextPath%>/board2/seachlist.bo" 
      name="search" 
      method="post"
      onsubmit="return fnSearch();">
	
	<table border=0 width=527 align=center cellpadding=4 cellspacing=0>
	<tr>
		<td align=center valign=bottom>
			<select name="keyField" size="1">
				<option value="name"> 이름
				<option value="subject"> 제목
				<option value="content"> 내용
			</select>
			<input type="text" size="16" name="keyWord"  id="word">
			
			<input type="submit" value="찾기">
			
			<input type="hidden" name="nowPage" value= "0">
			<input type="hidden" name="nowBlock" value= "0">
		</td>
	</tr>
	</table>
</form>
	<a href="<%=contextPath%>/board2/list.bo?nowBlock=0&nowPage=0">[처음으로]</a>

</center>	
</BODY>
</HTML>
