<%@page import="Product.ShoppingListVO"%>
<%@page import="Product.ProductDAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
	pageEncoding="UTF-8"%>
<jsp:useBean id="vo" class="Product.ShoppingListVO"></jsp:useBean>
<jsp:setProperty property="*" name="vo" />
<%
	ProductDAO dao = new ProductDAO();
	boolean result = dao.create(vo);
%><%=result%>
