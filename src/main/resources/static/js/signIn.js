function submitSignIn() {
	var email = $('#signIn_Form [name="email"]').val();
	var password = $('#signIn_Form [name="password"]').val();
	var loginInfo = { "email" : email, "password" : password };
	$.ajax({
		url : "signIn",
		type : "POST",
		data : loginInfo,
		success : function(data) {
			console.log(data);
			if(data == 1) {
				location.reload();
			} else {
				$('#signIn_Form')[0].reset();
			}
		},
		error : function(request, status, error) {
			console.log("Error");
			console.log("error code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	})
}

function signOut() {
	$.ajax({
		url : "signOut",
		type : "POST",
		success : function() {
			if(data== 1) {
				location.reload();
				console.log("로그아웃 성공");
				document.getElementById('signIn_Form').reset();
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