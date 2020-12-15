<%@page import="music.VO"%>
<%@page import="music.DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    String id = (String) request.getAttribute("id");
    DAO dao = new DAO();
    String music_id = dao.load_list(id);
    
   
    
    %><%=music_id %>
