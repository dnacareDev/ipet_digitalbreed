<%@page import="org.json.simple.JSONArray"%>
<%@page import="ipet_digitalbreed.*"%>    
<%@page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%
	GwasListJson gwasListJson = new GwasListJson();

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");

	JSONArray gwasListJsonValues = gwasListJson.getGwasListJson(permissionUid, varietyid);
	
	//System.out.println(varietyid);
	//System.out.println(gwasListJsonValues);

	response.setHeader("Access-Control-Allow-Origin", "*");
	response.setHeader("Access-Control-Allow-Credentials", "true");
	response.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
	response.setHeader("Access-Control-Allow-Headers", "Authorization,DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type");
	response.setContentType("application/json");
	
	out.print(gwasListJsonValues.toJSONString());	
%>



