<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8">
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no">
<meta name="description" content="">
<meta name="author" content="">

<!-- jqcloud -->
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>	
<script src="resources/js/jqcloud.js" charset="utf-8"></script>
<link rel="stylesheet" type="text/css" href="resources/css/jqcd.css" />
<title>NEWS ON MAP</title>

<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Sunflower:300&display=swap" rel="stylesheet">
<link
	href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap"
	rel="stylesheet">
<link href='https://fonts.googleapis.com/css?family=Kaushan+Script'
	rel='stylesheet' type='text/css'>
<link href='https://fonts.googleapis.com/css?family=Droid+Serif:400,700'
	rel='stylesheet' type='text/css'>
<link
	href='https://fonts.googleapis.com/css?family=Roboto+Slab:400,100,300,700'
	rel='stylesheet' type='text/css'>
<link href="https://fonts.googleapis.com/css?family=Nanum+Gothic&display=swap" rel="stylesheet">
<!-- 
<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.2.1.min.js"></script> -->

<!-- Custom styles for this template -->
<link href="resources/css/main.css" rel="stylesheet">
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${naverID}"></script>
</head>
<body id="page-top">

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="#page-top"></a>
			<!--  <img src="resources/img/로고.png">로고</a> -->
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
					<li class="nav-item" id="nav_signup" style="display: block"><a
						class="nav-link js-scroll-trigger" onclick="signup()">SignUp</a></li>
					<li class="nav-item" id="nav_login" style="display: block"><a
						class="nav-link js-scroll-trigger" onclick="openLogin()">Login</a></li>
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
				<div class="intro-heading" style="color: black; font-weight:550;">NEWS ON MAP</div>
			</div>
		</div>
	</header>

	<!-- ISSUE -->
	<section class="page-section" id="issue-sec">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading">Today's Issue</h2>
					<h5>
						<i class="far fa-clock"></i> <span id="issue-analysis-time"></span>
					</h5>
				</div>
			</div>
			<div class="row text-center">
				<div class="col-md-8">
					<div id="map" style="width: 100%; height: 550px;">지도자리</div>
				</div>
				<div class="col-md-4">
					<div id="issue-wrap" style="width: 100%; height: 550px;">
						<div>
							<button onclick="todayNews(1)">Reset 아이콘</button>
							<span id="zoneName"></span>
						</div>
						<div class="row">
							<ul style="width: 100%; height: 100%;" id="todayNews"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


<!-- Modal -->
<!-- Signup Modal -->
	<div id="signup" class="modal printable"
		style="display: none;">
		<div
			style="z-index: 1; position: fixed; top: 10%; left: 20%; right: 20%; background-color: white;">
			<div id="modal-signup">
				<button type="button" onclick="closeSignup()" class="close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<div class = "signup-form">
					<form class="form" method="POST" action=""
						onsubmit='return check()'>
						<h2>SIGN UP</h2>
						<hr>
						<div>
							<div class="form-group">
								이름
								<input type="text" name="userName" id="userName"
									class="form-control input-lg" placeholder="이름을 입력하세요."
									tabindex="3"> <span id="alert_userName"></span>
							</div>

							<div class="form-group">
								이메일
								<input type="email" name="email" id="email"
									class="form-control input-lg" placeholder="이메일을 입력하세요."
									tabindex="4"> <span id="alert_email"></span>
							</div>

							<div class="form-group">
								비밀번호
								<input onkeyup='mykeyup()' type="password" name="password"
									id="password" class="form-control input-lg"
									placeholder="비밀번호를 입력하세요." tabindex="5"> <span
									id="alert_password"></span>
							</div>

							<div class="form-group">
								비밀번호 확인
								<input onkeyup='mykeyup()' type="password" name="re_password"
									id="password_confirmation" class="form-control input-lg"
									placeholder="비밀번호를 한 번 더 입력하세요." tabindex="6"> <span
									id="alert_re_password"></span>
							</div>
						</div>
						남성 <input type="radio" name="gender" value="male" class="gender" />
						여성 <input type="radio" name="gender" value="female" class="gender" />
						<br>
						<span id="alert_gender"></span><br> GENERATION : 10대 <input
							type="radio" name="generation" value="10" class="generation" />
						20대 <input type="radio" name="generation" value="20"
							class="generation" /> 30대 <input type="radio"
							name="generation" value="30" class="generation" /> 40대 <input
							type="radio" name="generation" value="40" class="generation" />
						50대 이상 <input type="radio" name="generation" value="50"
							class="generation" /> <span id="alert_generation"></span><br>
						<div style="height:30px;"></div>
						<div>
							<div style= "width: 100%; text-align: center;">
								<input type="submit" value="회원가입" id="register-btn"><br>
								이미 회원이신가요? <a href="signIn.do" id="su-login-btn">로그인</a>
							</div>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>


