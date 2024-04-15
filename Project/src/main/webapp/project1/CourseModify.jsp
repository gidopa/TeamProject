<%@page import="DAO.CourseDAO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="VO.CourseVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%
request.setCharacterEncoding("UTF-8");
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}" />

<%
String id = (String) session.getAttribute("id");
int courseId = Integer.parseInt(request.getParameter("courseId")) ;

CourseDAO courseDAO = new CourseDAO();
CourseVO courseVO = courseDAO.modifyCourse(id, courseId);
%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 상세 등록창</title>
<style>
/* 스타일링 */
body {
	font-family: Arial, sans-serif;
	background-color: #f2f2f2;
}

.container {
	max-width: 600px;
	margin: 50px auto;
	padding: 20px;
	background-color: #fff;
	border-radius: 5px;
	box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
}

.form-group {
	margin-bottom: 10px;
}

.form-group label {
	display: inline-block;
	width: 200px;
	text-align: right;
	margin-right: 10px;
}

.form-group input {
	width: calc(100% - 220px);
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 3px;
}

.form-group input[type="submit"], .form-group input[type="reset"] {
	width: auto;
	padding: 8px 20px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 3px;
	cursor: pointer;
}

.form-group input[type="reset"] {
	background-color: #dc3545;
}

.form-group input[type="submit"]:hover, .form-group input[type="reset"]:hover
	{
	opacity: 0.8;
}

.form-group.text-center {
	text-align: center;
}

.form-group button {
	width: calc(100% - 220px);
	padding: 8px;
	border: 1px solid #ccc;
	border-radius: 3px;
}

.form-group button {
	width: auto;
	padding: 8px 20px;
	background-color: #007bff;
	color: #fff;
	border: none;
	border-radius: 3px;
	cursor: pointer;
}

.form-group button {
	background-color: #dc3545;
}

.form-group button:hover
	{
	opacity: 0.8;
}
</style>


</head>
<body>

	<div class="container">
		<form action="${contextPath}/Courses/ReqModCourse" method="post">
			<h1 style="text-align: center">강좌 수정</h1>
			<br> <br>
			<%-- <input type="hidden" name="courseId" value="${courseVO.courseId}"> --%>
			<input type="hidden" name="courseId"
				value="<%=courseVO.getCourseId()%>">
			<div class="form-group">
				<label for="courseNumber">강의 번호</label>
				<!-- 강의 아이디로 처리함 -->
				<input type="text" value="<%=courseVO.getCourseId()%>"
					name="courseNumber" disabled="disabled">
			</div>
			<div class="form-group">
				<label for="courseTitle">강좌명</label> <input type="text"
					value="<%=courseVO.getCourseTitle()%>" name="courseTitle">
			</div>
			<div class="form-group">
				<label for="courseSummary">상세 강좌 내용</label> <input type="text"
					value="<%=courseVO.getCourseDescription()%>"
					name="courseDescription">
			</div>
			<div class="form-group">
				<label for="imgpath">강좌 이미지</label> <input type="text"
					value="<%=courseVO.getImgPath()%>" name="imgPath"
					placeholder="example.png">
			</div>
			<div class="form-group">
				<label for="coursePrice">강좌 가격</label> <input type="text"
					value="<%=courseVO.getCoursePrice()%>" name="coursePrice">
			</div>
			<%-- <div class="form-group">
            <label for="videoLink">강의 링크</label>
            <input type="text" value="${courseVO.videoLink}" name="videoLink" placeholder="https://www.youtube.com/watch?v=P--ED5rmlqI">
        </div> --%>
			<div class="form-group text-center">
				<input type="submit" value="강좌 수정">
				<input type="reset" value="다시입력">
				<button type="button" id="deleteCourse">강좌 삭제</button>
			</div>
		</form>
		
		<form action="${contextPath}/Courses/deleteCourse" id="fDelete">
			<input type="hidden" name="courseId" value="<%=courseVO.getCourseId()%>">
		</form>
	</div>
<!-- 강좌삭제 버튼 클릭 -->
<script>
	document.getElementById("deleteCourse").addEventListener("click",
			function(event) {
				event.preventDefault(); // 기본 동작인 폼 제출 방지

				var confirmDelete = confirm("정말로 강좌를 삭제하시겠습니까?"); // 사용자에게 삭제 여부를 확인합니다.

				if (confirmDelete) {
					// 확인을 눌렀을 때만 삭제 요청을 보냅니다.
					var form = document.querySelector('#fDelete');
					console.log(form,'');
					
					form.submit(); // 폼 제출
				}
			});
</script>
</body>
</html>
