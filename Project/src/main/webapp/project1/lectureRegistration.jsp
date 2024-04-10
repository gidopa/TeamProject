<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("UTF-8"); %>

<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

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

    .form-group input[type="submit"],
    .form-group input[type="reset"] {
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

    .form-group input[type="submit"]:hover,
    .form-group input[type="reset"]:hover {
        opacity: 0.8;
    }

    .form-group.text-center {
        text-align: center;
    }
</style>
</head>
<body>

<div class="container">
    <form action="${contextPath}/Lecture/registraion" method="post">
        <h1 style="text-align:center">강의 상세 등록</h1>
        <br><br>
        <input type="hidden" name="courseId" value="${requestScope.vo.courseId}">
        <div class="form-group">
            <label for="lectureNumber">강의 번호</label>
            <input type="text" id="lectureNumber" name="lectureNumber">
        </div>
        <div class="form-group">
            <label for="lectureTitle">상세 강의 제목</label>
            <input type="text" id="lectureTitle" name="lectureTitle">
        </div>
        <div class="form-group">
            <label for="lectureSummary">상세 강의 내용</label>
            <input type="text" id="lectureSummary" name="lectureSummary">
        </div>
        <div class="form-group">
            <label for="imgpath">강의 이미지</label>
            <input type="text" id="imgpath" name="imgpath" placeholder="example.png">
        </div>
        <div class="form-group">
            <label for="videoLink">강의 링크</label>
            <input type="text" id="videoLink" name="videoLink" placeholder="https://www.youtube.com/watch?v=P--ED5rmlqI">
        </div>
        <div class="form-group text-center">
            <input type="submit" value="강의 등록">
            <input type="reset" value="다시입력">
        </div>
    </form>
</div>
</body>
</html>
