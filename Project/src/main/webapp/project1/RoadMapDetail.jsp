<%@page import="VO.UsersVO"%>
<%@page import="VO.CourseVO"%>
<%@page import="java.util.List"%>
<%@ page contentType="text/html;charset=UTF-8" language="java"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<title>강좌 로드맵</title>
<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<script type="text/javascript"
	src="https://code.jquery.com/jquery-1.12.4.min.js"></script>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<script type="text/javascript"
	src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"></script>
<style>
body {
	font-family: 'Arial', sans-serif;
	position: relative;
}

.toolbar {
	position: fixed;
	top: 260px; /* 위에서부터의 간격 */
	right: 50px; /* 오른쪽에서부터의 간격 */
	width: 200px; /* 툴바의 너비 */
	background-color: #f1f1f1;
	border: 1px solid #ddd;
	border-radius: 4px;
	box-shadow: 0 2px 5px rgba(0, 0, 0, 0.2);
	padding: 10px;
	z-index: 1000;
}

.toolbar a {
	padding: 6px 10px;
	text-decoration: none;
	font-size: 16px;
	color: #333;
	display: block;
	margin-bottom: 5px;
	border-radius: 4px;
	transition: background-color 0.3s;
	white-space: nowrap; /* 텍스트를 한 줄로 제한 */
	overflow: hidden; /* 내용이 넘치면 숨김 */
	text-overflow: ellipsis; /* 내용이 넘칠 때 ...으로 표시 */
}

.toolbar a:hover {
	background-color: #ddd;
}

.body-content {
	display: flex;
	flex-direction: column;
	align-items: center; /* 센터 정렬 수정 */
	margin-top: 50px; /* 상단 여백 조정 */
}

.main-content, .roadMap {
	width: 80%; /* 콘텐츠 너비 조정 */
	max-width: 1000px; /* 최대 너비 설정 */
}

.course-card {
	box-shadow: 0 4px 8px 0 rgba(0, 0, 0, 0.2);
	transition: 0.3s;
	width: 100%; /* 카드 너비를 부모 요소에 맞춤 */
	border-radius: 5px;
	margin-bottom: 20px;
	padding: 15px;
	background-color: white;
}

.course-card:hover {
	box-shadow: 0 8px 16px 0 rgba(0, 0, 0, 0.2);
}

.course-title {
	font-size: 24px;
	color: #333;
}

.course-image-text {
	display: flex;
	align-items: center; /* 세로 방향에서 중앙 정렬 */
}

.course-img {
	width:175px; /* 이미지 크기, 필요에 따라 조정 */
	height: auto; /* 이미지 비율 유지 */
	margin-right: 10px; /* 텍스트와의 간격 */
}

.course-text {
	/* 필요한 추가 스타일이 있다면 여기에 작성 */
	
}

.course-price {
	font-size: 20px;
	color: #888;
	margin-bottom: 15px;
}

.purchase-button-container {
	position: fixed;
	top: 200px; /* toolbar보다 위에 위치하도록 설정 */
	right: 50px; /* 오른쪽에서부터의 간격 유지 */
	z-index: 1001; /* toolbar 위에 표시되도록 z-index 설정 */
}

.purchase-btn {
	border: none;
	outline: none;
	padding: 10px;
	color: white;
	background-color: #4CAF50;
	text-align: center;
	cursor: pointer;
	font-size: 18px;
	border-radius: 5px;
	width: 200px; /* 버튼 너비를 툴바와 동일하게 설정 */
}

.purchase-btn:hover {
	background-color: #45a049;
}
</style>
<c:set var="contextPath" value="${pageContext.request.contextPath}" />
<%
	List<CourseVO> courseVOList = (List<CourseVO>)request.getAttribute("courseVOList");
	int roadMapPrice = 0;
	for(CourseVO vo : courseVOList){
		roadMapPrice += vo.getCoursePrice();
	}
	UsersVO userList = (UsersVO)request.getAttribute("userList");
