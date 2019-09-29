<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%@ include file="common/header.jsp" %>
<%-- <link href="<c:url value='/resources/css/myPage.css' />" rel="stylesheet"> --%>
<link href="${pageContext.request.contextPath}/resources/css/myPage.css" rel="stylesheet">
<script src="<c:url value='/resources/js/myPage.js' />"></script>
</head>
<body> 
	<div class="container">
		<div class="row">
			<div class="col-md-5  toppad  pull-right col-md-offset-3 ">
				<A href="edit.html">Edit Profile</A> <A href="signOut.do">Logout</A>
				<br>
				<p class=" text-info">May 05,2014,03:00 pm</p>
			</div>
			<div
				class="col-xs-12 col-sm-12 col-md-6 col-lg-6 col-xs-offset-0 col-sm-offset-0 col-md-offset-3 col-lg-offset-3 toppad">


				<div class="panel panel-info">
					<div class="panel-heading">
						<h3 class="panel-title">Show Your Information</h3>
					</div>
					<div class="panel-body" id="my_info" style="display: block;">
						<div class="row">
							<div class="col-md-3 col-lg-3 " align="center">
								<img alt="User Picture"
									src="https://coresos-phinf.pstatic.net/a/2ii809/g_8e9Ud018svc1nkpxtmwyqy38_b58e9f.jpg?type=cover_a264"
									class="img-circle img-responsive">
							</div>
							<div class=" col-md-9 col-lg-9 ">
									<table class="table table-user-information">
										<tbody>
											<tr>
												<td>UserName</td>
												<td>${ status.userName }</td>
											</tr>
											<tr>
												<td>Email</td>
												<td>${ status.email }</td>
											</tr>
											<tr>
												<td>Gender</td>
												<td>${ status.gender }</td>
											</tr>

											<tr>
											<tr>
												<td>Generation</td>
												<td>${ status.generation }대</td>
											</tr>
											<tr>
												<td>Created Date</td>
												<td>${ status.created_at }</td>
											</tr>
										</tbody>
									</table> 
								<div>
		
		
								<!-- 처음 정보수정 누를시 뜨는 비밀번호 재확인 창 -->
								</div>
							</div> 
						</div>
					</div>
					<div id="update_info" style="display: none;">
			<fieldset>
			<form action="updatePass.do" method="post">
			<legend>비밀번호 수정</legend>
			<table>
			<tr>
					<td>아이디</td>
					<td>${status.email}</td>
				</tr>
				<tr>
					<td>기존 비밀번호 입력<br>새 비밀번호 입력<br>새 비밀번호 확인
					</td>
					<td><input type="password" id="oldpw" name="password"><br>
					<input type="password" id="pw1" name="update_password" onkeyup='mykeyup()'><br>
					<input type="password" id="pw2" name="checked_password" onkeyup='mykeyup()'></td>
				</tr>
			</table>
			<input id="update_submit" type="submit" value="수정" disabled="disabled">
			</form>
		</fieldset>
		
		<fieldset><form action="myPage.do" method="post">
		<input type="hidden" name="action" value="updatepm">
		<br><br>
		<table>
			<tr>
					<td>닉네임</td>
					<td><input type="tel" id="userName" name="userName"
					value="${status.userName}"></td>
				</tr>
			</table>
				<input type="submit" value="수정" class="btn btn-dark">
			</form>
		</fieldset>
		</div>
					<div style="display: none;" id="confirm">
						<form action="withdrawal.do" method="post">
							<a>탈퇴를 진행하기 위해 재확인 하겠습니다</a><br>
							<div>아이디 : ${status.email}</div>
							<input type="password" name="password">
							<input type="submit" id="submit" value="확인" class="btn btn-dark">
						</form>
					</div>
					<div class="panel-footer">
						<a data-original-title="Broadcast Message" data-toggle="tooltip"
							type="button" class="btn btn-sm btn-primary"><i
							class="glyphicon glyphicon-envelope"></i></a> <span
							class="pull-right"> <a href="edit.html"
							data-original-title="Edit this user" data-toggle="tooltip"
							type="button" class="btn btn-sm btn-warning"><i
								class="glyphicon glyphicon-edit"></i></a> <a href="home.do"
							data-original-title="Remove this user" data-toggle="tooltip"
							type="button" class="btn btn-sm btn-danger"><i
								class="glyphicon glyphicon-remove"></i></a>
						</span>
								<a href="#" class="btn btn-primary" id="btn_my_info">내 정보</a>
								<a href="#" class="btn btn-primary" id="btn_update_info">회원 정보 수정</a>
								<a href="#" class="btn btn-primary" id="btn_withdrawal">회원 탈퇴</a>
					</div>
				</div>
			</div>
		</div>
	</div>
<script>
$('#btn_my_info').click(function() {
	$('#my_info').css('display','block');
	$('#update_info').css('display','none');
	$('#confirm').css('display','none');
})
$('#btn_update_info').click(function() {
	$('#my_info').css('display','none');
	$('#update_info').css('display','block');
	$('#confirm').css('display','none');
})
$('#btn_withdrawal').click(function() {
	$('#my_info').css('display','none');
	$('#update_info').css('display','none');
	$('#confirm').css('display','block');
})

function mykeyup() {
	var updatePass = document.getElementById('pw1').value;
	var checkPass = document.getElementById('pw2').value;
	if(updatePass == checkPass) {
		document.getElementById('update_submit').disabled = false;
	} else {
		document.getElementById('update_submit').disabled = true;
	}
}
</script>
<%@ include file="common/footer.jsp" %>