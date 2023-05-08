<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>  
<%@ page import="com.google.gson.*" %>  

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	String varietyid = request.getParameter("varietyid");
	String update_cells = request.getParameter("update_cells");

	//System.out.println(varietyid);
	//System.out.println(update_cells);

	JsonArray jsonArray = new Gson().fromJson(update_cells, JsonArray.class);
	System.out.println(jsonArray);
	
	try {
		for(int i=0 ; i<jsonArray.size() ; i++) {
			JsonObject jsonObject = jsonArray.get(i).getAsJsonObject();
			String sql = "UPDATE sampledata_traitval_t SET value='"+jsonObject.get("newValue").getAsString()+"' WHERE sampleno="+jsonObject.get("sampleno").getAsString()+" and seq="+jsonObject.get("seq").getAsString()+";";
			//System.out.println(sql);
		}  
	} catch (Exception e) {
		System.out.println(e);
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	
%>