<%@page import="music.VO"%>
<%@page import="java.util.ArrayList"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%><%
    
    String product = request.getParameter("product");
    String price = request.getParameter("price");
    
    VO vo = new VO();
    
    	ArrayList<VO> list = null;
   		
        if(session.getAttribute("basket") == null){
        list = new ArrayList<>();
        }else{
        	list =(ArrayList<VO>) session.getAttribute("basket");
        }
        if(product != null){
        list.add(vo);
   		}
        session.setAttribute("basket", list);
    %>
