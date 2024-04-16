<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt"%>
<%
request.setCharacterEncoding("UTF-8");
%>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<link
	href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css"
	rel="stylesheet">
<link
	href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css"
	rel="stylesheet">

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

.btn-edit, .btn-delete {
	margin-right: 5px;
}
</style>
</head>
<body>
	<br>
	<%
	//Session내장객체 메모리 영역에 session값 얻기
	String id = (String) session.getAttribute("id");
	//Session에 값이 저장되어 있지 않으면?
	if (id != null) {
	%>
	<div class="container mt-5">
		<h1 class="text-center mb-4">수강 후기</h1>
		<form id="commentForm" class="mb-3"
			action="${contextPath}/Review/comment" method="POST">
			<div class="mb-3">
				<label for="courseDropdown" class="form-label">코스 선택:</label> <select
					id="courseDropdown" name="courseId" class="form-select">
					<option value="">코스를 선택하세요</option>
					<c:forEach items="${courseList}" var="course">
						<option value="${course.courseId}">${course.courseTitle}</option>
						<input type="hidden" name="courseTitle"
							value="${course.courseTitle}">
					</c:forEach>
				</select>
			</div>
			<div class="mb-3">
				<input type="text" name="commentText" class="form-control"
					placeholder="후기를 입력하세요" required>
			</div>
			<div class="rating">
				<input type="hidden" name="rating" id="ratingInput"> <i
					class="far fa-star rating-star" data-value="1"></i> <i
					class="far fa-star rating-star" data-value="2"></i> <i
					class="far fa-star rating-star" data-value="3"></i> <i
					class="far fa-star rating-star" data-value="4"></i> <i
					class="far fa-star rating-star" data-value="5"></i>
			</div>
			<div class="mb-3">
				<input type="submit" class="btn btn-primary" value="댓글 달기">
			</div>
		</form>
		<div id="commentsContainer">
			<c:forEach items="${comments}" var="comment">
				<div id="comment-${comment.reviewId}" class="card mb-3">
					<div class="card-body">
						<h5 class="card-title" id="review-rating-${comment.reviewId}">
							${comment.courseTitle} - 평점: <span
								id="review-score-${comment.reviewId}">${comment.reviewScore}</span>
						</h5>
						<p class="card-text" id="review-content-${comment.reviewId}">${comment.reviewContent}</p>
						<div class="rating" id="rating-${comment.reviewId}">
<%-- 							<c:forEach begin="1" end="5" var="i"> --%>
<!-- 								<i -->
<%-- 									class="star far fa-star ${i <= comment.reviewScore ? 'fas' : 'far'}" --%>
<%-- 									data-value="${i}"></i> --%>
<%-- 							</c:forEach> --%>
						</div>
						<p class="card-text">
							<small class="text-muted">작성자: ${comment.userId} 작성 시간: <fmt:formatDate
									value="${comment.reviewDate}" pattern="yyyy-MM-dd" /></small>
						</p>
						<c:if test="${id == comment.userId}">
							<div class="card-actions float-right">
								<button type="button" class="btn btn-primary btn-edit"
									onclick="editComment(${comment.reviewId})">수정</button>
								<button type="button" class="btn btn-danger btn-delete"
									onclick="deleteComment(${comment.reviewId})">삭제</button>
							</div>
						</c:if>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>
	<%
	} else {
	%>

	<div id="commentsContainer">
		<c:forEach items="${comments}" var="comment">
			<div class="card mb-3">
				<div class="card-body">
					<h5 class="card-title">${comment.courseTitle}-평점:
						${comment.reviewScore}</h5>
					<p class="card-text">${comment.reviewContent}</p>
					<p class="card-text">
						<small class="text-muted">작성자: ${comment.userId} 작성 시간: <fmt:formatDate
								value="${comment.reviewDate}" pattern="yyyy-MM-dd" /></small>
					</p>
					<div class="card-actions float-right"></div>
				</div>
			</div>
		</c:forEach>
	</div>
	</div>
	<%
	}
	%>
	<script
		src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
	<script>
		$('#commentForm').submit(function(event) {
			event.preventDefault();
			$.ajax({
				url : '${contextPath}/Review/comment',
				type : 'POST',
				data : $(this).serialize(),
				dataType : 'html',
				success : function(response) {
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
		function editComment(reviewId) {
		    var contentElement = document.getElementById('review-content-' + reviewId);
		    var currentText = contentElement.innerHTML;
		    var currentScore = document.getElementById('review-score-' + reviewId).innerText;
		    
		    // 텍스트 수정 입력 필드 생성
		    var inputHtml = '<input type="text" id="input-' + reviewId + '" value="' + currentText + '">';

		    // 평점 수정 별 표시 생성
		    inputHtml += '<div class="rating-edit">';
		    for (let i = 1; i <= 5; i++) {
		        inputHtml += '<i class="star fa-star ' + (i <= currentScore ? 'fas' : 'far') + '" data-value="' + i + '" onclick="setRating(' + reviewId + ', ' + i + ')"></i>';
		    }
		    inputHtml += '</div>';
		    
		    inputHtml += '<button onclick="saveComment(' + reviewId + ')">저장</button>';
		    contentElement.innerHTML = inputHtml;
		}

		function setRating(reviewId, rating) {
		    var stars = document.querySelectorAll('#rating-edit-' + reviewId + ' .star');
		    stars.forEach(star => {
		        if (parseInt(star.getAttribute('data-value')) <= rating) {
		            star.classList.remove('far');
		            star.classList.add('fas');
		        } else {
		            star.classList.remove('fas');
		            star.classList.add('far');
		        }
		    });
		    document.getElementById('review-score-' + reviewId).innerText = rating;
		}

		function saveComment(reviewId) {
		    var inputValue = document.getElementById('input-' + reviewId).value;
		    var inputRating = document.getElementById('review-score-' + reviewId).innerText;
		    $.ajax({
		        url: '${contextPath}/Review/update',
		        type: 'POST',
		        data: {
		            reviewId: reviewId,
		            reviewContent: inputValue,
		            reviewScore: inputRating
		        },
		        success: function(response) {
		            // 성공적으로 처리된 경우, 입력 폼을 원래 텍스트와 평점으로 변경
		            document.getElementById('review-content-' + reviewId).innerHTML = inputValue;
		            document.getElementById('review-score-' + reviewId).innerText = inputRating;
		        }
		    });
		}
		
		function deleteComment(reviewId){
			$.ajax({
				url: '${contextPath}/Review/delete',
				type: 'POST',
				data: {
					reviewId: reviewId
				},
				success: function(response){
					alert("삭제가 완료 되었습니다");
					document.getElementById('comment-' + reviewId).remove();
				}
			})
		}
	</script>
</body>
</html>
