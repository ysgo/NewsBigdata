// 기본 지도 호출
var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 10
});

var marker = new naver.maps.Marker({
    position: new naver.maps.LatLng(37.3595704, 127.105399),
    map: map
});

naver.maps.Event.addListener(map, 'click', function(e) {
    marker.setPosition(e.latlng);
});

// 좌표검색 API 호출
naver.maps.Service.geocode({
    query: '불정로 6'
}, function(status, response) {
    if (status !== naver.maps.Service.Status.OK) {
        return alert('Something wrong!');
    }

    var result = response.v2, // 검색 결과의 컨테이너
        items = result.addresses; // 검색 결과의 배열

    // do Something
});

// 주소 검색 API 호출
naver.maps.Service.reverseGeocode({
        coords: new naver.maps.LatLng(37.3595316, 127.1052133),
    }, function(status, response) {
        if (status !== naver.maps.Service.Status.OK) {
            return alert('Something wrong!');
        }

        var result = response.v2, // 검색 결과의 컨테이너
            items = result.results; // 검색 결과의 배열

        // do Something
    });
    
// 다수의 마커에 이벤트 핸들러 등록하기
var HOME_PATH = window.HOME_PATH || '.';
var MARKER_SPRITE_X_OFFSET = 29,
    MARKER_SPRITE_Y_OFFSET = 50,
    MARKER_SPRITE_POSITION = {
        "A0": [0, 0],
        "B0": [MARKER_SPRITE_X_OFFSET, 0],
        "C0": [MARKER_SPRITE_X_OFFSET*2, 0],
        "D0": [MARKER_SPRITE_X_OFFSET*3, 0],
        "E0": [MARKER_SPRITE_X_OFFSET*4, 0],
        "F0": [MARKER_SPRITE_X_OFFSET*5, 0],
        "G0": [MARKER_SPRITE_X_OFFSET*6, 0],
        "H0": [MARKER_SPRITE_X_OFFSET*7, 0],
        "I0": [MARKER_SPRITE_X_OFFSET*8, 0],

        "A1": [0, MARKER_SPRITE_Y_OFFSET],
        "B1": [MARKER_SPRITE_X_OFFSET, MARKER_SPRITE_Y_OFFSET],
        "C1": [MARKER_SPRITE_X_OFFSET*2, MARKER_SPRITE_Y_OFFSET],
        "D1": [MARKER_SPRITE_X_OFFSET*3, MARKER_SPRITE_Y_OFFSET],
        "E1": [MARKER_SPRITE_X_OFFSET*4, MARKER_SPRITE_Y_OFFSET],
        "F1": [MARKER_SPRITE_X_OFFSET*5, MARKER_SPRITE_Y_OFFSET],
        "G1": [MARKER_SPRITE_X_OFFSET*6, MARKER_SPRITE_Y_OFFSET],
        "H1": [MARKER_SPRITE_X_OFFSET*7, MARKER_SPRITE_Y_OFFSET],
        "I1": [MARKER_SPRITE_X_OFFSET*8, MARKER_SPRITE_Y_OFFSET],

        "A2": [0, MARKER_SPRITE_Y_OFFSET*2],
        "B2": [MARKER_SPRITE_X_OFFSET, MARKER_SPRITE_Y_OFFSET*2],
        "C2": [MARKER_SPRITE_X_OFFSET*2, MARKER_SPRITE_Y_OFFSET*2],
        "D2": [MARKER_SPRITE_X_OFFSET*3, MARKER_SPRITE_Y_OFFSET*2],
        "E2": [MARKER_SPRITE_X_OFFSET*4, MARKER_SPRITE_Y_OFFSET*2],
        "F2": [MARKER_SPRITE_X_OFFSET*5, MARKER_SPRITE_Y_OFFSET*2],
        "G2": [MARKER_SPRITE_X_OFFSET*6, MARKER_SPRITE_Y_OFFSET*2],
        "H2": [MARKER_SPRITE_X_OFFSET*7, MARKER_SPRITE_Y_OFFSET*2],
        "I2": [MARKER_SPRITE_X_OFFSET*8, MARKER_SPRITE_Y_OFFSET*2]
    };

var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 10
});

var bounds = map.getBounds(),
    southWest = bounds.getSW(),
    northEast = bounds.getNE(),
    lngSpan = northEast.lng() - southWest.lng(),
    latSpan = northEast.lat() - southWest.lat();

var markers = [],
    infoWindows = [];

for (var key in MARKER_SPRITE_POSITION) {

    var position = new naver.maps.LatLng(
        southWest.lat() + latSpan * Math.random(),
        southWest.lng() + lngSpan * Math.random());

    var marker = new naver.maps.Marker({
        map: map,
        position: position,
        title: key,
        icon: {
            url: HOME_PATH +'/img/example/sp_pins_spot_v3.png',
            size: new naver.maps.Size(24, 37),
            anchor: new naver.maps.Point(12, 37),
            origin: new naver.maps.Point(MARKER_SPRITE_POSITION[key][0], MARKER_SPRITE_POSITION[key][1])
        },
        zIndex: 100
    });

    var infoWindow = new naver.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:10px;">The Letter is <b>"'+ key.substr(0, 1) +'"</b>.</div>'
    });

    markers.push(marker);
    infoWindows.push(infoWindow);
};

naver.maps.Event.addListener(map, 'idle', function() {
    updateMarkers(map, markers);
});

function updateMarkers(map, markers) {

    var mapBounds = map.getBounds();
    var marker, position;

    for (var i = 0; i < markers.length; i++) {

        marker = markers[i]
        position = marker.getPosition();

        if (mapBounds.hasLatLng(position)) {
            showMarker(map, marker);
        } else {
            hideMarker(map, marker);
        }
    }
}

