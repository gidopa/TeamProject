<%@page
	import="ch.qos.logback.core.recovery.ResilientSyslogOutputStream"%>
<%@page import="VO.LectureVO"%>
<%@page import="VO.CourseVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
request.setCharacterEncoding("UTF-8");
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 목록</title>
<style>
/* 스타일링 */
.lecture-container {
	margin: 0 auto;
	width: 80%;
}

.lecture-table {
	width: 100%;
	border-collapse: collapse;
}

.lecture-table th, .lecture-table td {
	border: 1px solid black;
	padding: 8px;
	text-align: center;
}

.lecture-table th {
	background-color: lightgreen;
	font-weight: bold;
}

.lecture-table tr:nth-child(even) {
	background-color: #f2f2f2;
}

.lecture-table tr:hover {
	background-color: #ddd;
}

.form-group button {
	padding: 8px 20px; /* 버튼 내부 여백 설정 */
	background-color: #007bff; /* 배경색 */
	color: #fff; /* 텍스트 색상 */
	border: none; /* 테두리 없음 */
	border-radius: 3px; /* 테두리 둥글게 처리 */
	cursor: pointer; /* 마우스 오버 시 커서 모양 */
	outline: none; /* 클릭 시 포커스 효과 제거 */
	transition: background-color 0.3s, color 0.3s; /* 변화에 부드러운 효과 적용 */
}

.form-group button[type="button"] {
	background-color: #dc3545; /* 리셋 버튼의 배경색 */
}

.form-group button[type="submit"]:hover, .form-group button[type="button"]:hover
	{
	opacity: 0.8; /* 마우스 호버 시 투명도 조정 */
}

.form-group.text-center {
	text-align: center; /* 텍스트 가운데 정렬 */
}

.form-group.text-center button {
	display: inline-block; /* 인라인 블록 요소로 변경 */
	margin: 0 auto; /* 가운데 정렬 */
}


</style>
</head>
<body>

	<div class="lecture-container">
		<form id="lectureForm" action="${contextPath}/RoadMap/updateRoadMapInsert" method="post">
			<table class="lecture-table">
				<br>
				<br>
				<h1 align="center">로드맵에 등록된 강의 목록입니다. 강의리스트를 체크해주세요</h1>
				<input type="hidden" name="roadMapId" value="${RoadMap_RoadMapId}">
				<br>
				<thead>
					<tr>
						<th>선택</th> <!-- 체크박스 열 추가 -->
						<th>강의 제목</th>
						<th>강의 내용</th>
						<th>강의 가격</th>
					</tr>
				</thead>
				<tbody>
					<c:forEach var="arrayList" items="${requestScope.arrayList}">
					        <c:choose>
					            <c:when test="${arrayList.roadMapId == 0}">
					                <td><input type="checkbox" name="course_id" value="${arrayList.courseId}"></td>
					            </c:when>
						            <c:otherwise>
						                <td><input type="checkbox" name="course_id" value="${arrayList.courseId}"checked="checked"></td>
						            </c:otherwise>
					        </c:choose>
							<td>${arrayList.courseTitle}</td>
							<td>${arrayList.courseDescription}</td>
							<td>${arrayList.coursePrice}</td>
						</tr>
					</c:forEach>
				</tbody>
			</table>
			<br><br>
				<div class="form-group text-center">
					<button type="submit">선택한 강의로 로드맵 수정</button>
					<button type="button" id="myButton">이전페이지로 이동</button>
				</div>
			
		</form>

	</div>
	<br>
	<br>


	<script type="text/javascript">
	    document.getElementById("myButton").onclick = function() {
	        history.back();
	    };
	</script>

</body>
</html>
