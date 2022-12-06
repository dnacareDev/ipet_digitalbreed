<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="ipet_digitalbreed.*"%>
<%@ page import="org.json.simple.*" %>    
<%

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	
	String permissionUid = session.getAttribute("permissionUid")+"";
	
	JSONArray jsonArray = new JSONArray();
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		String sql = "select no, logid, menuname, comment, date_format(cre_dt, '%Y-%m-%d') cre_dt from log_t where logid='" +permissionUid+ "' limit 12;";
		//System.out.println(sql);
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		
     		JSONObject jsonObject = new JSONObject();
     		
     		jsonObject.put("no",ipetdigitalconndb.rs.getString("no"));
     		jsonObject.put("logid",ipetdigitalconndb.rs.getString("logid"));
     		jsonObject.put("menuname",ipetdigitalconndb.rs.getString("menuname"));
     		jsonObject.put("comment",ipetdigitalconndb.rs.getString("comment"));
     		jsonObject.put("cre_dt",ipetdigitalconndb.rs.getString("cre_dt"));
     		jsonArray.add(jsonObject);
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	//System.out.println(jsonArray);
	
	out.clear();
	out.print(jsonArray);
	
	

%>