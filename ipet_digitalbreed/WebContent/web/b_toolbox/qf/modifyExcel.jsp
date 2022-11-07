<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	int excel_id = Integer.parseInt(request.getParameter("excel_id"));
	String column_name = request.getParameter("column_name");
	int row_index = Integer.parseInt(request.getParameter("row_index"));
	String new_value = request.getParameter("new_value");
	
	System.out.println("====================================");
	System.out.println("excel_id : " + excel_id);
	System.out.println("column_name : " + column_name);
	System.out.println("row_index : " + row_index);
	System.out.println("new_value : " + new_value);
	System.out.println("====================================");
	
	
 	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	try{
		//파일 이름 insert
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String updateSql = "update test_excel_contents set row_contents = json_set(row_contents, '$." +column_name+ "', '" +new_value+ "') where excel_id = " +excel_id+ " and row_index = " +row_index;
		System.out.println("updateSql : " + updateSql);
		
		ipetdigitalconndb.stmt.executeUpdate(updateSql);
		
		
		
	} catch(Exception e) {
		System.out.println(e);
	} finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}

	
	
	
%>