<%@page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>

<%
	//String permissionUid = request.getParameter("permissionUid");
	String permissionUid = "dnacare";
	session.setAttribute("permissionUid", permissionUid);
%>