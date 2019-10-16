<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Insert title here</title>
<script src="http://ajax.googleapis.com/ajax/libs/jquery/1.7/jquery.js"></script>
<style>
</style>
</head>
<body>
<c:if test="${sessionScope.mid != null}">
		<c:if test="${sessionScope.mid =='admin'}">
			<h2>${sessionScope.mid}님 안녕하세요!</h2>
			<a href="/NewsBigdata/home">Main</a>
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
	<a href="/newsbigdata/home">HOME</a>
	<a href="/NewsBigdata/loginmain">로그인</a>
	<a href="/NewsBigdata/memberForm">회원가입</a>
	
</c:if>
<hr>
<h2>임시 뉴스 정보</h2>
<output></output>	
	<hr>
	<div id="write" style="display: block;">
		<h2 id="divT">옵션 1 : 검색할 키워드를 입력하세요</h2>
	<form action="/newsbigdata/NewsdetailView" method="GET">
		<input type="hidden" name="action" value="search">
		<input type="hidden" name="curPage" value="1">
		
			<!--hidden:사용자에게 안보이지만 관리자에게 value값을 서버로 넘기기위해  
			   name=key/ value=name에 해당하는 값으로 서버에 넘어간다-->
			<input id='keyword' type="text" name="keyword">
			<input id='b' type="submit" value="뉴스검색">
		 	<input type="reset" value="재작성">
	</form>
	
	<b>${pagination.listCnt}</b>개의 게시물이 있습니다.
			
	</div>
	<br>
	<table>
		<c:choose>
			<c:when test="${ list1 != null }" >
				<c:forEach var="data" items="${list1}" varStatus="loop">
					<table>
					<tr>
			  			<th>News</th>
  					</tr>
  					</table>
					<tr>
						<td>${ data.title }</td>
						<td>${ data.contents }</td>
						<td>${ data.date }</td>
					</tr>
					<!-- 
					<td><a href="<c:url value="/boardRead/${board.num}${pageMaker.makeSearch(pageMaker.cri.page)}" />"> ${board.title}</a></td>
					 -->
				</c:forEach>
			</c:when>
			<c:otherwise>  
			${msg}
			</c:otherwise>
		</c:choose>
	</table>
	
  	   <div>
                    <c:if test="${pagination.curRange ne 1 }">
                        <a href="#" onClick="fn_paging(1)">[처음]</a> 
                    </c:if>
                    <c:if test="${pagination.curPage ne 1}">
                        <a href="#" onClick="fn_paging('${pagination.prevPage }')">[이전]</a> 
                    </c:if>
                    <c:forEach var="pageNum" begin="${pagination.startPage }" end="${pagination.endPage }">
                        <c:choose>
                            <c:when test="${pageNum eq  pagination.curPage}">
                                <span style="font-weight: bold;"><a href="#" onClick="fn_paging('${pageNum }')">${pageNum }</a></span> 
                            </c:when>
                            <c:otherwise>
                                <a href="#" onClick="fn_paging('${pageNum }')">${pageNum }</a> 
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
                        <a href="#" onClick="fn_paging('${pagination.nextPage }')">[다음]</a> 
                    </c:if>
                    <c:if test="${pagination.curRange ne pagination.rangeCnt && pagination.rangeCnt > 0}">
                        <a href="#" onClick="fn_paging('${pagination.pageCnt }')">[끝]</a> 
                    </c:if>
                </div>
                
                <div>
                    총 게시글 수 : ${pagination.listCnt } /    총 페이지 수 : ${pagination.pageCnt } / 현재 페이지 : ${pagination.curPage } / 현재 블럭 : ${pagination.curRange } / 총 블럭 수 : ${pagination.rangeCnt }
                </div>
  	
<hr>
<h2>옵션 2 : 필터링 항목들 ↑↑↑</h2>	 
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
	
<script>
function fn_paging(pageNum){
   location.href = '/newsbigdata/NewsdetailView?action=search&curPage='+pageNum+'&keyword=';
}
</script>	
</body>
</html>