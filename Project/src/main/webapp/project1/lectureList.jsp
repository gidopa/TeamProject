<%@page import="ch.qos.logback.core.recovery.ResilientSyslogOutputStream"%>
<%@page import="VO.LectureVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<%
    request.setCharacterEncoding("UTF-8");
%>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

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

.form-group button[type="submit"]:hover, .form-group button[type="button"]:hover {
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
<br><br><br><br><br>

<div class="lecture-container">
    <table class="lecture-table">
    	<br><br>
        	<h1>${courseTitle}</h1>
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
                    <td><a href="${contextPath}/member/memberDetail.do?id=${member.id}">수정</a></td>
                    <td><a href="${contextPath}/member/memberDel.do?id=${member.id}">삭제</a></td>
                </tr>
            </c:forEach>
        </tbody>
    </table>
    
    	
</div>     
           <br><br>
<%--            <% --%>
//            	List<LectureVO> lectureList = (List<LectureVO>)request.getAttribute("list");
//             LectureVO vo = lectureList.get(0);
// 			System.out.println("lectureList.get0 ? " + vo.getCourseId());
//             int courseId =  vo.getCourseId();
<%--            %> --%>
<!--           <div class="form-group text-center"> -->
<%--           <form action="${contextPath}/Lecture/addmore?courseId="<%=courseId%>"> --%>
<!-- 				 <button type="submit">강의 추가 등록</button> -->
<!-- 				</form> -->
<%-- 				   <form action="${contextPath}/Course/main"> --%>
<!--           		 <button type="button">강의 등록 완료</button> -->
<!--           		  </form> -->
<!-- 		 </div>		 -->

</body>
</html>
