window.onload = function() {
	curTime();
	setInterval(curTime, 1000);
	todayNews();
}

function curTime() {
	// Today Date&Time Display
	var d = new Date();
	var days = [ '일', '월', '화', '수', '목', '금', '토' ];
	var localeDate = d.toLocaleDateString();
	var localeTime = d.toLocaleTimeString();
	var dateTime = localeDate.substr(0, localeDate.length - 1) + ' ('
			+ days[d.getDay()] + ') ' + localeTime;
	document.getElementById("issue-analysis-time").innerHTML = dateTime;
}

function todayNews(e) {
	// Start window Ajax Request
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (this.status == 200) {
				var jsonObj = JSON.parse(this.responseText);
				var province = jsonObj.province;
				var sigungu = jsonObj.sigungu;
				var todayNews = jsonObj.todayNews;
				
				showNewsList(todayNews);
				if(e != 1)
					showMap(province, sigungu);
			} else {
				console.log("Error: " + this.status);
			}
		}
	};
	xhttp.open("GET", "mainNews", true);
	xhttp.send();
}

function showNewsList(newsList) {
	// 뉴스 리스트 출력 - idx는 인덱스, item은 데이터 json
	$('#todayNews *').remove();
	$.each(newsList, function(idx, item) {
		var str='<li>';
		str+='<span class="main_title" onclick="readNews('+ idx + ')">';
		str+=item;
		str+='</span>';
		str+='</li>';
		$("#todayNews").append(str);
	});
} 

var markers = [], infoWindows = [], map;
function showMap(province, sigungu) {
	// 지도에 행정구역 표시
	var mapDiv = document.getElementById('mapList');
	var mapOptions = {
		center : new naver.maps.LatLng(35.9, 127.2),
		zoom : 2,
		minZoom : 1,
		maxZoom : 7,
		logoControl : true,
		mapTypeControl : true,
		zoomControl : true,
		zoomControlOptions : {
			position : naver.maps.Position.TOP_RIGHT
		}
	};
	 
	map = new naver.maps.Map(mapDiv, mapOptions);
	setMarkers(province);
	markerInfo();
	naver.maps.Event.addListener(map, 'zoom_changed', function(zoom) {
		if(zoom >= 3) {
			clearmarkers();
			setMarkers(sigungu);
		} else {
			clearmarkers();
			setMarkers(province);
		}
		markerInfo();
	});
}

function setMarkers(zoneName) {
	for (var key in zoneName) {
		var lat = zoneName[key].latitude;
		var lng = zoneName[key].longitude;
		var name = zoneName[key].name;
		
		markers.push(new naver.maps.Marker({
			position : new naver.maps.LatLng(lat, lng),
			map : map,
			content: name
		}));
		
		infoWindows.push(new naver.maps.InfoWindow({
			content: '<div style="width:150px;text-align:center;padding:10px;">"'+ name +'"</div>'
		}));
	}
}

function markerInfo() {
	for (var i=0; i<markers.length; i++)
	    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
}

function clearmarkers() {
	for(var i in markers)
		markers[i].setMap(null);
}

function getClickHandler(seq) {
	 return function(e) {
		var marker = markers[seq], infoWindow = infoWindows[seq];

		if (infoWindow.getMap()) {
			infoWindow.close();
		} else {
			infoWindow.open(map, marker);
		}
		console.log(marker.content);
		
		$.ajax({
			url : 'selectZone',
			type : 'GET',
			data : { zoneName : marker.content },
			success : function(data) {
				console.log(data.zoneNews);
				showNewsList(data.zoneNews);
			},
			error : function(request, status, error) {
				console.log("Error");
				console.log("error code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}
}