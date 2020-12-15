<%@page import="java.util.ArrayList"%>
<%@page import="java.util.List"%>
<%@page import="login.BbsDAO"%>
<%@page import="login.BbsVO"%>
<%@page import="java.util.List"%> 
<%@page import="java.util.ArrayList"%>
<%@page import="javax.security.auth.callback.ConfirmationCallback"%>
<%@ page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <%
    	request.setCharacterEncoding("UTF-8");
    %>
    
  <%
      	String bbstitle = request.getParameter("bbstitle");
      %> 
    
   	
    
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
	<!-- 뷰포트 -->
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<!-- 뷰포트 -->
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<!-- 스타일시트 참조  -->
	<title>AppleMango 게시판 웹사이트</title>
	<link rel="stylesheet" href="css/styles.css">
	<link rel="icon" type="image/x-icon" href="assets/img/favicon.ico" />
	<!-- Google fonts-->
<link href="https://fonts.googleapis.com/css?family=Montserrat:400,700"
	rel="stylesheet" type="text/css" />
<link
	href="https://fonts.googleapis.com/css?family=Lato:400,700,400italic,700italic"
	rel="stylesheet" type="text/css" />
	<script src="https://use.fontawesome.com/releases/v5.13.0/js/all.js"
	crossorigin="anonymous"></script>
  <script src="https://ajax.googleapis.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
  <script src="https://maxcdn.bootstrapcdn.com/bootstrap/3.4.1/js/bootstrap.min.js"></script>
 <script type="text/javascript">
 function check(){
	 search = document.getElementById('search').value
	  
	  if(search.length == 0){
		  location.href = "bbs.jsp";
	  }else{
		  document.getElementById('form').submit();
		  return false;
	  }
 }
 
 
 </script>
 	<style type="text/css">
a, a:hover {
	color: #000000;
	text-decoration: none;
}

.head {
	padding-top: calc(6rem);
	padding-bottom: 4rem;
}
#img{
	width : 100%;
 	height : 300px;
	background-repeat: no-repeat;
}
#search{
	width : 500px;
	margin-top : 85px;
	margin-left : 300px;
	height : 60px
}
#search1{
	width : 100px;
	margin-top : 20px;
	margin-left : 500px;
	height : 30px
	
}
</style>
 


</head>
<body>
<nav class="navbar navbar-expand-lg bg-secondary text-uppercase fixed-top" id="mainNav" style="background : #000 !important;">
            <div class="container">
                <a class="navbar-brand js-scroll-trigger" href="../index.html"><img style="width: 50px" src="img/full_color.png" alt="" />AppleMANGO</a>
                <button class="navbar-toggler navbar-toggler-right text-uppercase font-weight-bold bg-secondary text-white rounded" type="button" data-toggle="collapse" data-target="#navbarResponsive" aria-controls="navbarResponsive" aria-expanded="false" aria-label="Toggle navigation">
                    Menu
                    <i class="fas fa-bars"></i>
                </button>
                <div class="collapse navbar-collapse" id="navbarResponsive">
                    <ul class="navbar-nav ml-auto">
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="../product/product_all.jsp">Products</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="../music/New.jsp">Music</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="customer.jsp">고객지원</a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a style="padding: 5px" class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="../product/call_list.jsp"><img style="width: 30px" src="img/cart.png" alt="" /></a></li>
                        <li class="nav-item mx-0 mx-lg-1"><a class="nav-link py-3 px-0 px-lg-3 rounded js-scroll-trigger" href="memlogin.html">Login</a></li>
                    </ul>
                </div>
            </div>
        </nav>
    <a href="bbs.jsp" class="btn btn-success btn-arrow-left">AppleMango 게시판</a>
	<a href="asdfasdfa" class="btn btn-success btn-arrow-left">AppleMango 메 인</a>
<%
	//로긴한사람이라면	 userID라는 변수에 해당 아이디가 담기고 그렇지 않으면 null값
	String id = null;
	if (session.getAttribute("id") != null) {
		id = (String) session.getAttribute("id");
	}
int bbstitle1 = 1;
	int pageNumber = 1; //기본 페이지 넘버
	//페이지넘버값이 있을때
	if (request.getParameter("pageNumber") != null) {
		pageNumber = Integer.parseInt(request.getParameter("pageNumber"));
	}
