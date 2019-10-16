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

