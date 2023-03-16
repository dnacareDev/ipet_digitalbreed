<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String permissionUid = session.getAttribute("permissionUid")+"";

	//String chr = request.getParameter("chr");
	String jobid = request.getParameter("jobid");
	
	JsonArray jsonArray = new JsonArray();

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	try {
		
	
		//String sql = "select * from variant_browser_selection where jobid='"+jobid+"' and chr='"+chr+ "';";
		String sql = "select * from variant_browser_selection where jobid='"+jobid+"' order by chr, pos;";
		//System.out.println(sql);
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		
		while(ipetdigitalconndb.rs.next()) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("vb_selection_id", ipetdigitalconndb.rs.getString("vb_selection_id"));
			jsonObject.addProperty("row_id", ipetdigitalconndb.rs.getString("chr") +"_"+ ipetdigitalconndb.rs.getString("pos"));
			jsonObject.addProperty("chr", ipetdigitalconndb.rs.getString("chr"));
			jsonObject.addProperty("pos", ipetdigitalconndb.rs.getInt("pos"));
			jsonObject.addProperty("snpeff", (ipetdigitalconndb.rs.getInt("snpeff") == 1 ? true : false ));
			jsonObject.addProperty("gwas", (ipetdigitalconndb.rs.getInt("gwas") == 1 ? true : false ));
			jsonObject.addProperty("marker_candidate", (ipetdigitalconndb.rs.getInt("marker_candidate") == 1 ? true : false ));
			jsonArray.add(jsonObject);
		}
	
	} catch (Exception e) {
		System.out.println("error - vb_features_grid_Selection - " + e);
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	out.clear();
	out.print(jsonArray);
%>

