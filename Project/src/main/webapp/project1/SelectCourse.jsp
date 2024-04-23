<%@page import="VO.LectureVO"%>
<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
  <%@page import="VO.CourseVO"%>

<% request.setCharacterEncoding("UTF-8"); %>
    <c:set var="contextPath"   value="${pageContext.request.contextPath}"/> 

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동영상 강의를 눌렀을때 나오는 화면</title>
 <link rel="stylesheet" href="/Project/project1/css/Detailpage.css" /> 

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
</head>
<body>
<%
					//Session내장객체 메모리 영역에 session값 얻기
					String id = (String)session.getAttribute("id");
					//Session에 값이 저장되어 있지 않으면?
					if(id == null){
						System.out.println("id : " + id);
%>
	<script>
    alert("로그인 해주세요.");
    history.back(); // 브라우저의 이전 페이지로 이동
</script>
<%
    }
%>
<%
					// 수강 중인 강의가 없을떄 
					List<LectureVO> lectureList = (List<LectureVO>)request.getAttribute("list");
					if(lectureList == null){
%>
	<br><br><br><br>
	<h3 align="center">수강중인 강의가 없습니다.</h3>
<%
    }
%>
 <div class="center-container">
        <div class="course-info">
            <%
                request.setCharacterEncoding("utf-8");
                String contextPath = request.getContextPath();
            %>
              <br><br><br><br><br>
            <c:set var="contextPath"   value="${pageContext.request.contextPath}"/> 
         <c:if test="${not empty requestScope.list}">
    <h1><i class="fas fa-video fa-icon"></i>내 강의</h1>
</c:if>
    <table width="1000" height="470">
        <c:set var="j" value="0"/>
        <c:forEach var="list" items="${requestScope.list}">
            <c:if test="${j % 4 == 0}">
                <tr align="center">
            </c:if>
            <%
            	
            %>
                <td>
                    <div class="course-container">
                        <a href="${contextPath}/Lecture/lectures?courseId=${list.courseId}">
                           <img src="${contextPath}/project1/images/${list.imgPath}">
                           <br><br>
                            <div class="course-info">
                                <p><strong>강의명</strong> : ${list.courseTitle}</p>
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
</body>
</html>
