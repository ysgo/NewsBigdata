function fn_paging(pageNum){
	//http://localhost:8000/newsbigdata/main.do/NewsdetailView.do?action=search&curPage=1&keyword=	
//	window.alert("fn_paging 눌림  : "+pageNum);
   location.href = '/newsbigdata/main/NewsdetailView?action=search&curPage='+pageNum+'&keyword='; 
}

function drawPagination(curPage){
var board = {};

board.boardList = {
        init : function(lstCnt) {
            var page = 1;
            board.boardList.param.pageNumber = Number(page);
            board.boardList.pageSize;
            board.boardList.startPage;
        },
       }
        
$(".pagination").empty();  //페이징에 필요한 객체내부를 비워준다.

if(Flag ==0){
	var sendData2 = 
	{"action":$('#action').val(), 
	"curPage":$('#curPage').val(), 
	"keyword":str,
	"newsname":str
	};
}
if(Flag ==1){
	var sendData2 = 
	{"action":$('#action').val(), 
	"curPage":$('#curPage').val(), 
	"keyword":$('#keyword').val()};
}
//window.alert("drawPagination 테스트");
//window.alert("drawPagination의 sendData2:"+sendData2.action + sendData2.curPage + sendData2.keyword);
//window.alert("drawPagination의 Flag:"+Flag);
//window.alert("drawPagination의 str:"+str);

$.ajax({
    type: "GET",
    url : 'main/NewsdetailView' ,
    data: sendData2,
    dataType : "JSON",
    success: function(data){
  		//board.boardList.pageSize = data.paginationttt.pageCnt;
  		//board.boardList.startPage= data.paginationttt.startPage;
    	
  		$(".pagination").empty();  //페이징에 필요한 객체내부를 비워준다.
 	          // 페이지가 1페이지 가아니면
  	    	$(".pagination").append("<button onclick='goFirstPage()' class=\"goFirstPage\"><a>처음</a></li>");        //첫페이지로가는버튼 활성화	
 		/*
  	    else{
  	    	$(".pagination").append("<li class=\"disabled\"><a>◀</a></li>");        //첫페이지로가는버튼 비활성화
  	    }
  	 	 */
  	/*  if(data.paginationttt.curRange = 1){            //첫번째 블럭이 아니면
  	    	$(".pagination").append("<button onclick='goBackPage()' class=\"goBackPage\"><a>이전</a></button>");        //뒤로가기버튼 활성화
  	    }else{
  	    	$(".pagination").append("<li class=\"disabled\"><a><</a></li>");        //뒤로가기버튼 비활성화
  	    } */
  	 for(var i = data.paginationttt.startPage ; i <= data.paginationttt.endPage ; i++){        //시작페이지부터 종료페이지까지 반복문    	
  	    		$(".pagination").append("<button onclick='goPage()' class=\"goPage\" data-page=\""+i+"\"><a>"+i+"</a></button>"); //버튼 활성화  	    	
  	    }
  	/*  if(data.paginationttt.rangeCnt <  data.paginationttt.curRange){           
  		 //전체페이지블럭수가 현재블럭수보다 작을때
  	    	$(".pagination").append("<li class=\"goNextPage\"><a>></a></li>");         //다음페이지버튼 활성화
  	    }else{
  	    	$(".pagination").append("<li class=\"disabled\"><a>></a></li>");        //다음페이지버튼 비활성화
  	    }
  	
  	if(data.paginationttt.curPage < data.paginationttt.pageCnt){                //현재페이지가 전체페이지보다 작을때
  			$(".pagination").append("<li class=\"goLastPage\"><a>다음</a></li>");    //마지막페이지로 가기 버튼 활성화
  		}else{
  			$(".pagination").append("<li class=\"disabled\"><a>다음</a></li>");        //마지막페이지로 가기 버튼 비활성화
  		}
  	 
  	if(data.paginationttt.rangeCnt <  data.paginationttt.curRange){           
 		 //전체페이지블럭수가 현재블럭수보다 작을때
 	    	$(".pagination").append("<button onclick='goNextPage()' class=\"goNextPage\"><a>다음</a></button>");         //다음페이지버튼 활성화
 	    }else{
 	    	$(".pagination").append("<li class=\"disabled\"><a>></a></li>");        //다음페이지버튼 비활성화
 	    }
  	*/
 	$(".pagination").append("<button onclick='goLastPage()' class=\"goLastPage\" data-page=\""+data.paginationttt.pageCnt+"\"><a>끝</a></button>");        //첫페이지로가는버튼 활성화	
		
  	
  	
		var lstCnt = data.paginationttt.listCnt;
//		window.alert("끝끝끝");
		
//		searchBoardListPaging(board.boardList.pageSize);
//		searchBoardListPaging(board.boardList.startPage);
   },
    error: function() {
        window.alert('조회 중 오류가 발생했습니다.');
    }
 });
} 

