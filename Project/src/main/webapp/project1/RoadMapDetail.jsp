<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>강좌 로드맵</title>
    <style>
          body {
            font-family: 'Arial', sans-serif;
            position: relative;
        }
        .toolbar {
            position: fixed;
            top: 50px; /* 위에서부터의 간격 */
            right: 50px; /* 오른쪽에서부터의 간격 */
            width: 150px; /* 툴바의 너비 */
            background-color: #f1f1f1;
            border: 1px solid #ddd;
            border-radius: 4px;
            box-shadow: 0 2px 5px rgba(0,0,0,0.2);
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
        }
        .toolbar a:hover {
            background-color: #ddd;
        }
        .main-content {
            padding: 16px;
            padding-right: 200px; /* 툴바 너비 + 간격 */
        }
        .course-card {
            box-shadow: 0 4px 8px 0 rgba(0,0,0,0.2);
            transition: 0.3s;
            width: 40%;
            border-radius: 5px;
            margin-bottom: 20px;
            padding: 15px;
            background-color: white;
        }
        .course-card:hover {
            box-shadow: 0 8px 16px 0 rgba(0,0,0,0.2);
        }
        .course-title {
            font-size: 24px;
            color: #333;
        }
        .course-price {
            font-size: 20px;
            color: #888;
            margin-bottom: 15px;
        }
        .purchase-btn {
            border: none;
            outline: none;
            padding: 10px;
            color: white;
            background-color: #4CAF50;
            text-align: center;
            cursor: pointer;
            width: 100%;
            font-size: 18px;
            border-radius: 5px;
        }
        .purchase-btn:hover {
            background-color: #45a049;
        }
    </style>
</head>
<body>

<div class="toolbar">
    <c:forEach var="course" items="${courses}">
        <a href="#${course.id}">
        <img src="${contextPath }/resources/images/img_shop_01_1.png"><br>${course.title}
        </a>
    </c:forEach>
</div>

<div class="main-content">
    <c:forEach var="course" items="${courses}">
        <div class="course-card" id="${course.id}">
            <div class="course-title">${course.title}</div>
            <div class="course-price">${course.price}</div>
            <button class="purchase-btn">결제하기</button>
        </div>
    </c:forEach>
</div>

</body>
</html>
