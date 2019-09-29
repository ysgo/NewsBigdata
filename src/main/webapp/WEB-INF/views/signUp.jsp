<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
<link href="<c:url value='/resources/css/signUp.css' />" rel="stylesheet">
<script src="<c:url value='/resources/js/signUp.js' />"></script>
</head>
<body>
    <nav class="navbar navbar-default navbar-fixed-top" role="navigation">
        <hr class="colorgraph colorgraph-header">
        <div class="container">
            <div class="navbar-header">
                <button type="button" class="navbar-toggle" data-toggle="collapse" data-target="#main-navbar-collapse">
                    <span class="sr-only">Toggle navigation</span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                    <span class="icon-bar"></span>
                </button>
                <a class="navbar-brand" href="index.php">Elementary</a>
            </div>
            <div class="collapse navbar-collapse" id="main-navbar-collapse">
                <ul class="nav navbar-nav navbar-right">
                    <li>
                        <a href="#"><i class="glyphicon glyphicon-arrow-left"></i> Back to Home</a>
                    </li>
                </ul>
            </div>
        </div>
    </nav>

    <div class="container">

<div class="row">
    <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3">
    	<form name="fr" method="POST" action="signUp.do" onsubmit='return check()'>
			<h2>Please Sign Up <small>It's free and always will be.</small></h2>
			<hr class="colorgraph">
			
			<div class="form-group">
				<input type="text" name="userName" id="userName" class="form-control input-lg" placeholder="Username" tabindex="3">
				<span id="alert_userName"></span>
			</div>
			<div class="form-group">
				<input type="email" name="email" id="email" class="form-control input-lg" placeholder="Email Address" tabindex="4">
				<span id="alert_email"></span>
			</div>
			<div class="row">
				<div class="col-xs-12 col-sm-6 col-md-6">
					<div class="form-group">
						<input onkeyup='mykeyup()' type="password" name="password" id="password" class="form-control input-lg" placeholder="Password" tabindex="5">
						<span id="alert_password"></span>
					</div>
				</div>
				<div class="col-xs-12 col-sm-6 col-md-6">
					<div class="form-group">
						<input onkeyup='mykeyup()' type="password" name="re_password" id="password_confirmation" class="form-control input-lg" placeholder="Confirm Password" tabindex="6">
						<span id="alert_re_password"></span>
					</div>
				</div>
				    남성 <input type="radio" name="gender" value="male" class="gender" />
			             여성 <input type="radio" name="gender" value="female" class="gender" />
			     <span id="alert_gender"></span><br>
				GENERATION : 
				 10대 <input type="checkbox" name="generation" value="10" class="generation"/>
				 20대 <input type="checkbox" name="generation" value="20" class="generation"/>
				 30대 <input type="checkbox" name="generation" value="30" class="generation"/>
				 40대 <input type="checkbox" name="generation" value="40" class="generation"/>
				 50대 이상 <input type="checkbox" name="generation" value="50" class="generation" />
				 <span id="alert_generation"></span><br>
			</div>
			<div class="row">
				<div class="col-xs-4 col-sm-3 col-md-3">
					<span class="button-checkbox">
						<button type="button" class="btn" data-color="info" tabindex="7">I Agree</button>
                        <input type="checkbox" name="t_and_c" id="t_and_c" class="hidden" value="1">
					</span>
				</div>
				<div class="col-xs-8 col-sm-9 col-md-9">
					 By clicking <strong class="label label-primary">Register</strong>, you agree to the <a href="#" data-toggle="modal" data-target="#t_and_c_m">Terms and Conditions</a> set out by this site, including our Cookie Use.
				</div>
			</div>
			
			<hr class="colorgraph">
			<div class="row">
				<div class="col-xs-12 col-md-6"><input type="submit" value="Register" class="btn btn-primary btn-block btn-lg" tabindex="7"></div>
				<div class="col-xs-12 col-md-6"><a href="signIn.do" class="btn btn-success btn-block btn-lg">Sign In</a></div>
			</div>
		</form>
	</div>
</div>
<!-- Modal -->
<div class="modal fade" id="t_and_c_m" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	<div class="modal-dialog modal-lg">
		<div class="modal-content">
			<div class="modal-header">
				<button type="button" class="close" data-dismiss="modal" aria-hidden="true">×</button>
				<h4 class="modal-title" id="myModalLabel">Terms & Conditions</h4>
			</div>
			<!--<div class="modal-body">
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique, itaque, modi, aliquam nostrum at sapiente consequuntur natus odio reiciendis perferendis rem nisi tempore possimus ipsa porro delectus quidem dolorem ad.</p>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique, itaque, modi, aliquam nostrum at sapiente consequuntur natus odio reiciendis perferendis rem nisi tempore possimus ipsa porro delectus quidem dolorem ad.</p>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique, itaque, modi, aliquam nostrum at sapiente consequuntur natus odio reiciendis perferendis rem nisi tempore possimus ipsa porro delectus quidem dolorem ad.</p>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique, itaque, modi, aliquam nostrum at sapiente consequuntur natus odio reiciendis perferendis rem nisi tempore possimus ipsa porro delectus quidem dolorem ad.</p>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique, itaque, modi, aliquam nostrum at sapiente consequuntur natus odio reiciendis perferendis rem nisi tempore possimus ipsa porro delectus quidem dolorem ad.</p>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique, itaque, modi, aliquam nostrum at sapiente consequuntur natus odio reiciendis perferendis rem nisi tempore possimus ipsa porro delectus quidem dolorem ad.</p>
				<p>Lorem ipsum dolor sit amet, consectetur adipisicing elit. Similique, itaque, modi, aliquam nostrum at sapiente consequuntur natus odio reiciendis perferendis rem nisi tempore possimus ipsa porro delectus quidem dolorem ad.</p>
			</div>-->
			<div class="modal-footer">
				<button type="button" class="btn btn-primary" data-dismiss="modal">I Agree</button>
			</div>
		</div><!-- /.modal-content -->
	</div><!-- /.modal-dialog -->
</div><!-- /.modal -->
</div><!-- container ends-->
    <footer>
        <div class="container">
            <div class="row">
                <div class="col-xs-12 col-sm-8 col-md-6 col-sm-offset-2 col-md-offset-3 text-center">
                    <ul class="list-inline">
                        <li>
                            <a href="#"><i class="glyphicon glyphicon-home"></i> Home</a>
                        </li>
                        <li class="footer-menu-divider">⋅</li>
                        <li>
                            <a href="#"><i class="glyphicon glyphicon-bullhorn"></i> Notice Board</a>
                        </li>
                        <li class="footer-menu-divider">⋅</li>
                        <li>
                            <a href="#"><i class="glyphicon glyphicon-info-sign"></i> About</a>
                        </li>
                        <li class="footer-menu-divider">⋅</li>
                        <li>
                            <a href="#"><i class="glyphicon glyphicon-envelope"></i> Contact Us</a>
                        </li>
                    </ul>
                    <p class="copyright text-muted small">Designed by XeQt for IEM. Copyright © 2014. All Rights Reserved.</p>
                </div>
            </div>
        </div><!--container ends-->
    </footer>
    <hr class="colorgraph colorgraph-footer">
<script>
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
</script>
<%@ include file="common/footer.jsp" %>