<!-- Login modal -->
<div id="login" class="modal printable" style="display: none;">
		<div style="z-index: 1; position: fixed; top: 15%; left: 30%; right: 30%; background-color: white;">
			<div id="modal-login">
				<button type="button" onclick="closeLogin()" class="close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<div class="login-form">
					<form class="form" action="signIn.do" method="POST">
						<h2>Login</h2>
						<hr>
						<div class="form-group">
							<input type="email" name="email" id="email"
								class="form-control input-lg" placeholder="이메일">
						</div>
						<div class="form-group">
							<input type="password" name="password" id="password"
								class="form-control input-lg" placeholder="비밀번호">
						</div>
						<div style="width: 100%; text-align: center;">
							<input type="submit" value="로그인" id="login-btn"><br>
							아직 회원이 아니신가요? <a href="">회원가입</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>

<!-- News Modal -->
<div id="modal_box" class="modal printable" style="display: none;">
	<div style="z-index:1;position: fixed; top: 10%; left: 15%;right:15%; bottom:10%; background-color:white;">
		<div id="modal-content">
			<div class="modal_header">
				<button type="button" onClick="closeBtn()" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
				<div>
					<h3 id="m_newsname" style="font-family: 'Sunflower', sans-serif;"></h3>
					<h3 id="m_title" style="font-family: 'Nanum Gothic', sans-serif;"></h3>
				</div>
				<div>
					<span id="m_category"></span>
					<span id="m_date"></span>
				</div>
			</div>
			<div class="modal_body">
					<div>
						<img id="m_img" src="">
					</div>
					<p id="m_content"></p>
			</div>
			<div class="modal_footer">
				<footer>
					<button id="closeModal">Close</button>
				</footer>
			</div>
		</div>
	</div>
