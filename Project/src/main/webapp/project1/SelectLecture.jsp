<%@page import="VO.LectureVO"%>
<%@page import="java.util.List"%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" isELIgnored="false"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>강의 목록</title>
<link href="https://cdn.jsdelivr.net/npm/tailwindcss@2.1.4/dist/tailwind.min.css" rel="stylesheet">
<style>
    body {
        font-family: 'Roboto', sans-serif;
        background-color: #e9ecef;
    }
     .lecture-item {
        padding: 2rem; /* 내부 여백을 늘립니다 */
    }
    .lecture-link {
        line-height: 1.75; /* 줄 높이를 증가시킵니다 */
    }
    .lecture-title {
        font-size: 1.75rem; /* 글자 크기를 키웁니다 */
    }
</style>
</head>
<body class="bg-gray-100">
     <div class="container mx-auto p-4">
        <h1 class="text-2xl font-bold text-center text-gray-800 mb-5">강의 목록</h1>
        <div class="space-y-4">
            <c:forEach items="${lectureList}" var="lecture">
                <div class="lecture-item bg-white rounded-lg shadow hover:shadow-md transition-shadow duration-300 ease-in-out max-w-7xl mx-auto">
                    <a href="${pageContext.request.contextPath}/Lecture/play?courseId=${lecture.courseId}&lectureId=${lecture.lectureId}" class="lecture-link flex items-center justify-between text-gray-800 hover:text-blue-600">
                        <div class="flex items-center">
                            <span class="font-semibold text-xl">${lecture.lectureNumber}강</span> <!-- 강의 번호 글자 크기 조정 -->
                            <span class="lecture-title ml-2 mr-4 truncate">${lecture.lectureTitle}</span> <!-- 강의 제목 글자 크기 조정 -->
                        </div>
                        <div class="text-xl text-gray-600">${lecture.duration}분</div> <!-- 강의 시간 글자 크기 조정 -->
                    </a>
                </div>
            </c:forEach>
        </div>
    </div>
</body>

</html>
