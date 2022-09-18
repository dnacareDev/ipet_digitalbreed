<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	String deleteSql=null;
	   
	String[] imgnoArray = request.getParameterValues("imgnoArray[]");
	String[] cmtArray = request.getParameterValues("cmtArray[]");
	
	try{
		for (int i = 1; i < imgnoArray.length; i++) {
			deleteSql = "update sampledata_img_t set comment='"+cmtArray[i]+"' where no='"+imgnoArray[i]+"';";	    
		    ipetdigitalconndb.stmt.executeUpdate(deleteSql);		
		}
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}	
	
%>