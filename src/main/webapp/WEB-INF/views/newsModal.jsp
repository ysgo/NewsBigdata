<%@ page language="java" contentType="text/html; charset=UTF-8"	pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
<script src="<c:url value='/resources/js/modal_news.js' />"></script>
</head>
<body>
	<div class="w3-container">
		<div id="id01" class="w3-modal">
			<div class="w3-modal-content">
				<header class="w3-container w3-teal">
					<span onclick="closeBtn()" class="w3-button w3-display-topright">&times;</span>
					<h3 id="m_newsname">Newsname: </h3> 
					<h2 id="m_title">Title: </h2> 
					<div>
						<span id="m_category">Category: </span>
						<span id="m_date">Date: </span>
					</div>
				</header>
				<div class="w3-container">
					<div>
						<img id="m_img" src="">
					</div>
					<span id="m_content">Contents: </span>
				</div>
				<footer class="w3-container w3-teal">
					<button class="w3-button w3-right w3-white w3-border"
						onclick="closeBtn()">Close</button>
				</footer>
			</div>
		</div>
	</div>
</body>
</html>