</div>

	<!-- NEWS -->

	<section class="page-section" id="news-sec"
		style="border-top: 1px solid #e8e8e8">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading"><i class="far fa-newspaper"></i> &nbsp;Today's News &nbsp;<i class="far fa-newspaper"></i></h2>
					<div class="blank"></div>

					<!-- action="/newsbigdata/main.do/NewsdetailView.do" -->
					<form id="SearchForm" name="SearchForm" method="GET">
						<input id="action" type="hidden" name="action" value="search">
						<input id="curPage" type="hidden" name="curPage" value="1">
						<input type="text" id="keyword" name="keyword"
							style="border: 0; outline: 0; border-bottom: 1px solid #bfbfbf; width: 60%; height: 30px;"
							type="text" placeholder="검색어를 입력하세요.">

						<button
							style="width: 17%; height: 30px; border: 0; outline: 0; background-color: #799ab8; color: white;"
							onclick="searchType('GET');return false; ">조회 GET</button>
					</form>
				</div>
			</div>

			<div class="blank"></div>

			<div class="row text-center">
				<div class="col-md-3">
					<div style="width: 100%; height: 750px; border: 1px solid black;">카테고리
					
					<input type="checkbox" class="check" value="KBS">KBS	
					<input type="checkbox" class="check" value="YTN">YTN	
					<input type="checkbox" class="check" value="MBC">MBC

					<br><br>
					<input type="checkbox" class="check" value="매일경제">매일경제
					<input type="checkbox" class="check" value="한국경제">한국경제
					<input type="checkbox" class="check" value="서울경제">서울경제
					
					<br><br>
					<input type="checkbox" class="check" value="동아일보">동아일보
					<input type="checkbox" class="check" value="문화일보">문화일보
					<input type="checkbox" class="check" value="국민일보">국민일보	
					
					<br><br>
					<input type="checkbox" class="check" value="세계일보">세계일보
					<input type="checkbox" class="check" value="중앙일보">중앙일보
					<input type="checkbox" class="check" value="충북일보">충북일보
					
					<br><br>
					<input type="checkbox" class="check" value="경향신문">경향신문
					<input type="checkbox" class="check" value="내일신문">내일신문
					<input type="checkbox" class="check" value="서울신문">서울신문

					
					</div>
			</div>
				<div class="col-md-9">

					<div id="issues-wrap"
						style="width: 100%; height: 750px; border: 1px solid black;">
						<br>
						<div id="id01">
							<span id="test"></span>
							<h2 id="news_count"></h2>
							</div>
												
						<div id=tb>
				
						</div>

						
					<ul style="align-items: center;" class="pagination">

							<li class="disabled"><a></a></li>

							<li class="disabled"><a></a></li>

							<li class="disabled active"><a></a></li>

							<li class="goPage" data-page="2"><a></a></li>

							<li class="goPage" data-page="3"><a></a></li>

							<li class="disabled"><a></a></li>

							<li class="goLastPage"><a></a></li>

						</ul>


					</div>
				</div>
			</div>
		</div>
	</section>

	<!-- KEYWORD -->
	<section class="page-section" id="keyword-sec"
		style="border-top: 1px solid #e8e8e8">
		<div  class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading"><i class="fas fa-chart-bar"></i>&nbsp; Today's Keyword &nbsp;<i class="fas fa-chart-bar"></i></h2>
				</div>
			</div>
			<div class="blank"></div>
			<div class="row text-center col-lg-12">
				<div class="col-md-3">
					<div style="width: 100%; height: 600px; border: 1px solid black;">
						<input type="button" class="ctg_btn" id="all" value="전체" /> 
						<input type="button" class="ctg_btn" value="정치" /> 
						<input type="button" class="ctg_btn" value="경제" /> 
						<input type="button" class="ctg_btn" value="사회" /> 
						<input type="button" class="ctg_btn" value="지역" />
						<input type="button" class="up_btn" value="키워드 검색결과로 이동" />
					</div>
				</div>
				<div id="wordcloud" class="col-md-9">
					<div style=" height:100%; align: center; margin: auto; border: 1px solid black"></div>
				</div>
			</div>
		</div>
	</section>

	<!-- Footer -->
	<footer class="footer">
		<div class="container">
			<span class="copyright">Copyright &copy; newsONmap 2019</span>
		</div>
	</footer>

	<!-- Bootstrap core JavaScript -->
	<!-- <script src="resources/vendor/jquery/jquery.min.js"></script> -->
	
	<!-- Bootstrap core JavaScript -->
	<script src="resources/vendor/bootstrap/js/bootstrap.bundle.min.js"></script>
	<script src="resources/vendor/jquery-easing/jquery.easing.min.js"></script>
	<script src="resources/js/agency.min.js"></script>

	<!-- javascript&ajax function -->
<script src="<c:url value='/resources/js/main_news.js'/>"> </script>
<script src="<c:url value='/resources/js/modal_news.js'/>"> </script>
<!-- 필터와 키워드검색 통합중 -->
<script src="<c:url value='/resources/js/newsDetail_Keyword.js'/>"> </script>
<script src="<c:url value='/resources/js/newsDetailPaging.js'/>"> </script>
<script src="<c:url value='/resources/js/signUp.js' />"></script>
<script type="text/javascript" src="resources/js/jqcdajax.js" charset="utf-8"></script>
</body>
</html>

