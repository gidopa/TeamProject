 <%@page import="VO.CourseVO"%>
            <%@ page language="java" contentType="text/html; charset=UTF-8"
                pageEncoding="UTF-8"%>
                <%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
            <%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
            <c:set var="contextPath"   value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>강의 정보 VIEW</title>
    <link rel="stylesheet" href="/Project/project1/css/Detailpage.css" />
      <script
            type="text/javascript"
            src="https://code.jquery.com/jquery-1.12.4.min.js"
    ></script>
    <!-- iamport.payment.js -->
    <script
            type="text/javascript"
            src="https://cdn.iamport.kr/js/iamport.payment-1.2.0.js"
    ></script>
    <script>
    const date = new Date();
    const year = date.getFullYear();
    const month = ('0' + (date.getMonth() + 1)).slice(-2);
    const day = ('0' + date.getDate()).slice(-2);
    const dateStr = `${year}-${month}-${day}`;
    
        var IMP = window.IMP;
        IMP.init("imp14405414");

        function requestPay() {
            IMP.request_pay(
                {
                    pg: "html5_inicis",		//KG이니시스 pg파라미터 값
                    pay_method: "card",		//결제 방법
                    merchant_uid: createOrderNum(),//주문번호
                    name: '${courseVO.courseTitle}',		//상품 명
                    amount: ${courseVO.coursePrice},			//금액
      				buyer_email: '${userVO.email}',
      				buyer_name: '${userVO.user_name}',
      				buyer_tel: '${userVO.phone_number}',
      				buyer_addr: '${userVO.address}',
//       				buyer_postcode: "01181"
     	
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
            let hours = today.getHours(); // 시
            let minutes = today.getMinutes();  // 분
            let seconds = today.getSeconds();  // 초
            let milliseconds = today.getMilliseconds();
            let makeMerchantUid = hours +  minutes + seconds + milliseconds;
            
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
    <div class="center-container">
        <div class="course-info">
           
            <%
                request.setCharacterEncoding("utf-8");
                String contextPath = request.getContextPath();
                CourseVO courseVO = (CourseVO)request.getAttribute("courseVO");
            %>
              <br><br><br><br><br>
            
            <h1 class="center1">강의 정보</h1>
          
<%--             <form action="<%=contextPath%>/Pay/check" method="post"> --%>
                <table>
                    <tr>
                        <td rowspan="4" class="center1"><a href="<%=contextPath%>/Courses/lecture"><img src="${contextPath}/project1/images/${courseVO.imgPath}" alt="강의 이미지"  width="500"></a></td>
                        <th>강의 카테고리</th>
                        <td>${courseVO.courseCategory}</td>
                    </tr>
                    <tr>
                        <th>강의명</th>
                        <td>${courseVO.courseTitle}</td>
                    </tr>
                    <tr>
                        <th>강사명</th>
                        <td>${courseVO.userId}</td> 
                    </tr>
                    <tr>
                        <th>강의 금액</th>
                        <td>₩<fmt:formatNumber value="${courseVO.coursePrice}" type="number" pattern="#,##0" /></td>
                    </tr>
                    </table>
                      <div class="btn-container">
                    <input type="hidden" name="courseTitle" value="${courseVO.courseTitle}">
                    <input type="hidden" name="coursePrice" value="${courseVO.coursePrice}">
                    <input type="button" class="btn" value="이전" onclick="history.back();">
<!--                     <input type="submit" class="btn" value="결제하기" onclick="requestPay()"> -->
                    <button class="btn" onclick="requestPay()">결제하기</button>
                </div>
<!--                 <button onclick="requestPay()">결제하기</button> -->
<!--             </form> -->
            <div class="course-info">
                <p><b>강의 정보</b></p>
                <p>${courseVO.courseDescription}</p> 
            </div>
        </div>
    </div>
    <form action="${contextPath}/Pay/payConfirm" id="payment_success_form">
		<!-- 결제 완료 후 정보 삽입 -->
		<input type="hidden" name="courseId" value="${courseVO.courseId }">
    </form>
     
</body>
</html>
