<%@page import="java.sql.Date"%>
<%@page import="VO.BoardCommentVO"%>
<%@page import="VO.BoardVO2"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>

<%
request.setCharacterEncoding("UTF-8");
String contextPath = request.getContextPath();

//조회한 글정보 얻기
BoardVO2 vo = (BoardVO2) request.getAttribute("vo");
String name = vo.getBoard_name();//조회한 글을 작성한 사람
String email = vo.getBoard_email();//조회한 글을 작성한 사람의 이메일
String title = vo.getBoard_title();//조회한 글제목
String content = vo.getBoard_content().replace("/r/n", "<br>");//조회한 글 내용
String b_idx = (String) request.getAttribute("b_idx");
String nowPage = (String) request.getAttribute("nowPage");
String nowBlock = (String) request.getAttribute("nowBlock");

//조회한 댓글 정보
// BoardCommentVO boardCommentVO = (BoardCommentVO) request.getAttribute("boardCommentVO");
// int comment_idx = boardCommentVO.getComment_idx(); // 댓글 번호
// int board_idx = boardCommentVO.getBoard_idx(); // 댓글이 달린 주글의 번호
// String comment_id = boardCommentVO.getComment_id(); // 작성자 아이디
// String comment_pw = boardCommentVO.getComment_pw(); // 작성자 비밀번호
// String comment_name = boardCommentVO.getComment_name(); // 작성자 이름
// String comment_email = boardCommentVO.getComment_email(); // 작성자 이메일
// String comment_content = boardCommentVO.getComment_content().replace("/r/n", "<br>"); // 댓글 내용
// Date comment_date = boardCommentVO.getComment_date(); // 작성일
%>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-latest.min.js"></script>

<!DOCTYPE html PUBLIC "-//W3C//DTD HTML 4.01 Transitional//EN" "http://www.w3.org/TR/html4/loose.dtd">
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
<title>글 수정 화면</title>

<style>
.comment-item {
	border: 1px solid #ccc; /* 테두리 설정 */
	border-radius: 5px; /* 둥근 테두리 설정 */
	margin-bottom: 10px; /* 아이템 간 간격 설정 */
	padding: 10px; /* 안쪽 여백 설정 */
	display: flex; /* 가로 배치를 위해 flex 사용 */
	justify-content: space-between; /* 요소들을 가로로 정렬 */
	align-items: center; /* 요소들을 세로 중앙 정렬 */
}

.comment-info {
	font-size: 14px; /* 작성자 및 작성일 폰트 크기 설정 */
	display: flex; /* 가로 배치를 위해 flex 사용 */
	align-items: center; /* 요소들을 세로 중앙 정렬 */
}

.comment-info .comment-writer {
	font-weight: bold; /* 작성자 이름 굵게 설정 */
	margin-right: 10px; /* 작성자 이름과 작성일 간 간격 설정 */
}

.comment-date {
	color: #999; /* 작성일 색상 설정 */
}

.comment-content {
	font-size: 16px; /* 댓글 내용 폰트 크기 설정 */
	margin-top: 10px; /* 작성자와 작성일과의 간격 설정 */
}

.comment-buttons {
	display: flex; /* 가로 배치를 위해 flex 사용 */
}

.comment-buttons button {
	margin-left: 5px; /* 버튼 간 간격 설정 */
	padding: 5px 10px; /* 버튼 안쪽 여백 설정 */
	border: none; /* 버튼 테두리 없애기 */
	border-radius: 3px; /* 둥근 테두리 설정 */
	cursor: pointer; /* 커서 모양 변경 */
}

.reply-button {
	background-color: #5bc0de; /* 답변 버튼 배경색 설정 */
	color: #fff; /* 답변 버튼 글자색 설정 */
}

.edit-button {
	background-color: #f0ad4e; /* 수정 버튼 배경색 설정 */
	color: #fff; /* 수정 버튼 글자색 설정 */
}

.delete-button {
	background-color: #d9534f; /* 삭제 버튼 배경색 설정 */
	color: #fff; /* 삭제 버튼 글자색 설정 */
}

/* 기본 버튼 스타일 */
#submitComment {
	display: inline-block;
	padding: 10px 20px;
	border: none;
	border-radius: 5px; /* 둥근 모서리 설정 */
	background-color: #4CAF50; /* 배경색 설정 */
	color: white; /* 글자색 설정 */
	text-align: center;
	text-decoration: none;
	font-size: 16px;
	cursor: pointer;
	transition-duration: 0.4s;
}

