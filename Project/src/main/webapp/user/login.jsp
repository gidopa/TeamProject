<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
request.setCharacterEncoding("UTF-8");
String contextPath = request.getContextPath();
String clientId = "RXYk8HbDBVuINgLo77fM";//애플리케이션 클라이언트 아이디값";
String redirectURI = URLEncoder.encode("http://localhost:8083/Project/Naver/api", "UTF-8");
SecureRandom random = new SecureRandom();
String state = new BigInteger(130, random).toString();
String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code" + "&client_id=" + clientId
		+ "&redirect_uri=" + redirectURI + "&state=" + state;
session.setAttribute("state", state);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>Inflearn 로그인</title>
<link href="../css/styles.css" rel="stylesheet" />
<script src="https://use.fontawesome.com/releases/v6.3.0/js/all.js"
	crossorigin="anonymous"></script>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>
<script type="text/javascript" src="./jquery.cookie.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/crypto-js/4.1.1/crypto-js.min.js"></script>
<style type="text/css">
.input {
	position: relative;
}

.eyes {
	color: #2b2b2b;
	opacity: 0.8;
	position: absolute;
	right: 7px;
	top: 50%;
	transform: translateY(-50%);
	border: none;
	background-color: rgba(0, 0, 0, 0);
}
</style>
</head>
<body class="bg-primary">
	<div id="layoutAuthentication">
		<div id="layoutAuthentication_content">
			<main>
				<div class="container">
					<div class="row justify-content-center">
						<div class="col-lg-5">
							<div class="card shadow-lg border-0 rounded-lg mt-5">
								<div class="card-header">
									<h3 class="text-center font-weight-light my-4">로그인하기</h3>
								</div>
								<div class="card-body">
									<form action="<%=contextPath%>/users/loginPro.me" method="post">
										<%-- <div class="form-check mb-3" style="align-content: center;">
                                            	<input type="radio" id="professor" value="교수" name="job" checked="checked"> 교수
                                            	&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
                                            	<input type="radio" id="student" value="학생" name="job"> 학생 
                                            	&nbsp;&nbsp;&nbsp; | &nbsp;&nbsp;&nbsp;
                                            	<input type="radio" id="employee" value="교직원" name="job"> 교직원
                                            </div> --%>
										<div class="form-floating mb-3">
											<input class="form-control" id="id" type="text" name="id"
												placeholder="202310001" /> <label for="inputId">아이디</label>
										</div>
										<div class="form-floating mb-3 input">
											<input class="form-control active" id="pwd" type="password"
												name="pwd" placeholder="Password" />
											<button type="button" class="showPwd eyes">
												<i class="fa fa-eye fa-lg"></i>
											</button>
											<button type="button" class="hidePwd eyes">
												<i class="fa fa-eye-slash fa-lg"></i>
											</button>
											<label for="inputPassword">비밀번호 </label>

										</div>
										<div class="form-check mb-3">
											<input class="form-check-input" id="inputRememberPassword"
												type="checkbox" value="" /> <label class="form-check-label"
												for="inputRememberPassword">30일동안 비밀번호 기억하기</label>
										</div>
										<div class="d-flex align-items-right mb-0">
											<input type="submit" class="btn btn-primary" value="로그인">
										</div>
										<div>
											<a href="<%=apiURL%>"><img height="50"
												src="http://static.nid.naver.com/oauth/small_g_in.PNG" /></a>
									
											<!-- ****************카카오 로그인 redirect_uri 조심할것!!!!! ************ -->
											<a
												href="https://kauth.kakao.com/oauth/authorize?response_type=code&client_id=7b619653ec29fa76d72250cd1d4fe5e1&redirect_uri=http://localhost:8083/Project/kakao/kakaoLogin"><img
												class="kakao-login"
												src="kakaologin/kakao_login_medium_narrow.png"></a>
										</div>
									</form>
								</div>
								<div class="card-footer text-center py-3">
									<div class="small">
										<a href="register.jsp">회원가입하러 가기</a>
									</div>
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
	<script type="text/javascript">
        	$('.hidePwd').hide();
        	$('.showPwd').hide();
        	
        	if($('#pwd').on('keyup', function() {
        		$('.showPwd').show();
        	}));
        	if($('#pwd').val().length == 0) {
        		$('.showPwd').hide();
        	}
        	
        	$('.eyes').on('click', function() {
				if($('#pwd').hasClass('active')){
					$('#pwd').removeClass('active');
					$('#pwd').attr('type', 'text');
					$('.showPwd').hide();
					$('.hidePwd').show();
				} else {
					$('#pwd').addClass('active');
					$('#pwd').attr('type', 'password');
					$('.hidePwd').hide();
					$('.showPwd').show();
				}
			});
        	
        	<%-- 
        	// Create a password for the user
        	var password = '';
        	var $job = $('input[name="job"]');
	    	var $id = $('#id');
        	
	    	$job.click(function() {
				var selectedVal = $(this).val();
				$job.prop('checked', false);
				$(this).prop('checked', true);
				
// 				console.log('selval: ', selectedVal);
// 				console.log('id: ', $id.val());
				
				if(selectedVal == '교수') {
					$.ajax({
						url : '<%=request.getContextPath()%>/register/checkP.me',
						type : 'POST',
						data : {id: $id.val(), job: selectedVal},
						dataType : 'json',
						success : function(data) {
							$.each(data, function(index, dto) {
// 								console.log(dto.pwd);
								password = dto.pwd;
							});
						}
					});
				} else if (selectedVal == '학생') {
					$.ajax({
						url : '<%=request.getContextPath()%>/register/checkS.me',
						type : 'POST',
						data : {id: $id.val(), job: selectedVal},
						dataType : 'json',
						success : function(data) {
							$.each(data, function(index, dto) {
// 								console.log(dto.pwd);
								password = dto.pwd;
							});						
						}
					});
				} else if (selectedVal == '교직원') {
					$.ajax({
						url : '<%=request.getContextPath()%>/register/checkE.me',
						type : 'POST',
						data : {id: $id.val(), job: selectedVal},
						dataType : 'json',
						success : function(data) {
							$.each(data, function(index, dto) {
// 								console.log(dto.pwd);
								password = dto.pwd;
							});						
						}
					});
				}
				
			});
        	/* 
        	// Encrypt the password using a secure encryption algorithm, such as AES
        	var encryptedPassword = CryptoJS.AES.encrypt(password, "");

        	// Create a cookie to store the encrypted password
        	document.cookie = "password=" + encryptedPassword + ";";

        	// Set the cookie's expiration date to the desired length of time
        	var date = new Date();
        	date.setTime(date.getTime() + (1 * 60 * 1000)); // 1 hour
        	document.cookie = "password=" + encryptedPassword + "; expires=" + date.toUTCString() + ";";
        	 */
        	const rememberPwd = $('#inputRememberPassword');
        	rememberPwd.on('change', function() {
        		
        		if(rememberPwd.is(':checked')) {
        			//로그인 아이디 쿠키 가져오기
        			alert('기억!');
        			if($.cookie == 'null') {
        				alert('쿠키저장');
	        			$.cookie('pwd', password, {expires:30, path:'/'});
        			} else {
        				$('#pwd').on('focus', function() {
	        				$('#pwd').val( $.cookie('pwd') );
						});
        			}
        			
        		} else {
        			//로그인 아이디 쿠키 제거
        			alert('망각!');
        			$.removeCookie('pwd', {path: '/'});
        		}
        	});
        	 --%>
        </script>
</body>
</html>