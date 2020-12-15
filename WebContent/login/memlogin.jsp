<%@page import="java.io.PrintWriter"%>
<%@page import="login.SignVO"%>
<%@page import="login.SignDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
 
                  
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">

	<!-- 뷰포트 -->
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<!-- 스타일시트 참조  -->
	<title>AppleMango 로그인</title>
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
		String id = request.getParameter("id");
		String pw = request.getParameter("pw");
		String name = request.getParameter("name");
		String check = null;
		SignDAO dao = new SignDAO();
		SignVO bag = new SignVO();
		bag.setId(id);
		bag.setPw(pw);
		bag.setName(name);
		boolean result1 = dao.read(bag);
		if (result1 == true) {
			PrintWriter script = response.getWriter();
			check = "ok";
			script.println("<script>");
			script.println("alert('환영합니다')");
			script.println("location.href='../index.jsp'");
			script.println("</script>");
			session.setAttribute("id", bag.getId());
			session.setAttribute("name", bag.getName());
		} else if (result1 == false) {
			PrintWriter script = response.getWriter();
			check = "no";
			script.println("<script>");
			script.println("alert('로그인 실패!')");
			script.println("history.back()");
			script.println("</script>");
		}

		session.setAttribute("id", bag.getId());
		session.setAttribute("name", bag.getName());
	%>




</body>
</html>