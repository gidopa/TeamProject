<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<title>강의 수정</title>
<link rel="stylesheet" type="text/css" href="style.css">
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$(document).ready(function(){
    $("#courseSelect").change(function(){
        var courseId = $(this).val();
        if(courseId) {
            $.ajax({
                url: "getCourseDetails.jsp",
                type: "GET",
                data: {courseId: courseId},
                success: function(data){
                    $("#courseForm").html(data);
                }
            });
        } else {
            $("#courseForm").html('');
        }
    });
});
</script>
</head>
<body>
<header>
    <h1>강의 수정</h1>
</header>
<main>
    <label for="courseSelect">강의 선택:</label>
    <select id="courseSelect">
        <option value="">강의를 선택하세요</option>
        <option value="1">웹 프로그래밍 기초</option>
        <option value="2">고급 자바스크립트</option>
        <!-- 강의 목록을 서버에서 동적으로 불러와서 추가 -->
    </select>
    <div id="courseForm">
        <!-- 여기에 선택된 강의의 수정 폼이 로드됩니다 -->
    </div>
</main>
<footer>
    <!-- 푸터 정보 -->
</footer>
</body>
</html>
