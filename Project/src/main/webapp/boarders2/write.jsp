<%@page import="VO.UsersVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
// 	String nowPage = request.getParameter("nowPage");
// 	String nowBlock = request.getParameter("nowBlock");

	//조회한 이메일, 이름, 아이디 를 얻기 위해
	//request에 바인딩된 조회된 정보 얻기 
	UsersVO vo = (UsersVO)request.getAttribute("usersvo"); 
	String email = vo.getEmail();
	String name = vo.getUser_name();
%>
 
<%
	String id = (String)session.getAttribute("id");
	if(id == null){//로그인 하지 않았을경우
%>		
	<script>	
		alert("로그인 하고 글을 작성하세요!"); 
		history.back(); 
 	</script>
<% 	}%>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=EUC-KR">

<title>Insert title here</title>
</head>
<body>

<table width="90%" border="0" cellspacing="0" cellpadding="0">
  <tr height="40"> 
    <td width="41%" style="text-align: left"> &nbsp;&nbsp;&nbsp; 
    	<img src="<%=contextPath%>/boarders/images/board02.gif" width="150" height="30">
    </td>
    <td width="57%">&nbsp;</td>
    <td width="2%">&nbsp;</td>
  </tr>
  <tr> 
    <td colspan="3"><div align="center"><img src="<%=contextPath%>/boarders/images/line_870.gif" width="870" height="4"></div></td>
  </tr>
  <tr> 
    <td colspan="3"><div align="center"> 
        <table width="95%" border="0" cellspacing="0" cellpadding="0">
          <tr> 
            <td height="20" colspan="3"></td>
          </tr>
          <tr> 
            <td colspan="3" valign="top">
            <div align="center"> 
                <table width="100%" height="373" border="0" cellpadding="0" cellspacing="1" class="border1">
                  <tr> 
                    <td width="13%" height="29" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">작 성 자</div>
                    </td>
                    <td width="34%" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="writer" size="20" class="text2" value="<%=name%>" readonly />
                    </td>
                    <td width="13%" height="29" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">아 이 디</div>
                    </td>
                    <td width="34%" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="writer_id" 
                    	size="20" class="text2" value="<%=id%>" readonly/>
                    </td>
                   </tr>
                   <tr>
                    <td width="13%" bgcolor="#e4e4e4">
                    	<div align="center"> 
                        	<p class="text2">메일주소</p>
                      	</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                        <input type="text" name="email" size="40" class="text2" value="<%=email%>" readonly/>
                    </td>
                  </tr>             
                  <tr> 
                    <td height="31" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">제&nbsp;&nbsp;&nbsp;목</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="title" size="70"/>
                    </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#e4e4e4" class="text2">
                    	<div align="center">내 &nbsp;&nbsp; 용</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<textarea name="content" rows="15" cols="100"></textarea>
                    </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#e4e4e4" class="text2">
                    	<div align="center">패스워드</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="password" name="pass"/>
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
            <td width="48%">
            <!-- 등록 버튼 -->
            <div align="right">
            	<a href="" id="registration1">
            		<img src="<%=contextPath%>/boarders2/images/confirm.gif" border="0"/>
           		</a>
            </div>
            </td>
            <td width="10%">
            <!-- 목록보기 -->
            <div align="center">
            	<a href="" id="list">
            		<img src="<%=contextPath%>/boarders2/images/list.gif" border="0"/>
            	</a>
            </div>
            </td>
            <td width="42%" id="resultInsert"></td>
          </tr>
        </table>
      </div></td>
  </tr>
</table>
</form>
	<script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<script type="text/javascript">
		
	//글목록 눌렀을때 
		$("#list").click(function(event) {
			event.preventDefault();
			//board테이블에 저장된 글을 조회 하는 요청!
			location.href="<%=contextPath%>/board2/list.bo?nowBlock=0&nowPage=0"; 
		})
		
	
	
		//새글 정보를 입력하고 등록 이미지를 감싸고 있는 <a>태그를 클릭 했을때
		$("#registration1").click(function(event) {
			
			event.preventDefault();
			
			//작성자 명을 입력할 <input>을 선택해
			var writer = $("input[name=writer]").val();
			//아이디 명을 입력할 <input>을 선택해
			var id = $("input[name=writer_id]").val();
			//작성자의 이메일을 입력 받아 얻는다.
			var email = $("input[name=email]").val();
			//글제목을 입력받아 얻는다.
			var title = $("input[name=title]").val();
			//글내용을 입력받아 얻는다.
			var content = $("textarea[name=content]").val();
			//글 비밀번호를 입력받아 얻는다.
			var pass = $("input[name=pass]").val();
			
			$.ajax({
				type:"post",
				async:true,
				url:"<%=contextPath%>/board2/writePro.bo",
				data:{
					w : writer,
					i : id,
					e : email,
					t : title,
					c : content,
					p : pass
				},
				dataType : "text",
				success:function(data){
					console.log(data);
					
					if(data == "1"){
						$("#resultInsert").text("글 작성 완료!").css("color","green");
						setTimeout(function() {
				            location.href = "<%=contextPath%>/board2/list.bo?nowBlock=0&nowPage=0";
				        }, 500); // 0.5초 대기
					}else{//"0"
						$("#resultInsert").text("글 작성 실패!").css("color","red");
					}
				},
				
				
				
			});
			
		})
		
	</script>
</body>
</html>