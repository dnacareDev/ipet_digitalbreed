<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String permissionUid = session.getAttribute("permissionUid")+"";

	String command = request.getParameter("command");
	
	String jobid = request.getParameter("jobid");
	String vb_selection_id = request.getParameter("vb_selection_id");
	String column = request.getParameter("column");
	String value = request.getParameter("value");
	String chr = "";
	String pos = "";
	
	System.out.println(jobid);
	System.out.println(vb_selection_id);
	System.out.println(column);
	System.out.println(value);
	
	
	
	switch(command) {
		case "add":
			chr = request.getParameter("chr");
			pos = request.getParameter("pos");
			transactionAdd(permissionUid, chr, pos, jobid, column, value);
			break;
		case "update":
			transactionUpdate(permissionUid, jobid, vb_selection_id, column, value);
			break;
		case "delete":
			chr = request.getParameter("chr");
			pos = request.getParameter("pos");
			transactionDelete(permissionUid, chr, pos, jobid);
			break;
		default:
			System.out.println("switch null");
	}
	

	
%>

<%!
	public void transactionAdd(String permissionUid, String chr, String pos, String jobid, String column, String value) throws SQLException {
	
		
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		try {
			
			String sql = "";
			switch(column) {
				case "snpeff":
					sql = "insert into variant_browser_selection (chr, pos, snpeff, gwas, marker_candidate, jobid, creuser, cre_dt) values ('" +chr+ "', " +pos+ ", true, false, false, '" +jobid+ "', '" +permissionUid+ "', now());";
					break;
				case "gwas":
					sql = "insert into variant_browser_selection (chr, pos, snpeff, gwas, marker_candidate, jobid, creuser, cre_dt) values ('" +chr+ "', " +pos+ ", false, true, false, '" +jobid+ "', '" +permissionUid+ "', now());";
					break;
				case "marker_candidate":
					sql = "insert into variant_browser_selection (chr, pos, snpeff, gwas, marker_candidate, jobid, creuser, cre_dt) values ('" +chr+ "', " +pos+ ", false, false, true, '" +jobid+ "', '" +permissionUid+ "', now());";
					break;
			}
			
			 
			System.out.println(sql);
			ipetdigitalconndb.stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("error - vb_features_grid_Selection - " + e);
			e.printStackTrace();
		} finally {
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
		
	} 
%>

<%!
	public void transactionUpdate(String permissionUid, String jobid, String vb_selection_id, String column, String value) throws SQLException {
	
		
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		try {
			
		
			String sql = "update variant_browser_selection set " +column+ "=" +value+ " where vb_selection_id=" +vb_selection_id+ " and jobid='" +jobid+"';";
			System.out.println(sql);
			ipetdigitalconndb.stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("error - vb_features_grid_Selection - " + e);
			e.printStackTrace();
		} finally {
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
	} 
%>


<%!
	public void transactionDelete(String permissionUid, String chr, String pos, String jobid) throws SQLException {
	
		
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		try {
			
			String sql = "delete from variant_browser_selection where chr='" +chr+ "' and pos=" +pos+ " and jobid='" +jobid+ "';";
			System.out.println(sql);
			ipetdigitalconndb.stmt.executeUpdate(sql);
			
		} catch (Exception e) {
			System.out.println("error - vb_features_grid_Selection - " + e);
			e.printStackTrace();
		} finally {
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
		
	} 
%>
