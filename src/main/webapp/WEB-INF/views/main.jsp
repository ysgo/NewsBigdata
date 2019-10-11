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
						style="width: 100%; height: 550px; border: 1px solid black;">리스트자리</div>
				</div>
			</div>
		</div>
	</section>

	<!-- NEWS 검색 -->
	<section class="page-section" id="news-sec"
		style="border-top: 1px solid #e8e8e8">
		<div class="container">
			<div class="row">
				<div class="col-lg-12 text-center">
					<h2 class="section-heading">Today's News</h2>
					<div class="blank"></div>
					
					<!-- action="/newsbigdata/main.do/NewsdetailView.do" -->
					<form id="SearchForm" name="SearchForm" method="GET">
						<input id="action" type="hidden" name="action" value="search">
						<input id="curPage" type="hidden" name="curPage" value="1">
						<input type="text" id="keyword" name="keyword"
							style="border: 0; outline: 0; border-bottom: 1px solid #bfbfbf; width: 60%; height: 30px;"
							type="text" placeholder="검색어를 입력하세요."> 
								
						<button style="width: 17%; height: 30px; border: 0; outline: 0; background-color: #799ab8; color: white;" 
						onclick="searchType('GET');return false; ">조회 GET</button>
					</form>
				</div>
			</div>

			<div class="blank"></div>

			<div class="row text-center">
				<div class="col-md-3">
					<div 
						style="width: 100%; height:	600px; border: 1px solid black;">카테고리</div>
					
					</div>
				<div class="col-md-9">
				
					<div id="issues-wrap"
						style="width: 100%; height: 600px; border: 1px solid black;">
						<br>
						
						
			<div id="id01">
					<span id="test"></span>
					<h2 id="news_count"> </h2> 
					<h2 id="title" ></h2>
			</div>
						
						<!-- <b>${pagination.listCnt}</b>개의 게시물이 있습니다.  -->
 						<br><br><br>
						
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
					<br>
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
  	
						</div>
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


<script>
function fn_paging(pageNum){
	//http://localhost:8000/newsbigdata/main.do/NewsdetailView.do?action=search&curPage=1&keyword=
	
	window.alert("fn_paging 눌림  : "+pageNum);
   location.href = '/newsbigdata/main.do/NewsdetailView.do?action=search&curPage='+pageNum+'&keyword=';
   
}
</script>
<script>
var firstGrid = null;
function searchGet(curPage) {
	window.alert("3-searchGet들어옴 "+curPage);
    var sendData = 
    {"action":$('#action').val(), 
    "curPage":$('#curPage').val(), 
    "keyword":$('#keyword').val()};
 
    $.ajax({
        type: "GET",
        url : 'main.do/NewsdetailView.do' ,
        data: sendData,
        dataType : "JSON",
        success: function(data){
        	window.alert("성공");
        	console.log(data);			
	//		window.alert("길이"+data.listtt.length);
			if(curPage != null){
				var count = data.listCnttt;		
				var text = "총 "+ count + "개의 기사가 검색되었습니다."
				var news_count = document.getElementById("news_count");
				news_count.innerHTML = "<b><font color='gray'>"+text+"</font></b>";
			}
		
			for (var i=0; i<data.listtt.length; i++){
				 var newstitle = data.listtt[i].title;
				 $('#title').append('<li>'+newstitle+'</li>');
			 }
			
			window.alert("페이징 prevpage= "+data.paginationttt.prevPage);
			window.alert("페이징 startPage= "+data.paginationttt.startPage);
			window.alert("페이징 endPage= "+data.paginationttt.endPage);
			window.alert("페이징 nextPage= "+data.paginationttt.nextPage);
			window.alert("페이징 pageCnt= "+data.paginationttt.pageCnt);
			window.alert("페이징 rangeSize= "+data.paginationttt.rangeSize);
			
			
			
			
	    },
        error: function() {
            window.alert("실패");
        }
    });
}

function searchType(method) {
	window.alert("1-걸림 "+method);
	$('#SearchForm').attr("method", method)
	//console.log($('#keyword').attr("method"));
	search(1)
}

function search(curPage) {
	window.alert("2-여기걸림 "+curPage);
	if($('#SearchForm').attr("method") == "POST") {
		searchPost(curPage);
	} else {
		searchGet(curPage);
	}
}
</script>
<script>
		$(document).ready(function(){
			$("#userId").blur(function(){
				var mid = $("#userId").val();
				$.ajax({
					url : '/festival/validateForm?mid=' + mid,
					type : 'get',
					success : function(data){
						if (data == 1){ // id 중복됨
							$('#idError').text("이미 사용중인 아이디입니다. =ㅅ=").css("color", "red");
							$("#submit").attr("disabled", true);
						}
						else {
							$('#idError').text("사용 가능한 아이디입니다. :) ").css("color", "blue");
							$("#submit").attr("disabled", false);					
						}
					},					
					error : function(){ console.log("실패"); }
				});
			});
		})
	</script>
</body>
</html>

