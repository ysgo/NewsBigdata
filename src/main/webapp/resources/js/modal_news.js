// 뉴스 기사 클릭시 모달에 뉴스 기사 출력 AJAX 구현
function readNews(num) {
	var value = document.getElementsByClassName("main_title")[num].innerText;
	$.ajax({
		url : "readNews",
		type : "GET",
		data : { title : value },
		success : function(data) {
			console.log(data);
			document.getElementById("modal_box").style.display = "block";
			//document.getElementById("modal_box").style.backgroundColor="rgba(0,0,0,0.5)"
			document.getElementById("m_title").innerHTML = data.title;
			document.getElementById("m_date").innerHTML = data.date;
			document.getElementById("m_contents").innerHTML = data.content;
			$('html, body').css({
				'overflow-x' : 'hidden',
				'overflow-y' : 'auto'
			});
			/*$('#element').on('scroll touchmove mousewheel', function(event) {
				event.preventDefault();
				event.stopPropagation();
				return false;
				});*/

		},
		error : function(request, status, error) {
			console.log("Error");
			console.log("error code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}

// Modal Close Button
function closeBtn() {
	document.getElementById("modal_box").style.display = "none";
	/*$('html, body').css({
		'overflow' : 'auto',
		'height' : '100%'
	});*/
	/*$('#element').off('scroll touchmove mousewheel');*/
}
