<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>    
<%

	int excel_id = Integer.parseInt(request.getParameter("excel_id"));
	String[] row_index_arr = request.getParameterValues("row_index_arr[]");

	System.out.println("====================================");
	System.out.println("excel_id : " + excel_id);
	System.out.println("row_index_arr : " + Arrays.toString(row_index_arr));
	System.out.println("====================================");
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	try{
		//파일 이름 insert
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String deleteSql = "delete from test_excel_contents where excel_id = " +excel_id+ " and (row_index = ";

		for(int i=0 ; i<row_index_arr.length ; i++) {
			deleteSql += row_index_arr[i];
			
			if(i == row_index_arr.length - 1) {
				deleteSql += ")";
			} else {
				deleteSql += " or row_index = ";
			}
					
		}
		
		System.out.println("deleteSql : " + deleteSql);
		ipetdigitalconndb.stmt.executeUpdate(deleteSql);
	} catch(Exception e) {
		System.out.println(e);
	} finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}

	
	
	
%>