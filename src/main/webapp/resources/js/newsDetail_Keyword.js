var keyword = null;
function searchType(method) {
//   window.alert("1-걸림 "+method);
   $('#SearchForm').attr("method", method)
   search(1)
   keyword = $('#keyword').val();
}

function search(curPage) {
//   window.alert("2-여기걸림 "+curPage);
   if($('#SearchForm').attr("method") == "POST") {
      searchPost(curPage);
   } else {
      searchGet(curPage);
   }
}

var Flag = null;   //체크박스내에서 확인;
var testFlag =null;
var str = null
var CheckOnFlag =null;// 체크박스 눌렸을때
var curPPage = null;
var curRRange = null;
var chk_send = null; // 이벤트버블링(중복실행) 방지;
var chk_click = true; // 이벤트버블링(중복실행) 방지;

// .check 클래스 중 어떤 원소가 체크되었을 때 발생하는 이벤트
$(".check").click(function(){  // 여기서 .click은 체크박스의 체크를 뜻한다.
	CheckOnFlag =0
	
	  str = "";  // 여러개가 눌렸을 때 전부 출력이 될 수 있게 하나의 객체에 담는다.
      //$(".check").each(function(){  // .each()는 forEach를 뜻한다.
         if($(this).is(":checked")){  // ":checked"를 이용하여 체크가 되어있는지 아닌지 확인한다.
            str = $(this).val();  // 체크된 객체를 str에 저장한다.
         $(".check").prop("checked", false);
         $(this).prop("checked", true)};
         searchGet(1);
         //});
});//필터링 눌렸을때
function searchGet(curPage) {
   chk_send == 1;

      //체크박스 안눌렸을때
      if(CheckOnFlag ==null){
         Flag =1;
         testFlag =1;
         if(curPage ==1 && str ==null){
            var sendData = 
             {"action":$('#action').val(), 
             "curPage":$('#curPage').val(), 
             "keyword":$('#keyword').val()};
         }
   
         if(curPage>=2 && str ==null){
            var sendData = 
             {"action":$('#action').val(), 
             "curPage":curPage, 
             "keyword":$('#keyword').val()};
         }
      }
      
      //체크박스 눌렸을떄
      else{
         Flag = 0;
         testFlag =0;
         //체크박스 눌려있고, 키워드검색은 안하고있을때(null일때)
         if(keyword == null){
            if(curPage ==1 && str !=null){
               var sendData = 
                {"action":$('#action').val(), 
                "curPage":curPage, 
               // "keyword":keyword,
                "newsname":str
                };
            }
            if(curPage >=2 && str !=null){
               var sendData = 
                {"action":$('#action').val(), 
                "curPage":curPage, 
              //  "keyword":keyword,
                "newsname":str
                };
            }   
         }
         
         //체크박스 눌려있고, 키워드검색도 하고잇을때
         else{
            testFlag =2;
            if(curPage ==1 && str !=null){
               var sendData = 
               {"action":$('#action').val(), 
                     "curPage":curPage, 
                     "keyword":keyword,
                     "newsname":str
               };
            }
            
            if(curPage >=2 && str !=null){
               var sendData = 
               {"action":$('#action').val(), 
                     "curPage":curPage, 
                     "keyword":keyword,
                     "newsname":str
               };
            }      
         }
      }//CheckOnFlag   
      
      //CheckOnFlag값과 Flag값 정의되고 ajax 하나만 수행.
      $.ajax({
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
            ('<div id="newsTable"><table><tbody class="detail_title" onclick="readDetailNews('+ idx+ ')" id=tbody>'+
            '<tr><td rowspan="3"><output id='+myUrl+'></output></td></div>'+
            '<td id="listTitle"><output id='+myTitle+'></output></td></tr>'+
            '<tr id="listItems" align="left"><td><output id='+myDate+'></output>'+
            '<output id='+myCategory+'>&nbsp;|&nbsp;</output>'+
            '<output id='+myNewsname+'>&nbsp;|&nbsp;</output></td></tr>'+
            '</tbody></table></div>');
               
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
                var curRange =data.paginationttt.curRange;    
                $('#url'+i).append('<img src="'+newsurl+'" height="60px">');
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
}//searchGet끝            