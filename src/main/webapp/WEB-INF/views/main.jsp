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
 /* The Modal (background) */
 .modal {
            display: none; /* Hidden by default */
            position: fixed; /* Stay in place */
            z-index: 1; /* Sit on top */
            left: 0;
            top: 0;
            width: 100%; /* Full width */
            height: 100%; /* Full height */
            overflow: auto; /* Enable scroll if needed */
            background-color: rgb(0,0,0); /* Fallback color */
            background-color: rgba(0,0,0,0.4); /* Black w/ opacity */
        }
    
        /* Modal Content/Box */
        .modal-content {
            background-color: #fefefe;
            margin: 15% auto; /* 15% from the top and centered */
            padding: 20px;
            border: 1px solid #888;
            width: 50%; /* Could be more or less, depending on screen size */                          
        }
        /* The Close Button */
        .close {
            color: #aaa;
            float: right;
            font-size: 28px;
            font-weight: bold;
        }
        .close:hover,
        .close:focus {
            color: black;
            text-decoration: none;
            cursor: pointer;
        }
#myBtn {
    -webkit-tap-highlight-color: rgba(0,0,0,0);
    line-height: 1.428571429;
    font-family: "Noto Sans KR",sans-serif;
    word-break: keep-all;
    white-space: nowrap;
    box-sizing: border-box;
    background-color: transparent;
    text-decoration: none;
    font-size: 16px;
    color: #424242;
    letter-spacing: -0.05em;
}
#myBtn:hover {
    color: black;
    font-weight: bold;
}
</style>
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
							<c:forEach var="data" items="${list1}">
								<p>
									<a href="#" id="myBtn" >${ data.title }</a>
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
	
	
    <!-- Trigger/Open The Modal -->
<!--     <button id="myBtn">Open Modal</button>
    <ul> 
        <li><p><a href="#" id="myBtn1">글1</a></p></li>
    </ul> -->
    <!-- The Modal -->
    <div id="myModal" class="modal fade" role="dialog">
        <div class="modal-dialog">
            <!-- Modal content -->
            <div class="modal-content">
                <div class="modal-header">
                    <!-- <span class="close">&times;</span>                                                               
                    <p>Some text in the Modal..</p> -->
                    <button type="button" class="close" data-dismiss="modal">x</button>
                    <h4 class="modal-title">Modal Header</h4>
                </div>
              <div class="modal-body">
                    <p>Some text in the modal.</p>
                  <div class="news-detail__content">
                      <div class="text-center news-detail__image mt-2 mb-2">
                      <c:if test="${!empty readNews }">
                      	<h3>Title : ${ readNews.title }</h3>
                      	<hr>
                      	<p>Date : ${ readNews.date }</p>
                      	<p>Contents : ${ readNews.contents }</p>
                      </c:if>
                      </div> 
                  </div>
              </div>
              <div class="modal-footer">
                  <button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
              </div>
        </div>
    </div>
</div>


<script>
function readNews(e) {
	console.log(e);
	$.ajax({
		url: "readNews.do",
		type: "GET",
		data: {title: e},
		dataType: "text",
		success: function(data) {
			$('body').html(data);
			console.log(data);
		    modal.style.display = "block";
		},
		error: function(request, status, error) {
			console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:");
		}
	})    
}
// Get the modal
var modal = document.getElementById('myModal');
 
 // Get the button that opens the modal
 var btn = document.getElementById("myBtn");
 // Get the <span> element that closes the modal
 var span = document.getElementsByClassName("close")[0];                                          
 
 // When the user clicks on the button, open the modal 
 btn.onclick = function() {
	 var value = btn.text;
	 console.log(value);
	 $.ajax({
			url: "readNews.do?title="+value,
			type: "GET",
			success: function(data) {
				$('body').html(data);
				console.log(data);
			    modal.style.display = "block";
			},
			error: function(request, status, error) {
				console.log("code:"+request.status+"\n"+"message:"+request.responseText+"\n"+"error:");
			}
		})    
	
 } 
 // When the user clicks on <span> (x), close the modal
 span.onclick = function() {
     modal.style.display = "none";
 }

 // When the user clicks anywhere outside of the modal, close it
 window.onclick = function(event) {
     if (event.target == modal) {
         modal.style.display = "none";
     }
 }

</script>
</body>
</html>