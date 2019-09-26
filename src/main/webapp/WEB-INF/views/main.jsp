<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<%@ taglib uri="http://www.springframework.org/tags" prefix="spring"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=&submodules=geocoder"></script>
<%-- <script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId='<spring:eval expression="@location['naver.ID']"></spring:eval>'"></script> --%>
<script src="<c:url value='/resources/js/main.js' />"></script>
<link href="/resources/jqueryui/jquery-ui.css" rel="stylesheet">
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.js"></script>
<link rel="stylesheet" href="https://cdnjs.cloudflare.com/ajax/libs/jquery-modal/0.9.1/jquery.modal.min.css" />
<title>Main Page</title>
<style>
button {
 all: unset;
 background-color: steelblue;
 color:white;
 padding: 5px 20px;
 border-radius: 5px;
 cursor: pointer;
}
.modal {
 box-shadow: 0 10px 20px rgba(0,0,0,0.19), 0 6px 6px rgba(0,0,0,0.23);
 position: absolute;
 top: 0;
 left: 0;
 width: 100%;
 height: 100%;
 display: flex;
 justify-content: center;
 align-items: center;
}
.modal_overlay {
	background-color: rgba(0, 0, 0, 0.6);
	width: 100%;
	height: 100%;
	position: absolute;
}
.modal_content {
	background-color: white;
	padding: 50px 100px;
	text-align: center;
	position: relative;
	border-radius: 5px;
	width: 20%;
	box-shadow: 0 10px 20px rgba(0, 0, 0, 0.19), 0 6px, 6px rgba(0, 0, 0, 0.23);
}
h1 {
	margin:0;
}
.hidden {
	display:none;
}
</style>
</head>
<body>
	<h1>Main 페이지</h1>
	<hr>
	
<!-- <button id="open">Open Modal</button> 
<div class="modal hidden">
	<div class="modal_overlay"></div>
	<div class="modal_content">
		<h1>I'm a modal</h1>
		<button>X</button>
	</div>
</div>
<div id="ex1" class="modal">
  <p>안녕하세요. 모달창안의 내용부분입니다.</p>
  <a href="#" rel="modal:close">닫기</a>
</div>
 
<p><a href="#ex1" rel="modal:open">모달창띄우기</a></p> -->


	<div>
		<div id="map"
			style="width: 55%; height: 400px; border: 1px solid black;"></div>
		<div id="list" style="width: 100%; height: 400px;">
			<div class="row">
				<h4>오늘의 이슈</h4>
			</div>
			<div class="row" style="border: 1px solid black;">
				<div id="issues-wrap" class="col-xs-12 col-sm-6 col-md-5">
					<c:choose>
						<c:when test="${ list1 != null }">
							<c:forEach var="data" items="${list1}">
								<ul> 
									<li><p><a href="#" id="open">${ data.title }</a></p></li>
								</ul>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
				<div class="col-xs-12 text-right mt-1"></div>
			</div>
			<div class="grey-text">
				<i class="fal fa-clock"></i> 날짜: <span id="issue-analysis-time">2019.09.25(수)
					14:00</span>
			</div>
		</div>
	</div>
<!-- <script>
	var openButton = document.getElementById("open");
	var modal = document.querySelector(".modal");
	var overlay = modal.querySelector(".modal_overlay");
	var closeBtn = modal.querySelector("button");
	function openModal() {
		modal.classList.remove("hidden");
	}
	function closeModal() {
		modal.classList.add("hidden");
	}
	overlay.addEventListener("click", closeModal);
	closeBtn.addEventListener("click", closeModal);
	openButton.addEventListener("click", openModal);
</script> -->
</body>
</html>