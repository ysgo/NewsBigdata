function bodyFunction() {
	var d = new Date();
	var days = ['일', '월', '화', '수', '목', '금', '토'];
	var localeDate = d.toLocaleDateString();
	var localeTime = d.toLocaleTimeString();
	var dateTime = localeDate.substr(0, localeDate.length-1) + ' ('+days[d.getDay()]+') '+localeTime;
	document.getElementById("issue-analysis-time").innerHTML = dateTime;
}

// Map in Province&Sigungu Load
window.onload = function() {
	 var xhttp = new XMLHttpRequest();
	  xhttp.onreadystatechange = function() {
		  if(this.readyState == 4) {
			  if(this.status == 200) {
				  var jsonObj = JSON.parse(this.responseText);
				  console.log("Response: " + jsonObj);
			  
				  // Map marker indicate
				  $(jsonObj).each(function(){
					  var x = this;
					  console.log(x);
	                }); 
			  } else {
				  console.log("Error: " + this.status);
			  }
		  }
	  };
	  xhttp.open("GET", "mainMap.do", true);
	  xhttp.send(); 
}

var mapOptions = {
    center: new naver.maps.LatLng(37.3595704, 127.105399),
    zoom: 10
};