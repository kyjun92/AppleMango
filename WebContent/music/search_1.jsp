<%@page import="music.DAO"%>
<%@page import="org.json.simple.JSONObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    String word = request.getParameter("word");
    DAO dao = new DAO();
    JSONObject result = dao.music_search_ajax1(word);
    
    %><%=result %>
