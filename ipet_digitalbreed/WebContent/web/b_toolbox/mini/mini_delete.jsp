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
	
	//System.out.println(Arrays.toString(deleteitems));

	try{
		for (int i = 0; i < deleteitems.length; i++) {
			deleteSql = "delete from mini_info_t where no='"+deleteitems[i]+"';";	    
		    ipetdigitalconndb.stmt.executeUpdate(deleteSql);
		}
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}	
	
%>