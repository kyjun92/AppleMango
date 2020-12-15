<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String user_id = (String) session.getAttribute("id");	
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>AppleMango</title>
<!-- Favicon-->
<link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
<!-- Font Awesome icons (free version)-->
<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"
	crossorigin="anonymous"></script>
<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
<!-- Core theme CSS (includes Bootstrap)-->
<link href="css/styles.css" rel="stylesheet" />
<script type="text/javascript" src="js/jquery-3.5.1.js"></script>
<script type="text/javascript">
var user_id = "<%= user_id %>"
	$(document).ready(function() {
		if (user_id != "null") {
			$('#login').text('Logout')
		} else {
			$('#login').text('Login')
		}
	})

	$('#cart').click(function() {
					if (user_id == "null") {
						location.href = "../login/memlogin.html";
					} else {
						location.href = "../product/call_list.jsp";
					}
				})
				
				$('#login').click(function() {
					if (user_id == "null") {
						location.href = "../login/memlogin.html";
					} else {
						$.ajax({
							url: 'logout.jsp',
							success: function() {
								location.href = "product_all.jsp";
								
								
								
								
								
								
								
								
							}
						})
					}
				})
</script>
<style>
div#product1, div#product2 {
	padding-top: calc(6rem + 74px);
	padding-bottom: 6rem;
	display: grid;
	grid-template-columns: 1fr 1fr 1fr 1fr;
}

div#imac1, div#iphone2 {
	display: inline-block;
	font-weight: 600;
	z-index: 1;
}

div#iphone2 {
	padding-left: 80px;
}

div#imac1 {
	padding-top: 40px;
}

div#iphone2 {
	padding-top: 120px;
}

h2#product-tit1 {
	font-size: 56px
}

h2#product-tit2 {
	font-size: 40px;
}

p#new {
	color: #f56300;
}

p#model, p#new {
	font-size: 21px;
}

p#product-cont1 {
	font-size: 28px;
}

p#product-cont2 {
	font-size: 42px;
}

a#button {
	min-width: 28px;
	padding-left: 16px;
	padding-right: 16px;
	padding-top: 8px;
	padding-bottom: 8px;
	border-radius: 18px;
	background: #0071e3;
	color: #fff;
	font-size: 17px;
}
</style>
</head>
<body id="page-top">
	<!-- Navigation-->
	<nav
		class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
		id="mainNav" style="background: #000 !important;">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="../index.html"><img
				style="width: 50px" src="img/full_color.png" alt="" />AppleMANGO</a>
			<button
				class="navbar-toggler navbar-toggler-right text-uppercase font-weight-bold bg-secondary text-white rounded"
				type="button" data-toggle="collapse" data-target="#navbarResponsive"
				aria-controls="navbarResponsive" aria-expanded="false"
				aria-label="Toggle navigation">
				Menu <i class="fas fa-bars"></i>
			</button>
			<div class="collapse navbar-collapse" id="navbarResponsive">
				<ul class="navbar-nav ml-auto">
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						href="../product/product_all.jsp">Products</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded"
						href="../music/New.jsp">Music</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						href="../login/customer.jsp">고객지원</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a style="padding: 5px"
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						id="cart"
						href="../product/call_list.jsp"><img style="width: 30px" src="img/cart.png"
							alt="" /></a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						id="login"
						href="">Login</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Masthead-->
	<div id="product1">
		<div></div>
		<div id="imac1">
			<p id="new">New</p>
			<p id="model">27형 모델</p>
			<h2 id="product-tit1">iMac</h2>
			<p id="product-cont1">
				모든 이에게 맞는, <br>모든 것을 갖춘 컴퓨터.
			</p>
			<p>
				<a id="button" href="product_com.jsp?p_id=PC001">구입하기</a>
			</p>
		</div>
		<div id="imac2">
			<img alt="" src="img/product1_4.png" width=471px height=357px>
		</div>
		<div></div>
	</div>
	<div id="product2">
		<div></div>
		<div id="iphone1">
			<img alt="" src="img/product2_5.jpg" width=490px height=563px>
		</div>
		<div id="iphone2">
			<p id="new">New</p>
			<h2 id="product-tit2">iPhone12</h2>
			<p id="product-cont2">
				더할 나위 없이 <br>완벽한 조화.
			</p>
			<p>
				<a id="button" href="product_phone.jsp?p_id=PP001">구입하기</a>
			</p>
		</div>
		<div></div>
	</div>
</body>
</html>
