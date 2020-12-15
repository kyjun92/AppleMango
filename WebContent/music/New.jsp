<%@page import="org.json.simple.JSONObject"%>
<%@page import="java.util.List"%>
<%@page import="java.util.ArrayList"%>
<%@page import="music.DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
String id = (String) session.getAttribute("id");
	DAO dao = new DAO();
JSONObject jo = dao.music_new();
%>
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>New Music</title>
<script type="text/javascript"
	src="https://ajax.googleapis.com/ajax/libs/jquery/3.1.0/jquery.min.js"></script>
<script type="text/javascript" src="js/music.js"></script>
<script type="text/javascript">
	var json =<%=jo%>;
	var jsondata = JSON.stringify(json);
	var memberData = JSON.parse(jsondata);
	var audio = new Audio();
	var playlist_id = 0;
	var playlist_array = [];
	var now_playing = 0;
	var memberData1;
	var random_id = false;
	var repeat_id = 0;
	var timer;
	
	var id ="<%=id%>";
	
	function music_play(playlist_id) {
		var music_id = $('#pl-musiclist-block-' + playlist_id).attr('class');
		$('ul#pl-musiclist > li').css('background', 'none');
		$('#pl-musiclist-block-' + playlist_id).css('background', '#ffe1e2')
		$.ajax({
			url : "num.jsp",
			data : {
				id : music_id
			},
			datatype : "json",
			success : function(data) {
				memberData1 = JSON.parse(data);
				audio.src = memberData1.music[0].file;
				$('#nowplaying-img').html(
						'<img alt="" src="' + memberData1.music[0].img
								+ '" width="100%">');

				$('#info_playlcd').html(
						'<a><b>' + memberData1.music[0].title
								+ '</b></a><br><a style="font-size: 12px">'
								+ memberData1.music[0].artist + '</a><input type="range" name="" id="currentTime_played" value="0" oninput="currenttime_played_bar(this.value)" style="position:absolute; left:10px; top:30px;" >');

				audio.play();
				now_playing = playlist_id;
				
			}
		})
		clearInterval(timer);
		timer = setInterval(function() {
					var x = audio.duration;
					var y = audio.currentTime;
					$('#currentTime_played').val(y/x*100);
					}, 1000);
		

		$("#play_img").css('display', 'none');
		$("#pause_img").css('display', 'block');

	}
	
	
	//노래 끝나면 다음 노래 자동 재생
	audio.onended = function() {
	var now_s = linkedList.find(now_playing); // 현재 재생중인 노드 

		if (random_id == false) {
			if (repeat_id == 0) {
				if (now_s.next == null) {
					alert('마지막 곡입니다.');
				} else {
					var next_s = now_s.next;
					music_play(next_s.element);
				}
			} else if (repeat_id == 1) {
				music_play(now_s.element);
			} else {
				
			}
		} else {
			if (repeat_id == 0) {
				if (now_s.next == null) {
					alert('마지막 곡입니다.');
				} else {
					var next_s = now_s.next;
					music_play(next_s.element);
				}
			} else if (repeat_id == 1) {

			} else {
				while(true){
					var random = Math.floor(Math.random() * linkedList.l());
					var next_s = linkedList.num_index(random);
					if(next_s != now_s){
						music_play(next_s.element);
						break;
					}
				}

			}
		}
	}

	function music_plus(x) {
		$('#pl-musiclist')
				.prepend(
						'<li id="pl-musiclist-block-'+ playlist_id +'" class="'+memberData.music[x].id+'" style="border-bottom:1px solid darkgray; padding:5px; border-radius:5px; background:#ffe1e2;"><div style="display: grid; grid-template-columns: [left-edge] 50px[artwork-edge] calc(100% - 112px)[title-edge] 40px[right-edge]; grid-column-gap: 16px;"><a href="#"><img style="border-radius: 5px;" width="100%" src="'
								+ memberData.music[x].img
								+ '"></a><div><a href="#" style="font-size: 20px">'
								+ memberData.music[x].title
								+ '</a><br><a href="#">'
								+ memberData.music[x].artist
								+ '</a></div><div><img src="img/play_icon.png" onclick="music_play('
								+ playlist_id
								+ ')" width="23px" style="cursor: pointer;"><img src="img/x_icon.png" onclick="music_delete('
								+ playlist_id
								+ ')" width="23px" style="cursor: pointer;"></div></div></li>');
		linkedList.append(playlist_id);
		music_play(playlist_id);
		playlist_id++;
	}

	function music_delete(x) {
		linkedList.remove(x);
		if (now_playing == x) {
			audio.pause();
			$("#pause_img").css('display', 'none');
			$("#play_img").css('display', 'block');
			$('#nowplaying-img')
					.html(
							'<img alt=""src="https://beta.music.apple.com/assets/product/MissingArtworkMusic-48f3c55581d88b6ddda5fe0d1bb9e18a.png" width="100%">');

			$('#info_playlcd').html(
					'<img alt="" src="img/full_black.png" width="30px">');
		}
		$('li').remove("#pl-musiclist-block-" + x);

	}

	$(
			function() {
				
				for (var i = 0; i < memberData.music.length; i++) {
					$('#m_content')
							.append(
									'<div id="m_'+i+'"><div style="cursor:pointer;" id="#music'
											+ i
											+ '" onclick="music_plus('
											+ i
											+ ');"><img alt="'+memberData.music[i].title+'"src="'+memberData.music[i].img+'" width="200px" style="border-radius: 10px;"></div><br> <a style="font-size: 20px;font-weight:bolder;">'
											+ memberData.music[i].title
											+ '</a><br> <a>'
											+ memberData.music[i].artist
											+ '</a></div>');
				}

				$('#playlist_icon')
						.click(
								function() {
									if ($('#playlist_icon').css('fill') == 'rgb(128, 128, 128)') {
										$('#playlist_icon').css('fill',
												'rgb(252,38,61)');
										$('#playlist').css('display', 'block');
									} else {
										$('#playlist_icon').css('fill',
												'rgb(128,128,128)')
										$('#playlist').css('display', 'none');

									}
								})

				$("#b_play").click(function() {
					if (audio.paused) {
						audio.play();
						$("#play_img").css('display', 'none');
						$("#pause_img").css('display', 'block');
					} else {
						audio.pause();
						$("#pause_img").css('display', 'none');
						$("#play_img").css('display', 'block');
					}
				})
				$('#b_back').click(function() {

					if (audio.currentTime > 5) {
						audio.currentTime = 0;
					} else {
						var prev = linkedList.findPrevious(now_playing);
						if (prev.element == "head") {
							alert('현재 곡이 첫 곡 입니다.')
						} else {
							var prev_id = prev.element;
							music_play(prev_id);
						}

					}
				})
				$('#b_next').click(function() {

					var now = linkedList.find(now_playing);
					var next_s = now.next;
					
					if (next_s == null) {
						alert('마지막 곡입니다.')
					} else {
						var next_s_id = next_s.element;
						music_play(next_s_id);
					}

				})
				$('#b_random').click(function() {
					if ($('#random_img').css('fill') == 'rgb(135, 135, 135)') {
						$('#random_img').css('fill', 'rgb(252,38,61)');
						random_id = true;

					} else {
						$('#random_img').css('fill', 'rgb(135, 135, 135)')
						random_id = false;
					}
				})
				//반복 버튼 설정 0 = 꺼짐/ 1= 한 곡 반복 / 2 = 플레이 리스트 전체 반복
				$('#b_repeat').click(function() {
					if (repeat_id == 0) {
						$('#repeat_img').css('fill', 'rgb(0,0,0)');
						repeat_id++;
						$('#icon_1').css('display', 'block');
					} else if (repeat_id == 1) {
						$('#repeat_img').css('fill', 'rgb(252,38,61)');
						repeat_id++;
						$('#icon_1').css('display', 'none');
					} else {
						$('#repeat_img').css('fill', 'rgb(135, 135, 135)')
						repeat_id = 0;
					}
				})
				
				if(id!="null"){
					$('#login').html('<button onclick="session_out()" id="login_b" class="c-button"><svg height="11" viewBox="0 0 10 11" width="10"xmlns="http://www.w3.org/2000/svg" fill="#000"fill-rule="nonzero" role="presentation"><g><pathd="M5 5.29495614c-1.29585799 0-2.38466244-1.17598684-2.38466244-2.67763158-.0058701-1.46546052 1.10063877-2.61732456 2.38466244-2.61732456 1.28994083 0 2.39053254 1.12774123 2.39053254 2.61129386 0 1.50767544-1.09467455 2.68366228-2.39053254 2.68366228zM1.31360947 11c-.97633136 0-1.31360947-.3015351-1.31360947-.8563596 0-1.5498904 1.92899408-3.68475882 5-3.68475882 3.06508876 0 5 2.13486842 5 3.68475882 0 .5548245-.33727811.8563596-1.31360947.8563596z"></path></g></svg>LogOut</button>')
				 } 
				
				$('.genre_set').click(function(){
					var genre = $(this).attr('id');
					location.href ="search_genre.jsp?genre="+genre;
				})
				
			})
			function session_out(){
				$.ajax({
					url : "music_logout.jsp",
					success : (function() {
						location.href = "New.jsp";
					})
				})
			
				
			}

			function lo_login(){
				location.href="../login/memlogin.html";
			}
			function set_volume(val){
				audio.volume = (val/100);
			}
	
			
			function currenttime_played_bar(val){
				var dur=audio.duration/100;
				audio.currentTime = val*dur;
			}
