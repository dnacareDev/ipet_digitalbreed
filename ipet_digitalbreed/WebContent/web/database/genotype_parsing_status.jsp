<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	String jobid = request.getParameter("jobid");
	//System.out.println("jobid : " + jobid);
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	String status = "";
	
	try {
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		String sql = "select status from vcf_parsing_status_t where jobid='" +jobid+"';";
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		while(ipetdigitalconndb.rs.next()) {
			status = ipetdigitalconndb.rs.getString("status");
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	out.clear();
	out.print(status);
%>