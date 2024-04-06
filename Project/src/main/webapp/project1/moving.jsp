<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>


<% request.setCharacterEncoding("UTF-8"); %>
    <c:set var="contextPath"   value="${pageContext.request.contextPath}"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동영상 강의를 눌렀을때 나오는 화면</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">

<style>
  <style>
  body {
        font-family: 'Roboto', sans-serif;
        background-color: #e9ecef;
    }
    h1 {
        color: #495057;
        text-align: center;
        margin: 40px 0;
    }
    .course-container {
    box-shadow: 0 4px 8px rgba(0,0,0,0.1);
    border-radius: 10px;
    background-color: #ffffff;
    margin: 10px;
    display: flex;
    flex-direction: column;
    align-items: center;
    padding: 20px;
    transition: 0.3s;
    width: 330px; /* 카드의 너비를 고정 */
    height: 400px; /* 카드의 높이를 고정 */
/*     overflow: auto; /* 내용이 넘칠 경우 스크롤바 표시 */ 
}
    .course-container:hover {
        transform: scale(1.05);
    }
   .course-container img {
    max-width: 100%; /* 이미지 너비를 컨테이너에 맞춤 */
    max-height: 55%; /* 이미지 높이를 카드 높이의 50%로 제한 */
    object-fit: cover; /* 이미지 비율을 유지하면서 컨테이너에 맞춤 */
    border-radius: 5px;
}

.course-info {
    padding: 15px; /* 내부 여백 */
    text-align: left; /* 텍스트 정렬 */
    overflow: hidden; /* 텍스트가 넘칠 경우 숨김 */
}

.course-info p {
    margin: 5px 0; /* 상하 간격 */
}
    

    .fa-icon {
        margin-right: 5px;
    }

</style>
</style>
</head>
<body>

<center>
<br><br><br><br><br>
<c:if test="${not empty requestScope.list}">
    <h1><i class="fas fa-video fa-icon"></i>${requestScope.list[0].courseCategory} 강의</h1>
</c:if>
    <table width="1000" height="470">
        <c:set var="j" value="0"/>
        <c:forEach var="list" items="${requestScope.list}">
            <c:if test="${j % 4 == 0}">
                <tr align="center">
            </c:if>
            
                <td>
                    <div class="course-container">
                        <a href="${contextPath}/Courses/detail?courseId=${list.courseId}">
                           <img src="${contextPath }/resources/images/img_shop_01_1.png">
                            <div class="course-info">
                                <p><strong>강의명</strong> : ${list.courseTitle}</p>
                                <p><i class="fas fa-tag fa-icon"></i><strong>강의</strong> 가격 : ₩<fmt:formatNumber value="${list.coursePrice}" type="number" pattern="#,##0" />
</p>
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
    <!-- 강의를 검색하는 기능 구현 추가 예정 강의이름, 강사이름, 카테고리명으로 검색할 수 있도록  -->
   
</div>

    
</center>
</body>
</html>
