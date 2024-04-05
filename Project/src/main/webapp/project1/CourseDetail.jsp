 <%@page import="VO.CourseVO"%>
            <%@ page language="java" contentType="text/html; charset=UTF-8"
                pageEncoding="UTF-8"%>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>강의 정보 VIEW</title>
    <link rel="stylesheet" href="/Project/project1/css/Detailpage.css" />
</head>
<body>
    <div class="center-container">
        <div class="course-info">
           
            <%
                request.setCharacterEncoding("utf-8");
                String contextPath = request.getContextPath();
                CourseVO courseVO = (CourseVO)request.getAttribute("courseVO");
            %>
              <br><br><br><br><br>
            <c:set var="contextPath"   value="${pageContext.request.contextPath}"/> 
            <h1 class="center1">강의 정보</h1>
          
            <form action="<%=contextPath%>/Pay/check" method="post">
                <table>
                    <tr>
                        <td rowspan="4" class="center1"><a href="<%=contextPath%>/Courses/lecture"><img src=" <%=contextPath%>/resources/images/img_shop_01_1.png" alt="강의 이미지"  width="500"></a></td>
                        <th>강의 카테고리</th>
                        <td>${courseVO.courseCategory}</td>
                    </tr>
                    <tr>
                        <th>강의명</th>
                        <td>${courseVO.courseTitle}</td>
                    </tr>
                    <tr>
                        <th>강사명</th>
                        <td>${courseVO.userId}</td> 
                    </tr>
                    <tr>
                        <th>강의 금액</th>
                        <td>₩<fmt:formatNumber value="${courseVO.coursePrice}" type="number" pattern="#,##0" /></td>
                    </tr>
                    </table>
                      <div class="btn-container">
                    <input type="hidden" name="courseTitle" value="${courseVO.courseTitle}">
                    <input type="hidden" name="coursePrice" value="${courseVO.coursePrice}">
                    <input type="button" class="btn" value="이전" onclick="history.back();">
                    <input type="submit" class="btn" value="결제하기">
                </div>
                
            </form>
            <div class="course-info">
                <p><b>강의 정보</b></p>
                <p>${courseVO.courseDescription}</p> 
            </div>
        </div>
    </div>
</body>
</html>
