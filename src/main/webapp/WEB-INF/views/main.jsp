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

<title>Bigdata News</title>

<!-- Bootstrap core CSS -->
<link href="resources/vendor/bootstrap/css/bootstrap.min.css"
	rel="stylesheet">

<!-- Custom fonts for this template -->
<link href="resources/vendor/fontawesome-free/css/all.min.css"
	rel="stylesheet" type="text/css">
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css">
<link
	href="https://fonts.googleapis.com/css?family=Mansalva&display=swap"
	rel="stylesheet">
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

<script type="text/javascript"
	src="http://code.jquery.com/jquery-3.2.1.min.js"></script>
<!-- Custom styles for this template -->
<link href="resources/css/main.css" rel="stylesheet">


<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=1${naverID}"></script>
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=1${naverID}"></script>
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
			<div class="blank"></div>
			<div class="row text-center">
				<div class="col-md-8">
					<div id="map" style="width: 100%; height: 550px;">지도자리</div>
				</div>
				<div class="col-md-4">
					<div id="issue-wrap" style="width: 100%; height: 550px;">
						<div class="row">
							<ul style="width: 100%; height: 100%;" id="todayNews"></ul>
						</div>
					</div>
				</div>
			</div>
		</div>
	</section>
	
<!-- News Modal -->

