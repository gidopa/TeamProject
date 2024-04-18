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
<title>내 로드맵 리스트</title>
<style>
/* 스타일링 */
 body {
        font-family: 'Arial', sans-serif;
        background-color: #f8f9fa;
        padding-top: 20px;
    }
    .RoadMap-container {
        margin: auto;
        width: 90%;
        background: #fff;
        padding: 20px;
        border-radius: 8px;
        box-shadow: 0 2px 5px rgba(0,0,0,0.1);
    }
    .RoadMap-table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
    }
    .RoadMap-table th, .RoadMap-table td {
        border: 1px solid #dee2e6;
        padding: 12px;
        text-align: center;
        color: #495057;
    }
    .RoadMap-table th {
        background-color: #007bff;
        color: #ffffff;
        font-weight: bold;
    }
    .RoadMap-table tr:nth-child(even) {
        background-color: #f2f2f2;
    }
    .RoadMap-table tr:hover {
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

	<div class="RoadMap-container">
		<table class="RoadMap-table">
<%-- 			<h1 align="center">${courseTitle}</h1> --%>
	<br>
			<thead>
				<tr>
					<th>로드맵 제목</th>
					
					<th>수정</th>
					<th>삭제</th>
				</tr>
			</thead>
			<tbody>
				<c:forEach var="list" items="${list}">
					<tr>
						<td>${list.roadMapTitle}</td>
						
		<td>
            <form action="${contextPath}/RoadMap/updateRoadMap" method="post">
                <input type="hidden" name="roadMapId" value="${list.roadMapId}" />
                <input type="hidden" name="userId" value="${list.userId}" />
                <input type="submit" value="수정" />
            </form>
        </td>
        <td>
            <form action="${contextPath}/RoadMap/deleteRoadMap" method="post">
                <input type="hidden" name="roadMapId" value="${list.roadMapId}" />
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
  
			

			
</body>
</html>
