<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>    

<%

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	JsonArray jsonArray = new JsonArray();

	try{

		//String sql="select refgenome_id, crop_name, refgenome, gff, author, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from reference_genome_t where creuser='" +permissionUid+ "' and varietyid='" +varietyid+ "' order by refgenome_id DESC;";
		String sql="select *, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from reference_genome_t where creuser='" +permissionUid+ "' and varietyid='" +varietyid+ "' order by refgenome_id DESC;";
		System.out.println(sql);
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		while (ipetdigitalconndb.rs.next()) { 
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("refgenome_id", ipetdigitalconndb.rs.getInt("refgenome_id"));
			jsonObject.addProperty("crop_name", ipetdigitalconndb.rs.getString("crop_name"));
			jsonObject.addProperty("refgenome", ipetdigitalconndb.rs.getString("refgenome"));
			jsonObject.addProperty("gff", ipetdigitalconndb.rs.getString("gff"));
			jsonObject.addProperty("author", ipetdigitalconndb.rs.getString("author"));
			jsonObject.addProperty("fasta_filename", ipetdigitalconndb.rs.getString("fasta_filename"));
			jsonObject.addProperty("gff_filename", ipetdigitalconndb.rs.getString("gff_filename"));
			jsonObject.addProperty("gene_filename", ipetdigitalconndb.rs.getString("gene_filename"));
			jsonObject.addProperty("cds_filename", ipetdigitalconndb.rs.getString("cds_filename"));
			jsonObject.addProperty("annotation_filename", ipetdigitalconndb.rs.getString("annotation_filename"));
			jsonObject.addProperty("cre_dt", ipetdigitalconndb.rs.getString("cre_dt"));
			
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