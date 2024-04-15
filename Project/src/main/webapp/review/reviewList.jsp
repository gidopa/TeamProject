<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
 <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<%request.setCharacterEncoding("UTF-8");%> 
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>
<script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
</head>
<body>
<br><br><br>
<form id="commentForm" action="${contextPath}/Review/comment" method="POST">
 <label for="courseDropdown">코스 선택:</label>
    <select id="courseDropdown" name="courseId">
        <option value="">코스를 선택하세요</option>
        <c:forEach items="${courseList}" var="course">
            <option value="${course.courseId}">${course.courseTitle}</option>
        </c:forEach>
    </select>

    <input type="text" name="commentText" placeholder="댓글을 입력하세요" required>
    <label>
    <input type="radio" name="rating" value="1" /> 1 별
  </label>
  <label>
    <input type="radio" name="rating" value="2" /> 2 별
  </label>
  <label>
    <input type="radio" name="rating" value="3" /> 3 별
  </label>
  <label>
    <input type="radio" name="rating" value="4" /> 4 별
  </label>
  <label>
    <input type="radio" name="rating" value="5" /> 5 별
  </label>
    <input type="submit" value="댓글 달기">
</form>
<br>
<div id="commentsContainer">
    <!-- 서버로부터 받은 댓글들이 여기에 표시됩니다 -->
</div><br>
  <h2>댓글 목록</h2>
    <c:forEach items="${comments}" var="comment">
        <div>
            <p><b>작성자:</b> ${comment.userId}</p>
            <p><b>강좌명:</b> ${comment.courseTitle}</p>
            <p><b>댓글:</b> ${comment.reviewContent}</p>
            <p><b>평점:</b> ${comment.reviewScore}</p>
            <p><b>작성 시간:</b> <fmt:formatDate value="${comment.reviewDate}" pattern="yyyy-MM-dd"/></p>
        </div>
    </c:forEach>
<script>
$('#commentForm').submit(function(event) {
    event.preventDefault();
    $.ajax({
        url: '${contextPath}/Review/comment',
        type: 'POST',
        data: $(this).serialize(),
        success: function(response) {
        	 var newCommentHtml = '<div>' +
             '<p><b>작성자:</b> ' + response.userId + '</p>' +
             '<p><b>강좌명:</b> ' + response.courseTitle + '</p>' +
             '<p><b>댓글:</b> ' + response.reviewContent + '</p>' +
             '<p><b>평점:</b> ' + response.reviewScore + ' 별</p>' +
             '<p><b>작성 시간:</b> ' + formatDate(response.reviewDate) + '</p>' +
             '</div>';
         $('#commentsContainer').prepend(newCommentHtml);
        }
    });
});

function formatDate(dateString) {
    var date = new Date(dateString);
    var year = date.getFullYear();
    var month = ('0' + (date.getMonth() + 1)).slice(-2);
    var day = ('0' + date.getDate()).slice(-2);
    return year + '-' + month + '-' + day;
}
</script>
</body>
</html>