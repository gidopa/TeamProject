<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%request.setCharacterEncoding("UTF-8");%>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>댓글 시스템</title>
<style type="text/css">
.card-actions {
    position: absolute;
    top: 10px;
    right: 10px;
}
</style>
</head>
<body>
<br>
<div class="container mt-5">
    <h1 class="text-center mb-4">수강 후기</h1>
    <form id="commentForm" class="mb-3" action="${contextPath}/Review/comment" method="POST">
        <div class="mb-3">
            <label for="courseDropdown" class="form-label">코스 선택:</label>
            <select id="courseDropdown" name="courseId" class="form-select">
                <option value="">코스를 선택하세요</option>
                <c:forEach items="${courseList}" var="course">
                    <option value="${course.courseId}">${course.courseTitle}</option>
                     <input type="hidden" name="courseTitle" value="${course.courseTitle}">
                </c:forEach>
            </select>
        </div>
        <div class="mb-3">
            <input type="text" name="commentText" class="form-control" placeholder="댓글을 입력하세요" required>
        </div>
        <div class="rating">
            <input type="hidden" name="rating" id="ratingInput">
            <i class="far fa-star rating-star" data-value="1"></i>
            <i class="far fa-star rating-star" data-value="2"></i>
            <i class="far fa-star rating-star" data-value="3"></i>
            <i class="far fa-star rating-star" data-value="4"></i>
            <i class="far fa-star rating-star" data-value="5"></i>
        </div>
        <div class="mb-3">
            <input type="submit" class="btn btn-primary" value="댓글 달기">
        </div>
    </form>
    <div id="commentsContainer">
        <c:forEach items="${comments}" var="comment">
            <div class="card mb-3">
                <div class="card-body">
                    <h5 class="card-title">${comment.courseTitle} - 평점: ${comment.reviewScore}</h5>
                    <p class="card-text">${comment.reviewContent}</p>
                    <p class="card-text"><small class="text-muted">작성자: ${comment.userId} 작성 시간: <fmt:formatDate value="${comment.reviewDate}" pattern="yyyy-MM-dd"/></small></p>
                    <div class="card-actions float-right">
                    <a href="${contextPath}/Review/edit?reviewId=${comment.reviewId}" class="card-link">수정</a>
                    <a href="${contextPath}/Review/delete?reviewId=${comment.reviewId}" class="card-link">삭제</a>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>
</div>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
<script>
$('#commentForm').submit(function(event) {
    event.preventDefault();
    $.ajax({
        url: '${contextPath}/Review/comment',
        type: 'POST',
        data: $(this).serialize(),
        dataType: 'html',
        success: function(response) {
            $('#commentsContainer').prepend(response);
        }
    });
});

$('.rating-star').click(function() {
    var ratingValue = $(this).data('value');
    $('#ratingInput').val(ratingValue);
    updateStars(ratingValue);
});

function updateStars(rating) {
    $('.rating-star').each(function() {
        var starValue = $(this).data('value');
        if (starValue <= rating) {
            $(this).removeClass('far').addClass('fas');
        } else {
            $(this).removeClass('fas').addClass('far');
        }
    });
}
</script>
</body>
</html>
