<%@page import="org.slf4j.Logger"%>
<%@page import="org.slf4j.LoggerFactory"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    
<%-- JSTL 전체라이브러리에 속한 core에 속한 태그들 사용을 위해  반드시 작성해야 하는 한줄 --%>   
<%@ taglib  uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>   
    
<% request.setCharacterEncoding("UTF-8");  %>        
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<link rel="stylesheet" href="../resources/css/setting.css" />
<link rel="stylesheet" href="../resources/css/plugin.css" />
<link rel="stylesheet" href="../resources/css/template.css" />
<link rel="stylesheet" href="../resources/css/common.css" />
<link rel="stylesheet" href="../resources/css/style.css" />
<link rel="stylesheet" href="../resources/css/style2.css" /> 

<link href="https://fonts.googleapis.com/css2?family=Roboto:wght@400;700&display=swap" rel="stylesheet">
<link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/5.15.1/css/all.min.css" rel="stylesheet">
<link href="https://stackpath.bootstrapcdn.com/bootstrap/5.1.3/css/bootstrap.min.css" rel="stylesheet">
<style type="text/css">
/* Wrapper for the whole page */
.wrapper {
    display: flex;
    flex-direction: column;
    min-height: 100vh; /* Ensure the wrapper fills at least the whole viewport height */
    width: 100%; /* Full width */
}

/* Header section styling */
.header {
    background-color: #f3f3f3; /* Light grey background */
    padding: 20px; /* Padding around content */
}

/* Main content section styling */
.content {
    flex: 1; /* Allows this section to expand to fill available space */
    padding: 20px; /* Padding around content */
    background-color: #fff; /* White background for contrast */
}

/* Footer section styling */
.footer {
    background-color: #222; /* Dark background for footer */
    color: #fff; /* White text color */
    padding: 10px 20px; /* Padding around content */
    text-align: center; /* Center the footer content */
}

/* Additional styles for responsiveness or other layout adjustments can be added below */

</style>
	
</head>
<body>
	<c:set var="center" value="${requestScope.center}"></c:set>
	<%
		String center = (String)request.getAttribute("center");
		Logger log = LoggerFactory.getLogger(getClass());
		String id = (String)session.getAttribute("id");
		log.debug("center = {}",center);
	%>
	<c:if test="${center == null }">		
		<c:set var="center" value="center.jsp"/>
	</c:if>
	
<div class="wrapper">
    <div class="header">
    <c:out value="${center}"/>
        <jsp:include page="top.jsp"/>
    </div>
    <div class="content">
        <jsp:include page="${center}"/>
    </div>
    <div class="footer">
        <jsp:include page="footer.jsp"/>
    </div>
</div>
<script src="../resources/js/slide.js"></script>
 
<!-- 
<script src="../resources/js/setting.js"></script>
   
    <script src="../resources/js/template.js"></script>
    <script src="../resources/js/common.js"></script>
    <script src="../resources/js/script.js"></script> -->


</body>
</html>













