<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="ipet_digitalbreed.*"%>
<%@ page import="java.util.*"%>      
<%-- 
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
--%>    
<%@ page import="com.google.gson.*" %>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");
	
	//JSONArray jsonArray = new JSONArray();
	JsonArray jsonArray = new JsonArray();

	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

		String sql = "select * from sampledata_info_t where varietyid='" +varietyid+ "' and creuser='" +permissionUid+ "' order by no DESC;";
		//System.out.println("sql : " + sql);
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		
		/*
		while (ipetdigitalconndb.rs.next()) { 	
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("no", ipetdigitalconndb.rs.getString("no"));
			jsonObj.addProperty("samplename", ipetdigitalconndb.rs.getString("samplename"));
			jsonObj.addProperty("cre_dt", ipetdigitalconndb.rs.getString("cre_dt").split(" ")[0]);
			jsonObj.addProperty("act_dt", ipetdigitalconndb.rs.getString("act_dt"));
			jsonArray.add(jsonObj);
		}
		*/
		for(int i=1 ; ipetdigitalconndb.rs.next() ; i++) { 	
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("row", i);
			jsonObj.addProperty("no", ipetdigitalconndb.rs.getString("no"));
			jsonObj.addProperty("samplename", ipetdigitalconndb.rs.getString("samplename"));
			jsonObj.addProperty("cre_dt", ipetdigitalconndb.rs.getString("cre_dt").split(" ")[0]);
			jsonObj.addProperty("act_dt", ipetdigitalconndb.rs.getString("act_dt"));
			jsonArray.add(jsonObj);
		}
	}catch(Exception e){
		System.out.println(e);
	}finally{ 
    	ipetdigitalconndb.stmt.close();
    	ipetdigitalconndb.rs.close();
    	ipetdigitalconndb.conn.close();
    }
	
	//System.out.println(jsonArray);
	out.clear();
	out.print(jsonArray);
		
%>