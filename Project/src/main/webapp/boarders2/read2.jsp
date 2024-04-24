<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<!DOCTYPE html>
<html lang="en">
<head>
<meta charset="UTF-8">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<title>댓글 입력</title>
<style>
    #commentForm {
        margin-bottom: 20px;
    }
    #commentForm textarea {
        width: calc(100% - 110px); /* 버튼 너비까지 고려하여 textarea 크기 설정 */
        height: 100px;
        resize: none;
        margin-bottom: 10px;
    }
    #commentForm button {
        background-color: #007bff;
        color: white;
        border: none;
        padding: 10px 20px;
        cursor: pointer;
    }
    #commentForm button:hover {
        background-color: #0056b3;
    }
</style>
</head>
<body>

<div id="commentForm">
    <textarea id="commentText" placeholder="댓글을 입력하세요"></textarea>
    <button id="submitComment">댓글 작성</button>
</div>

<div id="comments">
    <!-- 여기에 댓글이 추가됩니다 -->
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
$(document).ready(function(){
    // 댓글 작성 버튼 클릭 이벤트
    $(document).on("click", "#submitComment", function(){
        var commentText = $("#commentText").val(); // 입력한 댓글 내용 받아 저장

        // 여기에 댓글 작성 기능을 구현할 수 있습니다.
        // AJAX를 사용하여 서버로 댓글을 전송하고, 화면에 추가하는 등의 작업을 수행합니다.
        // 입력한 아이디가 DB에 저장되어 있는지 없는지 확인 요청
        // Ajax기술을 이용 하여 비동기 방식으로 MemberController로 합니다.
        $.ajax({  
        	url : "<%=request.getContextPath()%>/board/replyPro.bo", //요청할 주소
			type : "post",  //전송요청방식 설정! get 또는 post 둘중 하나를 작성
			async : true,  //true는 비동기방식 , false는 동기방식 으로 서버페이지 요청!
			data : {comment_content : commentText,  b_idx : <%=14%>}, //서버 페이지로 요청할 변수명 : 값
			dataType : "text", //서버페이지로 부터 응답 받을 데이터 종류 설정!
							   //종류는 json 또는 xml 또는 text중 하나 설정!
            success: function(data){
            	if(data=='성공'){ // 댓글 등록 성공 시
                    // 입력한 댓글 내용을 비활성화
                    $("#commentText").val("");
                    // 등록한 댓글을 화면에 추가
                    var newComment = '<div class="comment">';
                    newComment += '<p>' + commentText + '</p>';
                    newComment += '</div>';
                    $("#commentForm").before(newComment); // 입력칸 위에 추가
                    // 입력한 댓글 내용을 비활성화
                    $("#commentText").val("");
                } else {
                    alert("댓글 등록에 실패했습니다.");
                }
            },
            error: function(){
                alert("서버와의 통신에 실패했습니다.");
            }
        });
    });
});
</script>
</body>
</html>
