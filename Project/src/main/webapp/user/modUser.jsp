
<%@page import="DAO.UsersDAO"%>
<%@page import="VO.UsersVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%!String name;
	String id;
	String phone_number;
	String email;
	String address;
	
	String pre_pwd;
	%>

<%
request.setCharacterEncoding("UTF-8");
String contextPath = request.getContextPath();
%>

<%
id = (String) session.getAttribute("id");

UsersDAO usersDAO = new UsersDAO();
UsersVO usersVO = usersDAO.selectUser(id);

name = usersVO.getUser_name();
phone_number = usersVO.getPhone_number();
email = usersVO.getEmail();
address = usersVO.getAddress();

pre_pwd = usersVO.getPassword();


%>

<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Inflearn 회원정보 수정</title>
<link
	href="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/style.min.css"
	rel="stylesheet" />
<link href="../css/styles.css" rel="stylesheet" />
<script src="../js/scripts.js"></script>
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<style type="text/css">
.info_title {
	font-size: 12px;
	font-weight: 400;
	align-items: center;
}

.info {
	font-size: 16px;
	font-weight: 600;
	align-items: center;
}

hr {
	width: 100%;
	align-items: center;
	color: grey;
}

#btn {
	margin-left: 90%;
}

input {
	border: 1px solid grey;
}

@media ( max-width : 1200px) {
	#btn {
		margin-left: 80%;
	}
}
</style>
<script type="text/javascript">
        	$(function() {
        		
        		$("#pre_pwd").focusout(function() {
    				
        	
        	    		//입력한 비밀번호와 기존 비밀번호가 일치하는지 확인
        	    		$.ajax({  
        	    			url : "http://localhost:8083/Project/project1/users/modPwdCheck.me", //요청할 주소
        	    			type : "post",  //전송요청방식 설정! get 또는 post 둘중 하나를 작성
        	    			async : true,  //true는 비동기방식 , false는 동기방식 으로 서버페이지 요청!
        	    			data : {id : $("#id").val(),
        	    				pre_pwd : $("#pre_pwd").val()}, //서버 페이지로 요청할 변수명 : 값
        	    			dataType : "text", //서버페이지로 부터 응답 받을 데이터 종류 설정!
        	    							   //종류는 json 또는 xml 또는 text중 하나 설정!
        	    			
        	    			//전송요청과 응답통신에 성공했을때
        	    			//success 속성에 적힌 function(data,textStatus){}이 자동으로 호출된다.
        	    			// data매개변수로는 서버페이지가 전달한 응답 데이터가 넘어옵니다.
        	    			success : function(data,textStatus){
        	    				
        	    				if(data=='usable'){ //비밀번호가 일치하면?
        	    					$("#pre_pwdMsg").text("기존 비밀번호와 일치합니다.").css("color","blue");
        	    				}else{ // 일치하지 않으면?
        	    					$("#pre_pwdMsg").text("기존 비밀번호와 일치하지 않습니다.").css("color","red");
        	    				}
        	    				
        	    			}
        	    			
        	    		});
        	    		
            		
        		});
        		
        		
        		/* 비밀번호 확인 */
				$("#pwdConfirm").focusout(function() {
				
					var $pwd = $("#pwd").val();
					var $pwdConfirm = $("#pwdConfirm").val();
					var $msg = $("#pwdConfirmMsg");
					
					if($pwd != $pwdConfirm) {
						$msg.attr('style', 'color:red; font-size: small;');
						$msg.text("비밀번호가 일치하지 않습니다.");
						
						return false;
					} else {
						$msg.attr('style', 'color:grey; font-size: small;');
						$msg.text("비밀번호가 일치합니다.");
						return true;
					}
				});//비밀번호 확인
				
				/* 비밀번호 유효성 체크 */
				$("#pwd").focusout(function() {
					
					var $pwd = $("#pwd").val();
					var $msg = $("#pwdMsg");
					
					if( $pwd.length < 8 || $pwd.length > 16 ) {
						$msg.attr("style", "color:red; font-size:small;");
						$msg.text("비밀번호는 8자~16자 사이로 입력해주세요");
						
						return false;
					} else {
						$msg.text("");
						return true;
					}
					
				
				}); //비밀번호 유효성
        		
				
	        	
			});
        	/*수정하기 눌렀을때*/
        	function check() {
        		
        		var pre_pwdMsg = document.getElementById("pre_pwdMsg");
        		var pwdMsg = document.getElementById("pwdMsg");
        		var pwdConfirmMsg = document.getElementById("pwdConfirmMsg");
        		
        		if (pre_pwdMsg.innerText == "기존 비밀번호와 일치하지 않습니다.") {
        			window.alert("기존 비밀번호를 확인하세요.");
        			return false;
        		} 
        		
        		if (pwdMsg.innerText == "비밀번호는 8자~16자 사이로 입력해주세요") {
        			window.alert("비밀번호는 8자~16자 사이로 입력해주세요.");
        			return false;
        		}
        		
        		if(pwdConfirmMsg.innerText == "비밀번호가 일치하지 않습니다.") {
        			window.alert("새 비밀번호와 비밀번호 확인이 일치하지 않습니다.");
        			return false;
        		} 
        		
        		return true;
        	}
        </script>
