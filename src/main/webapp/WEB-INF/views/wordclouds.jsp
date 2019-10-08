<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp"%>
<!DOCTYPE html>
<html>
<head>
<script src="//code.jquery.com/jquery-1.11.1.min.js"></script>
<script
	src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.0.0/jquery.min.js"></script>



<style>
text:hover {
	stroke: black;
}

.legend {
	border: 1px solid grey;
	border-radius: 5px 5px 5px 5px;
	font-size: 0.8em;
	margin: 10px;
	padding: 8px;
}

svg {
	width: 700px;
	height: 500px;
	border: 1px solid black;
}
</style>

<meta charset="UTF-8">
<title>Insert title here</title>

</head>

<body>

	<script src="https://d3js.org/d3.v3.min.js"></script>
	<script
		src="https://rawgit.com/jasondavies/d3-cloud/master/build/d3.layout.cloud.js"
		type="text/JavaScript"></script>

	<div>
		<form action="ctgbtn.do" method="GET">
			<input type="button" id="ctgA" name="A" value="전체" /> <input
				type="button" id="ctgP" name="P" value="정치" /> <input type="button"
				id="ctgE" name="E" value="경제" /> <input type="button" id="ctgS"
				name="S" value="사회" /> <input type="button" id="ctgW" name="W"
				value="국제" />
		</form>
	</div>

	<div id="wordcloud" align="center"></div>
	<!-- <div class="legend"  align="center" style="width:60%;"> -->
	<!--          오늘날짜의 기사를 키워드로 보여줌 </div> -->

	<script>
		window.onload = function() {
			var width = 700, height = 500
			var fill = d3.scale.category20();
			var word;
			
			d3.json($.ajax({
				url : "wordclouds.do",
				type : "GET",
				success : function(keyMap){
					for (key in keyMap) {
						word = [key, keyMap[key]];
						//console.log(word);
						//console.log(word[0]);
					}
				}
			})
		,function(error,word){
				if(error){
					var error=function(request, status, error) {
					console.log("Error");
					console.log("error code:" + request.status + "\n"
							+ "message:" + request.responseText + "\n"
							+ "error:" + error);
					}
				}else{
					//console.log(word);
					showCloud(word)	
				}	
			});
			
			
		
					wordScale = d3.scale.linear().domain([0, 100]).range([0, 150]).clamp(true);
					
					var svg = d3.select("#wordcloud")
                    .append("g")
                    .attr("transform", "translate(" + width / 2 + "," + height / 2 + ")");
	
                    
                     function showCloud(word) {
            
						d3.layout.cloud().size([width, height])
                //클라우드 레이아웃에 데이터 전달
                .words(word)
                .rotate(function (d) {
                    return d.text.length > 2 ? 0 : 90;
                })
                //스케일로 각 단어의 크기를 설정
                .fontSize(function (d) {
                    return wordScale(d.frequency);
                })
                //클라우드 레이아웃을 초기화 > end이벤트 발생 > 연결된 함수 작동  
                .on("end", draw)
                .start();

            function draw(words) { 
                var cloud = svg.selectAll("text").data(words)
                //Entering words
                cloud.enter()
                    .append("text")
                    .style("font-family", "Arial")
                    .style("fill", function (d) {
                        return (keywords.indexOf(d.text) > -1 ? "#fbc280" : "#405275");
                    })
                    .style("fill-opacity", .5)
                    .attr("text-anchor", "middle") 
                    .attr('font-size', 1)
                    .text(function (d) {
                        return d.text;
                    }); 
                cloud
                    .transition()
                    .duration(600)
                    .style("font-size", function (d) {
                        return d.size + "px";
                    })
                    .attr("transform", function (d) {
                        return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                    })
                    .style("fill-opacity", 1); 
            }
        }
	}
                    
</script>
</body>
</html>

