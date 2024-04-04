<%@page import="org.slf4j.LoggerFactory"%>
<%@page import="org.slf4j.Logger"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8" isELIgnored="false"%>

<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
request.setCharacterEncoding("UTF-8");
%>

<!DOCTYPE html>
<html lang="ko">
<head>
<meta charset="UTF-8" />
<meta http-equiv="X-UA-Compatible" content="IE=edge" />
<meta http-equiv="imagetoolbar" content="no" />
<meta name="viewport" content="width=device-width, initial-scale=1.0" />
<meta name="format-detection" content="telephone=no" />
<meta name="title" content="웹사이트" />
<meta name="description" content="웹사이트입니다." />
<meta name="keywords" content="키워드,키워드,키워드" />
<meta property="og:title" content="웹사이트" />
<meta property="og:description" content="웹사이트입니다" />
<meta property="og:image" content="https://웹사이트/images/opengraph.png" />
<meta property="og:url" content="https://웹사이트" />
<title>첫페이지 | bed</title>
<link rel="stylesheet" href="../resources/css/setting.css" />
<link rel="stylesheet" href="../resources/css/plugin.css" />
<link rel="stylesheet" href="../resources/css/template.css" />
<link rel="stylesheet" href="../resources/css/common.css" />
<link rel="stylesheet" href="../resources/css/style.css" />
<link rel="stylesheet" href="../resources/css/style2.css" />
</head>

<%
	String contextPath = request.getContextPath();
	Logger log = LoggerFactory.getLogger(getClass());
	
%>
<body>
	<!-- [S]hooms-N54 -->
	<header class="hooms-N54" data-bid="aTlUHy5F8Z">
		<div class="header-inner">
			<div class="header-container container-lg">
				<div class="header-left">
					<h1 class="header-title">
						<a class="header-logo" href="<%=contextPath %>/Courses/main" title="hooms"></a>
					</h1>
				</div>
				<div class="header-center">
					<ul class="header-gnblist">
						<li class="header-gnbitem"><a class="header-gnblink"
							href="javascript:void(0)"> <span>강의</span>
						</a>
							<ul class="header-sublist">
								<li class="header-subitem"><a class="header-sublink"
									href="<%=contextPath%>/Courses/category?category=backend"> <span>BackEnd</span>
								</a></li>
								<li class="header-subitem"><a class="header-sublink"
									href="<%=contextPath%>/Courses/category?category=frontend"> <span>FrontEnd</span>
								</a></li>
								<li class="header-subitem"><a class="header-sublink"
									href="<%=contextPath%>/Courses/category?category=AI"> <span>AI</span>
								</a></li>

							</ul></li>

						<li class="header-gnbitem"><a class="header-gnblink"
							href="javascript:void(0)"> <span>강의 신청</span>
						</a></li>
						<li class="header-gnbitem"><a class="header-gnblink"
							href="javascript:void(0)"> <span>로드맵</span>
						</a></li>
						<li class="header-gnbitem"><a class="header-gnblink"
							href="javascript:void(0)"> <span>수강후기</span>
						</a></li>

						<li class="header-gnbitem"><a class="header-gnblink"
							href="javascript:void(0)"> <span>고객센터</span>
						</a></li>
						
						<li class="header-gnbitem"><a class="header-gnblink"
							href="javascript:void(0)"> <span>공지사항</span>
						</a></li>
					</ul>
				</div>
				<div class="header-right">
					<div class="header-utils">
						<a href="javascript:void(0);" class="btn-profile header-utils-btn"
							title="profile"></a>
						<button class="btn-search header-utils-btn" title="search"></button>
					</div>
				</div>
				<div class="header-search-form">
					<div class="inputset inputset-line">
					<form action="<%=contextPath%>/Courses/search" method="post">
						<button class="icon-right icon-search btn" type="submit"
							aria-label="아이콘"></button>
						<input type="text" class="inputset-input form-control"
							placeholder="검색어를 입력해주세요." aria-label="내용" />
					</form>
					</div>
				</div>
			</div>
		</div>

		<div class="header-dim"></div>
</header>
	
    <script src="../resources/js/setting.js"></script>
    <script src="../resources/js/plugin.js"></script>
    <script src="../resources/js/template.js"></script>
    <script src="../resources/js/common.js"></script>
    <script src="../resources/js/script.js"></script>
</body>
</html>