</head>
<body class="sb-nav-fixed">
	<nav class="sb-topnav navbar navbar-expand navbar-dark bg-dark">
		<%--  <jsp:include page="/inc/logo.jsp" /> --%>
	</nav>
	<div id="layoutSidenav">
		<div id="layoutSidenav_nav">
			<nav class="sb-sidenav accordion sb-sidenav-dark"
				id="sidenavAccordion">
				<%--사이드바--%>
				<%-- <jsp:include page="/inc/menu.jsp" /> --%>
			</nav>
		</div>
		<div id="layoutSidenav_content">
			<main>
				<div class="container-fluid px-4">
					<h1 class="mt-4">회원정보 수정</h1>
					<ol class="breadcrumb mb-4">
						<li class="breadcrumb-item active">my-info</li>
					</ol>
					<div class="col-xl-12 col-lg-7">
						<div class="card shadow mb-4">
							<div
								class="card-header py-3 d-flex flex-row align-items-center justify-content-between">
								<h4 class="m-0 font-weight-bold text-primary">정보 수정</h4>
							</div>
							<div class="card-body">
								<div class="chart-area">
									<div class="chartjs-size-monitor">
										<div class="chartjs-size-monitor-expand">
											<div class=""></div>
										</div>
										<div class="chartjs-size-monitor-shrink">
											<div class=""></div>
										</div>
									</div>
									<form action="<%=contextPath %>/users/modUserPro.me" onsubmit="return check();">
										<div class="container-fluid">
											<div class="row">
												<%
												if (id != null) {
												%>
												<div class="col-md-12">
													<div class="row">
														<div class="col-md-2">
															<span class="info_title">이름</span>
														</div>
														<div class="col-md-10">
															<input type="text" value="<%=name %>" class="info" name="name">
														</div>
														<br> <br>
														<hr>
														
														<div class="col-md-2">
															<span class="info_title">아이디</span>
														</div>
														<div class="col-md-10">
															<input type="text" value="<%=id%>" class="info" name="id" id="id"
																readonly> <input type="hidden" value=""
																name="id">
														</div>
														<br> <br>
														<hr>
														<div class="col-md-2">
															<span class="info_title">기존 비밀번호</span>
														</div>
														<div class="col-md-10">
															<input type="password" class="info" name="pre_pwd" id="pre_pwd">
															<span id="pre_pwdMsg"></span> <input type="hidden" value=""
																name="hidden_pre_pwd">
														</div>
														<br> <br>
														<hr>
														
														<div class="col-md-2">
															<span class="info_title">비밀번호 변경</span>
														</div>
														<div class="col-md-10">
															<input type="password" class="info" name="pwd" id="pwd">
															<span id="pwdMsg"></span> <input type="hidden" value=""
																name="pwd">
														</div>
														<br> <br>
														<hr>
														<div class="col-md-2">
															<span class="info_title">비밀번호 확인</span>
														</div>
														<div class="col-md-10">
															<input type="password" class="info" name="pwdConfirm"
																id="pwdConfirm"> <span id="pwdConfirmMsg"></span>
														</div>
														<br> <br>
														<hr>
														<%-- <div class="col-md-2">
														<span class="info_title">주민등록번호</span>
													</div>
													<div class="col-md-10">
														<input type="text" value="<%=dto.getSsn().substring(0, 8) %>******" name="ssn" disabled>
														<input type="hidden" value="<%=dto.getSsn() %>" name="ssn">
													</div>
													<br><br><hr> --%>
														<div class="col-md-2">
															<span class="info_title">연락처</span>
														</div>
														<div class="col-md-10">
															<input type="text" value="<%=phone_number %>" class="info" name="tel" id="tel">
														</div>
														<br> <br>
														<hr>
														<div class="col-md-2">
															<span class="info_title">이메일</span>
														</div>
														<div class="col-md-10">
															<input type="text" value="<%=email %>" class="info" name="email" id="email">
														</div>
														<br> <br>
														<hr>
														<div class="col-md-2">
															<span class="info_title">주소</span>
														</div>
														<div class="col-md-10">
															<input type="text" value="<%=address %>" class="info" name="addr" id="addr">
														</div>
														<br> <br>
														<hr>
														<!-- <div class="col-md-2 faculty">
														<span class="info_title">학부</span>
													</div>
													<div class="col-md-10 faculty">
														<input type="text" value="" class="info" name="faculty" disabled>
														<input type="hidden" value="" name="faculty">
													</div>
													<br class="faculty"><br class="faculty"><hr class="faculty">
													<div class="col-md-2 dept">
														<span class="info_title">전공</span>
													</div>
													<div class="col-md-10 dept">
														<input type="text" value="" class="info" name="dept" disabled>
														<input type="hidden" value="" name="dept">
													</div> -->

														<div class="col-md-10 interest">
															<fieldset>
																<legend>관심사를 선택하세요</legend>
																<div>
																	<input type="radio" id="frontEnd" name="categories"
																		value="frontEnd" /> <label for="frontend">프론트엔드</label>
																</div>
																<div>
																	<input type="radio" id="backEnd" name="categories"
																		value="backEnd" /> <label for="backend">백엔드</label>
																</div>
																<div>
																	<input type="radio" id="ai" name="categories"
																		value="ai" /> <label for="ai">AI</label>
																</div>
															</fieldset>
														</div>
														<br class="dept"> <br class="dept">
														<hr class="dept">
														<small><input type="submit" id="btn" value="수정하기"></small>
													</div>
												</div>
												<%
												} else {
												%>
												<script type="text/javascript">
														alert('로그인이 필요한 페이지입니다. \r\n로그인 후 다시 이용해주세요.');
														location.href = 'login.jsp';
													</script>
												<%
												}
												%>
											</div>
										</div>
									</form>
								</div>
							</div>
						</div>
					</div>
				</div>
				<%--                     <jsp:include page="../inc/chat.jsp"></jsp:include> --%>
			</main>
			<footer class="py-4 bg-light mt-auto">
				<div class="container-fluid px-4">
					<div
						class="d-flex align-items-center justify-content-between small">
						<div class="text-muted">Copyright &copy; Your Website 2023</div>
						<div>
							<a href="#">Privacy Policy</a> &middot; <a href="#">Terms
								&amp; Conditions</a>
						</div>
					</div>
				</div>
			</footer>
		</div>
	</div>
	<script
		src="https://cdn.jsdelivr.net/npm/bootstrap@5.2.3/dist/js/bootstrap.bundle.min.js"
		crossorigin="anonymous"></script>
	<script src="js/scripts.js"></script>
	<script
		src="https://cdnjs.cloudflare.com/ajax/libs/Chart.js/2.8.0/Chart.min.js"
		crossorigin="anonymous"></script>
	<script src="assets/demo/chart-area-demo.js"></script>
	<script src="assets/demo/chart-bar-demo.js"></script>
	<script
		src="https://cdn.jsdelivr.net/npm/simple-datatables@7.1.2/dist/umd/simple-datatables.min.js"
		crossorigin="anonymous"></script>
	<script src="js/datatables-simple-demo.js"></script>
</body>
</html>
