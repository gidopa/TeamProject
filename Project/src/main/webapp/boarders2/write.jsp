<%@page import="VO.UsersVO"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<% 
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
// 	String nowPage = request.getParameter("nowPage");
// 	String nowBlock = request.getParameter("nowBlock");

	//��ȸ�� �̸���, �̸�, ���̵� �� ��� ����
	//request�� ���ε��� ��ȸ�� ���� ��� 
	UsersVO vo = (UsersVO)request.getAttribute("usersvo"); 
	String email = vo.getEmail();
	String name = vo.getUser_name();
%>
 
<%
	String id = (String)session.getAttribute("id");
	if(id == null){//�α��� ���� �ʾ������
%>		
	<script>	
		alert("�α��� �ϰ� ���� �ۼ��ϼ���!"); 
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
                    	<div align="center">�� �� ��</div>
                    </td>
                    <td width="34%" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="writer" size="20" class="text2" value="<%=name%>" readonly />
                    </td>
                    <td width="13%" height="29" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">�� �� ��</div>
                    </td>
                    <td width="34%" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="writer_id" 
                    	size="20" class="text2" value="<%=id%>" readonly/>
                    </td>
                   </tr>
                   <tr>
                    <td width="13%" bgcolor="#e4e4e4">
                    	<div align="center"> 
                        	<p class="text2">�����ּ�</p>
                      	</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                        <input type="text" name="email" size="40" class="text2" value="<%=email%>" readonly/>
                    </td>
                  </tr>             
                  <tr> 
                    <td height="31" bgcolor="#e4e4e4" class="text2">
                    	<div align="center">��&nbsp;&nbsp;&nbsp;��</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<input type="text" name="title" size="70"/>
                    </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#e4e4e4" class="text2">
                    	<div align="center">�� &nbsp;&nbsp; ��</div>
                    </td>
                    <td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
                    	<textarea name="content" rows="15" cols="100"></textarea>
                    </td>
                  </tr>
                  <tr> 
                    <td bgcolor="#e4e4e4" class="text2">
                    	<div align="center">�н�����</div>
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
            <!-- ��� ��ư -->
            <div align="right">
            	<a href="" id="registration1">
            		<img src="<%=contextPath%>/boarders2/images/confirm.gif" border="0"/>
           		</a>
            </div>
            </td>
            <td width="10%">
            <!-- ��Ϻ��� -->
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
		
	//�۸�� �������� 
		$("#list").click(function(event) {
			event.preventDefault();
			//board���̺� ����� ���� ��ȸ �ϴ� ��û!
			location.href="<%=contextPath%>/board2/list.bo?nowBlock=0&nowPage=0"; 
		})
		
	
	
		//���� ������ �Է��ϰ� ��� �̹����� ���ΰ� �ִ� <a>�±׸� Ŭ�� ������
		$("#registration1").click(function(event) {
			
			event.preventDefault();
			
			//�ۼ��� ���� �Է��� <input>�� ������
			var writer = $("input[name=writer]").val();
			//���̵� ���� �Է��� <input>�� ������
			var id = $("input[name=writer_id]").val();
			//�ۼ����� �̸����� �Է� �޾� ��´�.
			var email = $("input[name=email]").val();
			//�������� �Է¹޾� ��´�.
			var title = $("input[name=title]").val();
			//�۳����� �Է¹޾� ��´�.
			var content = $("textarea[name=content]").val();
			//�� ��й�ȣ�� �Է¹޾� ��´�.
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
						$("#resultInsert").text("�� �ۼ� �Ϸ�!").css("color","green");
						setTimeout(function() {
				            location.href = "<%=contextPath%>/board2/list.bo?nowBlock=0&nowPage=0";
				        }, 500); // 0.5�� ���
					}else{//"0"
						$("#resultInsert").text("�� �ۼ� ����!").css("color","red");
					}
				},
				
				
				
			});
			
		})
		
	</script>
</body>
</html>