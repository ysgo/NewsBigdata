<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<!-- Login modal -->
<div id="login" class="modal printable" style="display: none;">
	<div
		style="z-index: 1; position: fixed; top: 15%; left: 30%; right: 30%; background-color: white;">
		<div id="modal-login">
			<button type="button" onclick="closeLogin()" class="close"
				data-dismiss="modal" aria-label="Close">
				<span aria-hidden="true">×</span>
			</button>
			<div class="login-form">
				<form class="form" method="POST" id="signIn_Form">
					<h2>Login</h2>
					<hr>
					<div class="form-group">
						<input type="email" name="email" id="email"
							class="form-control input-lg" placeholder="이메일">
					</div>
					<div class="form-group">
						<input type="password" name="password" id="password"
							class="form-control input-lg" placeholder="비밀번호">
					</div>
					<div style="width: 100%; text-align: center;">
						<input type="submit" value="로그인" id="login-btn"
							onclick="submitSignIn(); return false;"><br> 아직 회원이
						아니신가요? <a href="" onclick="signup();closeLogin();return false;">회원가입</a>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>