<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8" isELIgnored="false"%>
   		
   		 <%-- JSTL 전체라이브러리에 속한 core에 속한 태그들 사용을 위해  반드시 작성해야 하는 한줄 --%>
        <%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
    
    <% request.setCharacterEncoding("UTF-8"); %>  
    
    <c:set var="contextPath"   value="${pageContext.request.contextPath}"/> 
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>동영상 강의를 눌렀을때 나오는 화면</title>
		<style>
			  table {
			   
			    border: 1px solid #444444;
			  }
			  th, td {
			    border: 1px solid #444444;
			  }
	</style>

</head>


<body>
	<center>
					
			<table width="1000" height="470">
			
				<c:set var="j" value="0"/>
			
<%--   강의로 부터 재요청 받은 request영역에서 Vector배열을 꺼내와 
	   Vector배열에 저장된 VO객체의 갯수만큼 반복해서 얻어 정보를 출력
--%>				
			dasdsadsadsa
			<c:forEach var="list"  items="${requestScope.list}"><%--vo갯수만큼 반복 --%>
				
					<c:if test="${j % 4 == 0}">	한 행에 4열의 정보를 보여주기 위해 조건 
						<tr align="cetner">
					</c:if>
								
							<td>				<%--강의를 눌렀을때 요청주소  --%>
								<a href="${contextPath}/Courses/moveInfo.do?courses_id="1"">
								<img src="${contextPath }/resources/images/img_shop_01_1.png" width="220" height="180"><br> 
									강의명 : ${list.courseTitle}<br>
									강의 가격 : ${list.coursePrice} 
								</a>
							</td>
					 <c:set var="j" value="${j+1}"/>
			</c:forEach>
					  </tr>
			
			</table>
		</form>
	</center>



</body>
</html>