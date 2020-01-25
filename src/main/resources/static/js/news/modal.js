// 뉴스 기사 클릭시 모달에 뉴스 기사 출력 AJAX 구현
function readNews(num) {
	var value = document.getElementsByClassName("main_title")[num].innerText;
	requestAjax(value);
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
			if (data.url != 0) {
				$("#m_img").attr("src", data.url);
				$("#m_img").show();
			} else {
				$("#m_img").hide();
				$("#m_img").empty();
			}

			$('html, page-section').css({
				'overflow-x' : 'hidden',
				'overflow-y' : 'hidden'
			});
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
	$('html, body').css({
		'overflow-x' : 'hidden',
		'overflow-y' : 'auto'
	});
}

$("#closeModal").click(function(e){
	$("#modal-content").scrollTop(0);
	$("#modal_box").hide();
	
	$("html, body").css({
		"overflow-x": "hidden",
		"overflow-y": "auto",
	});
});
