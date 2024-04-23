<%@page import="VO.BoardVO"%> 
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 

<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	
	//조회한 글정보 얻기
	BoardVO vo = (BoardVO)request.getAttribute("vo");
	String name = vo.getB_name();//조회한 글을 작성한 사람
	String email = vo.getB_email();//조회한 글을 작성한 사람의 이메일
	String title = vo.getB_title();//조회한 글제목
	String content = vo.getB_content().replace("/r/n", "<br>");//조회한 글 내용
	
	String b_idx = (String)request.getAttribute("b_idx");
	String nowPage = (String)request.getAttribute("nowPage");
	String nowBlock = (String)request.getAttribute("nowBlock");
	
%>


<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 수정 화면</title>
</head>
<body>
<%
	String id = (String)session.getAttribute("id");
	if(id == null){//로그인 하지 않았을경우
%>		
	<script>	
		alert("로그인을 하셔야 합니다.");
		history.back();
	</script>
<%
	}

%>
	<table width="80%" border="0" cellspacing="0" cellpadding="0">
		<tr height="40">
			<td width="41%" style="text-align: left">&nbsp;&nbsp;&nbsp; 
				<img src="<%=contextPath%>/boarders/images/board02.gif" width="150" height="30">
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<div align="center">
					<img src="<%=contextPath%>/boarders/images/line_870.gif" width="870" height="4">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<div align="center">
					<table width="95%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="20" colspan="3"></td>
						</tr>
						<tr>
							<td height="327" colspan="3" valign="top">
								<div align="center">
									<table width="95%" height="373" border="0" cellpadding="0" cellspacing="1" class="border1">
										<tr>
											<td width="13%" height="29" bgcolor="#e4e4e4" class="text2">
												<div align="center">작 성 자</div>
											</td>
											<td width="34%" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="text" name="writer" id="writer" value="<%=name%>" disabled>
											</td>
											<td width="13%" bgcolor="#e4e4e4">
												<div align="center">
													<p class="text2">이메일</p>
												</div></td>
											<td width="40%" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="email" name="email" id="email" value="<%=email%>" disabled>
											</td>
										</tr>
										<tr>
											<td height="31" bgcolor="#e4e4e4" class="text2">
												<div align="center">제&nbsp;&nbsp;&nbsp; &nbsp; 목</div>
											</td>
											<td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="text" name="title" id="title" value="<%=title%>" disabled>
											</td>
										</tr>
										<tr>
											<td height="245" bgcolor="#e4e4e4" class="text2">
												<div align="center">내 &nbsp;&nbsp; 용</div>
											</td>
											<td colspan="3" bgcolor="#f5f5f5" style="text-align: left; vertical-align: top;">
												&nbsp; <textarea rows="20" cols="100" name="content" id="content" disabled><%=content%></textarea>
											</td>
										</tr>
										<tr>
											<td bgcolor="#e4e4e4" class="text2">
												<div align="center">패스워드</div>
											</td>
											<td colspan="2" bgcolor="#f5f5f5" style="text-align: left">
												<input type="password" name="pass" id="pass" />
											</td>
											<td colspan="2" bgcolor="#f5f5f5" style="text-align: center;">
												<p id="pwInput">글수정,삭제하려면 패스워드 입력바람</p>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
						<tr>
							<td style="width: 48%">
								<div align="right" id="menuButton" >
								<%--수정하기 --%>	
									<input type="image" src="<%=contextPath%>/boarders/images/update.gif" id="update" style="visibility:hidden" />&nbsp;&nbsp; 
								<%--삭제하기 --%>	
									<input type="image" src="<%=contextPath%>/boarders/images/delete01.gif" id="delete" onclick="javascript:deletePro('<%=b_idx%>');" style="visibility:hidden" />&nbsp;&nbsp; 
								<%--답변달기 --%>
									<input type="image" src="<%=contextPath%>/boarders/images/reply.gif" id="reply" />&nbsp;&nbsp; 
								</div>
							</td>
							<td width="10%">
								<div align="center">
									<%-- 목록 --%>
									<input type="image" 
											src="<%=contextPath%>/boarders/images/list.gif"
											id="list" 
											onclick="location.href='<%=contextPath%>/board/list.bo?nowBlock=<%=nowBlock%>&nowPage=<%=nowPage%>'" />&nbsp;
								</div>
							</td>
							<td width="42%"></td>
						</tr>
						<tr>
							<td colspan="3" style="height: 19px">&nbsp;</td>
						</tr>
					</table>
				</div>
			</td>
		</tr>
	</table>
	
	<%--답변을 눌렀을때 답변을 작성할 수 있는 화면 요청 --%>
	<form action="<%=contextPath%>/board/reply.do" id="replyForm">
		<input type="hidden" name="b_idx" value="<%=b_idx%>" id="b_idx">
		<input type="hidden" name="id" value="<%=id%>"> 
	</form>
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script>
		//답변 <input type="img">를 선택해서 클릭이벤트 등록 
		$("#reply").on("click",function(){
			//바로 위 <form>을 선택해서  답변을 입력하는 화면 요청! 
			$("#replyForm").submit();
			
			
		});
	
	
	
	
		function deletePro(b_idx){
			
			var result = window.confirm("정말로 글을 삭제하시겠습니까?");
			
			if(result == true){//확인 버튼 클릭
				
				//비동기방식으로 글삭제 요청!
				$.ajax({
					type : "post",
					async : true,
					url : "<%=contextPath%>/board/deleteBoard.bo",
					data : {b_idx : b_idx},
					dataType : "text",
					success : function(data){//"삭제성공"  또는 "삭제실패"
						
						if(data=="삭제성공"){
							
							$("#pwInput").text("삭제 성공!").css("color","green");
							//입력하여 수정할 수 있는 <input>2개, <textarea>1개 비활성화
							document.getElementById("email").disabled = true;
							document.getElementById("title").disabled = true;
							document.getElementById("content").disabled = true;
<%-- location.href = "<%=contextPath%>/board/list.bo?nowBlock=0&nowPage=0"; --%>
							
							//강제로 목록 <input>을 클릭 이벤트 발생시키는 부분!
//							$("#list").trigger("click");
							
							// 2초 쉬었다가 강제로 목록 <input>을 클릭 이벤트 발생시키는 부분! 
							// 삭제된 글목록을 확인 하기 위해 글목록 조회를 재요청!~
							setTimeout(function() { $("#list").trigger("click");}, 2000);
							
							
						}else{//"삭제실패"
							$("#pwInput").text("삭제 실패!").css("color","red");
							document.getElementById("email").disabled = false;
							document.getElementById("title").disabled = false;
							document.getElementById("content").disabled = false;
						}
						
						
					},
					error : function(){
						alert("비동기 통신 장애");
					}
				});
				
			}else{//취소 버튼을 눌렀을때
				return false;
			}
		}
	
	
	
	
		//수정 이미지 버튼을 선택해서 가져와서 클릭 이벤트 등록!
		$("#update").click(function() {
			
			var email = $("#email").val(); //수정시 입력한 이메일 얻기
			var title = $("#title").val(); //수정시 입력한 글 제목 얻기
			var content = $("#content").val(); //수정시 입력한 글 내용 얻기
			var idx = $("#b_idx").val(); //수정시 사용할 글번호 얻기
			
			$.ajax({
				type : "post",
				async : true,
				url : "<%=contextPath%>/board/updateBoard.do",
				data : {
					email : email,
					title : title,
					content : content,
					idx : idx
				},
				dataType : "text",
				success : function(data){
// 					console.log(data);
					
					if(data=="수정성공"){
						$("#pwInput").text("수정 성공!").css("color","green");
						//입력하여 수정할 수 있는 <input>2개, <textarea>1개 비활성화
						document.getElementById("email").disabled = true;
						document.getElementById("title").disabled = true;
						document.getElementById("content").disabled = true;
						
					}else{//"수정실패"
						$("#pwInput").text("수정 실패!").css("color","red");
						document.getElementById("email").disabled = false;
						document.getElementById("title").disabled = false;
						document.getElementById("content").disabled = false;
					}
					
				},
				error : function(){
					alert("비동기 통신 장애");
				}
				
				
			});
			
		});
	
	
	
	
	
	
		//수정 삭제를 위해 비밀번호를 입력하고 포커스가 떠난 이벤트가 발생했을때...
		$("#pass").on("focusout",function(){
			
			$.ajax({
				type : "post",
				async : true,
				url : "<%=contextPath%>/board/password.do",
				data : { b_idx : $("#b_idx").val(),        pass : $("#pass").val() },
				dataType : "text", 
				success : function(data){
// 					console.log(data);
					
					if(data=="비밀번호틀림"){
						$("#pwInput").text("글의 비밀번호가 다릅니다.").css("color","red");
						//입력하여 수정할 수 있는 <input>2개, <textarea>1개 비활성화
						document.getElementById("email").disabled = true;
						document.getElementById("title").disabled = true;
						document.getElementById("content").disabled = true;
						$("#update").css("visibility","hidden");
						$("#delete").css("visibility","hidden");
// 						document.getElementById("reply").disabled = true;
// 						document.getElementById("update").disabled = true;
// 						document.getElementById("delete").disabled = true;
					
					}else{//"비밀번호맞음"
						$("#pwInput").text("글의 비밀번호가 일치합니다. 글의 수정 및 삭제가 가능합니다.").css("color","green");
						//글 수정 및 삭제할수 있도록
						//위 비활성화 되어 있던 <input>들을 선택해서 disabled속성의 값을 false로 주어
						//활성화 시켜 입력할수 있도록 보여줌 
						document.getElementById("email").disabled = false;
						document.getElementById("title").disabled = false;
						document.getElementById("content").disabled = false;
						
						//숨겨져 있던 글 수정 이미지<input>과 글삭제 이미지<input>을 다시 보이게 했다
						$("#update").css("visibility","visible");
						$("#delete").css("visibility","visible");
// 						document.getElementById("reply").disabled = false;
// 						document.getElementById("update").disabled = false;
// 						document.getElementById("delete").disabled = false;
					}
					
				},
				error : function(){
					alert("비동기 통신 장애");
				}
			});
		});
	
		
	</script>
	
	
</body>
</html>