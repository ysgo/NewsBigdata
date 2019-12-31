<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
<%@ include file="signUp.jsp" %>
<%@ include file="signIn.jsp" %>
<%@ include file="newsModal.jsp" %>

<body id="page-top">
	<%@ include file="navigation.jsp" %>

	<!-- ISSUE -->
	<section class="page-section" id="issue-sec">
		<%@ include file="section1.jsp" %>
	</section>
	
	<!-- NEWS -->
	<section class="page-section" id="news-sec" style="border-top: 1px solid #e8e8e8">
		<%@ include file="section2.jsp" %>
	</section>

	<!-- KEYWORD -->
	<section class="page-section" id="keyword-sec" style="border-top: 1px solid #e8e8e8">
		<%@ include file="section3.jsp" %>
	</section>
	
	<%@ include file="common/footer.jsp" %>
	