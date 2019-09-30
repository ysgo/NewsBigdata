function mykeyup() {
	var updatePass = document.getElementById('pw1').value;
	var checkPass = document.getElementById('pw2').value;
	if(updatePass == checkPass) {
		document.getElementById('update_submit').disabled = false;
	} else {
		document.getElementById('update_submit').disabled = true;
	}
}

var btn_myinfo = document.getElementById('btn_my_info');
var btn_update = document.getElementById('btn_update_info');
var btn_withdrawal = document.getElementById('btn_withdrawal');

var myinfo = document.getElementById('my_info');
var updateinfo = document.getElementById('update_info');
var confirm = document.getElementById('confirm');

btn_myinfo.onclick = function() {
	myinfo.style.display = 'block';
	updateinfo.style.display = 'none';
	confirm.style.display = 'none';
}

btn_update.onclick = function() {
	myinfo.style.display = 'none';
	updateinfo.style.display = 'block';
	confirm.style.display = 'none';
}

btn_withdrawal.onclick = function() {
	myinfo.style.display = 'none';
	updateinfo.style.display = 'none';
	confirm.style.display = 'block';
}
