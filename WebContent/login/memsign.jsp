<%@page import="java.io.PrintWriter"%>
<%@page import="login.SignDAO"%>
<%@page import="login.SignVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>


<jsp:useBean id="vo" class="login.SignVO"></jsp:useBean>
<jsp:setProperty property="*" name="vo" />
<%
	SignDAO dao = new SignDAO();
	boolean result = dao.create(vo);
%>
<%
	if (result == true) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('AppleMango 가입 완료')");
		script.println("location.href='memlogin.html'");
		script.println("</script>");
	} else if (result == false) {
		PrintWriter script = response.getWriter();
		script.println("<script>");
		script.println("alert('ⓘ AppleMango ID로 사용할 유효한 이메일 주소를 입력하십시오.')");
		script.println("history.back()");
		script.println("</script>");
	}
%>


<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>Sign</title>
</head>
<body>




</body>
</html>    
  
