<%@page import="login.SignDAO"%>
<%@page import="login.SignDAO"%>
<%@page import="login.SignVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<%
	String id = request.getParameter("id");
	int result2;
	if (id.length() < 6) {
		result2 = 2;
	} else {
		SignDAO dao2 = new SignDAO();
		result2 = dao2.read(id);

	}
%><%=result2%>