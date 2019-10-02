function bodyFunction() {
	var d = new Date();
	var days = ['일', '월', '화', '수', '목', '금', '토'];
	var localeDate = d.toLocaleDateString();
	var localeTime = d.toLocaleTimeString();
	var dateTime = localeDate.substr(0, localeDate.length-1) + ' ('+days[d.getDay()]+') '+localeTime;
	document.getElementById("issue-analysis-time").innerHTML = dateTime;
}
//
//// 주소 -> 좌표 변환(geocode)
//naver.maps.Service.geocode({
//	query: '서울특별시'
//}, function(status, response) {
//	if (status !== naver.maps.Service.Status.OK) {
//		return console.log("변환 성공");
//	}
//	
//	var result = response.v2, // 검색 결과의 컨테이너
//	items = result.addresses; // 검색 결과의 배열
//	
//	// do Something
//});
//
//// 기본 지도 호출
//var map = new naver.maps.Map('map', {
//    center: new naver.maps.LatLng(37.3595704, 127.105399),
//    zoom: 10
//});
