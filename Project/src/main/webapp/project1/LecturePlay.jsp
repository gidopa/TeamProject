<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<html>
<head>
<title>강의 목록</title>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.4/dist/tailwind.min.css"
	rel="stylesheet">
<style>
.sidebar {
    background-color: #2d3748; /* 사이드바의 배경 색상 */
    color: #fff; /* 사이드바 내 텍스트 색상 */
    height: 100vh; /* 전체 뷰포트 높이 */
    width: 250px; /* 사이드바의 폭 */
    position: fixed; /* 사이드바를 화면에 고정 */
    left: 0; /* 좌측에서 시작 */
    top: 0; /* 상단에서 시작 */
    overflow-y: auto; /* 내용이 넘칠 경우 스크롤 */
    padding: 1rem; /* 내부 패딩 */
}

.content {
    margin-left: 250px; /* 사이드바 폭만큼 내용을 오른쪽으로 밀어냄 */
}
.embed-container {
	position: relative;
	padding-bottom: 56.25%;
	height: 0;
	overflow: hidden;
	max-width: 100%;
}

.embed-container iframe, .embed-container object, .embed-container embed
	{
	position: absolute;
	top: 0;
	left: 0;
	width: 100%;
	height: 100%;
}

body {
	font-family: 'Roboto', sans-serif;
	background-color: #e9ecef;
}

.lecture-item {
    padding: 2rem; /* 내부 여백을 늘립니다 */
    background-color: white; /* 배경색을 흰색으로 설정합니다 */
    border-radius: 0.5rem; /* 모서리를 둥글게 처리합니다 */
    box-shadow: 0 2px 4px rgba(0, 0, 0, 0.1); /* 그림자 효과를 추가합니다 */
    margin-bottom: 1rem; /* 강의 항목 간의 여백을 추가합니다 */
}

.lecture-title, .lecture-link {
    font-weight: 500; /* 글씨 굵기를 조정합니다 */
    color: #4a5568; /* 글씨 색상을 조정합니다 */
}

.lecture-number {
    color: #2c5282; /* 강의 번호의 색상을 조정합니다 */
    font-weight: 600; /* 강의 번호의 글씨 굵기를 조정합니다 */
}
 .sidebar ul li a{
          color: #fff; /* 사이드바 내 텍스트 색상을 흰색으로 설정 */
    display: block; /* 링크를 블록 요소로 만들어 너비 제어 가능하게 함 */
    white-space: nowrap; /* 텍스트를 한 줄로 표시 */
    overflow: hidden; /* 내용이 넘칠 경우 내용을 숨김 */
    text-overflow: ellipsis; /* 넘치는 텍스트를 '...'로 표시 */
    max-width: 230px; /* 최대 너비 설정 */
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.4/dist/tailwind.min.css"
	rel="stylesheet">
</head>
<body class="bg-gray-100">
<%
String videoPath = (String) request.getAttribute("videoLink");
%>

<!-- 시청 하는 동영상 옆에 사이드바를 띄워 바로 다른 강의로 이동할 수 있도록 함 -->
<div class="sidebar">
    <h2 class="text-lg font-semibold">메뉴</h2>
    <ul>
    	<br><br><br><br>
    	 <c:forEach var="lecture" items="${lectureList}">
            <li>
                <a href="${pageContext.request.contextPath}/Lecture/play?courseId=${lecture.courseId}&lectureId=${lecture.lectureId}">${lecture.lectureNumber} 강 : ${lecture.lectureTitle}</a>
            </li>
        </c:forEach>
        <!-- 추가 링크 -->
    </ul>
</div>
<div class="content">
<div class="container mx-auto px-4">
    <div class="lecture-item">
        <div class="text-md mt-2">
            <span class="lecture-number">${lectureInfo.lectureNumber}강: ${lectureInfo.lectureTitle} </span>
<%--             <span class="lecture-title">강의 제목: ${lectureInfo.lectureTitle}</span> --%>
        </div>
        <div class="text-md mt-2">
            <span class="lecture-link">강의 주제: ${lectureInfo.lectureSummary}</span>
        </div>
    </div>	
	<div class='embed-container'>
		<iframe src="<%=videoPath%>" title="YouTube video player"
			frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
			referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
	</div>
</div>
</body>
</html>