</script>

<link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
<link href="css/music2.css" rel="stylesheet" />
</head>
<body>
	<div class="apple-music">
		<aside class="c-nav">
			<nav id="nav">
				<h3 style="margin-bottom: 10px">
					<a href="index_music.jsp"><img alt=""
						src="img/full_black.png" width="20px">Music</a>
				</h3>
				<ul>
					<input type="text" width="100px" placeholder="Search"
						style="margin-bottom: 15px"onclick = "location.href='search.jsp'">
					<li style="margin-bottom: 15px; padding: 5px; font-weight: bolder;"><a
						href="Foryou.jsp">For You</a></li>
					<li style="margin-bottom: 15px; padding: 5px; font-weight: bolder;"><a
						href="Top100.jsp">Top 100</a></li>
					<li
						style="margin-bottom: 15px; background-color: #ffe1e2; padding: 5px; font-weight: bolder;"><a
						href="New.jsp">New Music</a></li>
				</ul>

				<hr>

				<h3>
					<a href="../index.jsp">Main page</a>
				</h3>

			</nav>

		</aside>
		<main style="width: 2000px; margin-left: 220px;">
			<div class="c-playback" style="position: fixed; fill: #000;">
				<div class="c-playback__controls__wrapper">
					<div class="c-playback__controls">
						<button id="b_random" class="c-playback__random">
							<svg id="random_img" width="100%" height="100%"
								viewBox="0 0 30 22" version="1.1"
								xmlns="http://www.w3.org/2000/svg"
								xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve"
								xmlns:serif="http://www.serif.com/"
								style="fill-rule: evenodd; clip-rule: evenodd; stroke-linejoin: round; stroke-miterlimit: 1.41421">
								<path
									d="M19.542,7l0,-1.032c0,-0.259 0.175,-0.468 0.392,-0.468c0.066,0 0.131,0.02 0.189,0.058l2.715,1.782c0.19,0.125 0.259,0.409 0.155,0.635c-0.036,0.078 -0.089,0.142 -0.155,0.185l-2.715,1.782c-0.19,0.125 -0.428,0.042 -0.533,-0.184c-0.032,-0.07 -0.048,-0.147 -0.048,-0.226l0,-1.032l-0.377,0c-0.524,0 -1.031,0.15 -1.466,0.423c-0.235,0.148 -0.45,0.333 -0.633,0.551l-1.292,1.526l1.292,1.526c0.183,0.218 0.398,0.403 0.633,0.551c0.435,0.273 0.942,0.423 1.466,0.423l0.377,0l0,-1.032c0,-0.259 0.175,-0.468 0.392,-0.468c0.066,0 0.131,0.02 0.189,0.058l2.715,1.782c0.19,0.125 0.259,0.409 0.155,0.635c-0.036,0.078 -0.089,0.142 -0.155,0.185l-2.715,1.782c-0.19,0.125 -0.428,0.042 -0.533,-0.184c-0.032,-0.07 -0.048,-0.147 -0.048,-0.226l0,-1.032l-0.377,0c-0.673,0 -1.327,-0.159 -1.913,-0.455c-0.504,-0.254 -0.958,-0.609 -1.332,-1.05l-1.128,-1.334l-1.129,1.334c-0.361,0.426 -0.797,0.772 -1.281,1.024c-0.6,0.312 -1.272,0.481 -1.964,0.481l-1.126,0c-0.415,0 -0.75,-0.336 -0.75,-0.75c0,-0.414 0.335,-0.75 0.75,-0.75l1.126,0c0.479,0 0.944,-0.125 1.352,-0.355c0.28,-0.158 0.534,-0.367 0.748,-0.619l1.291,-1.526l-1.291,-1.526c-0.214,-0.252 -0.468,-0.461 -0.748,-0.619c-0.408,-0.23 -0.873,-0.355 -1.352,-0.355l-1.126,0c-0.415,0 -0.75,-0.336 -0.75,-0.75c0,-0.414 0.335,-0.75 0.75,-0.75l1.126,0c0.692,0 1.364,0.169 1.964,0.481c0.484,0.252 0.92,0.598 1.281,1.024l1.129,1.334l1.128,-1.334c0.374,-0.441 0.828,-0.796 1.332,-1.05c0.586,-0.296 1.24,-0.455 1.913,-0.455l0.377,0Z"
									style="fill-rule:nonzero"></path></svg>
						</button>
						<div class="c-playback__controls__group">
							<button id="b_back" class="c-playback__controls__button">
								<svg width="100%" height="100%" viewBox="0 0 34 34"
									version="1.1" xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve"
									xmlns:serif="http://www.serif.com/"
									style="fill-rule: evenodd; clip-rule: evenodd; stroke-linejoin: round; stroke-miterlimit: 1.41421">
									<path
										d="M26.97,23c0.536,0 1.03,-0.38 1.03,-1.124l0,-9.752c0,-0.744 -0.494,-1.124 -1.03,-1.124c-0.294,0 -0.57,0.097 -0.889,0.283l-8.26,4.617c-0.436,0.243 -0.729,0.494 -0.804,0.874l0,-4.65c0,-0.744 -0.503,-1.124 -1.031,-1.124c-0.301,0 -0.578,0.097 -0.896,0.283l-8.261,4.617c-0.511,0.283 -0.829,0.574 -0.829,1.1c0,0.518 0.318,0.817 0.829,1.1l8.261,4.617c0.318,0.186 0.595,0.283 0.896,0.283c0.528,0 1.031,-0.38 1.031,-1.124l0,-4.658c0.075,0.388 0.368,0.639 0.804,0.882l8.26,4.617c0.319,0.186 0.595,0.283 0.889,0.283Z"
										style="fill-rule:nonzero"></path></svg>
							</button>
							<button id="b_play" class="c-playback__controls__button"
								value="play">
								<svg id="play_img" style="fill: #000;" width="100%"
									height="100%" viewBox="0 0 34 34" version="1.1"
									xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve"
									xmlns:serif="http://www.serif.com/"
									style="fill-rule: evenodd; clip-rule: evenodd; stroke-linejoin: round; stroke-miterlimit: 1.41421">
									<path
										d="M28.228,18.327l-16.023,8.983c-0.99,0.555 -2.205,-0.17 -2.205,-1.318l0,-17.984c0,-1.146 1.215,-1.873 2.205,-1.317l16.023,8.982c1.029,0.577 1.029,2.077 0,2.654Z"
										style="fill-rule:nonzero"></path></svg>
								<img id="pause_img" style="display: none;"
									src="img/ios-pause.svg" width="100%" height="100%">
							</button>

							<button id="b_next" class="c-playback__controls__button">
								<svg width="100%" height="100%" viewBox="0 0 34 34"
									version="1.1" xmlns="http://www.w3.org/2000/svg"
									xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve"
									xmlns:serif="http://www.serif.com/"
									style="fill-rule: evenodd; clip-rule: evenodd; stroke-linejoin: round; stroke-miterlimit: 1.41421">
									<path
										d="M8.307,23c-0.536,0 -1.031,-0.38 -1.031,-1.124l0,-9.752c0,-0.744 0.495,-1.124 1.031,-1.124c0.293,0 0.569,0.097 0.888,0.283l8.26,4.617c0.436,0.243 0.729,0.494 0.805,0.874l0,-4.65c0,-0.744 0.502,-1.124 1.03,-1.124c0.302,0 0.578,0.097 0.896,0.283l8.261,4.617c0.511,0.283 0.829,0.574 0.829,1.1c0,0.518 -0.318,0.817 -0.829,1.1l-8.261,4.617c-0.318,0.186 -0.594,0.283 -0.896,0.283c-0.528,0 -1.03,-0.38 -1.03,-1.124l0,-4.658c-0.076,0.388 -0.369,0.639 -0.805,0.882l-8.26,4.617c-0.319,0.186 -0.595,0.283 -0.888,0.283Z"
										style="fill-rule:nonzero"></path></svg>
							</button>
						</div>
						<button id="b_repeat" class="c-playback__repeat">
							<svg id='repeat_img' width="100%" height="100%"
								viewBox="0 0 30 22" version="1.1"
								xmlns="http://www.w3.org/2000/svg"
								xmlns:xlink="http://www.w3.org/1999/xlink" xml:space="preserve"
								xmlns:serif="http://www.serif.com/"
								style="fill-rule: evenodd; clip-rule: evenodd; stroke-linejoin: round; stroke-miterlimit: 1.41421">
								<path
									d="M17,7l0,-1.032c0,-0.259 0.176,-0.468 0.392,-0.468c0.066,0 0.131,0.02 0.189,0.058l2.716,1.782c0.19,0.125 0.259,0.409 0.154,0.635c-0.035,0.078 -0.089,0.142 -0.154,0.185l-2.716,1.782c-0.19,0.125 -0.428,0.042 -0.532,-0.184c-0.032,-0.07 -0.049,-0.147 -0.049,-0.226l0,-1.032l-5.092,0c-0.61,0 -1.055,0.1 -1.41,0.29c-0.309,0.165 -0.543,0.399 -0.708,0.708c-0.159,0.297 -0.255,0.658 -0.282,1.125c-0.004,0.06 -0.011,0.154 -0.024,0.281c-0.071,0.34 -0.372,0.596 -0.734,0.596c-0.414,0 -0.75,-0.336 -0.75,-0.75l0,-0.25c0,-0.866 0.162,-1.139 0.467,-1.709c0.306,-0.571 0.753,-1.018 1.324,-1.324c0.57,-0.305 1.251,-0.467 2.117,-0.467l5.092,0Zm-4,8l0,1.006c0,0.083 -0.017,0.165 -0.049,0.238c-0.104,0.239 -0.342,0.326 -0.532,0.195l-2.716,-1.881c-0.065,-0.045 -0.119,-0.113 -0.154,-0.195c-0.105,-0.239 -0.036,-0.539 0.154,-0.671l2.716,-1.881c0.058,-0.04 0.123,-0.061 0.189,-0.061c0.216,0 0.392,0.221 0.392,0.494l0,1.256l5.092,0c0.61,0 1.055,-0.1 1.41,-0.29c0.309,-0.165 0.543,-0.399 0.708,-0.708c0.159,-0.297 0.255,-0.658 0.282,-1.125c0.004,-0.06 0.011,-0.154 0.024,-0.281c0.071,-0.34 0.372,-0.596 0.734,-0.596c0.414,0 0.75,0.336 0.75,0.75l0,0.25c0,0.866 -0.162,1.139 -0.467,1.709c-0.306,0.571 -0.753,1.018 -1.324,1.324c-0.57,0.305 -1.251,0.467 -2.117,0.467l-5.092,0Z"
									style="fill-rule:nonzero"></path></svg>
							<img id="icon_1" alt="" src="img/Icon_1.png" width="10px"
								style="position: absolute; left: 195px; top: 15px; display: none;">
						</button>
					</div>
				</div>
				<div class="c-playback__lcd">
					<div id="nowplaying-img"
						style="width: 43px; height: 100%; position: absolute; left: 0;">
						<img alt=""
							src="https://beta.music.apple.com/assets/product/MissingArtworkMusic-48f3c55581d88b6ddda5fe0d1bb9e18a.png"
							width="100%">
					</div>
					<div id="info_playlcd">
						<img alt="" src="img/full_black.png" width="30px">
						
					</div>
				</div>
				<div class="c-playback__user">
					<div class="c-playback__user__vol">
						<div class="c-input-slider">
							<svg xmlns="http://www.w3.org/2000/svg" width="45" height="33"
								version="1.1" viewBox="0 0 45 33">
                                <path fill-rule="nonzero" stroke="none"
									stroke-width="1"
									d="M38.4179688,30.3604142 C40.3125,26.590883 41.796875,21.6885392 41.796875,16.3760392 C41.796875,11.0635392 40.3125,6.16119547 38.4179688,2.39166422 C37.9882812,1.53228922 38.1640625,0.731507974 38.90625,0.243226724 C39.6875,-0.264585776 40.625,0.0479142244 41.1328125,0.946351724 C43.4765625,5.12603922 44.9023438,10.497133 44.9023438,16.3760392 C44.9023438,22.2549455 43.4765625,27.6260392 41.1328125,31.8057267 C40.625,32.7041642 39.6875,33.0166642 38.90625,32.5088517 C38.1640625,32.0205705 37.9882812,31.2197892 38.4179688,30.3604142 Z M20.9375,27.5674455 C20.9375,29.2080705 19.8242188,30.3604142 18.2421875,30.3604142 C17.5390625,30.3604142 16.9140625,30.0869767 16.2109375,29.5791642 L8.671875,24.0322892 L3.59375,24.0322892 C1.3671875,24.0322892 0,22.8213517 0,20.4385392 L0,12.4307267 C0,10.0479142 1.3671875,8.83697672 3.59375,8.83697672 L8.671875,8.83697672 L16.2109375,3.29010172 C16.9140625,2.78228922 17.5390625,2.50885172 18.2421875,2.50885172 C19.8242188,2.50885172 20.9375,3.66119547 20.9375,5.30182047 L20.9375,27.5674455 Z M31.484375,26.356508 C32.8125,23.5049455 33.7890625,20.2236955 33.7890625,16.3760392 C33.7890625,12.528383 32.8125,9.24713297 31.484375,6.39557047 C31.09375,5.55572672 31.2695312,4.77447672 31.9921875,4.26666422 C32.734375,3.75885172 33.75,4.07135172 34.21875,4.96978922 C35.8789062,8.17291422 36.875,11.981508 36.875,16.3760392 C36.875,20.7705705 35.8789062,24.5791642 34.21875,27.7822892 C33.75,28.6807267 32.734375,28.9932267 31.9921875,28.4854142 C31.2695312,27.9776017 31.09375,27.1963517 31.484375,26.356508 Z M24.84375,22.684633 C25.703125,20.8486955 26.25,18.7588517 26.25,16.3760392 C26.25,13.9932267 25.703125,11.903383 24.84375,10.0674455 C24.4726563,9.26666422 24.609375,8.44635172 25.3515625,7.93853922 C26.1132813,7.43072672 27.1289063,7.72369547 27.578125,8.64166422 C28.6328125,10.8486955 29.296875,13.465883 29.296875,16.3760392 C29.296875,19.2861955 28.6328125,21.903383 27.578125,24.1104142 C27.1289063,25.028383 26.1132813,25.3213517 25.3515625,24.8135392 C24.609375,24.3057267 24.4726563,23.4854142 24.84375,22.684633 Z"></path>
                            </svg>
							<input type="range" name="" id="volume" value="100" oninput="set_volume(this.value)">
						</div>
					</div>
					<div class="c-playback__user__toggle">
						<button class="c-playback__toggle">
							<svg id="playlist_icon" style="fill: gray;"
								xmlns="http://www.w3.org/2000/svg" width="100%">
								height="100%" fill-rule="evenodd" stroke-linejoin="round"
								stroke-miterlimit="2" clip-rule="evenodd" version="1.1"
								viewBox="0 0 18 18" xml:space="preserve">
                                    <path
									d="M2.504,4.063l0.519,0c0.431,0 0.78,0.349 0.78,0.779c0,0.431 -0.349,0.78 -0.78,0.78l-0.519,0c-0.431,0 -0.78,-0.349 -0.78,-0.78c0,-0.43 0.349,-0.779 0.78,-0.779Zm3.118,0l9.874,0c0.431,0 0.78,0.349 0.78,0.779c0,0.431 -0.349,0.78 -0.78,0.78l-9.874,0c-0.43,0 -0.78,-0.349 -0.78,-0.78c0,-0.43 0.35,-0.779 0.78,-0.779Zm-3.118,4.157l0.519,0c0.431,0 0.78,0.35 0.78,0.78c0,0.43 -0.349,0.78 -0.78,0.78l-0.519,0c-0.431,0 -0.78,-0.35 -0.78,-0.78c0,-0.43 0.349,-0.78 0.78,-0.78Zm3.118,0l9.874,0c0.431,0 0.78,0.35 0.78,0.78c0,0.43 -0.349,0.78 -0.78,0.78l-9.874,0c-0.43,0 -0.78,-0.35 -0.78,-0.78c0,-0.43 0.35,-0.78 0.78,-0.78Zm-3.118,4.158l0.519,0c0.431,0 0.78,0.349 0.78,0.78c0,0.43 -0.349,0.779 -0.78,0.779l-0.519,0c-0.431,0 -0.78,-0.349 -0.78,-0.779c0,-0.431 0.349,-0.78 0.78,-0.78Zm3.118,0l9.874,0c0.431,0 0.78,0.349 0.78,0.78c0,0.43 -0.349,0.779 -0.78,0.779l-9.874,0c-0.43,0 -0.78,-0.349 -0.78,-0.779c0,-0.431 0.35,-0.78 0.78,-0.78Z"></path>
                                </svg>
						</button>
					</div>
					<div id="login" class="c-playback__user__signin">
						<button id="login_b" class="c-button" onclick="lo_login()">
							<svg height="11" viewBox="0 0 10 11" width="10"
								xmlns="http://www.w3.org/2000/svg" fill="#000"
								fill-rule="nonzero" role="presentation">
                                <g>
								<path
									d="M5 5.29495614c-1.29585799 0-2.38466244-1.17598684-2.38466244-2.67763158-.0058701-1.46546052 1.10063877-2.61732456 2.38466244-2.61732456 1.28994083 0 2.39053254 1.12774123 2.39053254 2.61129386 0 1.50767544-1.09467455 2.68366228-2.39053254 2.68366228zM1.31360947 11c-.97633136 0-1.31360947-.3015351-1.31360947-.8563596 0-1.5498904 1.92899408-3.68475882 5-3.68475882 3.06508876 0 5 2.13486842 5 3.68475882 0 .5548245-.33727811.8563596-1.31360947.8563596z"></path></g>
                            </svg>
							Sign In
						</button>
					</div>
				</div>
			</div>
			<div class="m_main" style="padding: 20px; margin-top: 50px">
				<div class="music_box" style="padding: 10px;">
					<h3 style="margin: 10px;">New Music</h3>
				</div>
				<div>
					<div id="m_content"
						style="display: grid; grid-template-columns: repeat(5, 200px); grid-auto-columns: 200px; grid-gap: 20px; flex-flow: row wrap;">
					</div>
				</div>
				<hr>

			</div>


		</main>
		<div id="playlist"
			style="padding: 10px; border: 1px solid lightgray; position: fixed; right: 0; height: 100%; width: 300px; background: #f9f9f9; overflow: auto; display: none; opacity: 0.95;">
			<h3>PlayList</h3>
			<hr color="lightgray">
			<ul id="pl-musiclist" style="list-style-type: none;">



			</ul>
		</div>
	</div>


</body>
</html>