<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>  
<%
	String jobid = request.getParameter("jobid");
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	List<String> chrnoList = new LinkedList<>();
	try {
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		String chrnoSql = "select distinct chrno from chr_pos_t where jobid = '" +jobid+ "'order by no;";
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(chrnoSql);
		while(ipetdigitalconndb.rs.next()) {
			chrnoList.add(ipetdigitalconndb.rs.getString("chrno"));
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	out.clear();
	out.print(chrnoList);
%>