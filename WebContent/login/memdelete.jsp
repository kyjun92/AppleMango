<%@page import="java.io.PrintWriter"%>
<%@page import="login.SignVO"%>
<%@page import="login.SignDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
   
<!DOCTYPE html>
<html>
<head>
<meta charset="UTF-8">
<title>계정삭제1</title>
</head>
<body>

 <%
 	String id = request.getParameter("id");
      	String pw = request.getParameter("pw");
      	
          SignDAO dao = new SignDAO();//1~2단계
          SignVO vo = new SignVO();
          boolean result1 =dao.read(vo);
          
          SignDAO dao2 = new SignDAO();//1~2단계
          boolean result = dao2.delete(id);
          String check1 = "탈퇴처리중 문제가 발생함. 탈퇴처리가 되지 않음.";
          if(result == true){
          	PrintWriter script = response.getWriter();
          	check1 = "ok";
        	  	script.println("<script>");
        	    script.println("alert('AppleMango 계정삭제 완료')");
        	  	script.println("location.href='../index.html'");
        	  	script.println("</script>");
          }else if(result == false){
              PrintWriter script = response.getWriter();
         		check1 = "no";
         	    script.println("<script>");
   		    script.println("alert('AppleMango ID와 암호가 일지하지 않습니다.')");
   		    script.println("history.back()");
  		    script.println("</script>");
          }
 %>


</body>
</html>


