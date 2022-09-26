<%@page import="org.json.simple.JSONArray"%>
<%@page import="ipet_digitalbreed.*"%>    
<%@page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%

	//MinimalMarkerListJson minimalMarkerListJson = new MinimalMarkerListJson();
	GenotypeAnalysisListJson minimalMarkerListJson = new GenotypeAnalysisListJson();

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");

	JSONArray minimalMarkerListJsonValues = minimalMarkerListJson.getMinimalMarkerListJson(permissionUid, varietyid);
	
	//System.out.println(varietyid);
	//System.out.println(GenotypeListJsonValues);

	response.setHeader("Access-Control-Allow-Origin", "*");
	response.setHeader("Access-Control-Allow-Credentials", "true");
	response.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
	response.setHeader("Access-Control-Allow-Headers", "Authorization,DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type");
	response.setContentType("application/json");
	
	out.print(minimalMarkerListJsonValues.toJSONString());	
%>



