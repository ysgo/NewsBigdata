<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>

<style>
.wrap {
	margin: auto;
	align: center;
	width: 1000px;
	padding: 30px;
	background: #e1eef7;
	height: 400px;
}

.box {
	float: left;
	margin-right: 50%;
	margin-bottom: 10px;
}

.right {
	text-align: right;
	float: right;
	margin-right: 0;
	margin-left: 50%;
}
</style>

<head>


<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<title>Bigdata News</title>

<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Mansalva&display=swap" rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Kaushan+Script'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700'
	rel='stylesheet' type='text/css'>
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<!-- Custom styles for this template -->
<link href="resources/css/main.css" rel="stylesheet">


<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=1${naverID}"></script>
</head>

<body id="page-top">

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="#page-top"><img
				src="resources/img/로고.png">로고</a>
			<button class="navbar-toggler navbar-toggler-right" type="button"
				data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav text-uppercase ml-auto">
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#issue-sec">ISSUE</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#news-sec">NEWS</a></li>
					<li class="nav-item"><a class="nav-link js-scroll-trigger"
						href="#keyword-sec">KEYWORD</a></li>
					<li class="nav-item" id="tmp_signup" style="display: block"><a
						class="nav-link js-scroll-trigger" href="#회원가입">SignUp</a></li>
					<li class="nav-item" id="tmp_login" style="display: block"><a
						class="nav-link js-scroll-trigger" href="#로그인">Login</a></li>
					<li class="nav-item" id="user"
						style="display: block; position: relative;"><a id="dropdown"
						class="nav-link js-scroll-trigger" style="display: block;">${sessionScope.nickname}</a>
						<div class="dropdown-content"
							style="display: none; color: #95b3d7 !important; width: 140px; padding: 10px 15px 0 15px; height: 75px; position: absolute; top: 50px; left: 0; background: #fff; opacity: 0.7">
							<a class="dcontent" href="mypage"
								style="padding: 0; color: #000 !important; text-decoration: none;">마이페이지</a><br>
							<a class="dcontent" href="logout"
								style="padding: 0; color: #000 !important; text-decoration: none;">로그아웃</a>
						</div> <script>
							$("#dropdown").mouseover(function() {

								$(".dropdown-content").css("display", "block");
							});

							$(".dropdown-content").mouseleave(function() {
								$(this).css("display", "none");
							});

							$("a.dcontent").mouseover(function() {
								$(this).css("color", "#95b3d7");
							});
							$("a.dcontent").mouseleave(function() {
								$(this).css("color", "#000");
							});
						</script></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Header -->
	<header class="masthead">
		<div class="container">
			<div class="intro-text">
				<div class="intro-heading" style="color: black;">슬로건 적기 / 수정사항</div>
				<a class="btn btn-primary btn-xl text-uppercase js-scroll-trigger"
					href="#회원가입" id="sbutton">시작 하기</a>

			</div>
		</div>
	</header>

	<!-- ISSUE -->
	<section class="page-section" id="issue-sec">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading">Today's Issue</h2>
				</div>
			</div>
			<div class="blank"></div>
			<div class="row text-center">
				<div class="col-md-8">
					<div id="map"
						style="width: 100%; height: 550px; border: 1px solid black;">지도자리</div>
				</div>
				<div class="col-md-4">
					<div id="issues-wrap"
						style="width: 100%; height: 550px; border: 1px solid black;">
							<h4>오늘의 이슈</h4>
							<jsp:include page="newsModal.jsp" />
							<div>
								<ul style="width:100%;"id="todayNews"></ul>
								<i class="fal fa-clock"></i> 날짜: <span id="issue-analysis-time"></span>
							</div>
					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- NEWS -->

	<section class="page-section" id="news-sec"
		style="border-top: 1px solid #e8e8e8">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading">Today's News</h2>
					<div class="blank"></div>
					<form 검색창>
						<input type="text" id="textMessage"
							style="border: 0; outline: 0; border-bottom: 1px solid #bfbfbf; width: 60%; height: 30px;"
							type="text" placeholder="검색어를 입력하세요."> <input
							style="width: 17%; height: 30px; border: 0; outline: 0; background-color: #799ab8; color: white;"
							onclick="sendMessage()" value="Search" type="button">
					</form>
				</div>


			</div>

			<div class="blank"></div>

			<div class="row text-center">
				<div class="col-md-3">
					<div id="map"
						style="width: 100%; height: 400px; border: 1px solid black;">카테고리</div>
				</div>
				<div class="col-md-9">
					<div id="issues-wrap"
						style="width: 100%; height: 400px; border: 1px solid black;">리스트자리</div>
				</div>
			</div>
		</div>

	</section>

	<!-- KEYWORD -->
	<section class="page-section" id="keyword-sec"
		style="border-top: 1px solid #e8e8e8">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading">Today's Keyword</h2>
				</div>
			</div>		
			<div class="blank"></div>
			<div class = "row text-center">
				<div id="분석창" class ="col-lg-12 text-center" 
				style="width: 1000px; height: 400px; align: center; margin: auto; border: 1px solid black">
				분석창 넣기</div>
				
			</div>		
		</div>
	</section>

	<!-- Footer -->
	<footer class="footer">
		<div class="container">
			<span class="copyright">Copyright &copy; Bigdata News 2019</span>
		</div>
	</footer>



	<!-- Bootstrap core JavaScript -->
	<script src="resources/vendor/jquery/jquery.min.js"></script>
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="resources/js/agency.min.js"></script>
	<!-- javascript&ajax function -->
	<script src="<c:url value='/resources/js/main_news.js' />"></script>
<script src="<c:url value='/resources/js/modal_news.js' />"></script>
</body>

</html>

