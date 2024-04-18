<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<% request.setCharacterEncoding("UTF-8"); %>
<c:set var="contextPath" value="${pageContext.request.contextPath}"/>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>강의 등록창</title>
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
            width: 100px;
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
					//Session내장객체 메모리 영역에 session값 얻기
					String id = (String)session.getAttribute("id");
					//Session에 값이 저장되어 있지 않으면?
					if(id == null){
						System.out.println("id : " + id);
%>
<script>
    alert("로그인 해주세요.");
    history.back(); // 브라우저의 이전 페이지로 이동
</script>
<%
    }
%>
<div class="container">
    <form action="${contextPath}/Courses/registration" method="post">
    	
        <h1 style="text-align:center">강의 등록</h1>
        <br>
        <div class="form-group">
            <label for="id">아이디 : </label>
            <input type="text" id="id" name="id" disabled="disabled" value="${sessionScope.id}">
        </div>
        <div class="form-group">
            <label for="price">강의 가격 : </label>
            <input type="text" id="price" name="price">원
            <p id="priceInput"></p>
        </div>
        <div class="form-group" align="center">
            <label for="category">강의 분야</label>
        </div>   
        <div>   
            <div class="form-radio">
                <input type="radio" id="backend" name="category" value="backend">
                <label for="backend">백엔드</label>
                
                <input type="radio" id="frontend" name="category" value="frontend">
                <label for="frontend">프론트엔드</label>
                
                <input type="radio" id="ai" name="category" value="ai">
                <label for="ai">인공지능 (AI)</label>
            </div>
            <p id="form-radio"></p>
        </div>
        <div class="form-group">
            <label for="title">강의 제목 : </label>
            <input type="text" id="title" name="title">
            <p id="titleInput"></p> 
        </div>
<!--         <div class="form-group"> -->
<!--             <label for="description">강의 내용 : </label>         -->
<!--             <input type="text" id="description" name="description"> -->
<!--         </div> -->

		<div class="form-group" style="width: 100%;">
		    <div style="position: relative;">
		        <label for="description" style="position: absolute; top: 0; left: 0;">강의 내용 : </label>  
		        <textarea id="description" name="description" rows="10" style="width: calc(90% - 100px); margin-left: 100px;"></textarea>
		    </div>
		</div>
		
        <div class="form-group">
            <label for="img">강의 이미지 : </label>
            <input type="text" id="img" name="img" placeholder="example.png">
        </div>
        <div class="form-group" style="text-align: center;">
       
    <button onclick="if (!check()) return false;" type="submit">강의 등록</button>
    <button type="reset">다시입력</button>

<!--             <button type="submit">강의 등록</button> -->
<!--             <button type="reset">다시입력</button> -->
        </div>
    </form>
</div>

 <script  src="https://code.jquery.com/jquery-latest.min.js"></script>
 
<%-- 강의등록 유효성 검사 체크 --%>
<script src="<%=request.getContextPath()%>/resources/js/course.js"></script>


</body>
</html>
