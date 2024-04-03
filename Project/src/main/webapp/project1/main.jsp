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
</head>
<body>
	

	<c:set var="center" value="${requestScope.center}" />  
	<c:out value="${center}" />   

	<c:if test="${center == null }">		
		<c:set var="center" value="center.jsp"/>
	</c:if>
	
	<center>
		<table  width="100%" height="100%">
			<tr align="left">
				<td height="25%"><jsp:include page="top.jsp"/></td>
			</tr>
			<tr>
				<td height="50%" align="center"><jsp:include page="${center}"/>  </td>
			</tr>		
			<tr>
				<td height="25%"><jsp:include page="footer.jsp"/></td>
			</tr>
		</table>
	</center>





</body>
</html>













