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

		//String sql="select a.refgenome_id, b.cropname, a.reference, a.gff, a.anno, a.length, a.author, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') as cre_dt from reference_genome_t a inner join crop_t b on a.cropid = b.cropid where a.creuser='" +permissionUid+ "' and varietyid='" +varietyid+ "' order by no DESC;";
		String sql="select refgenome_id, crop_name, reference, gff, author, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from reference_genome_t where creuser='" +permissionUid+ "' order by refgenome_id DESC;";
		//System.out.println(sql);
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		while (ipetdigitalconndb.rs.next()) { 
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("refgenome_id", ipetdigitalconndb.rs.getInt("refgenome_id"));
			jsonObject.addProperty("crop_name", ipetdigitalconndb.rs.getString("crop_name"));
			//jsonObject.addProperty("cropname", ipetdigitalconndb.rs.getString("crop_name"));
			jsonObject.addProperty("reference", ipetdigitalconndb.rs.getString("reference"));
			jsonObject.addProperty("gff", ipetdigitalconndb.rs.getString("gff"));
			//jsonObject.addProperty("anno", ipetdigitalconndb.rs.getString("anno"));
			//jsonObject.addProperty("length", ipetdigitalconndb.rs.getString("length"));
			jsonObject.addProperty("author", ipetdigitalconndb.rs.getString("author"));
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