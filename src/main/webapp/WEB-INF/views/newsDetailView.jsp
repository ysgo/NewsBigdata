<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<style>
</style>
</head>
<body>
<c:if test="${sessionScope.mid != null}">
		<c:if test="${sessionScope.mid =='admin'}">
			<h2>${sessionScope.mid}님 안녕하세요!</h2>
			<a href="/NewsBigdata/home.do">Main</a>
			<a href="/NewsBigdata/logout">로그아웃</a> 	
		</c:if>
		<c:if test="${sessionScope.mid !='admin'}">
			<h2>${sessionScope.mid}님 안녕하세요!</h2>
			<a href="/NewsBigdata/notice?pageNo=1">공지사항</a>
			<a href="/NewsBigdata/logout">로그아웃</a> 
			<a href="/NewsBigdata/MyPage">마이 페이지</a>	
		</c:if>		
</c:if>

<c:if test="${sessionScope.mid == null}">
	<a href="/NewsBigdata/loginmain">로그인</a>
	<a href="/NewsBigdata/memberForm">회원가입</a>
</c:if>
<hr>
<h2>임시 뉴스 정보</h2>
<output></output>	
	<hr>
	<div id="write" style="display: block;">
		<h2 id="divT">옵션 1 : 검색할 키워드를 입력하세요</h2>
		<form method="get" action="/NewsBigdata/NewsdetailView.do">
			키워드 :<input type="text" name="keyword">
 <input type="submit" value="등록"> 
 <input type="reset" value="재작성">		
		</form>
	</div>
	<br>
<h2>옵션 1 결과 화면 : (ajax로 구현 해야함.)↓↓↓</h2>
	<table>
		<c:choose>
			<c:when test="${ list1 != null }" >
				<c:forEach var="data" items="${list1}">
					<tr>
						<td>${ }</td>
						<td>${ data.title }</td>
						<td>${ data.date }</td>
						<td>${ data.contents }</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>  
			${msg}
			</c:otherwise>
		</c:choose>
	</table>
	
<hr>
<h2>옵션 2 : 필터링 항목들 ↓↓↓</h2>	 
<form method="get" action="/NewsBigdata/list">
<input type="hidden" name="action" value="search">
<input type="hidden" name="pageNo" value="1">
<section>
	<!-- 기간 -->
	<select name="date">
		<option value="2019">2019</option>
	</select>
	
	<!-- 언론사 -->
	<select name="press">
		<option value="">전체</option>
		<option value="동아일보">동아일보</option><option value="동아일보">한국일보</option>
		<option value="중앙일보">중앙일보</option>
	</select>
	
	<!-- 카테고리 -->
	<select name="category">
		<option value="">전체</option>
		<option value="01">정치</option><option value="02">경제</option>
		<option value="03">문화</option><option value="04">사회</option>
	</select>
	<input type="submit" value="검색하기">
</section>
</form>
<h2>옵션 2 결과 화면 : (옵션 1 결과 화면에 반영되야함.)</h2>
	<table>
		<c:choose>
			<c:when test="${ list1 != null }">
				<c:forEach var="data" items="${list1}">
					<tr>
						<td>${ data.title }</td>
						<td>${ data.date }</td>
						<td>${ data.contents }</td>
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