/* 마우스 호버 효과 */
#submitComment:hover {
	background-color: #45a049; /* 호버시 배경색 변경 */
	color: white; /* 호버시 글자색 변경 */
}

/* 텍스트 에어리어 스타일 */
#comment {
	display: block;
	margin-bottom: 10px; /* 버튼과의 간격 설정 */
	width: 100%;
	padding: 10px;
	border-radius: 5px; /* 둥근 모서리 설정 */
	border: 1px solid #ccc; /* 테두리 스타일 설정 */
	box-sizing: border-box; /* 패딩과 테두리 포함 설정 */
}
</style>


</head>
<body>
	<%
	String id = (String) session.getAttribute("id");
	if (id == null) {//로그인 하지 않았을경우
	%>
	<script>	
		alert("로그인을 하셔야 합니다.");
		history.back();
	</script>
	<%
	}
	%>
	<table width="80%" border="0" cellspacing="0" cellpadding="0">
		<tr height="40">
			<td width="41%" style="text-align: left">&nbsp;&nbsp;&nbsp; <img
				src="<%=contextPath%>/boarders/images/board02.gif" width="150"
				height="30">
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<div align="center">
					<img src="<%=contextPath%>/boarders/images/line_870.gif"
						width="870" height="4">
				</div>
			</td>
		</tr>
		<tr>
			<td colspan="3">
				<div align="center">
					<table width="95%" border="0" cellspacing="0" cellpadding="0">
						<tr>
							<td height="20" colspan="3"></td>
						</tr>
						<tr>
							<td height="327" colspan="3" valign="top">
								<div align="center">
									<table width="95%" height="373" border="0" cellpadding="0"
										cellspacing="1" class="border1">
										<tr>
											<td width="13%" height="29" bgcolor="#e4e4e4" class="text2">
												<div align="center">작 성 자</div>
											</td>
											<td width="34%" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="text" name="writer" id="writer"
												value="<%=name%>" disabled>
											</td>
											<td width="13%" bgcolor="#e4e4e4">
												<div align="center">
													<p class="text2">이메일</p>
												</div>
											</td>
											<td width="40%" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="email" name="email" id="email"
												value="<%=email%>" disabled>
											</td>
										</tr>
										<tr>
											<td height="31" bgcolor="#e4e4e4" class="text2">
												<div align="center">제&nbsp;&nbsp;&nbsp; &nbsp; 목</div>
											</td>
											<td colspan="3" bgcolor="#f5f5f5" style="text-align: left">
												&nbsp;&nbsp; <input type="text" name="title" id="title"
												value="<%=title%>" disabled>
											</td>
										</tr>
										<tr>
											<td height="245" bgcolor="#e4e4e4" class="text2">
												<div align="center">내 &nbsp;&nbsp; 용</div>
											</td>
											<td colspan="3" bgcolor="#f5f5f5"
												style="text-align: left; vertical-align: top;">&nbsp; <textarea
													rows="20" cols="100" name="content" id="content" disabled><%=content%></textarea>
											</td>
										</tr>
										<tr>
											<td bgcolor="#e4e4e4" class="text2">
												<div align="center">패스워드</div>
											</td>
											<td colspan="2" bgcolor="#f5f5f5" style="text-align: left">
												<input type="password" name="pass" id="pass" />
											</td>
											<td colspan="2" bgcolor="#f5f5f5" style="text-align: center;">
												<p id="pwInput">글수정,삭제하려면 패스워드 입력바람</p>
											</td>
										</tr>
									</table>
								</div>
							</td>
						</tr>
						<tr>
							<td colspan="3">&nbsp;</td>
						</tr>
						<tr>
							<td style="width: 48%">
								<div align="right" id="menuButton">
									<%--수정하기 --%>
									<input type="image"
										src="<%=contextPath%>/boarders/images/update.gif" id="update"
										style="visibility: hidden" />&nbsp;&nbsp;
									<%--삭제하기 --%>
									<input type="image"
										src="<%=contextPath%>/boarders/images/delete01.gif"
										id="delete" onclick="javascript:deletePro('<%=b_idx%>');"
										style="visibility: hidden" />&nbsp;&nbsp;
									<%--답변달기 --%>
									<%-- 									<input type="image" src="<%=contextPath%>/boarders/images/reply.gif" id="reply" />&nbsp;&nbsp;  --%>
								</div>
							</td>
							<td width="10%">
								<div align="center">
									<%-- 목록 --%>
									<input type="image"
										src="<%=contextPath%>/boarders/images/list.gif" id="list"
										onclick="location.href='<%=contextPath%>/board2/list.bo?nowBlock=<%=nowBlock%>&nowPage=<%=nowPage%>'" />&nbsp;
								</div>
							</td>

							<td width="42%"></td>
						</tr>
						<tr>
							<td colspan="3" style="height: 19px">&nbsp;</td>
						</tr>
					</table>
					<%--답변을 눌렀을때 답변을 작성할 수 있는 화면 요청 --%>
					<div id="detgul"></div>
					
						<c:forEach var="list" items="${list}"><div >
							<div class="comment-item" id="comment-item-${list.comment_idx}">
								<div class="comment-header">
									<p class="comment-info">
										<p> 작성자 : </p> <span class="comment-writer">${list.comment_id}</span>
										<span class="comment-date">${list.comment_date} </span>
									</p>
								</div>	

								<div id="comment-body-${list.comment_idx }" class="comment-body-${list.comment_idx }">
									<p id="comment-content-${list.comment_idx }" class="comment-content">${list.comment_content}</p>
								</div>

								<div class="comment-footer">
									<button class="reply-button">답변</button>
									<button class="edit-button" onclick="modifyComment(${list.comment_idx})">수정</button>
									
									<button  id="x" class="delete-button" data-comment-idx="${list.comment_idx}">삭제</button>
									
									<form action="<%=contextPath%>/board2/deleteComment.do">
