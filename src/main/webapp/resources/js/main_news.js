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

function setMarker(zoneName, map, marker) {
	for (var key in zoneName) {
		var lat = zoneName[key].latitude;
		var lng = zoneName[key].longitude;

		marker.push(new naver.maps.Marker({
			position : new naver.maps.LatLng(lat, lng),
			map : map
		// animation: naver.maps.Animation.BOUNCE
		}))
	}
}

function clearMarker(marker) {
	for(var i in marker) {
		marker[i].setMap(null);
	}
}
 
window.onload = function() {
	curTime();
	setInterval(curTime, 1000);

	// Province&Sigungu Map's Display
	var xhttp = new XMLHttpRequest();
	xhttp.onreadystatechange = function() {
		if (this.readyState == 4) {
			if (this.status == 200) {
				var jsonObj = JSON.parse(this.responseText);
				var province = jsonObj.province;
				var sigungu = jsonObj.sigungu;

				// province, sigungu를 key로 반복
				var mapDiv = document.getElementById('mapList');
				var mapOptions = {
					center : new naver.maps.LatLng(35.9, 127.2),
					zoom : 2,
					minZoom : 1,
					maxZoom : 7,
					scaleControl : true,
					logoControl : true,
					mapTypeControl : true,
					zoomControl : true,
					zoomControlOptions : {
						position : naver.maps.Position.TOP_RIGHT
					}
				};
				var map = new naver.maps.Map(mapDiv, mapOptions);
				var marker = [];
				setMarker(province, map, marker);
				naver.maps.Event.addListener(map, 'zoom_changed', function(zoom) {
					if(zoom >= 3) {
						clearMarker(marker);
						setMarker(sigungu, map, marker);
					} else {
						clearMarker(marker);
						setMarker(province, map, marker);
					}
				});
			} else {
				console.log("Error: " + this.status);
			}
		}
	};
	xhttp.open("GET", "mainMap.do", true);
	xhttp.send();
}
