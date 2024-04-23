<%@page import="VO.KakaoLoginVO"%>
<%@page import="VO.NaverLoginVO"%>
<%@ page import="java.net.URLEncoder" %>
<%@ page import="java.net.URL" %>
<%@ page import="java.net.HttpURLConnection" %>
<%@ page import="java.io.BufferedReader" %>
<%@ page import="java.io.InputStreamReader" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

 <%
	request.setCharacterEncoding("UTF-8");
	String contextPath = request.getContextPath();
	KakaoLoginVO kakaoLoginVO = (KakaoLoginVO)request.getAttribute("KakaoLoginVO");
%>

<html>
  <head>
  <!-- Required meta tags -->
	<meta charset="utf-8">
	<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">

	<!-- Bootstrap CSS -->
	<link rel="stylesheet"
	href="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/css/bootstrap.min.css"
	integrity="sha384-JcKb8q3iqJ61gNV9KGb8thSsNjpSL0n8PARn9HuZOnIxN0hoP+VmmDGMN5t9UJ0Z"
	crossorigin="anonymous">
    <title>카카오 로그인 추가정보 입력</title>
  </head>
  <body>

  													<!-- 컨트롤러 수정하는 경우 action태그도 수정필요 -->
<form id="registrationForm" action="<%=contextPath%>/users/KakaoJoin.do" class="form">	
	<div style="height: 100px;"></div>
	<div class="container">
				
		<div class="col-6">
				<label>관심 분야</label>
				<p id="adminInput"></p> 
				<hr> 
				backend
			    <input type="radio" 
					   class="m_admin" 
					   name="m_admin"
					   value="backend"
					   > 
				&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	   
			     fontend
			   <input type="radio" 
					   class="m_admin" 
					   name="m_admin"
					   value="frontend"
					   > 
					   	&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;	
					   ai
			   <input type="radio" 
			   class="m_admin" 
			   name="m_admin"
			   value="ai"
			   > 
		</div>
		
		<div class="row" style="height: 25px;"></div>
		<div class="row justify-content-left">
			<h1>카카오 로그인 추가정보 입력</h1>
		</div>


			<div class="form-group">
				<div class="row">
					<div class="col-6">
						<label>아이디</label> 
						<input type="text" 
							   id="m_id" 
							   name="m_id"
							   class="form-control"
							   value="<%= kakaoLoginVO.getUserId()%>"
							   readonly="readonly">
					    <p id="idInput"></p> 
					</div>
					<div class="col-6">
						<label>비밀번호</label> 
						<input type="password" 
							   id="m_pass" 
							   name="m_pass"
							   class="form-control"
							   placeholder="가입할 비밀번호를 적어주세요."> 
						<p id="passInput"></p>
					</div>
									
				</div>
			</div>
			
			
			<div class="form-group">
				<div class="row">
					<div class="col-6">
						<label>이름</label> 
						<input type="text" 
							   id="m_name" 
							   name="m_name"
							   class="form-control"
							   value="<%=kakaoLoginVO.getName()%>"
							   readonly="readonly"> 
						<p id="nameInput"></p>
					</div>
					
									
				</div>
			</div>
								
			<div class="form-group">
				<div class="row">
					<div class="col-6">
						<%-- name속성값 address1 부터 ~~ address5 까지 입력되어 있는 주소를 모두 합쳐서 DB에 address열에  INSERT 하자. --%>
						<label>주소</label>
						<p id="addressInput"></p> 
						<input type="text" id="sample4_postcode" name="address1" class="form-control" placeholder="우편번호">
						<input type="button" onclick="sample4_execDaumPostcode()" value="우편번호 찾기" class="form-control"><br>
						
						<input type="text" id="sample4_roadAddress" name="address2" placeholder="도로명주소" class="form-control">
						<input type="text" id="sample4_jibunAddress" placeholder="지번주소" name="address3" class="form-control">
						
						<span id="guide" style="color:#999;display:none"></span>
						
						<input type="text" id="sample4_detailAddress" placeholder="상세주소" name="address4" class="form-control">
						<input type="text" id="sample4_extraAddress" placeholder="참고항목"  name="address5" class="form-control">
						
					</div>
					
					
				</div>
			</div>
			
			
			<div class="form-group">
				<div class="row">
					<div class="col-4">
						<label>Email</label> 
						<input type="email" 
							   id="m_email" 
							   name="m_email"
							   class="form-control"
							   value="<%=kakaoLoginVO.getEmail()%>" 
							   readonly="readonly"
							   > 
						<p id="emailInput"></p>
					</div>
					<div class="col-4">
						<label>핸드폰번호</label> 
						<input type="text" 
							   id="m_hp" 
							   name="m_hp"
							   class="form-control"
							   value="<%=kakaoLoginVO.getPhoneNumber()%>"
							   readonly="readonly"> 
						<p id="hpInput"></p>
					</div>												
				</div>
			</div>				
								
			<div class="row">
				<div class="col">
					<div class="col">
						<input type="submit" value="회원가입하기" class="btn btn-primary btn-block">
					</div>
				</div>
			</div>
			<br /> <br /> <br />
		
	</div>
