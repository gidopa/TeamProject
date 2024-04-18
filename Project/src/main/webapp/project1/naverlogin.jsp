<%@ page import="java.net.URLEncoder"%>
<%@ page import="java.security.SecureRandom"%>
<%@ page import="java.math.BigInteger"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<html lang="ko">
<head>
<meta charset="utf-8">
<title>네이버 로그인</title>
<link rel="stylesheet" href="./style.css" />
<script src="https://static.nid.naver.com/js/naveridlogin_js_sdk_2.0.2.js" charset="utf-8"></script>
</head>
<body>
<%
	String contextPath = request.getContextPath();

	String clientId = "RXYk8HbDBVuINgLo77fM";//애플리케이션 클라이언트 아이디값";
	String redirectURI = URLEncoder.encode("http://localhost:8083/Project/Naver/api", "UTF-8");     
	SecureRandom random = new SecureRandom();
	String state = new BigInteger(130, random).toString();
	String apiURL = "https://nid.naver.com/oauth2.0/authorize?response_type=code"
	     + "&client_id=" + clientId
	     + "&redirect_uri=" + redirectURI
	     + "&state=" + state;
	session.setAttribute("state", state);
%>    
	 <a href="<%=apiURL%>"><img height="50" src="http://static.nid.naver.com/oauth/small_g_in.PNG"/></a>
</body>
</html>