<%@ page language="java" contentType="text/html; charset=utf-8"
	pageEncoding="utf-8"%>

<!--
	Prologue by HTML5 UP
	html5up.net | @ajlkn
	Free for personal and commercial use under the CCA 3.0 license (html5up.net/license)
-->
<html>
<head>
<title>Prologue by HTML5 UP</title>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no" />
<link rel="stylesheet" href="resources/assets/css/main.css" />
</head>
<body class="is-preload">

	<!-- Header -->
	<div id="header">

		<div class="top">

			<!-- Logo -->
			<div id="logo">
				<span class="image avatar48"><img
					src="resources/images/avatar.jpg" alt="" /></span>
				<h1 id="title">User Name</h1>
				<p></p>
			</div>

			<!-- Nav -->
			<nav id="nav">
				<ul>
					<li><a href="#top" id="top-link"><span
							class="icon solid fa-home">Intro</span></a></li>
					<li><a href="#news" id="portfolio-link"><span
							class="icon solid fa-newspaper">News</span></a></li>
					<li><a href="#visualization" id="about-link"><span
							class="icon solid fa-chart-area">Visualization</span></a></li>
					<li><a href="#analytics" id="contact-link"><span
							class="icon solid fa-chart-bar">Analytics</span></a></li>
				</ul>
			</nav>

		</div>
	</div>

	<!-- Main -->
	<div id="main">

		<!-- Intro -->
		<section id="top" class="one dark cover">
			<div class="container">

				<header>
					<h2 class="alt">
						<strong>Bigdata News Platform</strong>
					</h2>
					<p>
						Ligula scelerisque justo sem accumsan diam quis<br /> vitae
						natoque dictum sollicitudin elementum.
					</p>
				</header>

				<footer>
					<button id="signUpBtn">Sign Up</button>
				</footer>

			</div>
		</section>



		<!-- Portfolio -->
		<section id="news" class="two">
			<div class="container">

				<header>
					<h2>Portfolio</h2>
				</header>

				<p>Vitae natoque dictum etiam semper magnis enim feugiat
					convallis convallis egestas rhoncus ridiculus in quis risus amet
					curabitur tempor orci penatibus. Tellus erat mauris ipsum fermentum
					etiam vivamus eget. Nunc nibh morbi quis fusce hendrerit lacus
					ridiculus.</p>


			</div>
		</section>

		<!-- About Me -->
		<section id="visualization" class="three">
			<div class="container">

				<header>
					<h2>About Me</h2>
				</header>

				<a href="#" class="image featured"><img
					src="resources/images/pic08.jpg" alt="" /></a>

				<p>Tincidunt eu elit diam magnis pretium accumsan etiam id urna.
					Ridiculus ultricies curae quis et rhoncus velit. Lobortis elementum
					aliquet nec vitae laoreet eget cubilia quam non etiam odio
					tincidunt montes. Elementum sem parturient nulla quam placerat
					viverra mauris non cum elit tempus ullamcorper dolor. Libero rutrum
					ut lacinia donec curae mus vel quisque sociis nec ornare iaculis.</p>

			</div>
		</section>

		<!-- Contact -->
		<section id="analytics" class="four">
			<div class="container">

				<header>
					<h2>Contact</h2>
				</header>

				<p>Elementum sem parturient nulla quam placerat viverra mauris
					non cum elit tempus ullamcorper dolor. Libero rutrum ut lacinia
					donec curae mus. Eleifend id porttitor ac ultricies lobortis sem
					nunc orci ridiculus faucibus a consectetur. Porttitor curae mauris
					urna mi dolor.</p>

				<form method="post" action="#">
					<div class="row">
						<div class="col-6 col-12-mobile">
							<input type="text" name="name" placeholder="Name" />
						</div>
						<div class="col-6 col-12-mobile">
							<input type="text" name="email" placeholder="Email" />
						</div>
						<div class="col-12">
							<textarea name="message" placeholder="Message"></textarea>
						</div>
						<div class="col-12">
							<input type="submit" value="Send Message" />
						</div>
					</div>
				</form>

			</div>
		</section>

	</div>

	<!-- Footer -->
	<div id="footer">

		<!-- Copyright -->
		<ul class="copyright">
			<li>&copy; bigdataNews. All rights reserved.</li>
			<li>footer</li>
		</ul>

	</div>

	<!-- modal -->
	<!-- Sign Up -->

	<div id="signup" class="modal">
		<!-- <div class="modal-content-signup"> -->
			<span class="close">&times;</span>
			<h2 class="major">Sign Up</h2>
			<form method="post" action="signUp.do">
				<ul>
					<li><input type="submit" value="Regisger" /></li>
					<li><a href ="signIn.do"><input type="button" value="Sign In" /></a></li>
				</ul>
			</form>
		<!-- </div> -->
	</div>




	<!-- Login -->






	<!-- Scripts -->
	<script src="resources/assets/js/jquery.min.js"></script>
	<script src="resources/assets/js/jquery.scrolly.min.js"></script>
	<script src="resources/assets/js/jquery.scrollex.min.js"></script>
	<script src="resources/assets/js/browser.min.js"></script>
	<script src="resources/assets/js/breakpoints.min.js"></script>
	<script src="resources/assets/js/util.js"></script>
	<script src="resources/assets/js/main.js"></script>
	<script src="resources/assets/js/modal.js"></script>
</body>
</html>

