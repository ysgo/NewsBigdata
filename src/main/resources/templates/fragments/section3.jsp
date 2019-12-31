<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<div class="container">
	<div class="row">
		<div class="col-lg-12 text-center">
			<h2 class="section-heading">
				<i class="fas fa-chart-bar"></i>&nbsp; Today's Keyword &nbsp;<i
					class="fas fa-chart-bar"></i>
			</h2>
		</div>
	</div>
	<div class="blank"></div>
	<div class="row text-center col-lg-12">
		<div style="width: 100%;">
			<input type="button" class="ctg_btn" id="all" value="전체" /> <input
				type="button" class="ctg_btn" value="정치" /> <input type="button"
				class="ctg_btn" value="경제" /> <input type="button" class="ctg_btn"
				value="사회" /> <input type="button" class="ctg_btn" value="지역" />
		</div>
	</div>
	<div id="wordcloud">
		<div style="width: 850px; height: 450px; margin: auto;"></div>
	</div>
</div>