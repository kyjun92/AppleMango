<%@page import="org.json.simple.JSONObject"%>
<%@page import="Product.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%

	String user_id = (String) session.getAttribute("id");
	String p_id = request.getParameter("p_id");
	ProductDAO dao = new ProductDAO();
	JSONObject jo = dao.shopping(user_id);
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="utf-8" />
<meta name="viewport"
	content="width=device-width, initial-scale=1, shrink-to-fit=no" />
<meta name="description" content="" />
<meta name="author" content="" />
<title>AppleMango ${id}!</title>
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
<script type="text/javascript"
	src="https://service.iamport.kr/js/iamport.payment-1.1.5.js"></script>
<script type="text/javascript">
	var json =
<%=jo%>
	;
	var idValue;
	var total = 0;
	var user_id = "<%= user_id %>";
		$(document).ready(function() {
			if (user_id != "null") {
				$('#login').text('Logout')
			}  else {
			$('#login').text('Login')
		}
		})
	$(function() {
		for (var i = 0; i < Object.keys(json.shopping).length; i++) {
			idValue = i;
			$('#main-col')
					.prepend(
							'<div id="col1-img"><img src=' + json.shopping[i].p_pic +' width=170px height=203px></div><div id="col2-con"><div id="col2-con-top"><h2>제품명: '
									+ json.shopping[i].p_name
									+ '</h2><p>제품번호: '
									+ json.shopping[i].p_id
									+ '</p></div><div id="col2-con-body">[제품설명]<div>'
									+ json.shopping[i].ps_content
									+ '</div></div><div id="col2-con-bottom"><div><span>제품가격: </span><span id="price">'
									+ json.shopping[i].ps_price
									+ '</span><span>원</span></div><div><button class="delete-item" id="'+i+'">삭제</button></div></div></div>') //prepend
			console.log(idValue)
		}

		for (var i = 0; i < Object.keys(json.shopping).length; i++) {
			var price = json.shopping[i].ps_price
			console.log(price)
			total += Number(price)
			console.log(total)
			$('#sum1').text(total)
			$('#sum2').text(total)
		}

		$('.delete-item').click(function() {
			idValue = $(this).attr('id')
			console.log(idValue)
			$.ajax({
				url : 'deletedb.jsp',
				data : {
					l_id : json.shopping[idValue].l_id,
				},
				success : function(result) {
					if (result) {
						alert('항목이 삭제되었습니다.');
					}
				}
			}) //ajax
		}) //click

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
						location.href = "call_list.jsp";
					}
				})
			}
		})
		
		$("#check_module").click(function() {
			var IMP = window.IMP; // 생략가능
			IMP.init('imp21906426');
			// 'iamport' 대신 부여받은 "가맹점 식별코드"를 사용
			// i'mport 관리자 페이지 -> 내정보 -> 가맹점식별코드
			IMP.request_pay({
				pg : 'inicis', // version 1.1.0부터 지원.
				/*
				'kakao':카카오페이,
				html5_inicis':이니시스(웹표준결제)
				'nice':나이스페이
				'jtnet':제이티넷
				'uplus':LG유플러스
				'danal':다날
				'payco':페이코
				'syrup':시럽페이
				'paypal':페이팔
				 */
				pay_method : 'card',
				/*
				'samsung':삼성페이,
				'card':신용카드,
				'trans':실시간계좌이체,
				'vbank':가상계좌,
				'phone':휴대폰소액결제
				 */
				merchant_uid : 'merchant_' + new Date().getTime(),
				/*
				merchant_uid에 경우
				https://docs.iamport.kr/implementation/payment
				위에 url에 따라가시면 넣을 수 있는 방법이 있습니다.
				참고하세요.
				나중에 포스팅 해볼게요.
				 */
				name : '주문명:결제테스트',
				//결제창에서 보여질 이름
				amount : 1000,
				//가격
				buyer_email : 'iamport@siot.do',
				buyer_name : '구매자이름',
				buyer_tel : '010-1234-5678',
				buyer_addr : '서울특별시 강남구 삼성동',
				buyer_postcode : '123-456',
				m_redirect_url : 'https://www.yourdomain.com/payments/complete'
			/*
			모바일 결제시,
			결제가 끝나고 랜딩되는 URL을 지정
			(카카오페이, 페이코, 다날의 경우는 필요없음. PC와 마찬가지로 callback함수로 결과가 떨어짐)
			 */
			}, function(rsp) {
				console.log(rsp);
				if (rsp.success) {
					var msg = '결제가 완료되었습니다.';
					msg += '고유ID : ' + rsp.imp_uid;
					msg += '상점 거래ID : ' + rsp.merchant_uid;
					msg += '결제 금액 : ' + rsp.paid_amount;
					msg += '카드 승인번호 : ' + rsp.apply_num;
				} else {
					var msg = '결제에 실패하였습니다.';
					msg += '에러내용 : ' + rsp.error_msg;
				}
				alert(msg);
			});
		});
	})
</script>

<style>
div#main-body {
	padding-top: calc(6rem + 74px);
	padding-bottom: 6rem;
	margin-left: auto;
	margin-right: auto;
	max-width: 980px;
	text-align: center;
	line-height: 1.58824;
	letter-spacing: 0;
}

div#main-title {
	border-bottom: 0.5px solid #333333;
	padding: 10px 0 60px;
}

div#main-col {
	display: grid;
	grid-template-columns: 1fr 2.5fr;
	margin: 4.17647rem 0 20px;
}

div#col1-img {
	text-align: center;
	width: 245px;
	height: 468px;
}

div#col2-con {
	text-align: left;
}

div#col2-con-top {
	border-bottom: 0.5px solid #d6d6d6;
	font-weight: bold;
}

div#col2-con-top h2 {
	font-size: 43px;
}

div#col2-con-top p {
	font-size: 18px;
	font-style: italic;
}

div#col2-con-body {
	border-bottom: 0.5px solid #d6d6d6;
	padding: 21px 0 0;
	margin: 6px 0 0;
	font-size: 17px;
}

div#col2-con-bottom {
	padding: 21px 0 0;
	text-align: right;
	font-size: 24px;
	font-weight: bold;
}

button.delete-item {
	width: 50px;
	max-height: 45px;
	border: none;
	font-size: 17px;
	color: #06c;
	background-color: #ffffff;
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
		id="mainNav" style="background : #000 !important;">
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
	<div id="main-body">
		<div id="main-title">
			<h1>
				<span>장바구니에 들어있는 제품입니다 </span> <span id="sum1"></span> <span>원.</span>
			</h1>
			<p>모든 주문에 무료배송 서비스가 제공됩니다.</p>
		</div>
		<div id="main-col"></div>
		<div id="end-body">
			<div id="end-span">
				<span>총 가격: </span> <span id="sum2"></span> <span>원</span>
				<button id="check_module">결제</button>
			</div>
		</div>
	</div>
</body>
</html>
