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
			if(data.result == 1) {
				closeLogin();
				$('#nav_signup').hide();
				$('#nav_login').hide();
				$('#nav_myPage').show();
				$('#nav_logout').show();
				$('#nav_user').show();
				document.getElementById('user').innerText=data.memberInfo.userName;
			} else {
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

function signOut() {
	$.ajax({
		url : "signOut",
		type : "POST",
		success : function(data) {
			if(data== 1) {
				console.log("로그아웃 성공");
				document.getElementById('signIn_Form').reset();
				$('#nav_myPage').hide();
				$('#nav_logout').hide();
				$('#nav_user').hide();
				$('#nav_signup').show();
				$('#nav_login').show();
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