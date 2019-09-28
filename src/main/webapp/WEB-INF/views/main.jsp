<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c"%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="X-UA-Compatible" content="IE=edge">
<meta name="viewport"
	content="width=device-width, initial-scale=1.0, maximum-scale=1.0, minimum-scale=1.0, user-scalable=no">
<script type="text/javascript"
	src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=&submodules=geocoder"></script>
<script src="<c:url value='/resources/js/main.js' />"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>
<link rel="stylesheet" href="https://www.w3schools.com/w3css/4/w3.css">
<title>Main Page</title>
</head>
<body>

	<h1>Main 페이지</h1>
	<hr>
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
							<c:forEach var="data" items="${list1}" varStatus="status">
								<p> 
									<span class="main_title" onclick="readNews(${status.count-1})">${ data.title }</span>
									<%-- <a href="#" id="main_title" onclick="readNews()">${ data.title }</a> --%>
								</p>
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
	
    <div class="w3-container">
        <div id="id01" class="w3-modal">
          <!-- Modal with Container--> 
          <div class="w3-modal-content">
            <!-- Modal as Card-->
            <!-- <div class="w3-modal-content w3-card-4"> -->
            <header class="w3-container w3-teal"> 
              <span onclick="closeBtn()" 
              class="w3-button w3-display-topright">&times;</span>
              <h2>Title</h2>
	              <h2 id="m_title"></h2>
            </header>
            <div class="w3-container">
            <h2>Contents</h2>
              	<p id="m_contents"></p>
            </div>
            <footer class="w3-container w3-teal">
              <button class="w3-button w3-right w3-white w3-border"
            onclick="closeBtn()">Close</button>
            </footer>
          </div>
        </div>
      </div>
      <script>
      	function readNews(num) {
      		/* var val = document.getElementById("main_title").value; */
			var value = document.getElementsByClassName("main_title");
      		console.log(num); 
      		console.log(value[num]);
      		$.ajax({ 
      			url: "readNews.do?title="+value[num],
      			type: "GET",
      			success: function(data) {
		      		document.getElementById('id01').style.display='block';
      				console.log("Success");
      				console.log(data);
      				document.getElementById("m_title").innerHTML=data.readNews.title;
      				document.getElementById("m_contents").innerHTML=data.readNews.contents;
      			},
      			error: function(request, status, error) {
      				console.log("Error");
      				console.log("error code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:"+error);
      			}
      		});
      	}
      	function closeBtn() {
      		document.getElementById('id01').style.display='none';
      		reset();
      	}
      	function reset() {
      		document.getElementById("m_title").innerHTML=null;
			document.getElementById("m_contents").innerHTML=null;
      	}
      </script>
</body>
</html>