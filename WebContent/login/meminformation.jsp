<%@page import="java.io.PrintWriter"%>
<%@page import="login.SignVO"%>
<%@page import="login.SignDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
    <jsp:useBean id="vo" class="login.SignVO"></jsp:useBean>
	<!-- useBean액션태그 : new를 가지고 객체생성, import역할 -->
	<jsp:setProperty property="*" name="vo"/>
	
	<%
	
	%>
    
        
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
	<!-- 뷰포트 -->
	<meta name="viewport" content="width=device-width" initial-scale="1">
	<!-- 스타일시트 참조  -->
	<title>AppleMango 회원 정보</title>
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
	

		SignDAO dao2 = new SignDAO();
		boolean result = dao2.update(vo);
		String check = "정보수정에 실패하였습니다.!!";
		if (result == true) {
			PrintWriter script = response.getWriter();
			check = "ok";
			script.println("<script>");
			script.println("alert('정보수정을 완료 하였습니다!')");
			script.println("location.href='../index.jsp'");
			script.println("</script>");
		} else if (result == false) {
			PrintWriter script = response.getWriter();
			check = "no";
			script.println("<script>");
			script.println("alert('정보수정을 다시 시도 해주세요')");
			script.println("history.back()");
			script.println("</script>");

		}
	%>



</body>
</html>

