window.onload = function() {
  curTime();
  setInterval(curTime, 1000);
  todayNews();
//  searchGet(1);
  //	loadWordcloud();
}

function curTime() {
  const d = new Date();
  const days = ["일", "월", "화", "수", "목", "금", "토"];
  let localeDate = d.toLocaleDateString();
  let localeTime = d.toLocaleTimeString();
  let dateTime = localeDate.substr(0, localeDate.length - 1) + " (" + days[d.getDay()] + ") " + localeTime;
  document.getElementById("issue-analysis-time").innerHTML = dateTime;
}

function todayNews(e) {
  const xhttp = new XMLHttpRequest();
  xhttp.onreadystatechange = function() {
    if (this.readyState == 4) {
      if (this.status == 200) {
        const jsonObj = JSON.parse(this.responseText);
        const province = jsonObj.province;
        const sigungu = jsonObj.sigungu;
        const todayNews = jsonObj.todayNews;
        let source = $("#map-template").html();
        let template = Handlebars.compile(source);
        let item = template(jsonObj);
        $("#map-content").append(item);
        
		Handlebars.registerHelper('defaultImgUrl', function(url) {
			if(url == 0) {
				url = '/img/logo3.png';
			}
			return url;
		});
        source = $("#search-template").html();
        template = Handlebars.compile(source);
        item = template(jsonObj);
        $("#tb").append(item);
        
        let newsCount = todayNews.length;
        let text = '총' + newsCount + '개의 기사가 검색되었습니다.';
        $('#news-count').text(text);
        
        $("#zoneName").empty();
        if (e != 1) {
          showMap(province, sigungu);
        }
      } else {
        console.log("Error: " + this.status);
      }
    }
  }
  xhttp.open("GET", "/news/mainNews", true);
  xhttp.send();
}

function showNewsList(newsList) {
  $("#todayNews *").remove();
  $.each(newsList, function(idx, item) {
	  console.log(idx);
	  console.log(item);
//    let str = '<li class="main_title" onclick="readNews(' + idx + ')">';
//    str += "<span>";
//    str += item.title;
//    str += "</span>";
//    str += "</li>";
//    $("#todayNews").append(str);
  })
}

let markers = [], map;
function showMap(province, sigungu) {
  let mapDiv = document.getElementById("map");
  let mapOptions = {
  	useStyleMap: true,
    center: new naver.maps.LatLng(35.9, 127.2),
    zoom: 6,
    minZoom: 5,
    maxZoom: 12,
    logoControl: true,
    mapTypeControl: true,
    zoomControl: true,
    zoomControlOptions: {
      position: naver.maps.Position.TOP_RIGHT
    }
  }

  map = new naver.maps.Map(mapDiv, mapOptions);
  setMarkers(province, 1);
  markerInfo(markers);
  naver.maps.Event.addListener(map, "zoom_changed", function(zoom) {
    if (zoom >= 7) {
      clearMarkers(markers);
      setMarkers(sigungu, 0);
    } else {
      clearMarkers(markers);
      setMarkers(province, 1);
    }
    markerInfo(markers);
  });
}

function setMarkers(zoneName, chk_zone) {
  for (var key in zoneName) {
    let province_id = chk_zone == 1 ? zoneName[key].id : zoneName[key].province.id;
    let sigungu_id = chk_zone == 1 ? 0 : zoneName[key].id;
    let latitude = zoneName[key].latitude;
    let longitude = zoneName[key].longitude;
    let name = zoneName[key].name;
    markers.push(
      new naver.maps.Marker({
        position: new naver.maps.LatLng(latitude, longitude),
        map: map,
        content: {
          name: name,
          province_id: province_id,
          sigungu_id: sigungu_id
        }
      })
    );
  }
}

function markerInfo(markers) {
  for (let i = 0; i < markers.length; i++) naver.maps.Event.addListener(markers[i], "click", getClickHandler(i))
}

function clearMarkers(markers) {
  for (let i in markers) markers[i].setMap(null)
}

function getClickHandler(seq) {
  return function(e) {
    let marker = markers[seq];
    let content = marker.content;
    document.getElementById("zoneName").innerText = content.name;
    $.ajax({
      url: "selectZone",
      type: "GET",
      data: { p_code: content.p_code, s_code: content.s_code },
      success: function(data) {
        showNewsList(data.zoneNews)
      },
      error: function(request, status, error) {
        console.log("Error code:" + request.status + "\n" + "message:" + request.responseText + "\n" + "error:" + error)
      }
    });
  }
}
