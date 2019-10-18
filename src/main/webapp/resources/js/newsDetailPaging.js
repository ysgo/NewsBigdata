function drawPagination(curPage){
$(".pagination").empty();  //페이징에 필요한 객체내부를 비워준다.

if(Flag ==0){
	if(Flag == 0 && testFlag ==0){
		var sendData2 = 
		{"action":$('#action').val(), 
		"curPage":curPPage, 
		"newsname":str};
	}
	else{
		var sendData2 = 
		{"action":$('#action').val(), 
				"curPage":curPPage, 
				"keyword":keyword,
				"newsname":str
		};
	}
}
if(Flag ==1){
	var sendData2 = 
	{"action":$('#action').val(), 
	"curPage":curPPage, 
	"keyword":$('#keyword').val()};
}

$.ajax({
    type: "GET",
    url : 'main/NewsdetailView' ,
    data: sendData2,
    dataType : "JSON",
    success: function(data){
    	//이벤트버블링때매 한번만 실행하기 위해 검증하는 값  ex) 0 일때 실행 , 1일때 실행방지;
    	chk_send = 0;
    	
    	//현재 페이지 값을 전역변수로 선언.
    	curPPage = data.paginationttt.curPage;
  	
    //매번 페이징할때마다 객체 초기화;
    $(".pagination").empty();
    
    //처음 페이지 (curPPage 1일때)
   	$(".pagination").append("<button onclick='goFirstPage()' class=\"goFirstPage\"><a><i class='fas fa-angle-double-left'></i></a></button>");        

   	//이전 페이지 
   	if(data.paginationttt.curRange >= 2){            
  	    	$(".pagination").append("<button onclick='goBackPage()' class=\"goBackPage\"><a><i class='fas fa-angle-left'></i></a></button>");        
  	  }
  	
   	//searchGet에서 발생한 데이터 갯수만큼 리스트 출력;
  	for(var i = data.paginationttt.startPage ; i <= data.paginationttt.endPage ; i++){        //시작페이지부터 종료페이지까지 반복문    	
  	    		$(".pagination").append("<button onclick='goPage()' class=\"goPage\" data-page=\""+i+"\"><a>"+i+"</a></button>") //버튼 활성화  	    	
  	    		
  	}
  	 
  	if(data.paginationttt.curRange <  data.paginationttt.rangeCnt){           
  		 //전체페이지블럭수가 현재블럭수보다 작을때
  	    	$(".pagination").append("<button onclick='goNextPage()' class=\"goNextPage\" ><a><i class='fas fa-angle-right'></i></a></button>");         //다음페이지버튼 활성화
  	    	curPPage = data.paginationttt.curPage;
  	  	}
 	$(".pagination").append("<button onclick='goLastPage()' class=\"goLastPage\" data-page=\""+data.paginationttt.pageCnt+"\"><a><i class='fas fa-angle-double-right'></i></a></button>");        //첫페이지로가는버튼 활성화	
		
	var lstCnt = data.paginationttt.listCnt;
   },
    error: function() {
        window.alert('페이징 생성 오류가 발생했습니다.');
    }
 });
} 

//버튼 누른 페이지 이동
function goPage() {
	$('.goPage').click(function(){
		page = $(this).attr("data-page");
		pageNum = page;
		searchGet(pageNum);
	});
}

//맨 처음 페이지로 이동
function goFirstPage() {
	$('.goFirstPage').click(function(){
		pageNum = 1;
		searchGet(pageNum);  
	});
}

//다음 페이지 [11] [12] ~~ [20]으로 이동할때
function goNextPage() {
	$('.goNextPage').click(function(){
		
		//버튼 두번 실행 방지
		if (chk_send == 0)
		{
		       chk_send = 1;
		       pageNum = (curRRange*10)+1;
		//       window.alert("최종 pageNum 값 " +pageNum);
		       searchGet(pageNum); 
		}
	});
}

//이전 페이지로 이동할때
function goBackPage() {
	$('.goBackPage').click(function(){
		if (chk_send == 0)
		{
		       chk_send = 1;
		       
		       pageNum = ((curRRange*10)+1)-20;
		     //  window.alert("gobackPage 최종 값 " +pageNum);
		       searchGet(pageNum); 
		}
	});
}

//맨 마지막 페이지로 이동;
function goLastPage() {
	$('.goLastPage').click(function(){
		page = $(this).attr("data-page");
		pageNum = page;
		searchGet(pageNum);  
	});
}

//키워드 검색 화면에서 뉴스 기사 출력 AJAX 구현
function readDetailNews(num) {
	var value = document.getElementsByClassName("detail_title")[num].innerText.split(/\r?\n/);
		requestAjax(value[0].substr(1));
}