function showMarker(map, marker) {

    if (marker.setMap()) return;
    marker.setMap(map);
}

function hideMarker(map, marker) {

    if (!marker.setMap()) return;
    marker.setMap(null);
}

// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
var HOME_PATH = window.HOME_PATH || '.';
var MARKER_SPRITE_X_OFFSET = 29,
    MARKER_SPRITE_Y_OFFSET = 50,
    MARKER_SPRITE_POSITION = {
        "A0": [0, 0],
        "B0": [MARKER_SPRITE_X_OFFSET, 0],
        "C0": [MARKER_SPRITE_X_OFFSET*2, 0],
        "D0": [MARKER_SPRITE_X_OFFSET*3, 0],
        "E0": [MARKER_SPRITE_X_OFFSET*4, 0],
        "F0": [MARKER_SPRITE_X_OFFSET*5, 0],
        "G0": [MARKER_SPRITE_X_OFFSET*6, 0],
        "H0": [MARKER_SPRITE_X_OFFSET*7, 0],
        "I0": [MARKER_SPRITE_X_OFFSET*8, 0],

        "A1": [0, MARKER_SPRITE_Y_OFFSET],
        "B1": [MARKER_SPRITE_X_OFFSET, MARKER_SPRITE_Y_OFFSET],
        "C1": [MARKER_SPRITE_X_OFFSET*2, MARKER_SPRITE_Y_OFFSET],
        "D1": [MARKER_SPRITE_X_OFFSET*3, MARKER_SPRITE_Y_OFFSET],
        "E1": [MARKER_SPRITE_X_OFFSET*4, MARKER_SPRITE_Y_OFFSET],
        "F1": [MARKER_SPRITE_X_OFFSET*5, MARKER_SPRITE_Y_OFFSET],
        "G1": [MARKER_SPRITE_X_OFFSET*6, MARKER_SPRITE_Y_OFFSET],
        "H1": [MARKER_SPRITE_X_OFFSET*7, MARKER_SPRITE_Y_OFFSET],
        "I1": [MARKER_SPRITE_X_OFFSET*8, MARKER_SPRITE_Y_OFFSET],

        "A2": [0, MARKER_SPRITE_Y_OFFSET*2],
        "B2": [MARKER_SPRITE_X_OFFSET, MARKER_SPRITE_Y_OFFSET*2],
        "C2": [MARKER_SPRITE_X_OFFSET*2, MARKER_SPRITE_Y_OFFSET*2],
        "D2": [MARKER_SPRITE_X_OFFSET*3, MARKER_SPRITE_Y_OFFSET*2],
        "E2": [MARKER_SPRITE_X_OFFSET*4, MARKER_SPRITE_Y_OFFSET*2],
        "F2": [MARKER_SPRITE_X_OFFSET*5, MARKER_SPRITE_Y_OFFSET*2],
        "G2": [MARKER_SPRITE_X_OFFSET*6, MARKER_SPRITE_Y_OFFSET*2],
        "H2": [MARKER_SPRITE_X_OFFSET*7, MARKER_SPRITE_Y_OFFSET*2],
        "I2": [MARKER_SPRITE_X_OFFSET*8, MARKER_SPRITE_Y_OFFSET*2]
    };

var map = new naver.maps.Map('map', {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 10
});

var bounds = map.getBounds(),
    southWest = bounds.getSW(),
    northEast = bounds.getNE(),
    lngSpan = northEast.lng() - southWest.lng(),
    latSpan = northEast.lat() - southWest.lat();

var markers = [],
    infoWindows = [];

for (var key in MARKER_SPRITE_POSITION) {

    var position = new naver.maps.LatLng(
        southWest.lat() + latSpan * Math.random(),
        southWest.lng() + lngSpan * Math.random());

    var marker = new naver.maps.Marker({
        map: map,
        position: position,
        title: key,
        icon: {
            url: HOME_PATH +'/img/example/sp_pins_spot_v3.png',
            size: new naver.maps.Size(24, 37),
            anchor: new naver.maps.Point(12, 37),
            origin: new naver.maps.Point(MARKER_SPRITE_POSITION[key][0], MARKER_SPRITE_POSITION[key][1])
        },
        zIndex: 100
    });

    var infoWindow = new naver.maps.InfoWindow({
        content: '<div style="width:150px;text-align:center;padding:10px;">The Letter is <b>"'+ key.substr(0, 1) +'"</b>.</div>'
    });

    markers.push(marker);
    infoWindows.push(infoWindow);
};

naver.maps.Event.addListener(map, 'idle', function() {
    updateMarkers(map, markers);
});

function updateMarkers(map, markers) {

    var mapBounds = map.getBounds();
    var marker, position;

    for (var i = 0; i < markers.length; i++) {

        marker = markers[i]
        position = marker.getPosition();

        if (mapBounds.hasLatLng(position)) {
            showMarker(map, marker);
        } else {
            hideMarker(map, marker);
        }
    }
}

function showMarker(map, marker) {

    if (marker.setMap()) return;
    marker.setMap(map);
}

function hideMarker(map, marker) {

    if (!marker.setMap()) return;
    marker.setMap(null);
}

	// 해당 마커의 인덱스를 seq라는 클로저 변수로 저장하는 이벤트 핸들러를 반환합니다.
function getClickHandler(seq) {
    return function(e) {
        var marker = markers[seq],
            infoWindow = infoWindows[seq];

        if (infoWindow.getMap()) {
            infoWindow.close();
        } else {
            infoWindow.open(map, marker);
        }
    }
}

for (var i=0, ii=markers.length; i<ii; i++) {
    naver.maps.Event.addListener(markers[i], 'click', getClickHandler(i));
}