</form>
		<!-- Optional JavaScript -->
		<!-- jQuery first, then Popper.js, then Bootstrap JS -->
		<script src="https://code.jquery.com/jquery-3.5.1.slim.min.js"
			integrity="sha384-DfXdz2htPH0lsSSs5nCTpuj/zy4C+OGpamoFVy38MVBnE+IbbVYUew+OrCXaRkfj"
			crossorigin="anonymous"></script>
		<script
			src="https://cdn.jsdelivr.net/npm/popper.js@1.16.1/dist/umd/popper.min.js"
			integrity="sha384-9/reFTGAW83EW2RDu2S0VKaIzap3H66lZH81PoYlFhbGU+6BZp6G7niu735Sk7lN"
			crossorigin="anonymous"></script>
		<script
			src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.2/js/bootstrap.min.js"
			integrity="sha384-B4gt1jrGC7Jh4AgTPSdUtOBvfO8shuf57BaghqFfPlYxofvL8/KUEfYiJOMMV+rV"
			crossorigin="anonymous"></script>
			
		<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
	<script>
	    //본 예제에서는 도로명 주소 표기 방식에 대한 법령에 따라, 내려오는 데이터를 조합하여 올바른 주소를 구성하는 방법을 설명합니다.
	    function sample4_execDaumPostcode() {
	        new daum.Postcode({
	            oncomplete: function(data) {
	                // 팝업에서 검색결과 항목을 클릭했을때 실행할 코드를 작성하는 부분.
	
	                // 도로명 주소의 노출 규칙에 따라 주소를 표시한다.
	                // 내려오는 변수가 값이 없는 경우엔 공백('')값을 가지므로, 이를 참고하여 분기 한다.
	                var roadAddr = data.roadAddress; // 도로명 주소 변수
	                var extraRoadAddr = ''; // 참고 항목 변수
	
	                // 법정동명이 있을 경우 추가한다. (법정리는 제외)
	                // 법정동의 경우 마지막 문자가 "동/로/가"로 끝난다.
	                if(data.bname !== '' && /[동|로|가]$/g.test(data.bname)){
	                    extraRoadAddr += data.bname;
	                }
	                // 건물명이 있고, 공동주택일 경우 추가한다.
	                if(data.buildingName !== '' && data.apartment === 'Y'){
	                   extraRoadAddr += (extraRoadAddr !== '' ? ', ' + data.buildingName : data.buildingName);
	                }
	                // 표시할 참고항목이 있을 경우, 괄호까지 추가한 최종 문자열을 만든다.
	                if(extraRoadAddr !== ''){
	                    extraRoadAddr = ' (' + extraRoadAddr + ')';
	                }
	
	                // 우편번호와 주소 정보를 해당 필드에 넣는다.
	                document.getElementById('sample4_postcode').value = data.zonecode;
	                document.getElementById("sample4_roadAddress").value = roadAddr;
	                document.getElementById("sample4_jibunAddress").value = data.jibunAddress;
	                
	                // 참고항목 문자열이 있을 경우 해당 필드에 넣는다.
	                if(roadAddr !== ''){
	                    document.getElementById("sample4_extraAddress").value = extraRoadAddr;
	                } else {
	                    document.getElementById("sample4_extraAddress").value = '';
	                }
	
	                var guideTextBox = document.getElementById("guide");
	                // 사용자가 '선택 안함'을 클릭한 경우, 예상 주소라는 표시를 해준다.
	                if(data.autoRoadAddress) {
	                    var expRoadAddr = data.autoRoadAddress + extraRoadAddr;
	                    guideTextBox.innerHTML = '(예상 도로명 주소 : ' + expRoadAddr + ')';
	                    guideTextBox.style.display = 'block';
	
	                } else if(data.autoJibunAddress) {
	                    var expJibunAddr = data.autoJibunAddress;
	                    guideTextBox.innerHTML = '(예상 지번 주소 : ' + expJibunAddr + ')';
	                    guideTextBox.style.display = 'block';
	                } else {
	                    guideTextBox.innerHTML = '';
	                    guideTextBox.style.display = 'none';
	                }
	            }
	        }).open();
	    }
	</script>	
	<!-- jQuery cdn -->	
	 <script  src="http://code.jquery.com/jquery-latest.min.js"></script>
	
	<%-- 회원가입 유효성 검사 체크 --%>
	<script src="<%=contextPath %>/js/join6.js"></script>
	
		
  
  </body>
</html>