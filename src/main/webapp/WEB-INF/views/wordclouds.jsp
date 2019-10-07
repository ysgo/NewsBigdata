<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
<style>
text:hover {
	stroke: black;
}

body {
	font-family: "Lucida Grande", "Droid Sans", Arial, Helvetica, sans-serif;
}

.legend {
	border: 1px solid grey;
	border-radius: 5px 5px 5px 5px;
	font-size: 0.8em;
	margin: 10px;
	padding: 8px;
}

.bld {
	font-weight: bold;
}
</style>

<meta charset="UTF-8">
<title>Insert title here</title>
</head>

<body>
<script src="https://d3js.org/d3.v3.min.js" charset="utf-8"></script>
<script src="d3.layout.cloud.js"></script>

	<div>
		<form action="ctgbtn.do" method="GET">
			<input type="button" id="ctgA" name="A" value="전체" /> 
			<input type="button" id="ctgP" name="P" value="정치" /> 
			<input type="button" id="ctgE" name="E" value="경제" /> 
			<input type="button" id="ctgS" name="S" value="사회" />
			<input type="button" id="ctgW" name="W" value="국제" />
		</form>
	</div>
	
<div id="wordcloud" align="center" ></div>
<div class="legend"  align="center" style="width:60%;">
         오늘날짜의 기사를 키워드로 보여줌 </div>


</body>

<script>
    var frequency_list = $.ajax({
            url: "/wordclouds.do",
            dataType: "json",
            async: false
        }).responseText;
   

    var x = JSON.parse(frequency_list);
    
    d3.layout.cloud().size([800, 300])
            .words(x)
            .rotate(0)
            .fontSize(function(d) { return d.size; })
            .on("end", draw)
            .start();

    function draw(words) {
        d3.select("#wordcloud").append("svg")
                .attr("width", 850)
                .attr("height", 350)
                .attr("class", "wordcloud")
                .append("g")
                .attr("transform", "translate(320,200)")
                .selectAll("text")
                .data(words)
                .enter().append("text")
                .style("font-size", function(d) { return d.size + "px"; })
                .style("fill", function(d, i) { return color(i); })
                .attr("transform", function(d) {
                    return "translate(" + [d.x, d.y] + ")rotate(" + d.rotate + ")";
                })
                .text(function(d) { return d.text; });
    }
    
	   $('#ctgA').on('click',function(){

		   location.href="./";

	   });
</script>
</html>