%>
	<script>
    const date = new Date();
    const year = date.getFullYear();
    const month = ('0' + (date.getMonth() + 1)).slice(-2);
    const day = ('0' + date.getDate()).slice(-2);
    const dateStr = `${year}-${month}-${day}`;
    const roadMapprice = <%=roadMapPrice%>;
	
        var IMP = window.IMP;
        IMP.init("imp14405414");

        function requestPay() {
            IMP.request_pay(
                {
                    pg: "html5_inicis",						//KG이니시스 pg파라미터 값
                    pay_method: "card",						//결제 방법
                    merchant_uid: createOrderNum(),			//주문번호
                    name: '${roadMapVO.roadMapTitle}',		//상품 명
                    amount: roadMapprice,					//금액
      				buyer_email: '${userVO.email}',
      				buyer_name: '${userVO.user_name}',
      				buyer_tel: '${userVO.phone_number}',
      				buyer_addr: '${userVO.address}',
//       			buyer_postcode: "01181"
     	
                },
                function (rsp) {
                	 console.log(rsp);
                     if ( rsp.success ) { //결제 성공시
                       var msg = '결제가 완료되었습니다.';
//                        var result = {
//                          "mpaynum" : rsp.merchant_uid, //결제번호
//                          "membernum" :[[${member.membernum}]], //회원번호
//                          "mpaymethod":rsp.pay_method, //결제수단
//                          "mpayproduct":rsp.name, //헬스장 이름 + 상품이름
//                          "mpayprice":rsp.paid_amount, // 결제금액
//                          "mpaydate" : new Date().toISOString().slice(0, 10), //결제일
//                          "mpaytime" : "",
//                          "tgoodsint" : null,
//                        }
                       makePaymentDTO(rsp); // 결제 DTO 생성
                       $("#payment_success_form").submit(); // 서브밋
                  	  alert(msg);
                    } else {
                        alert("결제에 실패하였습니다. 에러 내용: " + rsp.error_msg);
                    }
                }
            );
        }
        
        function createOrderNum() {
        	// 주문번호 임의로 만들기
            let today = new Date();
            let hours = today.getHours();		// 시
            let minutes = today.getMinutes();	// 분
            let seconds = today.getSeconds();	// 초
            let milliseconds = today.getMilliseconds();
            let makeMerchantUid = hours + minutes + seconds + milliseconds;
            
            return "IMP"+makeMerchantUid;
            }
        
        function makePaymentDTO(rsp) {
        	// 결제 완료 후, 결제 DTO 생성
        	let payment_code = $('<input>', {
                type: 'hidden',
                name: 'payment_id',
                value: rsp.merchant_uid
            });
            
             let userName = $('<input>', {
                type: 'hidden',
                name: 'userName',
                value: rsp.buyer_name
            });
            
            let payment_date = $('<input>', {
                type: 'hidden',
                name: 'payment_date',
                value: dateStr
            });
            
            let payment_amount = $('<input>', {
                type: 'hidden',
                name: 'payment_amount',
                value: rsp.paid_amount
            });
            
            let payment_status = $('<input>', {
                type: 'hidden',
                name: 'payment_status',
                value: rsp.status
            });
            
            let courseTitle = $('<input>', {
                type: 'hidden',
                name: 'courseTitle',
                value: rsp.name
            });
            
            let phoneNumber = $('<input>', {
                type: 'hidden',
                name: 'phone_number',
                value: rsp.buyer_tel
            });
            
            let email = $('<input>', {
                type: 'hidden',
                name: 'email',
                value: rsp.buyer_email
            });
        
            // 생성한 input 요소 폼 추가
            $("#payment_success_form").append(payment_code);
            $("#payment_success_form").append(userName);
            $("#payment_success_form").append(payment_date);
            $("#payment_success_form").append(payment_amount);
            $("#payment_success_form").append(payment_status);
            $("#payment_success_form").append(courseTitle);
            $("#payment_success_form").append(phoneNumber);
            $("#payment_success_form").append(email);
        }
    </script>
</head>

<body>

	<div class="purchase-button-container">
		<div class="roadmap-price-display"><strong>로드맵 가격</strong> : ₩<fmt:formatNumber value="<%=roadMapPrice%>" type="number" pattern="#,##0" /></div>
		<form action="#" method="post">
			<input type="hidden" name="roadMapPrice" value="<%=roadMapPrice%>">
			<input type="button" class="purchase-btn" value="로드맵 결제하기" onclick="requestPay()">
		</form>
	</div>
	<div class="toolbar">
		<c:forEach var="courses" items="${courseVOList}">
			<a href="${contextPath}/Courses/detail?courseId=${courses.courseId}">
				${courses.courseTitle} </a>
		</c:forEach>
	</div>
	<br>
	<br>
	<br>
	<div class="body-content">
		<div class="roadMap">
			<h1>${roadMapVO.roadMapTitle }</h1>
			<div class="roadMapDescription">
				<br>
				<h3>${roadMapVO.roadMapDescription }</h2>
			</div>
		</div>
		<div class="main-content">
			<c:forEach var="course" items="${courseVOList}">
				<div class="course-card" id="${course.courseId}">
					<div class="course-title">
						<div class="course-image-text">
							<a
								href="${contextPath}/Courses/detail?courseId=${course.courseId}">
								<img alt="강의 이미지" src="${contextPath }/project1/images/${course.imgPath}" class="course-img">
							</a>
							<div class="text-container">
								<!-- 새로운 div로 감싸 텍스트와 설명을 세로로 정렬 -->
								<div class="course-text">${course.courseTitle}</div>
								<div class="course-price">${course.courseDescription}</div>
								<div class="course-price">₩<fmt:formatNumber value="${course.coursePrice }" type="number" pattern="#,##0" /></div>
							</div>
						</div>
					</div>
				</div>
			</c:forEach>
		</div>
	</div>

    <form action="${contextPath}/Enroll/roadMap" id="payment_success_form">
		<!-- 결제 완료 후 정보 삽입 -->
		<input type="hidden" id="roadMapId" name="roadMapId" value="${roadMapVO.roadMapId}">
    </form>
</body>
</html>
