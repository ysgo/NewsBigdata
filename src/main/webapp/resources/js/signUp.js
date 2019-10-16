function submitSignUp() {
	var userName = $('#userName').val();
	var email = $('#email').val();
	var password = $('#password').val();
	var gender = $('input[type=radio][name=gender]:checked').val();
	var generation = $('input:radio[class="generation"]:checked').val();
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
			if(data.result == 1) {
				console.log("가입 성공");
				closeSignup();
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
