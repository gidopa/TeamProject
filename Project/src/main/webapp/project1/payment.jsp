<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%request.setCharacterEncoding("UTF-8");%> 
<!DOCTYPE html>
<html lang="en">
<head>
    <!-- jQuery -->
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
        var IMP = window.IMP;
        IMP.init("imp14405414");

        function requestPay() {
            IMP.request_pay(
                {
                    pg: "html5_inicis",		//KG이니시스 pg파라미터 값
                    pay_method: "card",		//결제 방법
                    merchant_uid: createOrderNum(),//주문번호
                    name: "당근 10kg",		//상품 명
                    amount: 100,			//금액
      				buyer_email: "gildong@gmail.com",
      				buyer_name: "홍길동",
      				buyer_tel: "010-4242-4242",
      				buyer_addr: "서울특별시 강남구 신사동",
      				buyer_postcode: "01181"
     	
                },
                function (rsp) {
                	 console.log(rsp);
                     if ( rsp.success ) { //결제 성공시
                       var msg = '결제가 완료되었습니다.';
                       var result = {
                         "mpaynum" : rsp.merchant_uid, //결제번호
                         "membernum" :[[${member.membernum}]], //회원번호
                         "mpaymethod":rsp.pay_method, //결제수단
                         "mpayproduct":rsp.name, //헬스장 이름 + 상품이름
                         "mpayprice":rsp.paid_amount, // 결제금액
                         "mpaydate" : new Date().toISOString().slice(0, 10), //결제일
                         "mpaytime" : "",
                         "tgoodsint" : null,
                       }
                       console.log(result);
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
    </script>
    <meta charset="UTF-8"/>
    <title>Sample Payment</title>
</head>
<body>
<button onclick="requestPay()">결제하기</button>
<!-- 결제하기 버튼 생성 -->
</body>
</html>