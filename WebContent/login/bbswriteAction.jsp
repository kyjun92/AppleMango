<%@page import="login.BbsVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="login.BbsDAO"%>
<!-- bbsdao의 클래스 가져옴 -->
<%@ page import="java.io.PrintWriter"%>
<!-- 자바 클래스 사용 -->
<%
	request.setCharacterEncoding("UTF-8");
	response.setContentType("text/html; charset=UTF-8"); //set으로쓰는습관들이세오.
%>

<!-- 한명의 회원정보를 담는 user클래스를 자바 빈즈로 사용 / scope:페이지 현재의 페이지에서만 사용-->

<jsp:useBean id="bean" class="login.BbsVO" scope="page" />
<!-- // Bbs bbs = new Bbs(); -->
<jsp:setProperty name="bean" property="bbsTitle" /><!-- bbs.setBbsTitle(requrst) -->
<jsp:setProperty name="bean" property="bbsContent" />

<%
	System.out.println(bean);
%>

<!DOCTYPE html>
<html>
<head>
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>AppleMango 게시판</title>
<link rel="stylesheet" href="css/styles.css">
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

</head>
<body>

<%
	String id = null;
		if (session.getAttribute("id") != null) {//유저아이디이름으로 세션이 존재하는 회원들은 
	id = (String) session.getAttribute("id");//유저아이디에 해당 세션값을 넣어준다.
		}
		if (id == null) {
	PrintWriter script = response.getWriter();
	script.println("<script>");
	script.println("alert('로그인을 하세요.')");
	script.println("location.href = 'memlogin.html'");
	script.println("</script>");
		} else {
	if (bean.getBbsTitle() == null || bean.getBbsContent() == null) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('입력이 안된 사항이 있습니다')");
		script.println("history.back()");
		script.println("</script>");
	} else {
		BbsDAO BbsDAO = new BbsDAO();
		int result = BbsDAO.write(bean.getBbsTitle(), id, bean.getBbsContent());
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글쓰기에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='bbs.jsp'");
			//script.println("history.back()");
			script.println("</script>");
		}
	}
		}
%>




</body>
</html>