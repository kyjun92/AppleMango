<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="Product.ProductSubVO"%>
<%@page import="Product.ProductMainVO"%>
<%@page import="Product.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String user_id = (String) session.getAttribute("id");

	String p_id = request.getParameter("p_id");
	ProductDAO dao = new ProductDAO();
	ProductMainVO bag1 = dao.one(p_id);

	ProductSubVO bag2 = new ProductSubVO();
	ArrayList<ProductSubVO> list1 = dao.subcon(p_id);
	String[] sub = new String[list1.size()];
	for (int i = 0; i < list1.size(); i++) {
		bag2 = list1.get(i);
		sub[i] = bag2.getPs_content();
	}

	ArrayList<ProductSubVO> list2 = dao.subprc(p_id);
	int[] prc = new int[list2.size()];
	for (int i = 0; i < list2.size(); i++) {
		bag2 = list2.get(i);
		prc[i] = bag2.getPs_price();
	}
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

	var index1 = true;
	var index2 = true;
	var index3 = true;
	var index4 = true; // 총가격의 합을 구하기 위해 값이 변한것을 확인하기 위한 index값
	var end_price; // 최종가격을 담기위한 변수.
	var	con1;
	var	con2;
	var	con3;
	var	con4; // 바뀌는 옵션을 담기 위한 변수.
	var user_id = "<%=user_id%>"
	$(document).ready(function() {
		if (user_id != "null") {
			$('#login').text('Logout')
		} else {
			$('#login').text('Login')
		}
	})
	$(function() {
		//옵션값 변경
		console.log(user_id)
		con1 = $('#input1').text(); //기본값 세팅
		<%for (int i = 1; i < 3; i++) {%>
			$('#dp-choice<%=i%>').click(function() { //클릭시 작동
				var label = $('#change-val<%=i%>').text(); //바뀌는 옵션의 텍스트 따오고
				con1 = label //바뀐 값을 담아주고
				console.log(label)
				console.log(con1)
				$('#input1').text(label); //위 라벨에 표시
			})
		<%}%>
		con2 = $('#input2').text();
		<%for (int i = 3; i < 5; i++) {%>
			$('#dp-choice<%=i%>').click(function() {
				var label = $('#change-val<%=i%>').text();
				con2 = label
				console.log(label)
				$('#input2').text(label);
			})
		<%}%>
		con3 = $('#input3').text();
		<%for (int i = 5; i < 7; i++) {%>
			$('#dp-choice<%=i%>').click(function() {
				var label = $('#change-val<%=i%>').text();
				con3 = label
				console.log(label)
				con2 = $('#input3').text(label);
			})
		<%}%>
		con4 = $('#input4').text();
		<%for (int i = 7; i < 9; i++) {%>
			$('#dp-choice<%=i%>').click(function() {
				var label = $('#change-val<%=i%>').text();
					con4 = label
					console.log(label)
					$('#input4').text(label);
				})
		<%}%>
	//총합계산
				var total = Number($('#sum').text()); //기본 가격 표시
				end_price = total; //처음 가격을 담아주고
				$('#dp-choice1').click(function() {
					var plus = Number($("input[id='dp-choice2']").val()); //값을 가져와서 수로 바꿔주고
					if (index1 == false) {
						console.log(plus)
						end_price -= plus; // 인덱스의 값이 false 이면 위의 값을 빼준다
						$('#sum').text(end_price); // 바뀐 값을 대입
						index1 = true; // 인덱스의 값을 트루로 바꿔줌
					}
				})
				$('#dp-choice2').click(function() {
					var plus = Number($("input[id='dp-choice2']").val());
					if (index1) {
						console.log(plus)
						end_price += plus;
						$('#sum').text(end_price);
						index1 = false;
					}
				})
				$('#dp-choice3').click(function() {
					var plus = Number($("input[id='dp-choice4']").val());
					if (index2 == false) {
						console.log(plus)
						end_price -= plus;
						$('#sum').text(end_price);
						index2 = true;
					}
				})
				$('#dp-choice4').click(function() {
					var plus = Number($("input[id='dp-choice4']").val());
					if (index2) {
						console.log(plus)
						end_price += plus;
						$('#sum').text(end_price);
						index2 = false;
					}
				})
				$('#dp-choice5').click(function() {
					var plus = Number($("input[id='dp-choice6']").val());
					if (index3 == false) {
						console.log(plus)
						end_price -= plus;
						$('#sum').text(end_price);
						index3 = true;
					}
				})
				$('#dp-choice6').click(function() {
					var plus = Number($("input[id='dp-choice6']").val());
					if (index3) {
						console.log(plus)
						end_price += plus;
						$('#sum').text(end_price);
						index3 = false;
					}
				})
				$('#dp-choice7').click(function() {
					var plus = Number($("input[id='dp-choice8']").val());
					if (index4 == false) {
						console.log(plus)
						end_price -= plus;
						$('#sum').text(end_price);
						index4 = true;
					}
				})
				$('#dp-choice8').click(function() {
					var plus = Number($("input[id='dp-choice8']").val());
					if (index4) {
						console.log(plus)
						end_price += plus;
						$('#sum').text(end_price);
						index4 = false;
					}
				})

				//db저장
				if (user_id == "null") {
					$('#go-db').click(function() {
						location.href = "../login/memlogin.html";
					})
				} else {
					$('#go-db')
							.click(
									function godb() {
										con = con1 + '<br>' + con2 + '<br>'
												+ con3 + '<br>' + con4 + '<br>';
										prc = end_price
										console.log(con)
										location.href = 'product_add.jsp?p_id=PC001&ps_content='
												+ con + '&ps_price=' + prc
									})
				}

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
							url : 'logout.jsp',
							success : function() {
								location.href = "product_com.jsp";
							}
						})
					}
				})
			})
