<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	String file_name = request.getParameter("file_name");
	int new_excel_id = Integer.parseInt(request.getParameter("new_excel_id"));
	int column_length = Integer.parseInt(request.getParameter("column_length"));
	String file_contents = request.getParameter("file_contents");
	
	System.out.println("====================================");
	System.out.println("file_name : " + file_name);
	System.out.println("new_excel_id : " + new_excel_id);
	System.out.println("column_length : " + column_length);
	System.out.println("file_contents : " + file_contents);
	System.out.println("====================================");
	
	//String으로 받은 json을 List<Map<String,Object>로 배열화하는 방법을 몰라서 수동으로 배열화. 다른 방법이 있으면 그걸로 변경
	String contents_str = file_contents.replaceAll("\\[|\\]", "").replaceAll("\\},\\{", "\\}\\},\\{\\{");
	String[] json_arr = contents_str.split("\\},\\{");
	
	/*
	for(int i=0 ; i<json_arr.length ; i++) {
		System.out.println(json_arr[i]);
	}
	*/ 
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	try{
		//파일 이름 insert
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		String insertFileNameSql = "insert into test_excel_file (excel_id, file_name, column_length) values ('" +new_excel_id+ "','" +file_name+ "','" +column_length+ "')";
		ipetdigitalconndb.stmt.executeUpdate(insertFileNameSql);
		
		//파일 내용 insert
		ipetdigitalconndb.stmt1 = ipetdigitalconndb.conn.createStatement();

		String insertFileContentSql = "insert into test_excel_contents (excel_id, row_index, row_contents) values (";
		for(int i=0 ; i<json_arr.length ; i++) {
			insertFileContentSql += new_excel_id+ "," +i+ ",'" +json_arr[i]+ "')";
			
			if(i != json_arr.length - 1) {
				insertFileContentSql += ",(";
			}
		}
		System.out.println(insertFileContentSql);
		ipetdigitalconndb.stmt.executeUpdate(insertFileContentSql);
		
	} catch(Exception e) {
		System.out.println(e);
	} finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.stmt1.close();
		ipetdigitalconndb.conn.close();
	}
	

	
	
	
%>