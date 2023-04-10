<%@page import="org.json.simple.JSONArray"%>
<%@page import="ipet_digitalbreed.*"%>    
<%@page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	JsonArray jsonArray = new JsonArray();

	try{
		String sql="select no, cropid, filename, status, uploadpath, resultpath, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt  from ideogram_t where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' order by no desc;";
		//System.out.println(sql);
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		while (ipetdigitalconndb.rs.next()) { 
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("no",ipetdigitalconndb.rs.getString("no"));
			jsonObject.addProperty("file_name",ipetdigitalconndb.rs.getString("filename"));
			jsonObject.addProperty("status",ipetdigitalconndb.rs.getString("status"));
			jsonObject.addProperty("uploadpath",ipetdigitalconndb.rs.getString("uploadpath"));
			jsonObject.addProperty("resultpath",ipetdigitalconndb.rs.getString("resultpath"));
			jsonObject.addProperty("comment",ipetdigitalconndb.rs.getString("comment"));
			jsonObject.addProperty("cropid",ipetdigitalconndb.rs.getString("cropid"));
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
	
	response.setHeader("Access-Control-Allow-Origin", "*");
	response.setHeader("Access-Control-Allow-Credentials", "true");
	response.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
	response.setHeader("Access-Control-Allow-Headers", "Authorization,DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type");
	response.setContentType("application/json");
	
	out.clear();
	out.print(jsonArray);
%>



