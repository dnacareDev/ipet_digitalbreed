<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	String deleteSql=null;
	
	String[] deleteitems = request.getParameterValues("params[]");

	String[] change_target = deleteitems[0].split("\\n");
	
	for(int i=1;i<change_target.length;i++) {
	    System.out.println(change_target[i]+" N");
	}	
%>