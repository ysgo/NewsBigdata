let keyword;
function searchType(method) {
//   window.alert("1-걸림 "+method);
//   $('#SearchForm').attr("method", method);
//   search(1);
   keyword = $('#keyword').val();
   searchGet(1);
}

//function search(curPage) {
////   window.alert("2-여기걸림 "+curPage);
//   if($('#SearchForm').attr("method") == "POST") {
//      searchPost(curPage);
//   } else {
//      searchGet(curPage);
//   }
//}

var Flag = null;   //체크박스내에서 확인;
var testFlag =null;
var newsname = null
var CheckOnFlag =null;// 체크박스 눌렸을때
var curPPage = null;
var curRRange = null;
var chk_send = null; // 이벤트버블링(중복실행) 방지;
var chk_click = true; // 이벤트버블링(중복실행) 방지;

let checkedCategoryList = [];
// .check 클래스 중 어떤 원소가 체크되었을 때 발생하는 이벤트
$(".check").click(function() {  // 여기서 .click은 체크박스의 체크를 뜻한다.
	CheckOnFlag =0
	  newsname = "";  // 여러개가 눌렸을 때 전부 출력이 될 수 있게 하나의 객체에 담는다.
      //$(".check").each(function(){  // .each()는 forEach를 뜻한다.
//         if($(this).is(":checked")){  // ":checked"를 이용하여 체크가 되어있는지 아닌지 확인한다.
//            newsname = $(this).val();  // 체크된 객체를 newsname에 저장한다.
//         $(".check").prop("checked", false);
//         $(this).prop("checked", true)};
//         searchGet(1);
	newsname = $(this).val();
	if($(this).is(':checked')) {
		checkedCategoryList.push(newsname);
	} else {
		let indexOf = checkedCategoryList.indexOf(newsname);
		checkedCategoryList.splice(indexOf, 1);
	}
    console.log(checkedCategoryList);
    searchGet(1);
         //});
});//필터링 눌렸을때

function searchGet(curPage) {
//   chk_send == 1;

      //체크박스 안눌렸을때
//      if(CheckOnFlag ==null){
//         Flag =1;
//         testFlag =1;
//         if(curPage ==1 && newsname ==null){
//            var sendData = 
//             {"action":$('#action').val(), 
//             "curPage":$('#curPage').val(), 
//             "keyword":$('#keyword').val()};
//         }
//   
//         if(curPage>=2 && newsname ==null){
//            var sendData = 
//             {"action":$('#action').val(), 
//             "curPage":curPage, 
//             "keyword":$('#keyword').val()};
//         }
//      } else{	//체크박스 눌렸을떄
//         Flag = 0;
//         testFlag =0;
//         //체크박스 눌려있고, 키워드검색은 안하고있을때(null일때)
//         if(keyword == null){
//            if(curPage ==1 && newsname !=null){
//               var sendData = 
//                {"action":$('#action').val(), 
//                "curPage":curPage, 
//               // "keyword":keyword,
//                "newsname":newsname
//                };
//            }
//            if(curPage >=2 && newsname !=null){
//               var sendData = 
//                {"action":$('#action').val(), 
//                "curPage":curPage, 
//              //  "keyword":keyword,
//                "newsname":newsname
//                };
//            }   
//         } else{ //체크박스 눌려있고, 키워드검색도 하고잇을때
//            testFlag =2;
//            if(curPage ==1 && newsname !=null){
//               var sendData = 
//               {"action":$('#action').val(), 
//                     "curPage":curPage, 
//                     "keyword":keyword,
//                     "newsname":newsname
//               };
//            }
//            
//            if(curPage >=2 && newsname !=null){
//               var sendData = 
//               {"action":$('#action').val(), 
//                     "curPage":curPage, 
//                     "keyword":keyword,
//                     "newsname":newsname
//               };
//            }      
//         }
//      }//CheckOnFlag   
      
//	const data = {
//		'keyword': keyword,
//		'name': newsname,
//		'checkedCategoryList':checkedCategoryList
//	}
//	console.log(data);
//	$.ajax({
//		type: 'GET',
//		url: '/news/detail/' + id,
//		data: data,
//		success: function(response) {
//			console.log(response);
//			let text = '총 1개의 기사가 검색되었습니다.';
////			let text = '총'+ count + '개의 기사가 검색되었습니다.';
//			$('#news-count').text(text);
//		},
//		error: function(error) {
//			console.log('error: ' + error);
//		}
//	});
      //CheckOnFlag값과 Flag값 정의되고 ajax 하나만 수행.
      /*$.ajax({
           type: "GET",
           url : 'main/NewsdetailView' ,
           data: sendData,
           async:false,
           dataType : "JSON",
           success: function(data){
              console.log(data);
              //window.alert("☆☆☆ 리스트 출력 들어옴");
              if(curPage != null){
               var count = data.listCnttt;      
               var keyword = data.listtt[0].keyword;
               var text = "총 "+ count + "개의 기사가 검색되었습니다."
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
            ('<div id="newsTable">
            	<table>
            		<tbody class="detail_title" onclick="readDetailNews('+ idx+ ')" id=tbody>'+
            			'<tr>
            				<td rowspan="3">
            					<output id='+myUrl+'></output>
            				</td>
		            </div>'+
				            '<td id="listTitle">
				            	<output id='+myTitle+'></output>
				            </td>
			            </tr>'+
            '			<tr id="listItems" align="left">
            				<td>
            					<output id='+myDate+'></output>'+
            					'<output id='+myCategory+'>&nbsp;|&nbsp;</output>'+
            					'<output id='+myNewsname+'>&nbsp;|&nbsp;</output></td></tr>'+
            				'</tbody>
            			</table>
            		</div>');
               
                var newstitle =data.listtt[i].title;
                var newsurl = data.listtt[i].url
                if(newsurl != 0){
                  //url 이미지가 존재할 때
                   newsurl = data.listtt[i].url;
                }
                else{
                   //디폴트 이미지
                  newsurl = "resources/img/logo3.png";
                }
                
                var date = data.listtt[i].date;
                var category = data.listtt[i].category;
                var newsname =data.listtt[i].newsname;    
                var curRange =data.paginationttt.curRange;    
                $('#url'+i).append('<img src="'+newsurl+'" style="width:100px; height:60px; padding:7px 15px 5px 2px">');
                $('#title'+i).append(newstitle);
                $('#date'+i).append(date);
                $('#category'+i).append(category); 
                $('#newsname'+i).append(newsname);
                
             }
            curRRange =curRange;
            curPPage = curPage ;
            drawPagination(curPPage);
          },
           error: function() {
               window.alert('조회 중 오류가 발생했습니다.');
           }
       });//ajax끝
*/}//searchGet끝            
