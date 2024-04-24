<%@page import="VO.UsersVO"%>
<%@page import="VO.BoardVO2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
 

<%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	
	//부모글의 글 번호를 전달받아
	//DB로부터 부모글의 b_group열 값과, b_level열값을 조회 해야 합니다. 그래서 받아 온 것입니다.
	String b_idx = (String)request.getAttribute("b_idx");
	UsersVO vo = (UsersVO)request.getAttribute("vo"); 
	
  
	String id = (String)session.getAttribute("id");
	if(id == null){//로그인 하지 않았을경우
%>		
	<script>	
		alert("로그인을 하셔야 작성하실수 있습니다.");
		history.back();
	</script>
<%
	}
                    
%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>답변글 작성 화면</title>
</head>
<body>
	<p id="t" align="center" style="background-color:aqua">답변글 작성 화면</p>

<form action="<%=contextPath%>/board2/replyPro.do" method="post" onsubmit="return check();">		
	
	<%--답변글(자식글)을 DB에 Insert하기 위해 주글(부모글)의 글번호를 같이 전달 합니다. --%>
	<input type="hidden" name="super_b_idx" value="<%=b_idx%>">
	
	<%--답변글을 작성하는 사람의 ID를 전달합니다. --%>
	<input type="hidden" name="id" value="<%=id%>">			
	
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
												&nbsp;&nbsp; <input type="text" name="writer" id="writer" value="<%=vo.getUser_name()%>" readonly>
											</td>
											<td width="13%" bgcolor="#e4e4e4">
												<div align="center">
													<p class="text2">이메일</p>
												</div></td>
											<td width="40%" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="email" name="email" id="email" value="<%=vo.getEmail()%>" readonly>
											</td>
										</tr>
										<tr>
											<td height="31" bgcolor="#e4e4e4" class="text2">
												<div align="center">제&nbsp;&nbsp;&nbsp; &nbsp; 목</div>
											</td>
											<td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="text" name="title" id="title">
											</td>
										</tr>
										<tr>
											<td height="245" bgcolor="#e4e4e4" class="text2">
												<div align="center">내 &nbsp;&nbsp; 용</div>
											</td>
											<td colspan="3" bgcolor="#f5f5f5" style="text-align: left; vertical-align: top;">
												&nbsp; <textarea rows="20" cols="100" name="content" id="content" ></textarea>
											</td>
										</tr>
										<tr>
											<td bgcolor="#e4e4e4" class="text2">
												<div align="center">패스워드</div>
											</td>
											<td colspan="2" bgcolor="#f5f5f5" style="text-align: left">
												<input type="password" name="pass" id="pass" />
											</td>
											<td colspan="2" bgcolor="#f5f5f5" style="text-align: left">
												<p id="pwInput"></p>
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
								<%--답변달기 --%>
									<input type="image" src="<%=contextPath%>/boarders/images/reply.gif" id="reply" />&nbsp;&nbsp; 
								</div>
							</td>
							<td width="10%">
								<div align="center">
									<input type="image" 
											src="<%=contextPath%>/boarders/images/list.gif"
											id="list" 
											onclick="location.href='<%=contextPath%>/board1/list.bo?nowBlock=0&nowPage=0'" />&nbsp;
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
</form>	
	<script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
	<script type="text/javascript">
		function check(){
			var writer = $("input[name='writer']").val();
			var email = $("input[name='email']").val();
			var title = $("input[name='title']").val();
			var content = $("input[name='content']").val();
			var pass = $("input[name='pass']").val();
			
			if( writer == "" || email == "" || title == "" || content == "" || pass == "" )
				{
					$("#pwInput").text("모두 작성해 주세요.").css("color","red");
					return false;
				}
				return true;
		}
	
	
	
	</script>
	
	
</body>
</html>