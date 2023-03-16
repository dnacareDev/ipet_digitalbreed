<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.* "%>
<%@ page import="com.google.gson.JsonArray, com.google.gson.JsonObject " %>
<%@ page import="ipet_digitalbreed.* "%>
<%
	String permissionUid = session.getAttribute("permissionUid")+"";
	
	int vcf_id = Integer.parseInt(request.getParameter("vcf_id"));
	int row_count = Integer.parseInt(request.getParameter("row_count"));
	String chr = request.getParameter("chr");
	String jobid = request.getParameter("jobid");
	
	JsonArray jsonArray = new JsonArray();
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	try {
		String sql = "select vcf_id, position from vcfviewer_t where vcf_id>=" +vcf_id+ " and vcf_id<=" +(vcf_id + row_count)+ " and chr='" +chr+"' and jobid='" +jobid+ "';";
		System.out.println(sql);
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		
		while(ipetdigitalconndb.rs.next()) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("vcf_id", ipetdigitalconndb.rs.getString("vcf_id"));
			jsonObject.addProperty("position", ipetdigitalconndb.rs.getString("position"));
			
			jsonArray.add(jsonObject);
		}
		
	} catch (SQLException e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	/*
	try { 
		String sql = "select position from vcfviewer_t where vcf_id>=? and vcf_id<=? and chr=? and jobid=?";
		ipetdigitalconndb.pstmt = ipetdigitalconndb.conn.prepareStatement(sql);
		ipetdigitalconndb.pstmt.setInt(1, vcf_id);
		ipetdigitalconndb.pstmt.setInt(2, vcf_id + row_count - 1);
		ipetdigitalconndb.pstmt.setString(3, chr);
		ipetdigitalconndb.pstmt.setString(4, jobid);
		
		System.out.println(ipetdigitalconndb.pstmt);
		
		ipetdigitalconndb.rs = ipetdigitalconndb.pstmt.executeQuery();
		while(ipetdigitalconndb.rs.next()) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("position", ipetdigitalconndb.rs.getString("position"));
			
			jsonArray.add(jsonObject);
		}
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		if(ipetdigitalconndb.rs != null) {ipetdigitalconndb.rs.close();}
		if(ipetdigitalconndb.pstmt != null) {ipetdigitalconndb.pstmt.close();}
		if(ipetdigitalconndb.conn != null) {ipetdigitalconndb.conn.close();}
	}
	*/
	
	//System.out.println(jsonArray);
	out.clear();
	out.print(jsonArray);
	
%>