<div id="modal_box" style="display:none; width:100%; height:100%; background-color:black !important; ">
	<div style="z-index:1;position: fixed; top: 20%; left: 20%;right:20%; background-color:white;">
		<div id="modal-content">
			<div class="modal_header">
				<button type="button" onClick="closeBtn()" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">×</span></button>
				<div>
					<h3 id="m_newsname">Newsname: </h3>
					<h2 id="m_title" style="font-family: 'Nanum Gothic', sans-serif;">Title :</h2>
				</div>
				<div>
					<span id="m_category">Category: </span>
					<span id="m_date">Date : </span>
				</div>
			</div>
			<div class="modal_body">
					<div>
						<img id="m_img" src="">
					</div>
					<p id="m_content">Contents :</p>
			</div>
			<div class="modal_footer">
				<footer>
					<button onclick="closeBtn()">Close</button>
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
					<h2 class="section-heading">Today's News</h2>
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
					<div style="width: 100%; height: 600px; border: 1px solid black;">카테고리</div>

				</div>
				<div class="col-md-9">

					<div id="issues-wrap"
						style="width: 100%; height: 600px; border: 1px solid black;">
						<br>


						<div id="id01">
							<span id="test"></span>
							<h2 id="news_count"></h2>
							<h2 id="title"></h2>
						</div>




						<ul class="pagination">

							<li class="disabled"><a><<</a></li>

							<li class="disabled"><a><</a></li>

							<li class="disabled active"><a>1</a></li>

							<li class="goPage" data-page="2"><a>2</a></li>

							<li class="goPage" data-page="3"><a>3</a></li>

							<li class="disabled"><a>></a></li>

							<li class="goLastPage"><a>>></a></li>

						</ul>



						<%-- <div id=paginationttt> <!-- ne!=  //  eq== -->
                  <c:if test="${pagination.curRange ne 1 }">
                        <a href="#" onClick="fn_paging(1)">[처음]</a> 
                    </c:if>
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
              
                <div>
	                    총 게시글 수 : ${data.paginationttt.listCnt } /    총 페이지 수 : ${paginationttt.pageCnt } / 현재 페이지 : ${paginationttt.curPage } / 현재 블럭 : ${paginationttt.curRange } / 총 블럭 수 : ${paginationttt.rangeCnt }
	             </div> 
               </div>
              <!-- 페이징끝 --> --%>


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
			<div class="row text-center">
				<div id="분석창" class="col-lg-12 text-center"
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
	
	var curPage2= null;
    var sendData = 
    {"action":$('#action').val(), 
    "curPage":$('#curPage').val(), 
    "keyword":$('#keyword').val()};
 	window.alert(sendData.keyword);
    $.ajax({
        type: "GET",
        url : 'main.do/NewsdetailView.do' ,
        data: sendData,
        dataType : "JSON",
        success: function(data){
        	window.alert("성공");
        	console.log(data);			    	
        	if(curPage != null){
				var count = data.listCnttt;		
				var text = "총 "+ count + "개의 기사가 검색되었습니다."
				var news_count = document.getElementById("news_count");
				news_count.innerHTML = "<b><font color='gray'>"+text+"</font></b>";
			}
			
			$('#title').empty();  //출력 객체 초기화.
			for (var i=0; i<data.listtt.length; i++){
				 var newstitle = data.listtt[i].title;
				 $('#title').append('<li>'+newstitle+'</li>');
			 }
		
			window.alert("curPage 테스트 : "+ curPage);
			
			drawPagination(curPage);
//맵 pagination 테스트Pagination [rangeSize=10, curPage=1, curRange=1, listCnt=7, pageCnt=1, rangeCnt=1, startPage=1, endPage=1, startIndex=0, prevPage=0, nextPage=2]
			
	    },
        error: function() {
            window.alert('조회 중 오류가 발생했습니다.');
        }
    });
}		      
</script>
<script>
function drawPagination(curPage){
var board = {};

board.boardList = {
        init : function(cmpnNo, lstCnt) {
            var page = 1;
            board.boardList.param.pageNumber = Number(page);
            board.boardList.param.cmpnNo = cmpnNo;
            board.boardList.pageSize;
            board.boardList.startPage;
            board.boardList.data();
        },
       }
        
$(".pagination").empty();  //페이징에 필요한 객체내부를 비워준다.

var sendData2 = 
{"action":$('#action').val(), 
"curPage":$('#curPage').val(), 
"keyword":$('#keyword').val()};

window.alert("drawPagination 테스트");
$.ajax({
    type: "GET",
    url : 'main.do/NewsdetailView.do' ,
    data: sendData2,
    dataType : "JSON",
    success: function(data){
  		board.boardList.pageSize = data.paginationttt.pageCnt;
  		board.boardList.startPage= data.paginationttt.startPage;
    	
  		$(".pagination").empty();  //페이징에 필요한 객체내부를 비워준다.
 	          // 페이지가 1페이지 가아니면
  	    	$(".pagination").append("<li class=\"goFirstPage\"><a>◀</a></li>");        //첫페이지로가는버튼 활성화
  	    
 		/*
 		else{
  	    	$(".pagination").append("<li class=\"disabled\"><a>◀</a></li>");        //첫페이지로가는버튼 비활성화
  	    }
 		*/
  	 if(data.paginationttt.curRange != 1){            //첫번째 블럭이 아니면
  	    	$(".pagination").append("<li class=\"goBackPage\"><a><</a></li>");        //뒤로가기버튼 활성화
  	    }else{
  	    	$(".pagination").append("<li class=\"disabled\"><a><</a></li>");        //뒤로가기버튼 비활성화
  	    }
  	 for(var i = data.paginationttt.startPage ; i <= data.paginationttt.endPage ; i++){        //시작페이지부터 종료페이지까지 반복문
  	    	if(data.paginationttt.curPage == i){                            
  	    		//현재페이지가 반복중인 페이지와 같다면
  	            	$(".pagination").append("<li class=\"disabled active\"><a>"+i+"</a></li>");    //버튼 비활성화
  	    	}else{
  	    		$(".pagination").append("<li class=\"goPage\" data-page=\""+i+"\"><a>"+i+"</a></li>"); //버튼 활성화
  	    	}
  	    }
  	 if(data.paginationttt.rangeCnt <  data.paginationttt.curRange){           
  		 //전체페이지블럭수가 현재블럭수보다 작을때
  	    	$(".pagination").append("<li class=\"goNextPage\"><a>></a></li>");         //다음페이지버튼 활성화
  	    }else{
  	    	$(".pagination").append("<li class=\"disabled\"><a>></a></li>");        //다음페이지버튼 비활성화
  	    }
  	if(data.paginationttt.curPage < data.paginationttt.pageCnt){                //현재페이지가 전체페이지보다 작을때
  			$(".pagination").append("<li class=\"goLastPage\"><a>▶</a></li>");    //마지막페이지로 가기 버튼 활성화
  		}else{
  			$(".pagination").append("<li class=\"disabled\"><a>▶</a></li>");        //마지막페이지로 가기 버튼 비활성화
  		}
		var lstCnt = data.paginationttt.listCnt;
		
		searchBoardListPaging(board.boardList.pageSize);
		searchBoardListPaging(board.boardList.startPage);
		
		
//맵 pagination 테스트Pagination [rangeSize=10, curPage=1, curRange=1, listCnt=7, pageCnt=1, rangeCnt=1, startPage=1, endPage=1, startIndex=0, prevPage=0, nextPage=2]

   },
    error: function() {
        window.alert('조회 중 오류가 발생했습니다.');
    }
 });
} 
</script>
<script>

