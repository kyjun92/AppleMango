<%@page import="org.json.simple.JSONObject"%>
<%@page import="music.DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    String id = request.getParameter("id");
    
    DAO dao = new DAO();
    JSONObject json = dao.one_m_load(id);
    %><%=json %>
