<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp"%>
</head>
<body>
	<h1>Hello world!</h1>
	<P>The time on the server is ${serverTime}.</P>
	<div>
		<c:choose>
			<c:when test="${ !empty status }">
				<div class="sign">
					<form action="signOut.do" method="post" style='float: left;'>
						<input id="signColor" type="submit" class="nav-link p-2"
							value="로그아웃">
					</form>
					<form action="myPage.do" method="get" style='float: left;'>
						<input id="signColor" type="submit" class="nav-link p-2"
							value="마이페이지">
					</form>
				</div>
			</c:when>
			<c:otherwise>
				<div class="sign">
					<form action="signIn.do" method="get" style='float: left;'>
						<input id="signColor" type="submit" class="nav-link p-2"
							value="로그인">
					</form>
					<form action="signUp.do" method="get" style='float: left;'>
						<input id="signColor" type="submit" class="nav-link p-2"
							value="회원가입">
					</form>
						<!-- 테스트중 -->
					<form action="NewsdetailView.do" method="POST" style='float: left;'>
						<input id="signColor" type="submit" class="nav-link p-2"
							value="상세검색">
					</form>
				</div>
			</c:otherwise>
		</c:choose>
	</div>

</body>
</html>