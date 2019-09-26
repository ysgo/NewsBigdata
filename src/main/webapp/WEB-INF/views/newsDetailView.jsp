<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>

</style>
</head>
<body>
    <h2> 임시 뉴스 정보 </h2>
    <hr>
<table>
		<tr id=a>
			<td>title</td>
			<td>time</td>
			<td>content</td>
		</tr>
	 	<c:choose>
	<c:when test="${ list1 != null }">  
			<c:forEach var="data"  items="${list1}">
	 		<tr>
	 		<td>${ data.title }</td>
	 		<td>${ data.time }</td>
	 		<td>${ data.content }</td>
	 		</tr>		
			</c:forEach>
	</c:when>
	<c:otherwise>  
			${msg}
	</c:otherwise>
	</c:choose> 
</table>	
</body>
</html>