function submitSignIn() {
	var email = $('#email').val();
	var password = $('#password').val();
	var loginInfo = { "email" : email, "password" : password };
	$.ajax({
		url : "signIn",
		type : "POST",
		data : loginInfo,
		success : function(data) {
			console.log(data);
			if(data.result == 1) {
				console.log("로그인 성공");
				closeLogin();
			} else {
				console.log("로그인 실패");
				$('#signIn_Form')[0].reset();
			}
		},
		error : function(request, status, error) {
			console.log("Error");
			console.log("error code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}

function openLogin() {
	document.getElementById("login").style.display="block";
	$('html, page-section').css({
		'overflow-x' : 'hidden',
		'overflow-y' : 'hidden'
	});
}

// Modal Close Button
function closeLogin() {
	document.getElementById("login").style.display="none";	
	$('html, body').css({
		'overflow-x' : 'hidden',
		'overflow-y' : 'auto'
	});
}