function goPage() {
	$('.goPage').click(function(){
		page = $(this).attr("data-page");
		pageNum = page;
//		window.alert("pageNum"+pageNum );
		searchGet(pageNum);  
	});
}
function goFirstPage() {
	$('.goFirstPage').click(function(){
//		window.alert("첫번째 버튼 클릭");
		pageNum = 1;
		searchGet(pageNum);  
	});
}
function goNextPage() {
	$('.goBackPage').click(function(){
//		window.alert("다음 버튼 클릭");
		pageNum = 1;
		searchGet(pageNum);  
	});
}
function goLastPage() {
	$('.goLastPage').click(function(){
//		window.alert("끝 버튼 클릭");
		page = $(this).attr("data-page");
		pageNum = page;
//		window.alert("끝 버튼 클릭"+pageNum);
		searchGet(pageNum);  
	});
}
/*



						<%-- <div id=paginationttt> <!-- ne!=  //  eq== -->
                  <c:if test="${pagination.curRange ne 1 }">
                        <a href="#" onClick="fn_paging(1)">[처음]</a> 
                    </c:if>
                    <c:if test="${pagination.curRange ne 1 }">
                        <a href="#" onClick="fn_paging(1)">[처음]</a> 
                    </c:if>
                    
                    <c:if test="${pagination.curPage ne 1}">
                        <a href="#" onClick="fn_paging('${pagination.prevPage }')">[이전]</a> 
                    </c:if>
                    <c:forEach var="pageNum" begin="${pagination.startPage }" end="${pagination.endPage }">
                        <c:choose>
                            <c:when test="${pageNum eq  pagination.curPage}">
                                <span style="font-weight: bold;"><a href="#" onClick="fn_paging('${pageNum }')">${pageNum }</a></span> 
                            </c:when>
                            <c:otherwise>
                                <a href="#" onClick="fn_paging('${pageNum }')">${pageNum }</a> 
                            </c:otherwise>
                        </c:choose>
                    </c:forEach>
                    <c:if test="${pagination.curPage ne pagination.pageCnt && pagination.pageCnt > 0}">
                        <a href="#" onClick="fn_paging('${pagination.nextPage }')">[다음]</a> 
                    </c:if>
                    <c:if test="${pagination.curRange ne pagination.rangeCnt && pagination.rangeCnt > 0}">
                        <a href="#" onClick="fn_paging('${pagination.pageCnt }')">[끝]</a> 
                    </c:if>
              
                <div>
	                    총 게시글 수 : ${data.paginationttt.listCnt } /    총 페이지 수 : ${paginationttt.pageCnt } / 현재 페이지 : ${paginationttt.curPage } / 현재 블럭 : ${paginationttt.curRange } / 총 블럭 수 : ${paginationttt.rangeCnt }
	             </div> 
               </div>
              <!-- 페이징끝 --> --%>

 * */


/*  여기 테스트임 지우지마세요
//location.href = '/newsbigdata/main.do/NewsdetailView.do?action=search&curPage='+pageNum+'&keyword='; 
	function searchBoardListPaging (page) {
		//마지막
		$(".goLastPage").click(function(){
			window.alert("마지막 버튼 클릭"+page);
			pageNum = page;

			window.alert("마지막페이지 +" + pageNum );
		   	$("상단 ajax를 함수로 만들어 재귀호출");
		   	
		   	searchGet(pageNum);
		    drawPagination(pageNum);
		   	

		    
		//맨처음   	
		  	$(".goFirstPage").click(function(){
		  		window.alert("첫번째 버튼 클릭"+page);
				pageNum = page;
				window.alert("처음페이지 +" + pageNum );
			   	$("상단 ajax를 함수로 만들어 재귀호출");
			   	
			   	searchGet(pageNum);
			    drawPagination(lstCnt);
	        })
		});
	}



	//페이징을 설정하고 페이징 영역에 화면에 그리는 함수
	//첫번째 페이지로 가기 버튼 이벤트

	   	$(".goFirstPage").click(function(){

		       	page = 1;

		       	pageFlag = 1;

		       	$("상단 ajax를 함수로 만들어 재귀호출");

		       	pageFlag = 0;

	       })
	//뒷페이지로 가기 버튼 이벤트

	$(".goBackPage").click(function(){

	     	page = Number(paging.startPage) - 1;

	      	pageFlag = 1;

	      	$("상단 ajax를 함수로 만들어 재귀호출");

	      	pageFlag = 0;

	   });



	   	//클릭된 페이지로 가기 이벤트

			$(".goPage").click(function(){

				page = $(this).attr("data-page");

				pageFlag = 1;

			       	$("상단 ajax를 함수로 만들어 재귀호출");

			       	
			       	pageFlag = 0;

			});



	//다음페이지로 가기 클릭이벤트

			$(".goNextPage").click(function(){

				page = Number(paging.endPage) + 1;

				pageFlag = 1;

			      	$("상단 ajax를 함수로 만들어 재귀호출");

			       	pageFlag = 0;

		        });

			
			$(document).ready(function(){
			    // test라는 클래스를가진 div를 클릭할 경우 "테스트입니다요."라는 alert가 뜬다.
			    $(".test").on("click", function(){  
			        alert("테스트입니다요.");
			    });    
			});
		

	//마지막페이지로 가기 클릭이벤트

		        $(".goLastPage").click(function(){
					
		        	pageNum = data.paginationttt.pageCnt;

		        	pageFlag = 1;
					window.alert("마지막페이지 +" + data.paginationttt.pageCnt );
			       	$("상단 ajax를 함수로 만들어 재귀호출");
			        location.href = '/newsbigdata/main/NewsdetailView?action=search&curPage='+pageNum+'&keyword='; 
			      	pageFlag = 0;

		        });
		        */