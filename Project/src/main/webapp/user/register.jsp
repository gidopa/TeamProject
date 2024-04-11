
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" 
	 %>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<% 
	request.setCharacterEncoding("UTF-8"); 
	String contextPath = request.getContextPath();
%>

<!DOCTYPE html>
<html>
	<head>
        <meta charset="utf-8" />
        <meta http-equiv="X-UA-Compatible" content="IE=edge" />
        <meta name="viewport" content="width=device-width, initial-scale=1, shrink-to-fit=no" />
        <meta name="description" content="" />
        <meta name="author" content="" />
        <title>Inflearn 회원가입</title>
        <link href="../css/styles.css" rel="stylesheet" />
        <script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js" crossorigin="anonymous"></script>
        <script type="text/javascript" src="http://code.jquery.com/jquery-latest.min.js"></script>
       <script type="text/javascript">
      function validateForm() {
    	  var id = document.getElementById("id").value;
    	  var pwd = document.getElementById("pwd").value;
    	  var pwdConfirm = document.getElementById("pwdConfirm").value;
    	  var name = document.getElementById("name").value;
    	  var tel = document.getElementById("tel").value;
    	  var email = document.getElementById("email").value;
    	  var addr = document.getElementById("addr").value;
    	  
    	if(id === '') {
    		alert('아이디를 입력하세요.');
    		return false;
    	}
    	
    	if(pwd === '' && pwd.length < 8 || pwd.length > 10) {
    		alert('비밀번호를 입력하세요.');
    		return false;
    	}
    	
    	if(pwdConfirm !== pwd) {
    		alert('비밀번호 확인을 맞게 입력하세요.');
    		return false;
    	}
    	
    	if(tel === '') {
    		alert('전화번호를 입력하세요.');
    		return false;
    	}
    	
    	if(email === '') {
    		alert('이메일을 입력하세요.');
    		return false;
    	}
    	
    	if(addr === '') {
    		alert("주소를 입력하세요.");
    		return false;
    	}
    	
    	var checkboxes = document.querySelectorAll('input[name="categories"]:checked');
    	if(checkboxes.length === 0) {
    		alert('하나 이상의 관심사를 선택하세요.');
    		return false;
    	}
    	
    	alert('환영합니다!')
    	return true;
      }
    	
      	function checkDuplicate() {
      		var id = document.getElementById("id").value;
      		
       		//입력한 아이디가 DB에 저장되어 있는지 없는지 확인 요청
    		//Ajax기술을 이용 하여 비동기 방식으로 MemberController로 합니다.
    		$.ajax({  
    			url : "http://localhost:8083/Project/users/joinIdCheck.me", //요청할 주소
    			type : "post",  //전송요청방식 설정! get 또는 post 둘중 하나를 작성
    			async : true,  //true는 비동기방식 , false는 동기방식 으로 서버페이지 요청!
    			data : {id : id}, //서버 페이지로 요청할 변수명 : 값
    			dataType : "text", //서버페이지로 부터 응답 받을 데이터 종류 설정!
    							   //종류는 json 또는 xml 또는 text중 하나 설정!
    			
    			//전송요청과 응답통신에 성공했을때
    			//success 속성에 적힌 function(data,textStatus){}이 자동으로 호출된다.
    			// data매개변수로는 서버페이지가 전달한 응답 데이터가 넘어옵니다.
    			success : function(data,textStatus){
    				//서버페이지에서 전송된 아이디 중복? 인지 아닌지 판단하여
    				//현재 join.jsp화면에 보여주는 처리 구문 작성
    				if(data=='usable'){ //아이디가 DB에 없으면?
    					$("#chkId").text(" | 사용할 수 있는 ID 입니다.").css("color","blue");
    				}else if(data=="not_usable"){ //아이디가 DB에 있으면?
    					$("#chkId").text(" | 이미 사용중인 ID입니다.").css("color","red");
    				}else {
    					$("#chkId").text(" | ID를 입력하세요.").css("color","red");
    				}
    				
    			}
    			
    		});
      		
      		
      		
      		
      		
      	}
        		
        </script>
    </head>
    <body class="bg-primary">
        <div id="layoutAuthentication">
            <div id="layoutAuthentication_content">
                <main>
                    <div class="container">
                        <div class="row justify-content-center">
                            <div class="col-lg-7">
                                <div class="card shadow-lg border-0 rounded-lg mt-5">
                                    <div class="card-header"><h3 class="text-center font-weight-light my-4">학생 / 강사 등록하기</h3></div>
                                    <div class="card-body">
                                        <form action="<%=contextPath%>/users/usersregisterPro.me" method="post" onsubmit="return validateForm()">
                                        	<%-- <div class="form-floating mb-3">
                                        
                                        	</div> --%>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="id" type="text" name="id" />
                                                <label for="id">아이디<span><small id="chkId"></small></span></label>
                                                
                                                <input type="button" onclick="checkDuplicate()" value="중복확인">
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="pwd" type="password" name="pwd" />
                                               <label for="pwd">비밀번호<span style="color: grey;" id="pwdSpan"><small id="pwdMsg">&nbsp;| 비밀번호는 8자~16자 사이로 입력해주세요</small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="pwdConfirm" type="password" />
                                                <label for="pwdConfirm">비밀번호 확인<span style="color: grey;"><small id="pwdConfrimMsg">&nbsp;| 비밀번호와 똑같이 입력해주세요.</small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="name" type="text" name="name" />
                                                <label for="name">이름</label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="tel" type="text" name="tel" />
                                                <label for="mobile">전화번호<span style="color: grey;"><small>&nbsp;| ex) 010-1234-5678 </small></span></label>
                                            </div>
                                            <%-- <div class="form-floating mb-3">
                                                <input class="form-control" id="ssn" type="text" name="ssn" />
                                                <label for="ssn">주민등록번호<span style="color: grey;"><small>&nbsp;| ex) 901203-1234567 </small></span></label>
                                            </div> --%>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="email" type="email" name="email" />
                                                <label for="email">이메일<span style="color: grey;"><small>&nbsp;| test@example.com</small></span></label>
                                            </div>
                                            <div class="form-floating mb-3">
                                                <input class="form-control" id="addr" type="text" name="addr" />
                                                <label for="addr">주소</label>
                                            </div>
                                            <div class="row mb-3" id="fac_dep">
                                                <%--<div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <select class="form-control" id="faculty" name="faculty">
                                                        </select>
                                                        <label for="faculty">학부</label>
                                                    </div>
                                                </div>
                                                <div class="col-md-6">
                                                    <div class="form-floating mb-3 mb-md-0">
                                                        <select class="form-control" id="dept" name="dept">
                                                        </select>
                                                        <label for="dept">전공</label>
                                                    </div>
                                                </div>--%>
                                                
                                                <fieldset>
												  <legend>관심사를 선택하세요</legend>
												  <div>
												    <input type="radio" id="categories" name="categories" value="frontend" />
												    <label for="frontEnd">프론트엔드</label>
												  </div>
												  <div>
												    <input type="radio" id="categories" name="categories" value="backend" />
												    <label for="backEnd">백엔드</label>
												  </div>
												  <div>
												    <input type="radio" id="categories" name="categories" value="ai" />
												    <label for="ai">AI</label>
												  </div>
												</fieldset>
                                            </div>
                                            
                                            <div class="mt-4 mb-0">
                                                <div class="d-grid"><button type="submit">등록하기</button></div>
                                            </div>
                                        </form>
                                    </div>
                                    <div class="card-footer text-center py-3">
                                        <div class="small"><a href="login.jsp">계정이 있으신가요? 로그인하러 가기</a></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </main>
            </div>
            <div id="layoutAuthentication_footer">
                <footer class="py-4 bg-light mt-auto">
                    <div class="container-fluid px-4">
                        <div class="d-flex align-items-center justify-content-between small">
                            <div class="text-muted">Copyright &copy; Your Website 2023</div>
                            <div>
                                <a href="#">Privacy Policy</a>
                                &middot;
                                <a href="#">Terms &amp; Conditions</a>
                            </div>
                        </div>
                    </div>
                </footer>
            </div>
        </div>
        <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js" crossorigin="anonymous"></script>
        
       
    </body>
</html>