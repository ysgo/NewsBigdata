// 뉴스 기사 클릭시 모달에 뉴스 기사 출력 AJAX 구현
function readNews(num) {
	var value = document.getElementsByClassName("main_title")[num].innerText;
	/*console.log(value);*/

	$.ajax({
		url : "readNews.do?title=" + value,
		type : "GET",
		success : function(data) {
			document.getElementById('id01').style.display = 'block';
			console.log("Success");
			console.log(data);
			document.getElementById("m_title").innerHTML = data.readNews.title;
			document.getElementById("m_date").innerHTML = data.readNews.date;
			document.getElementById("m_contents").innerHTML = data.readNews.contents;
			
			$('html, body').css({
				'overflow' : 'hidden',
				'height' : '100%'
					});
			$('#element').on('scroll touchmove mousewheel',
					function(event) {
				event.preventDefault();
				event.stopPropagation();
				return false;
				});
			},
			error : function(request, status, error) {
				console.log("Error");
				console.log("error code:" + request.status + "\n"
						+ "message:" + request.responseText + "\n"
						+ "error:" + error);
				}
			});
	}

// 모달 닫기 버튼
function closeBtn() {
	document.getElementById('id01').style.display = 'none';
	$('html, body').css({
		'overflow' : 'auto',
		'height' : '100%'
	});
	$('#element').off('scroll touchmove mousewheel');
}
