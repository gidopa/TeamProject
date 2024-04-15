<%@page import="VO.CourseVO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>강좌 로드맵</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<style>
body {
	font-family: 'Arial', sans-serif;
	position: relative;
}

.toolbar {
	position: fixed;
	top: 260px; /* 위에서부터의 간격 */
	right: 50px; /* 오른쪽에서부터의 간격 */
	width: 200px; /* 툴바의 너비 */
	background-color: #f1f1f1;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	padding: 10px;
	z-index: 1000;
}

.toolbar a {
	padding: 6px 10px;
	text-decoration: none;
	font-size: 16px;
	color: #333;
	display: block;
	margin-bottom: 5px;
	border-radius: 4px;
	transition: background-color 0.3s;
	white-space: nowrap; /* 텍스트를 한 줄로 제한 */
	overflow: hidden; /* 내용이 넘치면 숨김 */
	text-overflow: ellipsis; /* 내용이 넘칠 때 ...으로 표시 */
}

.toolbar a:hover {
	background-color: #ddd;
}

.body-content {
	display: flex;
	flex-direction: column;
	align-items: center; /* 센터 정렬 수정 */
	margin-top: 50px; /* 상단 여백 조정 */
}

.main-content, .roadMap {
	width: 80%; /* 콘텐츠 너비 조정 */
	max-width: 1000px; /* 최대 너비 설정 */
}

.course-card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	transition: 0.3s;
	width: 100%; /* 카드 너비를 부모 요소에 맞춤 */
	border-radius: 5px;
	margin-bottom: 20px;
	padding: 15px;
	background-color: white;
}

.course-card:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}

.course-title {
	font-size: 24px;
	color: #333;
}

.course-image-text {
	display: flex;
	align-items: center; /* 세로 방향에서 중앙 정렬 */
}

.course-img {
	width:175px; /* 이미지 크기, 필요에 따라 조정 */
	height: auto; /* 이미지 비율 유지 */
	margin-right: 10px; /* 텍스트와의 간격 */
}

.course-text {
	/* 필요한 추가 스타일이 있다면 여기에 작성 */
	
}

.course-price {
	font-size: 20px;
	color: #888;
	margin-bottom: 15px;
}

.purchase-button-container {
	position: fixed;
	top: 200px; /* toolbar보다 위에 위치하도록 설정 */
	right: 50px; /* 오른쪽에서부터의 간격 유지 */
	z-index: 1001; /* toolbar 위에 표시되도록 z-index 설정 */
}

.purchase-btn {
	border: none;
	outline: none;
	padding: 10px;
	color: white;
	background-color: #4CAF50;
	text-align: center;
	cursor: pointer;
	font-size: 18px;
	border-radius: 5px;
	width: 200px; /* 버튼 너비를 툴바와 동일하게 설정 */
}

.purchase-btn:hover {
	background-color: #45a049;
}
</style>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
</head>
<body>
<%
	List<CourseVO> courseVOList = (List<CourseVO>)request.getAttribute("courseVOList");
	int roadMapPrice = 0;
	for(CourseVO vo : courseVOList){
		roadMapPrice += vo.getCoursePrice();
	}
%>
	<div class="purchase-button-container">
	 <div class="roadmap-price-display"><strong>로드맵 가격</strong> : ₩<fmt:formatNumber value="<%=roadMapPrice%>" type="number" pattern="#,##0" /></div>
	<form method="post" action="#">
		<input type="hidden" name="roadMapPrice" value="<%=roadMapPrice%>"> 
		<input type="submit" class="purchase-btn" value="로드맵 결제">
		</form>
	</div>
	<div class="toolbar">
		<c:forEach var="courses" items="${courseVOList}">
			<a href="${contextPath}/Courses/detail?courseId=${courses.courseId}">
				${courses.courseTitle} </a>
		</c:forEach>
	</div>
	<br>
	<br>
	<br>
	<div class="body-content">
		<div class="roadMap">
			<h1>${roadMapVO.roadMapTitle }</h1>
			<div class="roadMapDescription">
				<br>
				<h3>${roadMapVO.roadMapDescription }</h2>
			</div>
		</div>
		<div class="main-content">
			<c:forEach var="course" items="${courseVOList}">
				<div class="course-card" id="${course.courseId}">
					<div class="course-title">
						<div class="course-image-text">
							<a
								href="${contextPath}/Courses/detail?courseId=${course.courseId}">
								<img alt="강의 이미지" src="${contextPath }/project1/images/${course.imgPath}" class="course-img">
							</a>
							<div class="text-container">
								<!-- 새로운 div로 감싸 텍스트와 설명을 세로로 정렬 -->
								<div class="course-text">${course.courseTitle}</div>
								<div class="course-price">${course.courseDescription}</div>
								<div class="course-price">₩<fmt:formatNumber value="${course.coursePrice }" type="number" pattern="#,##0" /></div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
</body>
</html>
