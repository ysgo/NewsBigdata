<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ include file="common/header.jsp" %>
<%@ include file="signUp.jsp" %>
</head>
<body id="page-top">

	<!-- Navigation -->
	<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="#page-top"><img
				src="resources/img/logo1.png" style="width: 200px; height: 65px;"></a>

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
							<li class="nav-item" id="nav_myPage" style="display: block">
							<a class="nav-link js-scroll-trigger" onclick="openMypage()">MyPage</a></li>
							<li class="nav-item" id="nav_logout" style="display: block">
							<a class="nav-link js-scroll-trigger" onclick="signOut()">Logout</a></li>
							<li class="nav-item" id="nav_user" style="display: block; position: relative;">
							<a id="user" class="nav-link js-scroll-trigger" style="display: block;"></a>
							<li class="nav-item" id="nav_signup" style="display: block">
							<a class="nav-link js-scroll-trigger" onclick="signup()">SignUp</a></li>
							<li class="nav-item" id="nav_login" style="display: block">
							<a class="nav-link js-scroll-trigger" onclick="openLogin()">Login</a></li>
				</ul>
			</div>
		</div>
	</nav>

	<!-- Header -->
	<header class="masthead">
		<div class="container">
			<div class="intro-text">
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

			<div class="row">
				<div class="col-md-8" style="text-align:right; padding-right:30px;">
					<h5>
						<i class="far fa-clock"></i> <span id="issue-analysis-time"></span>&nbsp;&nbsp;&nbsp;
					</h5>
				</div>

				<div class="col-md-4">
					<h5>
						<button onclick="todayNews(1)" id="refresh">
							<i class="fas fa-sync-alt"></i>
						</button>
						<span id="zoneName"></span>
					</h5>
				</div>
			</div>
			<div style="height:10px"></div>
			<div class="row text-center">
				<div class="col-md-8">
					<div id="map" style="width: 100%; height: 550px;">지도자리</div>
				</div>
				<div class="col-md-4">
					<div id="issue-wrap" style="width: 100%; height: 550px;">
						<div class="row">
							<ul style="width: 100%; height: 100%; margin: 0px; padding:0px 0px 0px 15px !important" id="todayNews"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>


<!-- News Modal -->
<div id="modal_box" class="modal printable" style="display: none;">
	<div style="z-index:1;position: fixed; top: 10%; left: 15%;right:15%; bottom:10%; background-color:white;">
		<div id="modal-content" style="height:100%">
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
					<div style="text-align:center;">
						<img class="img-responsive" id="m_img" src="">
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
					<h2 class="section-heading" style="padding-top:0px;"><i class="far fa-newspaper"></i> &nbsp;Today's News &nbsp;<i class="far fa-newspaper"></i></h2>
					<div class="blank"></div>

					<!-- action="/newsbigdata/main.do/NewsdetailView.do" -->
					<form id="SearchForm" name="SearchForm" method="GET">
						<input id="action" type="hidden" name="action" value="search">
						<input id="curPage" type="hidden" name="curPage" value="1">
						<input type="text" id="keyword" name="keyword"
							style="border: 0; outline: 0; border-bottom: 1px solid #bfbfbf; width: 60%; height: 40px; font-size:18px"
							type="text" placeholder="검색어를 입력하세요.">

						<button
							style="width: 17%; height: 40px; border: 0; outline: 0; background-color: #799ab8; color: white;"
							onclick="searchType('GET');return false; ">검색</button>
					</form>
				</div>
			</div>

			<div class="row text-center">
				<div class="col-md-2" style="min-height:800px">
					<div style="padding-top: 70px; height: 100%">
						
						<div id="ctg-list">
						<div style="padding-top:20px; padding-bottom:15px; border-bottom:1px solid #c2c3c4">
							<h4>언론사</h4>
						</div>
							<span id="multiPrint"></span><br/>
							<div class="cb">KBS&nbsp;<input type="checkbox" class="check" value="KBS"><br></div>
							<div class="cb">YTN&nbsp;<input type="checkbox" class="check" value="YTN"><br></div>
							<div class="cb">서울경제&nbsp;<input type="checkbox" class="check" value="서울경제"><br></div>
							<div class="cb">매일경제&nbsp;<input type="checkbox" class="check" value="매일경제"><br></div>
							<div class="cb">중앙일보&nbsp;<input type="checkbox" class="check" value="중앙일보"><br></div>
							<div class="cb">내일신문&nbsp;<input type="checkbox" class="check" value="내일신문"><br></div>
							<div class="cb">동아일보&nbsp;<input type="checkbox" class="check" value="동아일보"><br></div>
							<div class="cb">문화일보&nbsp;<input type="checkbox" class="check" value="문화일보"><br></div>
							<div class="cb">국민일보&nbsp;<input type="checkbox" class="check" value="국민일보"><br></div>
							<div class="cb">조선일보&nbsp;<input type="checkbox" class="check" value="조선일보"><br></div>
							<div class="cb">머니투데이&nbsp;<input type="checkbox" class="check" value="머니투데이"><br></div>
							<div class="cb">파이낸셜뉴스&nbsp;<input type="checkbox" class="check" value="파이낸셜뉴스"><br></div>
							<div class="cb">디지털타임스&nbsp;<input type="checkbox" class="check" value="디지털타임스"><br></div>
						</div>
					</div>
				</div>
				<div class="col-md-10" >

					<div id="issues-wrap" style="width: 100%;">
						<br>
						<div id="id01">
							<span id="test"></span>
							<h2 id="news_count" style="padding-bottom: 15px;"></h2>
						</div>

						<div id=tb class="newsList" style="min-height:800px"></div>
						<div class="blank"></div>
						<ul style="align-items: center;" class="pagination">
							<li class="disabled"><a>&lt;&lt;</a></li>
							<li class="disabled"><a>&lt;</a></li>
							<li class="disabled active"><a>1</a></li>
							<li class="goPage" data-page="2"><a>2</a></li>
							<li class="goPage" data-page="3"><a>3</a></li>
							<li class="disabled"><a>></a></li>
							<li class="goLastPage"><a>>></a></li>
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
					<div style="width: 100%;">
						<input type="button" class="ctg_btn" id="all" value="전체" /> 
						<input type="button" class="ctg_btn" value="정치" /> 
						<input type="button" class="ctg_btn" value="경제" /> 
						<input type="button" class="ctg_btn" value="사회" /> 
						<input type="button" class="ctg_btn" value="지역" />
					</div>
			</div>
			<div id="wordcloud"> 
				<div style="width:850px; height:450px; margin:auto;">
				</div>
			</div>
			</div>
	</section>
<%@ include file="common/footer.jsp" %>
