<%@page
	import="ch.qos.logback.core.recovery.ResilientSyslogOutputStream"%>
<%@page import="VO.LectureVO"%>
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
 body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        padding-top: 20px;
    }
    .lecture-container {
        margin: auto;
        width: 90%;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .lecture-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .lecture-table th, .lecture-table td {
        border: 1px solid #dee2e6;
        padding: 12px;
        text-align: center;
        color: #495057;
    }
    .lecture-table th {
        background-color: #007bff;
        color: #ffffff;
        font-weight: bold;
    }
    .lecture-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .lecture-table tr:hover {
        background-color: #ddd;
    }
    .form-group button {
        padding: 10px 20px;
        background-color: #28a745;
        color: #fff;
        border-radius: 5px;
        border: none;
        cursor: pointer;
        transition: background-color 0.3s, transform 0.3s;
    }
    .form-group button[type="button"] {
        background-color: #dc3545;
    }
    .form-group button:hover {
        background-color: #218838;
        transform: scale(1.05);
    }
    .form-group button[type="button"]:hover {
        background-color: #c82333;
    }
    .form-group.text-center {
        margin-top: 20px;
    }
</style>
</head>
<body>
	<br>
	<br>
	<br>
	<div class="lecture-container">
		<table class="lecture-table">
			<br>
			<br>
<%-- 			<h1 align="center">${courseTitle}</h1> --%>
	<br>
			<thead>
				<tr>
					<th>강의 순서</th>
					<th>강의 제목</th>
					<th>강의 내용</th>
					<th>강의 링크</th>
					<th>강의 이미지</th>
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
					<tr>
						<td>${list.lectureNumber}강</td>
						<td>${list.lectureTitle}</td>
						<td>${list.lectureSummary}</td>
						<td>${list.videoLink}</td>
						<td>${list.imgPath}</td>
						 <td>
            <form action="${contextPath}/Lecture/modify" method="post">
                <input type="hidden" name="lectureId" value="${list.lectureId}" />
                <input type="hidden" name="courseId" value="${list.courseId}" />
                <input type="submit" value="수정" />
            </form>
        </td>
        <td>
            <form action="${contextPath}/Lecture/delete" method="post">
                <input type="hidden" name="lectureId" value="${list.lectureId}" />
                <input type="submit" value="삭제" onclick="return confirm('정말 삭제하시겠습니까?');" />
            </form>
        </td>
					</tr>
				</c:forEach>
			</tbody>
		</table>


	</div>
	<br>
	<br>
<form action="${contextPath}/Lecture/addRegistraion">
 		<input type="hidden" name="courseId" value="${courseId}">
        <input type="hidden" name="courseTitle" value="${courseTitle}">
        <input type="hidden" name="courseCategory" value="${courseCategory}">
 <div class="form-group text-center">
				 <button type="submit">강의 추가 등록</button>
          		 <button id="myButton" type="button">강의 등록 완료>메인페이지로 이동</button>
		 </div>		

</form>  	  
			
			
		<script type="text/javascript">
		
	    
		
			 function moveToNextPage() {
		           
		            var nextPageUrl = "<%=request.getContextPath()%>/Courses/main"; 
		  
		            window.location.href = nextPageUrl;
		        }
			
			 document.getElementById("myButton").onclick = moveToNextPage;
			 
		</script>	
			
</body>
</html>
