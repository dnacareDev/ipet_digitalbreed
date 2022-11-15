<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	String jobid = request.getParameter("jobid");

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	JSONArray jsonArray = new JSONArray();
	try {
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		String sql = "select 'position', GROUP_CONCAT(distinct accession order by no SEPARATOR ',') as 'chr_pos' from accession_t where jobid='20221112211631' union all SELECT pos, GROUP_CONCAT(genotype order by no SEPARATOR ',') FROM accession_t where jobid='20221112211631' GROUP BY pos;";
		System.out.println("sql : " + sql);
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		while (ipetdigitalconndb.rs.next()) { 
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("column_0", ipetdigitalconndb.rs.getString("position"));
			
			String[] tokens = ipetdigitalconndb.rs.getString("chr_pos").split(",");
			for(int i=0 ; i<tokens.length ; i++) {
				jsonObj.addProperty("column_"+(i+1), tokens[i]);
			}
			
			jsonArray.add(jsonObj);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	//System.out.println(jsonArray);
	out.clear();
	out.print(jsonArray);
	
%>