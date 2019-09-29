<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="header.jsp" %>
<body>
	<div class="w3-container">
		<div id="id01" class="w3-modal">
			<!-- Modal with Container-->
			<div class="w3-modal-content">
				<!-- Modal as Card-->
				<!-- <div class="w3-modal-content w3-card-4"> -->
				<header class="w3-container w3-teal">
					<span onclick="closeBtn()" class="w3-button w3-display-topright">&times;</span>
					<h2 id="m_title">Title :</h2>
					<span id="m_date">Date : </span>
				</header>
				<div class="w3-container">
					<p id="m_contents">Contents :</p>
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