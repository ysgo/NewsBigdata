<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!-- Navigation -->
<nav class="navbar navbar-expand-lg navbar-dark fixed-top" id="mainNav">
	<div class="container">
		<a class="navbar-brand js-scroll-trigger" href="#page-top"><img
			src="resources/img/logo1.png" style="width: 200px; height: 65px;"></a>

		<button class="navbar-toggler navbar-toggler-right" type="button"
			data-toggle="collapse" data-target="#navbarResponsive"
			aria-controls="navbarResponsive" aria-expanded="false"
			aria-label="Toggle navigation">
			Menu <i class="fas fa-bars"></i>
		</button>
		<div class="collapse navbar-collapse" id="navbarResponsive">
			<ul class="navbar-nav text-uppercase ml-auto">
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#issue-sec">ISSUE</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#news-sec">NEWS</a></li>
				<li class="nav-item"><a class="nav-link js-scroll-trigger"
					href="#keyword-sec">KEYWORD</a></li>
				<li class="nav-item" id="nav_myPage" style="display: block"><a
					class="nav-link js-scroll-trigger" onclick="openMypage()">MyPage</a></li>
				<li class="nav-item" id="nav_logout" style="display: block"><a
					class="nav-link js-scroll-trigger" onclick="signOut()">Logout</a></li>
				<li class="nav-item" id="nav_user"
					style="display: block; position: relative;"><a id="user"
					class="nav-link js-scroll-trigger" style="display: block;"></a>
				<li class="nav-item" id="nav_signup" style="display: block"><a
					class="nav-link js-scroll-trigger" onclick="signup()">SignUp</a></li>
				<li class="nav-item" id="nav_login" style="display: block"><a
					class="nav-link js-scroll-trigger" onclick="openLogin()">Login</a></li>
			</ul>
		</div>
	</div>
</nav>

<!-- Header -->
<header class="masthead">
	<div class="container">
		<div class="intro-text"></div>
	</div>
</header>