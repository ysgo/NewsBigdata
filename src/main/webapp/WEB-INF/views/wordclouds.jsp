<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script type="text/javascript"
	src="http://ajax.googleapis.com/ajax/libs/jquery/3.4.1/jquery.min.js"></script>

<link rel="stylesheet" type="text/css" href="resources/css/jqcd.css" />
<script src="resources/js/jqcloud.js" charset="utf-8"></script>




<style>
/* text:hover {
	stroke: black;
} */

/* .legend {
	border: 1px solid grey;
	border-radius: 5px 5px 5px 5px;
	font-size: 0.8em;
	margin: 10px;
	padding: 8px;
} */
</style>


<meta charset="UTF-8">
<title>Insert title here</title>

</head>

<body>
	<div>
		<input type="button" class="ctg_btn" id="all" value="전체" /> <input
			type="button" class="ctg_btn" value="정치" /> <input type="button"
			class="ctg_btn" value="경제" /> <input type="button" class="ctg_btn"
			value="사회" /> <input type="button" class="ctg_btn" value="지역" />
	</div>

	<div id="wordcloud" align="center" style="width: 700px; height: 500px;"></div>
	<!-- <div class="legend"  align="center" style="width:60%;"> -->
	<!--          오늘날짜의 기사를 키워드로 보여줌 </div> -->


	<script type="text/javascript">
	$(document).ready(function() {
			$.ajax({
				url : "wordclouds.do",
				type : "GET",
				success : function(data) {
					var word_array = new Array();
					var obj;	
					
					for (key in data) {
						obj = new Object();
						
						obj.text=key;
						obj.weight=data[key];
						obj.handlers={
								 click: function() {
									 var keywordClicked=$(this).val();
								    	console.log(keywordClicked);
								       /* $.ajax({
											url : "NewsdetailView.do",//검색창 주소
											type : "GET",
											data:{"keywordClicked":keywordClicked},
											success : function(data) {//검색결과 총 기사리스트 갖고오기(변수명:list?)
												var ctg_btn_array = new Array();
												
												for()
												
												$(document).ready(function(){
													$('#wordcloud').jQCloud('update',ctg_btn_array)
													
													
												});
											},
											error : function(request, status, error) {
												console.log("Error");
												console.log("error code:" + request.status + "\n"
														+ "message:" + request.responseText + "\n"
														+ "error:" + error);
											}
				                    }); */
						}
						}	    
						word_array.push(obj);
						//console.log(data);
						//console.log(key,data[key]);	link			
					}
					console.log(obj);
						console.log(word_array);
		
					$(document).ready(function(){
						$('#wordcloud').jQCloud(word_array)
						

						 /* $(".jqcloud-word").click(function(){
							 alert('You clicked the word !');
						 }); */
					});
				},
				error : function(request, status, error) {
					console.log("Error");
					console.log("error code:" + request.status + "\n"
							+ "message:" + request.responseText + "\n"
							+ "error:" + error);
				}
			});
		});
		
		/* var a=function() {
			  $('span').click(function(){
			     // type = $(this).val(); // update the value in the var type here
			     alert("??");
			   })
	      } */
	
		    $(".ctg_btn").click(function(){
		    	var ctg=$(this).val();
		    	console.log(ctg);
		    	//ctg.style.backgroundColor  = '#A9A9A9';
		       $.ajax({
					url : "ctgkeyword.do",
					type : "GET",
					data:{"ctg":ctg},
					success : function(data) {
						var ctg_btn_array = new Array();
						var obj;
						for (key in data) {
							obj = new Object();
							obj.text=key;
							obj.weight=data[key];
							ctg_btn_array.push(obj);		
						}
							console.log(ctg_btn_array);
			
						$(document).ready(function(){
							$('#wordcloud').jQCloud('update',ctg_btn_array)
						});
					},
					error : function(request, status, error) {
						console.log("Error");
						console.log("error code:" + request.status + "\n"
								+ "message:" + request.responseText + "\n"
								+ "error:" + error);
					}
				});
		    });
		
	</script>
</body>
</html>

