<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>    

<%

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();

	ipetdigitalconndb = new IPETDigitalConnDB();	
	//JSONArray jsonArray = new JSONArray();
	JsonArray jsonArray = new JsonArray();

	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

		String sql="select * from reference_genome_t where creuser='" +permissionUid+ "' and varietyid='" +varietyid+ "';";
		//String sql="select * from reference_genome_t where creuser='" +permissionUid+ "';";
		//System.out.println(sql);
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		while (ipetdigitalconndb.rs.next()) { 
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("refgenome_id", ipetdigitalconndb.rs.getString("refgenome_id"));
			jsonObject.addProperty("refgenome", ipetdigitalconndb.rs.getString("refgenome"));
			jsonObject.addProperty("gff", ipetdigitalconndb.rs.getString("gff"));
			
			jsonArray.add(jsonObject);
		}
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}

	//System.out.println(jsonArray);
	out.clear();
	out.print(jsonArray);
%>