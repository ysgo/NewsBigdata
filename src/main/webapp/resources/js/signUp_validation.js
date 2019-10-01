//회원가입 유효성 검사 등
function mykeyup() {
	var updatePass = document.getElementById('password').value;
	var checkPass = document.getElementById('password_confirmation').value;
	if(updatePass == checkPass) {
		document.getElementById('update_submit').disabled = false;
	} else {
		document.getElementById('update_submit').disabled = true;
	}
};

function checkVal(e) {
	if(fr.e.value == "") {
		var name = 'alert_'+e;
		document.getElementById(name).innerHTML="값을 입력해주세요.";
	}
};

function check() {
	if(fr.password.value != fr.re_password.value) {
		cosole.log(fr.password.value);
		cosole.log(fr.re_password.value);
	    document.getElementById('alert_re_password').innerHTML="비밀번호 다릅니다.";
	    fr.re_password.focus();
	    return false;
	  } else return true;
};   