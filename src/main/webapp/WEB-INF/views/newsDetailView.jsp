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
	<form action="/newsbigdata/NewsdetailView.do" method="GET">
		<input type="hidden" name="action" value="search">
		<input type="hidden" name="pageNo" value="1">
		
			<!--hidden:사용자에게 안보이지만 관리자에게 value값을 서버로 넘기기위해  
			   name=key/ value=name에 해당하는 값으로 서버에 넘어간다-->
			<input id='keyword' type="text" name="keyword">
			<input id='b' type="submit" value="뉴스검색">
		 	<input type="reset" value="재작성">
	</form>
	
	<b>${count}</b>개의 게시물이 있습니다.
			
	</div>
	<br>
<h2>옵션 1 결과 화면 : ↓↓↓</h2>
	<table>
		<c:choose>
			<c:when test="${ list1 != null }" >
				<c:forEach var="data" items="${list1}">
					<tr>
						<td>${ data.title }</td><td>${ data.date }</td><td>${ data.contents }</td>
					</tr>
				</c:forEach>
			</c:when>
			<c:otherwise>  
			${msg}
			</c:otherwise>
		</c:choose>
	</table>
	<table border="1">
  		<tr>
  			<th>번호</th>
  			<th>뉴스제목</th>
  			<th>뉴스작성일</th>
  			<th>뉴스본문</th>
  			<th>조회수</th>
  		</tr>
  		<c:forEach var="board" items="${searchList}" varStatus="loop">
  		<tr>
  			<td>${loop.count}</td>
  			<td><a href="<c:url value="/boardRead/${board.num}${pageMaker.makeSearch(pageMaker.cri.page)}" />"> ${board.title}</a></td>
  			<td>${board.name}</td>
  			<td>${board.date}</td>
  			<td>${board.count}</td>
  		</tr>
  		</c:forEach>
  	</table>
  	<table>
  		<tr>
  		    <c:if test="${pageMaker.prev}">
  		    <td>
  		        <a href='<c:url value="/boardSearchList?${pageMaker.makeSearch(pageMaker.startPage-1)}"/>'>&laquo;</a>
  		    </td>
  		    </c:if>
  		    <c:forEach begin="${pageMaker.startPage}" end="${pageMaker.endPage}" var="idx">
  		    <td>
  		        <a href='<c:url value="/boardSearchList${pageMaker.makeSearch(idx)}"/>'>${idx}</a>
  		    </td>
  		    </c:forEach>
  		    <c:if test="${pageMaker.next && pageMaker.endPage >0}">
  		    <td>
  		        <a href='<c:url value="/boardSearchList${pageMaker.makeSearch(pageMaker.endPage+1)}"/>'>&raquo;</a>
  		    </td>
  		    </c:if>
  		</tr>
  	</table>
  	 	
  	<div class="row">				
				<c:if test='${!empty resultlist }'>
				<div class="container">
				<h4>현재 ${resultlist.currentPage }페이지 총 ${ resultlist.total }개의 검색결과</h4>
					<table class="table table-stripaed" style="text-align: center; border: 1px solid #dddddd; height: 70%">
						<c:forEach var="vo" items="${resultlist.list }">
							<tr onclick="location.href='http://localhost:8000/festival/detail?fid=${vo.fid}'">
								<td width="40%">
									<img src="resources/images/${vo.fid }/1.jpg" height='100'>
								</td>
								<td width="60%">
									<h3>${vo.name }</h3> ${vo.place }<br> ${vo.opendate }~${vo.closedate }
								</td>
							</tr>
						</c:forEach>
					</table>
					<table class="table" style="text-align: center; border: 1px solid #dddddd">
						<c:if test="${resultlist.hasVs()}">
							<tr>
								<td>
									<c:if test="${resultlist.startPage > 5}">
										<a href="http://localhost:8000/festival/list?pageNo=${resultlist.startPage - 5}&action=">[이전]</a>
									</c:if> <c:forEach var="pNo" begin="${resultlist.startPage}" end="${resultlist.endPage}">
										<a href="http://localhost:8000/festival/list?pageNo=${pNo}&action=">[${pNo}]</a>
									</c:forEach> <c:if test="${resultlist.endPage < resultlist.totalPages}">
										<a href="http://localhost:8000/festival/list?pageNo=${resultlist.startPage + 5}&action=">[다음]</a>
									</c:if>
								</td>
							</tr>
						</c:if>
					</table>
					</div>
				</c:if>
		</div>
  	
  	
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