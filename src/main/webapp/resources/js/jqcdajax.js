/*!
 * jQCloud 2.0.3
 * Copyright 2011 Luca Ongaro (http://www.lucaongaro.eu)
 * Copyright 2013 Daniel White (http://www.developerdan.com)
 * Copyright 2014-2017 Damien "Mistic" Sorel (http://www.strangeplanet.fr)
 * Licensed under MIT (http://opensource.org/licenses/MIT)
 */


/*$(document).ajaxStart(function(){
	$('#Progress_Loading').show(); //ajax실행시 로딩바를 보여준다.
})
$(document).ajaxStop(function(){
	$('#Progress_Loading').hide(); //ajax종료시 로딩바를 숨겨준다.
});*/
	function loadWordcloud() {
		$.ajax({
//		 $('#loadingImg').src='resources/img/ajax-loader.gif';
			url : "wordclouds",
			type : "GET",
			data : {
				"ctg" : ""
		},
		success : function(data) {
			var word_array = new Array();
			var obj;
			var keyword;
			for (key in data) {
				obj = new Object();
				obj.text = key;
				obj.weight = data[key];
				obj.handlers = {
					click : function() {
						keyword = $(this).html();
						console.log(keyword);
						searchGet("search", 1, keyword);
						// linearGraph()
					}
				}
				word_array.push(obj);
				console.log(obj);
			}
			console.log(word_array);
//			 $('#loadingImg').src='';
			$('#wordcloud').jQCloud(word_array, {
				shape : 'Cloud shape'
			});
		},
		error : function(request, status, error) {
			console.log("Error");
			console.log("error code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}
/*
 * function linearGraph(){
 *  }
 */
$(".ctg_btn").click(
		function() {
			var ctg = $(this).val();
			console.log(ctg);
			$.ajax({
				url : "wordclouds",
				type : "GET",
				data : {
					"ctg" : ctg
				},
				success : function(data) {
					var ctg_btn_array = new Array();
					var obj;
					var keyword;
					for (key in data) {
						obj = new Object();

						obj.text = key;
						obj.weight = data[key];
						obj.handlers = {
							click : function() {
								keyword = $(this).html();
								console.log(keyword);
								searchGet("search", 1, keyword);
							}
						}
						ctg_btn_array.push(obj);
					}
					console.log(ctg_btn_array);
					$('#wordcloud').jQCloud('update', ctg_btn_array);
				},
				error : function(request, status, error) {
					console.log("Error");
					console.log("error code:" + request.status + "\n"
							+ "message:" + request.responseText + "\n"
							+ "error:" + error);
				}
			});
		});

$(".up_btn").click(function() {
	document.getElementById('up_btnLine').scrollIntoView();
});
