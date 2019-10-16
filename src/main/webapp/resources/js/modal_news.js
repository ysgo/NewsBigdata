// 뉴스 기사 클릭시 모달에 뉴스 기사 출력 AJAX 구현
function readNews(num) {
	var value = document.getElementsByClassName("main_title")[num].innerText;
	requestAjax(value);
}

// Modal Close Button
function closeBtn() {
	document.getElementById("modal_box").style.display = "none";
}

function requestAjax(value) {
	$.ajax({
		url : "readNews",
		type : "GET",
		data : { title : value },
		success : function(data) {
			document.getElementById("modal_box").style.display = "block";
			document.getElementById("m_newsname").innerHTML = data.newsname;
			document.getElementById("m_title").innerHTML = data.title;
			document.getElementById("m_category").innerHTML = data.category;
			document.getElementById("m_date").innerHTML = data.date;
			document.getElementById("m_content").innerHTML = data.content;
			if(data.url != 0)
				document.getElementById("m_img").src = data.url;
			else
				document.getElementById("m_img").src = "";

			// Modal Close Button
			$('html, body').css({
				'overflow-x' : 'hidden',
				'overflow-y' : 'auto'
			});
		},
		error : function(request, status, error) {
			console.log("Error");
			console.log("error code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}
