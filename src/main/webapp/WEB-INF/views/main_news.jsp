<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
<script type="text/javascript" src="https://openapi.map.naver.com/openapi/v3/maps.js?ncpClientId=${ naverID }&submodules=geocoder"></script>
</head>
<body onload="bodyFunction()">
	<h1>Main 페이지</h1>
	<hr> 
	<div style="margin-left:5%; margin-right: 5%;">
		<div id="map" style="width: 100%; height: 400px; border: 1px solid black;"></div>
		<div id="list" style="width: 100%; height: 400px;">
			<div class="row">
				<h4>오늘의 이슈</h4>
			</div>
			<div class="row" style="border: 1px solid black;">
				<jsp:include page="newsModal.jsp" />
				<div id="issues-wrap" class="col-xs-12 col-sm-6 col-md-5">
					<c:choose>
						<c:when test="${ list1 != null }">
							<c:forEach var="data" items="${list1}" varStatus="status">
								<p>
									<span class="main_title" onclick="readNews(${status.count-1})">${ data.title }</span>
								</p>
							</c:forEach>
						</c:when>
					</c:choose>
				</div>
				<div class="col-xs-12 text-right mt-1"></div>
			</div>
			<div class="grey-text">
				<i class="fal fa-clock"></i> 날짜: <span id="issue-analysis-time" ></span>
			</div>
		</div>
	</div>
	
<script src="<c:url value='/resources/js/main_news.js' />"></script>
<script src="<c:url value='/resources/js/modal_news.js' />"></script>
<%@ include file="common/footer.jsp" %>