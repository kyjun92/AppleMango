<%@page import="login.BbsVO"%>
<%@page import="login.BbsDAO"%>
<%@page import="java.io.PrintWriter"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<!DOCTYPE html>

<html>

<head>

<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">

<title>AppleMango</title>
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
		script.println("location.href = 'login.jsp'");
		script.println("</script>");
			} 
			int bbsID = 0;
			if(request.getParameter("bbsID") != null){
		bbsID = Integer.parseInt(request.getParameter("bbsID"));
			}
			if(bbsID == 0) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('유효하지 않은 글 입니다')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");
			}
			BbsVO bbs = new BbsDAO().getBbsVO(bbsID);
			if(!id.equals(bbs.getId())) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('권한이 없습니다')");
		script.println("location.href='bbs.jsp'");
		script.println("</script>");			
			}
			else{
		BbsDAO bbsDAO = new BbsDAO();
		int result = bbsDAO.delete(bbsID);
		if (result == -1) {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("alert('글 삭제에 실패했습니다')");
			script.println("history.back()");
			script.println("</script>");
		} else {
			PrintWriter script = response.getWriter();
			script.println("<script>");
			script.println("location.href='bbs.jsp'");
			script.println("</script>");
		}
			}
	%>

</body>

</html>



