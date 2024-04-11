<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%-- 강의 정보 로드 로직 구현 --%>
<%-- 예시 데이터와 HTML 폼 --%>
<form action="updateCourse.jsp" method="post">
    <input type="hidden" name="courseId" value="<%= request.getParameter("courseId") %>">
    <label for="title">강의 제목:</label>
    <input type="text" id="title" name="title" value="웹 프로그래밍 기초"><br>
    <label for="instructor">강사 이름:</label>
    <input type="text" id="instructor" name="instructor" value="홍길동"><br>
    <label for="date">등록 날짜:</label>
    <input type="text" id="date" name="date" value="2023-04-10"><br>
    <input type="submit" value="갱신">
</form>
