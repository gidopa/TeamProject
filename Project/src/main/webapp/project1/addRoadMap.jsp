<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로드맵 등록창</title>
    <style>
        /* 일반적인 스타일 */
        body {
            font-family: Arial, sans-serif;
            background-color: #f2f2f2;
        }

        .container {
            max-width: 1000px;
            margin: 50px auto;
            padding: 20px;
            background-color: #fff;
            border-radius: 5px;
            box-shadow: 0 0 10px rgba(0, 0, 0, 0.1);
        }

        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: inline-block;
            text-align: center;
            margin-right: 10px;
        }

        .form-group input {
            width: calc(70%);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .form-group textarea {
            width: calc(70%);
            padding: 8px;
            border: 1px solid #ccc;
            border-radius: 3px;
        }

        .form-group button {
            padding: 8px 20px;
            background-color: #007bff;
            color: #fff;
            border: none;
            border-radius: 3px;
            cursor: pointer;
        }

        .form-group button[type="reset"] {
            background-color: #dc3545;
        }

        .form-group button[type="submit"]:hover, .form-group button[type="reset"]:hover {
            opacity: 0.8;
        }

        /* 라디오 버튼 스타일 */
        .form-radio {
            text-align: center;
        }

        .form-radio input[type="radio"] {
            display: none;
        }

        .form-radio input[type="radio"] + label {
            display: inline-block;
            margin-right: 20px;
            padding: 8px 10px;
            margin-bottom: 10px;
            background-color: #ccc;
            border-radius: 3px;
            cursor: pointer;
        }

        .form-radio input[type="radio"]:checked + label {
            background-color: #007bff;
            color: #fff;
        }

        .form-group>label{
            align : center;
        }
    </style>
</head>
<body>
<%
    // Session 내장객체 메모리 영역에 session값 얻기
    String id = (String)session.getAttribute("id");
    // Session에 값이 저장되어 있지 않으면?
    if(id == null){
%>
<script>
    alert("로그인 해주세요.");
    history.back(); // 브라우저의 이전 페이지로 이동
</script>
<%
    }
%>
<div class="container">
    <form id="roadMapForm" action="${contextPath}/RoadMap/roadMapPlus" method="post">
        <h1 style="text-align:center">로드맵 등록</h1>
        <input type="hidden" id="userId" name="userId" value="${id}">
        <br>
        <div class="form-group">
            <label for="price">로드맵 제목 : </label>
            <input type="text" id="roadMapTitle" name="roadMapTitle">
            <p id="roadMapTitleInput"></p>
        </div>
        <div class="form-group">
            <div style="position: relative;">
                <label for="roadMapDescription" style="position: absolute; top: 0; left: 0;">로드맵 내용 : </label>
                <textarea id="roadMapDescription" name="roadMapDescription" rows="10" style="width: calc(80% - 100px); margin-left: 100px;"></textarea>
            </div>
        </div>
        <div class="form-group">
            <label for="img">로드맵 이미지 : </label>
            <input type="text" id="imgPath" name="imgPath" placeholder="example.png">
        </div>
        <div class="form-group" style="text-align: center;">
            <button type="button" id="submitBtn">로드맵 등록</button>
            <button type="reset">다시입력</button>
        </div>
    </form>
</div>

<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $('#roadMapTitle').blur(function(){
        var title = $(this).val();
        if(title.trim() === '') {
            $('#roadMapTitleInput').text('로드맵 제목을 입력해주세요.').css("color", "red");
        } else {
            $.ajax({
                type: 'POST',
                url: '${contextPath}/RoadMap/checkRoadMapTitle',
                data: {roadMapTitle: title},
                success: function(response){
                    if(response === 'exists') {
                        $('#roadMapTitleInput').text('로드맵 제목이 이미 존재합니다. 다른 제목을 입력해주세요.').css("color", "red");
                        $('#roadMapTitle').val(''); // 입력란 비우기
                    } else {
                        $('#roadMapTitleInput').text('로드맵 제목을 사용할 수 있습니다.').css("color", "blue");
                    }
                }
            });
        }
    });

    $('#submitBtn').click(function(){
        var title = $('#roadMapTitle').val();
        if(title.trim() === '') {
            alert('로드맵 제목을 입력해주세요.');
        } else {
            var exists = ($('#roadMapTitleInput').text().trim() === '로드맵 제목이 이미 존재합니다. 다른 제목을 입력해주세요.');
            if(!exists) {
                $('#roadMapForm').submit();
            } else {
                alert('로드맵 제목을 다시 입력해주세요.');
            }
        }
    });
});
</script>

</body>
</html>
