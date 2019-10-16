function fn_paging(pageNum){
	//http://localhost:8000/newsbigdata/main.do/NewsdetailView.do?action=search&curPage=1&keyword=	
	window.alert("fn_paging 눌림  : "+pageNum);
	location.href = '/newsbigdata/main/NewsdetailView?action=search&curPage='+pageNum+'&keyword='; 
} 

var firstGrid = null;
var Flag = null;
var str = null
function searchGet(curPage) {
//	window.alert("3-searchGet들어옴 "+curPage);
	//var curPage = curPage;
//	window.alert("searchGet에 들어온 str값 테스트"+str);
	$(document).ready(function(){
	// .check 클래스 중 어떤 원소가 체크되었을 때 발생하는 이벤트
	$(".check").click(function(){  // 여기서 .click은 체크박스의 체크를 뜻한다.
		str = "";  // 여러개가 눌렸을 때 전부 출력이 될 수 있게 하나의 객체에 담는다.
		$(".check").each(function(){  // .each()는 forEach를 뜻한다.
			if($(this).is(":checked"))  // ":checked"를 이용하여 체크가 되어있는지 아닌지 확인한다.
				str += $(this).val();  // 체크된 객체를 str에 저장한다.
				//window.alert("str값 ");
		});
		//$("#multiPrint").text(str);  // #multiPrint에 체크된 원소를 출력한다.
		if(curPage ==1 && str !=null){
			var sendData = 
		    {"action":$('#action').val(), 
		    "curPage":curPage, 
		    "keyword":str,
		    "newsname":str
		    };
//			window.alert("클릭된!! curPage==1 && str !=null 영역"+sendData.curPage+" str값 : " +str);
			
			if(curPage >=2 && str !=null){
				var sendData = 
			    {"action":$('#action').val(), 
			    "curPage":curPage, 
			    "keyword":str};
//				window.alert("클릭된 !!curPage>=2 && str !=null 영역"+sendData.curPage+ " str 값 :" +str);
			}		
			$.ajax({
		        type: "GET",
		        url : 'main/NewsdetailView' ,
		        data: sendData,
		        dataType : "JSON",
		        success: function(data){
//		        	window.alert("성공"+sendData.newsname);
		        	console.log(data);			    	
		        	if(curPage != null){
						var count = data.listCnttt;		
						var text = "총 "+ count + "개의 기사가 검색되었습니다."
						var keyword = data.listtt.keyword;
						window.alert("키워드 "+sendData.keyword);
						var news_count = document.getElementById("news_count");
						news_count.innerHTML = "<b><font size='5' color='gray'>"+text+"</font></b>";
					}
		        	console.log("11");
		       	    $('#tb').empty();
		        	$('#url').empty();
					$('#title').empty();
					$('#date').empty();
				
					//출력 객체 초기화.
					for (var i=0; i<data.listtt.length; i++){
						var myTitle = "title"+i;
						var myUrl = "url"+i;
						var myDate = "date"+i;
						var myNewsname = "newsname"+i;
						var myCategory = "category"+i;
						var idx = i;
						
						$('#tb').append
						('<table><tbody class="detail_title" onclick="readDetailNews('+ idx+ ')" id=tbody>'+
						'<tr><td rowspan="3" style="width: 10%"><output id='+myUrl+'></output></td>'+
						'<td><output id='+myTitle+'> </output></td></tr>'+
						'<tr align="left"><td><output id='+myDate+'>기사 날짜 :</output></td>'+
						'<td><output id='+myCategory+'> 카테고리 :</output></td>'+
						'<td align="left"><output id='+myNewsname+'> 언론사 :</output></td></tr>'+
						'</tbody></table>');
						
						 var newstitle =data.listtt[i].title;
						 var newsurl = data.listtt[i].url
						 if(newsurl != 0){
							//url 이미지가 존재할 때
						 	newsurl = data.listtt[i].url;
						 }
						 else{
							 //디폴트 이미지
							newsurl = "http://70.12.113.163:8000/newsbigdata/resources/img/news_default.png";
						 }
						 
						 var date = data.listtt[i].date;
						 var category = data.listtt[i].category;
						 var newsname =data.listtt[i].newsname;	 

						 $('#url'+i).append('<img src="'+newsurl+'" height="60px">');
						 $('#title'+i).append(newstitle);
						 $('#date'+i).append(date);
						 $('#category'+i).append(category); 
						 $('#newsname'+i).append(newsname);
						 
					 }
				
//					window.alert("클릭한 curPage 테스트 : "+ curPage);
					Flag = 0;
					drawPagination(curPage);
					//flag가 =0일때 필터링 검색만 쓴거,flag =1일때 키워드 검색만쓴거 
					
					//필요한게 keyword newsname
		//맵 pagination 테스트Pagination [rangeSize=10, curPage=1, curRange=1, listCnt=7, pageCnt=1, rangeCnt=1, startPage=1, endPage=1, startIndex=0, prevPage=0, nextPage=2]
					
			    },
		        error: function() {
		            window.alert('조회 중 오류가 발생했습니다.');
		        }
		    });
		}
		});
	});
	
	if(curPage ==1 && str ==null){
		var sendData = 
	    {"action":$('#action').val(), 
	    "curPage":$('#curPage').val(), 
	    "keyword":$('#keyword').val()};
	 	window.alert("curPage==1 && str ==null 영역 "+sendData.curPage);
	}
	if(curPage ==1 && str !=null){
		var sendData = 
	    {"action":$('#action').val(), 
	    "curPage":curPage, 
	    "keyword":str};
		window.alert("curPage==1 && str !=null 영역"+sendData.curPage+" str값 : " +str);
	}
	if(curPage>=2 && str ==null){
		var sendData = 
	    {"action":$('#action').val(), 
	    "curPage":curPage, 
	    "keyword":$('#keyword').val()};
	 	window.alert("curPage>=2 && str ==null 영역"+sendData.curPage);	
	}
	if(curPage >=2 && str !=null){
		var sendData = 
	    {"action":$('#action').val(), 
	    "curPage":curPage, 
	    "keyword":str};
		window.alert("curPage>=2 && str !=null 영역"+sendData.curPage+ " str 값 :" +str);
	}
	
	$.ajax({
        type: "GET",
        url : 'main/NewsdetailView' ,
        data: sendData,
        dataType : "JSON",
        success: function(data){
//        	window.alert("성공");
        	console.log(data);			    	
        	if(curPage != null){
				var count = data.listCnttt;		
				var text = "총 "+ count + "개의 기사가 검색되었습니다."
				var keyword = data.listtt.keyword;
//				window.alert("키워드 "+keyword);
				var news_count = document.getElementById("news_count");
				news_count.innerHTML = "<b><font size='5' color='gray'>"+text+"</font></b>";
			}
        	
       	    $('#tb').empty();
        	$('#url').empty();
			$('#title').empty();
			$('#date').empty();
		
			//출력 객체 초기화.
			for (var i=0; i<data.listtt.length; i++){
				var myTitle = "title"+i;
				var myUrl = "url"+i;
				var myDate = "date"+i;
				var myNewsname = "newsname"+i;
				var myCategory = "category"+i;
				var idx = i;
				
				$('#tb').append
				('<table><tbody class="detail_title" onclick="readDetailNews('+ idx+ ')" id=tbody>'+
				'<tr><td rowspan="3" style="width: 10%"><output id='+myUrl+'></output></td>'+
				'<td><output id='+myTitle+'> </output></td></tr>'+
				'<tr align="left"><td><output id='+myDate+'>기사 날짜 :</output></td>'+
				'<td><output id='+myCategory+'> 카테고리 :</output></td>'+
				'<td align="left"><output id='+myNewsname+'> 언론사 :</output></td></tr>'+
				'</tbody></table>');
				
				 var newstitle =data.listtt[i].title;
				 var newsurl = data.listtt[i].url
				 if(newsurl != 0){
					//url 이미지가 존재할 때
				 	newsurl = data.listtt[i].url;
				 }
				 else{
					 //디폴트 이미지
					newsurl = "http://70.12.113.163:8000/newsbigdata/resources/img/news_default.png";
				 }
				 
				 var date = data.listtt[i].date;
				 var category = data.listtt[i].category;
				 var newsname =data.listtt[i].newsname;	 

				 $('#url'+i).append('<img src="'+newsurl+'" height="60px">');
				 $('#title'+i).append(newstitle);
				 $('#date'+i).append(date);
				 $('#category'+i).append(category); 
				 $('#newsname'+i).append(newsname);
				 
			 }
		
//			window.alert("일반 curPage 테스트 : "+ curPage);
		
			Flag =1;
			drawPagination(curPage);
			//필터링 검색x 키워드검색o
//맵 pagination 테스트Pagination [rangeSize=10, curPage=1, curRange=1, listCnt=7, pageCnt=1, rangeCnt=1, startPage=1, endPage=1, startIndex=0, prevPage=0, nextPage=2]
			
	    },
        error: function() {
            window.alert('조회 중 오류가 발생했습니다.');
        }
    });
}		      


//키워드 검색 화면에서 뉴스 기사 출력 AJAX 구현
function readDetailNews(num) {
	var value = document.getElementsByClassName("detail_title")[num].innerText.split(/\r?\n/);
	//console.log(value);
	//console.log(value[0].substr(1));
	//첫번째(타이틀)값의 빈공간을 substr로 제거
	requestAjax(value[0].substr(1));
}

		   
function searchType(method) {
//	window.alert("1-걸림 "+method);
	$('#SearchForm').attr("method", method)
	//console.log($('#keyword').attr("method"));
	search(1)
}

function search(curPage) {
//	window.alert("2-여기걸림 "+curPage);
	if($('#SearchForm').attr("method") == "POST") {
		searchPost(curPage);
	} else {
		searchGet(curPage);
	}
}
