<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("UTF-8"); %>
    <c:set var="contextPath"   value="${pageContext.request.contextPath}"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동영상 강의를 눌렀을때 나오는 화면</title>
<style>
  body {
        font-family: 'Arial', sans-serif; /* 기본 글꼴 변경 */
        background-color: #f0f0f0; /* 배경색 설정 */
    }
     h1 {
        color: #333; /* 제목의 색상 */
        text-align: center; /* 제목을 가운데 정렬 */
        font-size: 2em; /* 글꼴 크기 */
        margin-top: 20px; /* 상단 마진 */
        margin-bottom: 20px; /* 하단 마진 */
    }
    .course-container {
        box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2); /* 그림자 효과 */
        transition: 0.3s; /* 호버 효과의 전환 속도 */
        border-radius: 10px; /* 테두리 둥글게 */
        background-color: #ffffff; /* 배경색 */
        margin: 10px; /* 주변 요소와의 간격 */
        vertical-align: top;
        border: 1px solid #444444; /* 외곽선을 얇게 설정 */
        padding: 10px; /* 내부 여백을 설정 */
        display: inline-block; /* 다른 항목과 나란히 배치 */
    }
    .course-container:hover {
        box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2); /* 호버 시 그림자 강조 */
    }
    .course-container img {
        width: 220px;
        height: 180px;
        border-top-left-radius: 10px; /* 상단 왼쪽 테두리 둥글게 */
        border-top-right-radius: 10px; /* 상단 오른쪽 테두리 둥글게 */
    }
    .course-info {
        padding: 15px; /* 내부 여백 */
        text-align: left; /* 텍스트 정렬 */
    }
    .course-info p {
        margin: 5px 0; /* 상하 간격 */
    }
    table {
        border-collapse: collapse;
    }
    th, td {
        border: 1px solid #444444;
    }
    .course-container {
        border: 1px solid #444444; /* 외곽선을 얇게 설정 */
        padding: 10px; /* 내부 여백을 설정 */
        display: inline-block; /* 다른 항목과 나란히 배치 */
        margin: 5px; /* 주변 요소와의 간격 */
        vertical-align: top; /* 수직 정렬 */
    }
    .course-container img {
        width: 220px; /* 이미지 너비 */
        height: 180px; /* 이미지 높이 */
    }
    .course-info {
        max-width: 220px; /* 최대 너비를 이미지 너비에 맞춤 */
    }
    table {
        border-collapse: collapse; /* 테이블 간격 없애기 */
    }
    th, td {
        border: 1px solid #444444;
    }
</style>
</head>
<body>

<center>
<br><br><br><br><br>
<c:if test="${not empty requestScope.list}">
    <h1>${requestScope.list[0].courseCategory} 강의</h1>
</c:if>
    <table width="1000" height="470">
        <c:set var="j" value="0"/>
        <c:forEach var="list" items="${requestScope.list}">
            <c:if test="${j % 4 == 0}">
                <tr align="center">
            </c:if>
            
                <td>
                    <div class="course-container">
                        <a href="${contextPath}/Courses/moveInfo.do?courses_id='1'">
                           <img src="${contextPath }/resources/images/img_shop_01_1.png">
                            <div class="course-info">
                                <p>강의명 : ${list.courseTitle}</p>
                                <p>강의 가격 : ${list.coursePrice}</p>
                            </div>
                        </a>
                    </div>
                </td>
            <c:set var="j" value="${j+1}"/>
            <c:if test="${j % 4 == 0}">
                </tr>
            </c:if>
        </c:forEach>
    </table>
</center>
</body>
</html>
