<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!-- Signup Modal -->
	<div id="signup" class="modal printable"
		style="display: none;">
		<div
			style="z-index: 1; position: fixed; top: 10%; left: 20%; right: 20%; background-color: white;">
			<div id="modal-signup">
				<button type="button" onclick="closeSignup()" class="close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<div class = "signup-form">
					<form class="form" method="POST" action=""
						onsubmit='return check()'>
						<h2>SIGN UP</h2>
						<hr>
						<div>
							<div class="form-group">
								이름
								<input type="text" name="userName" id="userName"
									class="form-control input-lg" placeholder="이름을 입력하세요."
									tabindex="3"> <span id="alert_userName"></span>
							</div>

							<div class="form-group">
								이메일
								<input type="email" name="email" id="email"
									class="form-control input-lg" placeholder="이메일을 입력하세요."
									tabindex="4"> <span id="alert_email"></span>
							</div>

							<div class="form-group">
								비밀번호
								<input onkeyup='mykeyup()' type="password" name="password"
									id="password" class="form-control input-lg"
									placeholder="비밀번호를 입력하세요." tabindex="5"> <span
									id="alert_password"></span>
							</div>

							<div class="form-group">
								비밀번호 확인
								<input onkeyup='mykeyup()' type="password" name="re_password"
									id="password_confirmation" class="form-control input-lg"
									placeholder="비밀번호를 한 번 더 입력하세요." tabindex="6"> <span
									id="alert_re_password"></span>
							</div>
						</div>
						남성 <input type="checkbox" name="gender" value="male" class="gender" />
						여성 <input type="checkbox" name="gender" value="female" class="gender" />
						<br>
						<span id="alert_gender"></span><br> GENERATION : 10대 <input
							type="checkbox" name="generation" value="10" class="generation" />
						20대 <input type="checkbox" name="generation" value="20"
							class="generation" /> 30대 <input type="checkbox"
							name="generation" value="30" class="generation" /> 40대 <input
							type="checkbox" name="generation" value="40" class="generation" />
						50대 이상 <input type="checkbox" name="generation" value="50"
							class="generation" /> <span id="alert_generation"></span><br>
						<div style="height:30px;"></div>
						<div>
							<div style= "width: 100%; text-align: center;">
								<input type="submit" value="회원가입" id="register-btn"><br>
								이미 회원이신가요? <a href="signIn.do" id="su-login-btn">로그인</a>
							</div>
						</div>
						
					</form>
				</div>
			</div>
		</div>
	</div>


<!-- Login modal -->
<div id="login" class="modal printable" style="display: none;">
		<div style="z-index: 1; position: fixed; top: 15%; left: 30%; right: 30%; background-color: white;">
			<div id="modal-login">
				<button type="button" onclick="closeLogin()" class="close"
					data-dismiss="modal" aria-label="Close">
					<span aria-hidden="true">×</span>
				</button>
				<div class="login-form">
					<form class="form" action="signIn.do" method="POST">
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
							<input type="submit" value="로그인" id="login-btn"><br>
							아직 회원이 아니신가요? <a href="">회원가입</a>
						</div>
					</form>
				</div>
			</div>
		</div>
	</div>