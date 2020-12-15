<%@page import="com.mysql.jdbc.PingTarget"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="music.VO"%>
<%@page import="music.DAO"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    int id = Integer.parseInt(request.getParameter("id"));
    DAO dao = new DAO();
    dao.num_play_update(id);

    JSONObject json = dao.file_read(id);
    
   	
    
    %><%=json%>
    