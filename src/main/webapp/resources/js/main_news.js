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

function setmarkers(zoneName) {
	for (var key in zoneName) {
		var lat = zoneName[key].latitude;
		var lng = zoneName[key].longitude;
		var name = zoneName[key].name;
		markers.push(new naver.maps.Marker({
			position : new naver.maps.LatLng(lat, lng),
			map : map,
			content: name
		// animation: naver.maps.Animation.BOUNCE
		}));
		
		infoWindows.push(new naver.maps.InfoWindow({
			content: '<div style="width:150px;text-align:center;padding:10px;">"'+ name +'"</div>'
		}));
	}
}

function clearmarkers() {
	for(var i in markers) {
		markers[i].setMap(null);
	}
}

var markers = [], infoWindows = [], map;
window.onload = function() {
	curTime();
	setInterval(curTime, 1000);
	
	// Start window Ajax Request
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (this.status == 200) {
				var jsonObj = JSON.parse(this.responseText);
				var province = jsonObj.province;
				var sigungu = jsonObj.sigungu;
				var todayNews = jsonObj.todayNews;
				
				// 오늘의 뉴스 출력
				$.each(todayNews, function(idx, item) {
					// idx는 인덱스, item은 데이터 json
					var str="<li>";
					str+='<span class="main_title" onclick="readNews('+ idx + ')">';
					str+=item;
					str+="</span>";
					str+="</li>";
					$("#todayNews").append(str);
				});

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
				setmarkers(province);
				info();
				naver.maps.Event.addListener(map, 'zoom_changed', function(zoom) {
					if(zoom >= 3) {
						clearmarkers();
						setmarkers(sigungu);
					} else {
						clearmarkers();
						setmarkers(province);
					}
					info();
				});
				
			} else {
				console.log("Error: " + this.status);
			}
		}
	};
	xhttp.open("GET", "mainNews.do", true);
	xhttp.send();
}

function info() {
	for (var i=0; i<markers.length; i++) {
	    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
	}
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
			url : 'selectZone.do',
			type : 'GET',
			data : {
				name : marker.content
			},
			success : function(data) {
				console.log(data);
			},
			error : function(request, status, error) {
				console.log("Error");
				console.log("error code:" + request.status + "\n" + "message:"
						+ request.responseText + "\n" + "error:" + error);
			}
		});
	}
}