</script>
<style>
div#main-body {
	padding-top: calc(6rem + 74px);
	padding-bottom: 6rem;
	display: grid;
	grid-template-columns: 1fr 1fr;
	line-height: 1.57143;
}

div#col-m-1 {
	text-align: center;
}

div#col-m-2 {
	margin-right: 20px;
}

div#column2_1 {
	border-top: 0.5px solid #333333;
}

div#col1-1 h1 {
	font-size: 32px;
}

div#col1-2 ul {
	list-style: none;
	font-size: 20px;
	margin-left: 0;
	padding: 0;
}

div#col2-title, div#col2-choice {
	font-size: 17px;
}

div#col2-title h3 {
	margin: 22px 0 0 0;
}

div#col2-choice label {
	width: 350px;
	margin: 0;
	padding: 11px 14px;
}

div#col2-choice span {
	margin-left: 60px;
	padding: 0;
}

div#end-body {
	position: fixed;
	right: 0px;
	bottom: 0px;
	padding-right: 100px;
	padding-top: 3px;
	width: 100%;
	height: 70px;
	background-color: #d6d6d6;
	text-align: right;
	font-size: 40px;
	font-weight: bold;
}

div#end-span {
	margin-right: 50px;
}
</style>
</head>
<body id="page-top">
	<!-- Navigation-->
	<nav
		class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top"
		id="mainNav" style="background: #000 !important;">
		<div class="container">
			<a class="navbar-brand js-scroll-trigger" href="index.html"><img
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
						class="nav-link py-3 px-0 px-lg-3 rounded" href="../music/New.jsp">Music</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						href="../login/customer.jsp">고객지원</a></li>
					<li class="nav-item mx-0 mx-lg-1"><a style="padding: 5px"
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						id="cart" href="../product/call_list.jsp"><img
							style="width: 30px" src="img/cart.png" alt="" /></a></li>
					<li class="nav-item mx-0 mx-lg-1"><a
						class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger"
						id="login" href="">Login</a></li>
				</ul>
			</div>
		</div>
	</nav>
	<!-- Masthead-->
	<div id="main-body">
		<div id="col-m-1">
			<img alt="" src="<%=bag1.getP_pic()%>" width=410px height=341px>
			<br> <br> <br> <img alt="" src="img/HDbar.png"
				width=480px height=180px>
		</div>
		<div id="col-m-2">
			<div id="col1-1">
				<h1>27형 iMac Retina 5K 디스플레이를 맞춤 구성하세요.</h1>
			</div>
			<div id="col1-2">
				<ul>
					<li id="input1"><%=sub[0]%></li>
					<li id="input2"><%=sub[2]%></li>
					<li id="input3"><%=sub[4]%></li>
					<li id="input4"><%=sub[6]%></li>
					<li><%=bag1.getP_content()%></li>
				</ul>
			</div>
			<br>
			<div id="column2_1">
				<div id="col2-title">
					<h3>디스플레이</h3>
				</div>
				<div id="col2-choice">
					<div>
						<input type="radio" name="bt1" id="dp-choice1" value="<%=prc[0]%>"
							checked="checked"> <label id="change-val1"><%=sub[0]%></label>
					</div>
					<div>
						<input type="radio" name="bt1" id="dp-choice2" value="<%=prc[1]%>">
						<label id="change-val2"><%=sub[1]%></label> <span>+<%=prc[1]%>원
						</span>
					</div>
				</div>
				<div id="col2-title">
					<h3>프로세서</h3>
				</div>
				<div id="col2-choice">
					<div>
						<input type="radio" name="bt2" id="dp-choice3" value="<%=prc[2]%>"
							checked="checked"> <label id="change-val3"><%=sub[2]%></label>
					</div>
					<div>
						<input type="radio" name="bt2" id="dp-choice4" value="<%=prc[3]%>">
						<label id="change-val4"><%=sub[3]%></label> <span>+<%=prc[3]%>원
						</span>
					</div>
				</div>
				<div id="col2-title">
					<h3>메모리</h3>
				</div>
				<div id="col2-choice">
					<div>
						<input type="radio" name="bt3" id="dp-choice5" value="<%=prc[4]%>"
							checked="checked"> <label id="change-val5"><%=sub[4]%></label>
					</div>
					<div>
						<input type="radio" name="bt3" id="dp-choice6" value="<%=prc[5]%>">
						<label id="change-val6"><%=sub[5]%></label> <span>+<%=prc[5]%>원
						</span>
					</div>
				</div>
				<div id="col2-title">
					<h3>그래픽</h3>
				</div>
				<div id="col2-choice">
					<div>
						<input type="radio" name="bt4" id="dp-choice7" value="<%=prc[6]%>"
							checked="checked"> <label id="change-val7"><%=sub[6]%></label>
					</div>
					<div>
						<input type="radio" name="bt4" id="dp-choice8" value="<%=prc[7]%>">
						<label id="change-val8"><%=sub[7]%></label> <span>+<%=prc[7]%>원
						</span>
					</div>
				</div>
			</div>
		</div>
	</div>
	<div id="end-body">
		<div id="end-span">
			<span>총 가격: </span> <span id="sum"><%=bag1.getP_price()%></span> <span>원</span>
			<button id="go-db" onclick="godb()">장바구니에 추가</button>
		</div>
	</div>
</body>
</html>
