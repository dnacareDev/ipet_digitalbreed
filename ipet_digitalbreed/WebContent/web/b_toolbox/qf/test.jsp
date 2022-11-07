<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>
    
<%
	int excel_id = Integer.parseInt(request.getParameter("excel_id"));
	
	//System.out.println("excel_id : " + excel_id);

	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb = new IPETDigitalConnDB();	
	JSONArray jsonArray = new JSONArray();
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		String sql="select * from test_excel_contents where excel_id = " +excel_id+ " order by row_index desc;";
		System.out.println("sql : " + sql);
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		while (ipetdigitalconndb.rs.next()) { 
			
			JsonObject jsonObj = JsonParser.parseString(ipetdigitalconndb.rs.getString("row_contents")).getAsJsonObject();
			
			jsonObj.addProperty("excel_id", ipetdigitalconndb.rs.getString("excel_id"));
			jsonObj.addProperty("row_index", ipetdigitalconndb.rs.getString("row_index"));
			
			jsonArray.add(jsonObj);
		}
	} catch(Exception e) {
		System.out.println(e);
	} finally { 
		ipetdigitalconndb.stmt.close();
		//ipetdigitalconndb.stmt1.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	out.print(jsonArray);
	
	
	//Test test = new Test();
	//out.print(test.testMethod2());
%>