//location.href = '/newsbigdata/main.do/NewsdetailView.do?action=search&curPage='+pageNum+'&keyword='; 
function searchBoardListPaging (page) {
	//마지막
	$(".goLastPage").click(function(){
		window.alert("마지막 버튼 클릭"+page);
		pageNum = page;

		window.alert("마지막페이지 +" + pageNum );
	   	$("상단 ajax를 함수로 만들어 재귀호출");
	   	
	   	searchGet(pageNum);
	    drawPagination(pageNum);
	   	
	   	
	//맨처음   	
	  	$(".goFirstPage").click(function(){
	  		window.alert("첫번째 버튼 클릭"+page);
			pageNum = page;
			window.alert("처음페이지 +" + pageNum );
		   	$("상단 ajax를 함수로 만들어 재귀호출");
		   	
		   	searchGet(pageNum);
		    drawPagination(lstCnt);
        })
	});
}


</script>


<script>		      
	 
		 //페이징을 설정하고 페이징 영역에 화면에 그리는 함수
	    //첫번째 페이지로 가기 버튼 이벤트

	        	$(".goFirstPage").click(function(){

			       	page = 1;

			       	pageFlag = 1;

			       	$("상단 ajax를 함수로 만들어 재귀호출");

			       	pageFlag = 0;

		        })
//뒷페이지로 가기 버튼 이벤트

		$(".goBackPage").click(function(){

		      	page = Number(paging.startPage) - 1;

		       	pageFlag = 1;

		       	$("상단 ajax를 함수로 만들어 재귀호출");

		       	pageFlag = 0;

	        });



	        	//클릭된 페이지로 가기 이벤트

	    		$(".goPage").click(function(){

	    			page = $(this).attr("data-page");

	    			pageFlag = 1;

	    		       	$("상단 ajax를 함수로 만들어 재귀호출");

	    		       	pageFlag = 0;

	    		});



	    //다음페이지로 가기 클릭이벤트

	    		$(".goNextPage").click(function(){

	    			page = Number(paging.endPage) + 1;

	    			pageFlag = 1;

	    		      	$("상단 ajax를 함수로 만들어 재귀호출");

	    		       	pageFlag = 0;

	    	        });

	    		
	    		$(document).ready(function(){
	    		    // test라는 클래스를가진 div를 클릭할 경우 "테스트입니다요."라는 alert가 뜬다.
	    		    $(".test").on("click", function(){  
	    		        alert("테스트입니다요.");
	    		    });    
	    		});
	    	

	    //마지막페이지로 가기 클릭이벤트

	    	        $(".goLastPage").click(function(){
						
	    	        	pageNum = data.paginationttt.pageCnt;

	    	        	pageFlag = 1;
						window.alert("마지막페이지 +" + data.paginationttt.pageCnt );
	    		       	$("상단 ajax를 함수로 만들어 재귀호출");
	    		        location.href = '/newsbigdata/main.do/NewsdetailView.do?action=search&curPage='+pageNum+'&keyword='; 
	    		      	pageFlag = 0;

	    	        });

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

