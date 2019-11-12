function submitSignUp() {
	var userName = $('#signUp_Form [name="userName"]').val();
	var email = $('#signUp_Form [name="email"]').val();
	var password = $('#signUp_Form [name="password"]').val();
	var gender = $('#signUp_Form [type=checkbox][name=gender]:checked').val();
	var generation = $('#signUp_Form [type=checkbox][name=generation]:checked').val();
	var memberInfo = {"userName" : userName,
				"email" : email,
				"password" : password,
				"gender" : gender,
				"generation" : generation};
	$.ajax({
		url : "signUp",
		type : "POST",
		data : memberInfo,
		success : function(data) {
			console.log(data);
			if(data == 1) {
				console.log("가입 성공");
				location.reload();
			} else {
				console.log("가입 실패");
				$('#signUp_Form')[0].reset();
			}
		},
		error : function(request, status, error) {
			console.log("Error");
			console.log("error code:" + request.status + "\n" + "message:"
					+ request.responseText + "\n" + "error:" + error);
		}
	});
}

function signup() {
	document.getElementById("signup").style.display="block";
	$('html, page-section').css({
		'overflow-x' : 'hidden',
		'overflow-y' : 'hidden'
	});
}

// Modal Close Button
function closeSignup() {
	document.getElementById("signup").style.display="none";	
	$('html, body').css({
		'overflow-x' : 'hidden',
		'overflow-y' : 'auto'
	});
}