%>
<div class="container">
<form action="bbssearch.jsp">
<div class="head">
  <div id="img" class="form-group" style="background-image: url('img/3.JPG')">
	<label>AppleMango search</label>
     <input type="text" class="form-control" name="bbstitle"  id="search"
      placeholder="search" >
      <input style="background-color: #2c3e50; color:white; "  type="submit" class="form-control" onclick="check()" value="검색"  id="search1" value="검색" name="bbstitle" >
  	</div>

 </div>  
</form>
				<%
					//라긴안된경우
						if (id == null) {
				%>

				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
 						aria-expanded="false">접속하기<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="login.html">로그인</a></li>
							<li><a href="join.jsp">회원가입</a></li>
						</ul></li>
				</ul>
				<%
					} else {
				%>
				<ul class="nav navbar-nav navbar-right">
					<li class="dropdown"><a href="#" class="dropdown-toggle"
						data-toggle="dropdown" role="button" aria-haspopup="true"
						aria-expanded="false">회원관리<span class="caret"></span></a>
						<ul class="dropdown-menu">
							<li><a href="logoutAction.jsp">로그아웃</a></li>
						</ul></li>
				</ul>
				<%
					}
				%>
			</div>

		<!-- 게시판 -->
		<div class="container">
			<div class="row">
				<table class="table table-striped"
					style="text-align: center; table-layout: fixed; border: 1px solid #dddddd">
					<thead>
						<tr>
							<th style="background-color:  #2c3e50; color:white; width:10%; text-align: center;">번호</th>
							<th style="background-color:  #2c3e50; color:white; width:50%; ">제목</th>
							
							<th style="background-color:  #2c3e50; color:white; width:15%; ">작성자</th>
							<th style="background-color:  #2c3e50; color:white; width:15%; ">작성일</th>
							<th style="background-color:  #2c3e50; color:white; width:10%; ">조회수</th>
						</tr>
					</thead>
					<tbody>

						<%
										BbsDAO bbsDAO = new BbsDAO();
										ArrayList<BbsVO> list1 = bbsDAO.getList(pageNumber);
										
										BbsDAO dao = new BbsDAO();
										List<BbsVO> list = dao.search(bbstitle);
										for (int i = 0; i < list.size(); i++) {
						%>
						<tr>
							<td style="background-color: white;"><%=list.get(i).getBbsID()%></td>
							<th style="background-color: white; white-space: nowrap; overflow: hidden; text-overflow: ellipsis;"><a href="bbsview.jsp?bbsID=<%=list.get(i).getBbsID()%>"><%=list.get(i).getBbsTitle()%></a><br>
							</th>

							<td style="background-color: white;"><%=list.get(i).getId()%></td>
							<td style="background-color: white;"><%=list.get(i).getBbsDate().substring(0, 11) + list.get(i).getBbsDate().substring(11, 13) + "시" 
							+ list.get(i).getBbsDate().substring(14, 16) + "분" %></td>
							<th style="background-color: white;"><%=list.get(i).getBbsCount()%></th>
						</tr>
						<%
							}
						%>
					</tbody>


				</table>
				<!-- 페이지 넘기기 -->
			    	<%
					if (pageNumber != 1) {
				%>
				<a style="background-color: #2c3e50;" href="bbssearch.jsp?pageNumber=<%=pageNumber - 1%>"
					class="btn btn-success btn-arrow-left">이전</a>
				<%
					}
					if (dao.nextPage(pageNumber)) {
				%>
				<a style="background-color: #2c3e50;" href="bbssearch.jsp?pageNumber=<%=pageNumber + 1%>"
					class="btn btn-success btn-arrow-left">다음</a>
				<%
					}
				%>

	

	

				<!-- 회원만넘어가도록 -->
				<%
					//if logined userID라는 변수에 해당 아이디가 담기고 if not null
					if (session.getAttribute("id") != null) {
				%>
				<a style="background-color: #2c3e50;" href="bbswrite.jsp" class="btn btn-primary pull-right">글쓰기</a>
				<%
					} else {
				%>
				<button style="background-color: #2c3e50;" class="btn btn-primary pull-right"
					onclick="if(confirm('로그인 하세요'))location.href='memlogin.html';"
					type="button">글쓰기</button>
				<%
					}
				%>
				<a style="background-color: #2c3e50;" href="bbs.jsp?"
					class="btn btn-success btn-arrow-left">게시판 목록</a>
			</div>

		</div>

		<!-- 애니매이션 담당 JQUERY -->

		<script src="https://code.jquery.com/jquery-3.1.1.min.js"></script>

		<!-- 부트스트랩 JS  -->

		<script src="js/bootstrap.js"></script>
		<!-- Footer-->
        <footer class="footer text-center">
            <div class="container">
                <div class="row">
                    <!-- Footer Location-->
                    <div class="col-lg-4 mb-5 mb-lg-0">
                        <h4 class="text-uppercase mb-4">Location</h4>
                        <p class="lead mb-0">
                          	  서울특별시 마포구 신촌로 94,
                            <br />
                           	 7층(노고산동, 그랜드플라자)
                        </p>
                    </div>
                    <!-- Footer Social Icons-->
                    <div class="col-lg-4 mb-5 mb-lg-0">
                        <h4 class="text-uppercase mb-4">Around the Web</h4>
                        <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-facebook-f"></i></a>
                        <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-twitter"></i></a>
                        <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-linkedin-in"></i></a>
                        <a class="btn btn-outline-light btn-social mx-1" href="#!"><i class="fab fa-fw fa-dribbble"></i></a>
                    </div>
                    <!-- Footer About Text-->
                    <div class="col-lg-4">
                        <h4 class="text-uppercase mb-4">About Freelancer</h4>
                        <p class="lead mb-0">
                            Freelance is a free to use, MIT licensed Bootstrap theme created by
                            <a href="http://startbootstrap.com">Start Bootstrap</a>
                            .
                        </p>
                    </div>
                </div>
            </div>
        </footer>
         <!-- Copyright Section-->
        <div class="copyright py-4 text-center text-white">
            <div class="container"><small>Copyright © AppleMango 2020</small></div>
        </div>
        <!-- Scroll to Top Button (Only visible on small and extra-small screen sizes)-->
        <div class="scroll-to-top d-lg-none position-fixed">
            <a class="js-scroll-trigger d-block text-center text-white rounded" href="#page-top"><i class="fa fa-chevron-up"></i></a>
        </div>
        <!-- Portfolio Modals-->
        <!-- Portfolio Modal 1-->
        <div class="portfolio-modal modal fade" id="portfolioModal1" tabindex="-1" role="dialog" aria-labelledby="portfolioModal1Label" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fas fa-times"></i></span>
                    </button>
                    <div class="modal-body text-center">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <!-- Portfolio Modal - Title-->
                                    <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0" id="portfolioModal1Label">Log Cabin</h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <!-- Portfolio Modal - Image-->
                                    <img class="img-fluid rounded mb-5" src="assets/img/portfolio/cabin.png" alt="" />
                                    <!-- Portfolio Modal - Text-->
                                    <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia neque assumenda ipsam nihil, molestias magnam, recusandae quos quis inventore quisquam velit asperiores, vitae? Reprehenderit soluta, eos quod consequuntur itaque. Nam.</p>
                                    <button class="btn btn-primary" data-dismiss="modal">
                                        <i class="fas fa-times fa-fw"></i>
                                        Close Window
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio Modal 2-->
        <div class="portfolio-modal modal fade" id="portfolioModal2" tabindex="-1" role="dialog" aria-labelledby="portfolioModal2Label" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fas fa-times"></i></span>
                    </button>
                    <div class="modal-body text-center">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <!-- Portfolio Modal - Title-->
                                    <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0" id="portfolioModal2Label">Tasty Cake</h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <!-- Portfolio Modal - Image-->
                                    <img class="img-fluid rounded mb-5" src="assets/img/portfolio/cake.png" alt="" />
                                    <!-- Portfolio Modal - Text-->
                                    <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia neque assumenda ipsam nihil, molestias magnam, recusandae quos quis inventore quisquam velit asperiores, vitae? Reprehenderit soluta, eos quod consequuntur itaque. Nam.</p>
                                    <button class="btn btn-primary" data-dismiss="modal">
                                        <i class="fas fa-times fa-fw"></i>
                                        Close Window
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio Modal 3-->
        <div class="portfolio-modal modal fade" id="portfolioModal3" tabindex="-1" role="dialog" aria-labelledby="portfolioModal3Label" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fas fa-times"></i></span>
                    </button>
                    <div class="modal-body text-center">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <!-- Portfolio Modal - Title-->
                                    <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0" id="portfolioModal3Label">Circus Tent</h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <!-- Portfolio Modal - Image-->
                                    <img class="img-fluid rounded mb-5" src="assets/img/portfolio/circus.png" alt="" />
                                    <!-- Portfolio Modal - Text-->
                                    <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia neque assumenda ipsam nihil, molestias magnam, recusandae quos quis inventore quisquam velit asperiores, vitae? Reprehenderit soluta, eos quod consequuntur itaque. Nam.</p>
                                    <button class="btn btn-primary" data-dismiss="modal">
                                        <i class="fas fa-times fa-fw"></i>
                                        Close Window
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio Modal 4-->
        <div class="portfolio-modal modal fade" id="portfolioModal4" tabindex="-1" role="dialog" aria-labelledby="portfolioModal4Label" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fas fa-times"></i></span>
                    </button>
                    <div class="modal-body text-center">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <!-- Portfolio Modal - Title-->
                                    <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0" id="portfolioModal4Label">Controller</h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <!-- Portfolio Modal - Image-->
                                    <img class="img-fluid rounded mb-5" src="assets/img/portfolio/game.png" alt="" />
                                    <!-- Portfolio Modal - Text-->
                                    <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia neque assumenda ipsam nihil, molestias magnam, recusandae quos quis inventore quisquam velit asperiores, vitae? Reprehenderit soluta, eos quod consequuntur itaque. Nam.</p>
                                    <button class="btn btn-primary" data-dismiss="modal">
                                        <i class="fas fa-times fa-fw"></i>
                                        Close Window
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio Modal 5-->
        <div class="portfolio-modal modal fade" id="portfolioModal5" tabindex="-1" role="dialog" aria-labelledby="portfolioModal5Label" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fas fa-times"></i></span>
                    </button>
                    <div class="modal-body text-center">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <!-- Portfolio Modal - Title-->
                                    <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0" id="portfolioModal5Label">Locked Safe</h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <!-- Portfolio Modal - Image-->
                                    <img class="img-fluid rounded mb-5" src="assets/img/portfolio/safe.png" alt="" />
                                    <!-- Portfolio Modal - Text-->
                                    <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia neque assumenda ipsam nihil, molestias magnam, recusandae quos quis inventore quisquam velit asperiores, vitae? Reprehenderit soluta, eos quod consequuntur itaque. Nam.</p>
                                    <button class="btn btn-primary" data-dismiss="modal">
                                        <i class="fas fa-times fa-fw"></i>
                                        Close Window
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Portfolio Modal 6-->
        <div class="portfolio-modal modal fade" id="portfolioModal6" tabindex="-1" role="dialog" aria-labelledby="portfolioModal6Label" aria-hidden="true">
            <div class="modal-dialog modal-xl" role="document">
                <div class="modal-content">
                    <button class="close" type="button" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="fas fa-times"></i></span>
                    </button>
                    <div class="modal-body text-center">
                        <div class="container">
                            <div class="row justify-content-center">
                                <div class="col-lg-8">
                                    <!-- Portfolio Modal - Title-->
                                    <h2 class="portfolio-modal-title text-secondary text-uppercase mb-0" id="portfolioModal6Label">Submarine</h2>
                                    <!-- Icon Divider-->
                                    <div class="divider-custom">
                                        <div class="divider-custom-line"></div>
                                        <div class="divider-custom-icon"><i class="fas fa-star"></i></div>
                                        <div class="divider-custom-line"></div>
                                    </div>
                                    <!-- Portfolio Modal - Image-->
                                    <img class="img-fluid rounded mb-5" src="assets/img/portfolio/submarine.png" alt="" />
                                    <!-- Portfolio Modal - Text-->
                                    <p class="mb-5">Lorem ipsum dolor sit amet, consectetur adipisicing elit. Mollitia neque assumenda ipsam nihil, molestias magnam, recusandae quos quis inventore quisquam velit asperiores, vitae? Reprehenderit soluta, eos quod consequuntur itaque. Nam.</p>
                                    <button class="btn btn-primary" data-dismiss="modal">
                                        <i class="fas fa-times fa-fw"></i>
                                        Close Window
                                    </button>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
        <!-- Bootstrap core JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.5.1/jquery.min.js"></script>
        <script src="https://stackpath.bootstrapcdn.com/bootstrap/4.5.0/js/bootstrap.bundle.min.js"></script>
        <!-- Third party plugin JS-->
        <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery-easing/1.4.1/jquery.easing.min.js"></script>
        <!-- Contact form JS-->
        <script src="assets/mail/jqBootstrapValidation.js"></script>
        <script src="assets/mail/contact_me.js"></script>
        <!-- Core theme JS-->
        <script src="js/scripts.js"></script>
</body>
</html>