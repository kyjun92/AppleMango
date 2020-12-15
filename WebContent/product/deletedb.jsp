<%@page import="Product.ProductDAO"%>
<%@page import="Product.ShoppingListVO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>

<%
	String l_id1 = request.getParameter("l_id");
	System.out.println(l_id1);
	int l_id = Integer.parseInt(l_id1);
	System.out.println(l_id);
	ProductDAO dao = new ProductDAO();
	boolean result = dao.delete(l_id);
%><%=result%>