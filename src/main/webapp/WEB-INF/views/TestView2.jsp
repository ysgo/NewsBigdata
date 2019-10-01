<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %> 
<%@ page import="vo.NewsVO, java.util.ArrayList, java.util.List" %>   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<script src="http://code.jquery.com/jquery-1.11.0.min.js"></script>
<title>Insert title here</title>

</head>
<body>
<h2>뉴스 상세 검색</h2><hr>

<c:if test="${sessionScope.mid != null}">
		<c:if test="${sessionScope.mid =='admin'}">
			<h2>${sessionScope.mid}님 안녕하세요!</h2>
			<a href="/festival/notice?pageNo=1">공지사항</a>
			<a href="/festival/logout">로그아웃</a> 
			<a href="/festival/adminpage">관리자 페이지</a>	
		</c:if>
		<c:if test="${sessionScope.mid !='admin'}">
			<h2>${sessionScope.mid}님 안녕하세요!</h2>
			<a href="/festival/notice?pageNo=1">공지사항</a>
			<a href="/festival/logout">로그아웃</a> 
			<a href="/festival/MyPage">마이 페이지</a>	
		</c:if>		
</c:if>

<c:if test="${sessionScope.mid == null}">
	<a href="/festival/notice?pageNo=1">공지사항</a>
	<a href="/festival/loginmain">로그인</a>
	<a href="/festival/memberForm">회원가입</a>
</c:if>

<output></output>
<form method="get" action="/festival/list">
<input type="hidden" name="action" value="search">
<input type="hidden" name="pageNo" value="1">
<section>
	<select name="date">
		<option value="2019">2019</option>
	</select>
	<select name="press">
		<option value="">전체</option>
		<option value="동아일보">동아일보</option><option value="동아일보">한국일보</option>
		<option value="중앙일보">중앙일보</option>
	</select>
	<select name="category">
		<option value="">전체</option>
		<option value="01">정치</option><option value="02">경제</option>
		<option value="03">문화</option><option value="04">사회</option>
	</select>
	<input type="submit" value="검색하기">
</section>
</form>
<hr>
<h2>검색 결과 리스트 (ajax로 구현할 부분?)↓↓↓</h2>


</body>
</html>