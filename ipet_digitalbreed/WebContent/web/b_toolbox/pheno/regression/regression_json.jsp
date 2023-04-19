<%@page import="org.json.simple.JSONArray"%>
<%@page import="ipet_digitalbreed.*"%>    
<%@page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.google.gson.*"%>
<%

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");
	
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	JsonArray jsonArray = new JsonArray();

	try{

		String sql="select *, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt from regression_t where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' ORDER BY no DESC;";
		System.out.println(sql);
		
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		while (ipetdigitalconndb.rs.next()) { 
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("no",ipetdigitalconndb.rs.getInt("no"));
			jsonObject.addProperty("status",ipetdigitalconndb.rs.getString("status"));
			jsonObject.addProperty("comment",ipetdigitalconndb.rs.getString("comment"));
			jsonObject.addProperty("analysis_number",ipetdigitalconndb.rs.getString("analysis_number"));
			jsonObject.addProperty("phenotype_independent",ipetdigitalconndb.rs.getString("phenotype_independent"));
			jsonObject.addProperty("phenotype_dependent",ipetdigitalconndb.rs.getString("phenotype_dependent"));
			jsonObject.addProperty("uploadpath",ipetdigitalconndb.rs.getString("uploadpath"));
			jsonObject.addProperty("resultpath",ipetdigitalconndb.rs.getString("resultpath"));
			jsonObject.addProperty("jobid",ipetdigitalconndb.rs.getString("jobid"));
			jsonObject.addProperty("cre_dt",ipetdigitalconndb.rs.getString("cre_dt"));
			jsonArray.add(jsonObject);
		}
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	out.print(jsonArray);
	
%>



