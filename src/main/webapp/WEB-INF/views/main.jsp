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
<title>Main Page</title>
</head>
<body>
	<h1>Main 페이지</h1>
	<hr>
	<div >
		<div id="map" style="width: 55%; height: 400px; border:1px solid black;"></div>
		<div id="list" style="width: 100%; height: 400px;">
			<div class="row">
				<h4>오늘의 이슈</h4>
			</div>
			<div class="row" style="border:1px solid black;">
				<div id="issues-wrap" class="col-xs-12 col-sm-6 col-md-5">
				<c:choose>
					<c:when test="${ list1 != null }">  
							<c:forEach var="data"  items="${list1}">
					 		<ul>
						 		<li>${ data.title }</li>
					 		</ul>		
							</c:forEach>
					</c:when>
				</c:choose> 
				</div>
				<div class="col-xs-12 text-right mt-1">
				</div>
			</div>
					<div class="grey-text">
						<i class="fal fa-clock"></i> 날짜: <span id="issue-analysis-time">2019.09.25(수)
							14:00</span> 
					</div>
		</div>

	</div>
</body>
</html>