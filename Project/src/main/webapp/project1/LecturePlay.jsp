<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ page import="java.util.List"%>
<html>
<head>
<title>강의 목록</title>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.4/dist/tailwind.min.css"
	rel="stylesheet">
<style>
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
}

.lecture-link {
	line-height: 1.75; /* 줄 높이를 증가시킵니다 */
}

.lecture-title {
	font-size: 1.75rem; /* 글자 크기를 키웁니다 */
}
</style>
<link
	href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.4/dist/tailwind.min.css"
	rel="stylesheet">
</head>
<body class="bg-gray-100">
	<%
	String videoPath = (String) request.getAttribute("videoLink");
	%><br><br>
		<div class="flex items-center">
		<span class="font-semibold text-xl">${lectureInfo.lectureNumber}강</span><br>
		<!-- 강의 번호 글자 크기 조정 -->
		<span class="lecture-title ml-2 mr-4 truncate">강의 제목 : ${lectureInfo.lectureTitle}</span><br>
		<!-- 강의 제목 글자 크기 조정 -->
		<span class="lecture-title ml-2 mr-4 truncate">강의 주제 : ${lectureInfo.lectureSummary}</span><br>
		<!-- 강의 제목 글자 크기 조정 -->
	</div>
	<br>
	<div class='embed-container'>
		<iframe src="<%=videoPath%>" title="YouTube video player"
			frameborder="0"
			allow="accelerometer; autoplay; clipboard-write; encrypted-media; gyroscope; picture-in-picture; web-share"
			referrerpolicy="strict-origin-when-cross-origin" allowfullscreen></iframe>
	</div>

</body>
</html>