<!-- 										<input type="submit"  class="delete-button" value="삭제"> -->
										<input type="hidden" value="${list.comment_idx}" name="comment_idx" id="commentIDX">
									</form>
									
								</div>
							</div></div>
						</c:forEach>
					
					<form id="replyForm">
						<input type="hidden" name="b_idx" value="<%=b_idx%>" id="b_idx">
						<input type="hidden" name="id" value="<%=id%>">
						<div id="replySection">
							<!-- 댓글 작성을 위한 디자인 코드 -->
							<div id="replySectionSub">
								<textarea rows="4" cols="50" name="comment" id="comment"></textarea>
								<!-- 버튼을 클릭하여 폼 서브밋 -->
								<input type="button" id="submitComment" value="댓글 작성">
							</div>
						</div>
					</form>

					<script>
					$(document).ready(function(){
					    $("#submitComment").click(function(){
					        var commentText = $('#comment').val();  // 입력된 댓글 내용 가져오기
							var id = <%=b_idx%>;
					        // AJAX를 통해 서버에서 로그인한 사용자의 ID를 가져오는 요청을 보냅니다.
					        $.ajax({
					            url: '<%=contextPath%>/board2/replyPro.bo', // 사용자의 ID를 가져오는 서버 엔드포인트 URL을 입력하세요.
					            type: 'POST',
					            dataType: 'html',
					            data : {b_idx : <%=b_idx%>,
					            		comment : commentText},
					            success: function(response) {
					                var writerID = '<%=id%>';  // 서버에서 받아온 로그인한 사용자의 ID
					                var commentDate = new Date().toLocaleString();  // 현재 날짜와 시간을 가져와서 댓글 작성 시간으로 사용
									
					                // 새로운 댓글 아이템 생성 및 내용 입력
					                var newCommentHtml = '<div class="comment-item">' +
	                       									 '<div class="comment-header">' +
	                         							     	'<p class="comment-info">작성자: <span class="comment-writer">' + writerID + '</span>작성일: <span class="comment-date">' + commentDate + '</span></p>' +
	                     								     '</div>' +
	                       									 '<div class="comment-body">' +
	                        							     	'<p class="comment-content">' + commentText + '</p>' +
	                      								     '</div>' +
	                      								     '<div class="comment-footer">' +
									                             '<button class="reply-button">답변</button>' +
									                             '<button class="edit-button">수정</button>' +
									                             '<button class="delete-button">삭제</button>' +
								                      	     '</div>' +
							                             '</div>';

					                // 새로운 댓글 아이템을 detgul에 추가
					                $('#detgul').prepend(newCommentHtml);
					               
					                // 댓글 입력 필드 초기화
					                $('#comment').val('');
					                
					                location.reload();
					            },
					            error: function(xhr, status, error) {
					                console.error('AJAX 요청 실패:', status, error);
					            }
					        });
					    });
					});
			
					
					
					
					// 삭제 버튼 클릭 시 댓글 삭제 함수
					$(document).on("click", ".delete-button", function() {
						event.preventDefault();
	
						
						
						$("#x").data("commentIdx", $("#commentIDX").val());
						
						
					    var commentIdx = $(this).data("commentIdx"); 
					    
					    
// 					    	
					    console.log(commentIdx,"");
					    
					    var result = window.confirm("정말로 이 댓글을 삭제하시겠습니까?");

					    if (result) { // 확인 버튼 클릭 시
					        $.ajax({
					            type: "POST",
					            url: "<%=contextPath%>/board2/deleteComment.do",
					            data: { commentIdx : commentIdx },  
					            dataType: "text",
					            success: function (response) {
					            	console.log("서버로부터 받은 응답:", response);
					                // 서버로부터의 응답에 따라 적절한 동작 수행
					                if (response == "삭제성공") {
					                    // 삭제에 성공한 경우 해당 댓글을 화면에서 제거
					                    $("#comment-item-"+commentIdx).remove();
					                } else {
					                    // 삭제에 실패한 경우 사용자에게 알림
					                    alert("댓글 삭제에 실패했습니다.");
					                }
					            },
					            error: function () {
					                // 통신 오류 발생 시 사용자에게 알림
					                alert("서버와의 통신 중 오류가 발생했습니다.");
					            }
					        });
					    }
					});
					
	function modifyComment(commentIdx){
		
		console.log('comment-content-'+commentIdx);
		
		var contentElement = document.getElementById('comment-content-'+commentIdx);
// 			$(".comment-body"+commentIdx);          
		console.log(contentElement);
		
		var currentText = contentElement.innerText;
		
		 var textareaHtml = '<textarea id="input-' + commentIdx + '" class="form-control" rows="4">' + currentText+ '</textarea>';

         // 평점 수정 별 표시 생성
//          textareaHtml += '<div class="rating-edit" id="rating-edit-' + reviewId + '">';
//          for (let i = 1; i <= 5; i++) {
//              textareaHtml += '<i class="star fa-star ' + (i <= currentScore ? 'fas' : 'far') + '" data-value="' + i + '" onclick="setRating(' + reviewId + ', ' + i + ')"></i>';
//          }
//          textareaHtml += '</div>';
         
         textareaHtml += '<button onclick="saveComment(' + commentIdx + ')" class="btn btn-success">저장</button>';
         contentElement.innerHTML = textareaHtml;
	}
	
	function saveComment(commentIdx) {
        var inputValue = document.getElementById('input-' + commentIdx).value;
        $.ajax({
            url: "<%=contextPath%>/board2/update",
            type: 'POST',
            data: {
                reviewId: commentIdx,
                reviewContent: inputValue,
            },
            success: function(response) {
                // 성공적으로 처리된 경우, 입력 폼을 원래 텍스트와 평점으로 변경
//                 document.getElementById('comment-content').innerHTML = inputValue;
                document.getElementById('comment-content-'+commentIdx).innerText = inputValue;
            }
        });
    }

