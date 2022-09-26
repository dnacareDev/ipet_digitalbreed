<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	String deleteSql=null;
	String seleccntSql=null;
	String updateSql=null;
	int imgcnt=0;
	
	String[] deleteitems = request.getParameterValues("params[]");
	String samplename = request.getParameter("samplename");
	String variety = request.getParameter("variety");

	try{
		for (int i = 0; i < deleteitems.length; i++) {
			deleteSql = "delete from sampledata_img_t where no='"+deleteitems[i]+"';";	    

		    ipetdigitalconndb.stmt.executeUpdate(deleteSql);
		}
		
		seleccntSql = "select count(*) as cnt from sampledata_img_t where samplename='"+samplename+"' and varietyid='"+variety+"';";	    

	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(seleccntSql);	
	    
	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		imgcnt =  Integer.parseInt(ipetdigitalconndb.rs.getString("cnt"));
	  	 }
	  	 
	  	 if(imgcnt==0){	  		 
	  		updateSql = "update sampledata_info_t set photo_status='0' where samplename='"+samplename+"' and varietyid='"+variety+"';";	

		    ipetdigitalconndb.stmt.executeUpdate(updateSql);
	  	 }
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}	
	
%>