</script>


				</div>
			</td>
		</tr>
	</table>

	<%--답변을 눌렀을때 답변을 작성할 수 있는 화면 요청 --%>
	<form action="<%=contextPath%>/board2/reply.do" id="replyForm">
		<input type="hidden" name="b_idx" value="<%=b_idx%>" id="b_idx">
		<input type="hidden" name="id" value="<%=id%>">
	</form>
	<script>
// 		//답변 <input type="img">를 선택해서 클릭이벤트 등록 
// 		$("#reply").on("click",function(){
// 			//바로 위 <form>을 선택해서  답변을 입력하는 화면 요청! 
// 			$("#replyForm").submit();
			
			
// 		});
	
	
	
	
		function deletePro(b_idx){
			
			var result = window.confirm("정말로 글을 삭제하시겠습니까?");
			
			if(result == true){//확인 버튼 클릭
				
				//비동기방식으로 글삭제 요청!
				$.ajax({
					type : "post",
					async : true,
					url : "<%=contextPath%>/board2/deleteBoard.bo",
					data : {b_idx : b_idx},
					dataType : "text",
					success : function(data){//"삭제성공"  또는 "삭제실패"
						
						if(data=="삭제성공"){
							
							$("#pwInput").text("삭제 성공!").css("color","green");
							//입력하여 수정할 수 있는 <input>2개, <textarea>1개 비활성화
							document.getElementById("email").disabled = true;
							document.getElementById("title").disabled = true;
							document.getElementById("content").disabled = true;
<%-- location.href = "<%=contextPath%>/board/list.bo?nowBlock=0&nowPage=0"; --%>
							
							//강제로 목록 <input>을 클릭 이벤트 발생시키는 부분!
//							$("#list").trigger("click");
							
							// 1초 쉬었다가 강제로 목록 <input>을 클릭 이벤트 발생시키는 부분! 
							// 삭제된 글목록을 확인 하기 위해 글목록 조회를 재요청!~
							setTimeout(function() { $("#list").trigger("click");}, 500);
														
						}else{//"삭제실패"
							$("#pwInput").text("삭제 실패!").css("color","red");
							document.getElementById("email").disabled = false;
							document.getElementById("title").disabled = false;
							document.getElementById("content").disabled = false;
						}
						
						
					},
					error : function(){
						alert("비동기 통신 장애");
					}
				});
			
				
			}else{//취소 버튼을 눌렀을때
				return false;
			}
		}
	
	
	
	
		//수정 이미지 버튼을 선택해서 가져와서 클릭 이벤트 등록!
		$("#update").click(function() {
			
			var email = $("#email").val(); //수정시 입력한 이메일 얻기
			var title = $("#title").val(); //수정시 입력한 글 제목 얻기
			var content = $("#content").val(); //수정시 입력한 글 내용 얻기
			var idx = $("#b_idx").val(); //수정시 사용할 글번호 얻기
			
			$.ajax({
				type : "post",
				async : true,
				url : "<%=contextPath%>/board2/updateBoard.do",
				data : {
					email : email,
					title : title,
					content : content,
					idx : idx
				},
				dataType : "text",
				success : function(data){
// 					console.log(data);
					
					if(data=="수정성공"){
						$("#pwInput").text("수정 성공!").css("color","green");
						//입력하여 수정할 수 있는 <input>2개, <textarea>1개 비활성화
						document.getElementById("email").disabled = true;
						document.getElementById("title").disabled = true;
						document.getElementById("content").disabled = true;
						
					}else{//"수정실패"
						$("#pwInput").text("수정 실패!").css("color","red");
						document.getElementById("email").disabled = false;
						document.getElementById("title").disabled = false;
						document.getElementById("content").disabled = false;
					}
					
				},
				error : function(){
					alert("비동기 통신 장애");
				}
				
				
			});
			
		});
	
	
	
	
	
	
		//수정 삭제를 위해 비밀번호를 입력하고 포커스가 떠난 이벤트가 발생했을때...
		$("#pass").on("focusout",function(){
			
			$.ajax({
				type : "post",
				async : true,
				url : "<%=contextPath%>/board2/password.do",
				data : { b_idx : $("#b_idx").val(),        pass : $("#pass").val() },
				dataType : "text", 
				success : function(data){
// 					console.log(data);
					
					if(data=="비밀번호틀림"){
						$("#pwInput").text("글의 비밀번호가 다릅니다.").css("color","red");
						//입력하여 수정할 수 있는 <input>2개, <textarea>1개 비활성화
						document.getElementById("email").disabled = true;
						document.getElementById("title").disabled = true;
						document.getElementById("content").disabled = true;
						$("#update").css("visibility","hidden");
						$("#delete").css("visibility","hidden");
// 						document.getElementById("reply").disabled = true;
// 						document.getElementById("update").disabled = true;
// 						document.getElementById("delete").disabled = true;
					
					}else{//"비밀번호맞음"
						$("#pwInput").text("글의 비밀번호가 일치합니다. 글의 수정 및 삭제가 가능합니다.").css("color","green");
						//글 수정 및 삭제할수 있도록
						//위 비활성화 되어 있던 <input>들을 선택해서 disabled속성의 값을 false로 주어
						//활성화 시켜 입력할수 있도록 보여줌 
						document.getElementById("email").disabled = false;
						document.getElementById("title").disabled = false;
						document.getElementById("content").disabled = false;
						
						//숨겨져 있던 글 수정 이미지<input>과 글삭제 이미지<input>을 다시 보이게 했다
						$("#update").css("visibility","visible");
						$("#delete").css("visibility","visible");
// 						document.getElementById("reply").disabled = false;
// 						document.getElementById("update").disabled = false;
// 						document.getElementById("delete").disabled = false;
					}
					
				},
				error : function(){
					alert("비동기 통신 장애");
				}
			});
		});
	
		
	</script>


</body>
</html>