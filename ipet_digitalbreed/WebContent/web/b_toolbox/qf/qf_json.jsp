<%@page import="org.json.simple.JSONArray"%>
<%@page import="ipet_digitalbreed.*"%>    
<%@page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.google.gson.*"%>
<%

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");
	
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();	
	JsonArray jsonArray = new JsonArray();

	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

		//String sql="SELECT no, status, filename, manufacture, uploadpath, resultpath, save_cmd, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt FROM genotype_filter_t  where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' ORDER BY no DESC;";
		//String sql="SELECT no, status, filename, manufacture, uploadpath, resultpath, save_cmd, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt FROM genotype_filter_t  where varietyid='"+varietyid+"' ORDER BY no DESC;";
		String sql="SELECT a.no, a.refgenome_id, b.refgenome, a.status, a.filename, a.manufacture, a.uploadpath, a.resultpath, a.save_cmd, a.jobid, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') AS cre_dt FROM genotype_filter_t a left join reference_genome_t b on a.refgenome_id = b.refgenome_id  where a.creuser='"+permissionUid+"' and a.varietyid='"+varietyid+"' ORDER BY a.no DESC;";
			
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		while (ipetdigitalconndb.rs.next()) { 
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("no",ipetdigitalconndb.rs.getInt("no"));
			jsonObject.addProperty("refgenome",ipetdigitalconndb.rs.getString("refgenome"));
			jsonObject.addProperty("refgenome_id",ipetdigitalconndb.rs.getInt("refgenome_id"));
			jsonObject.addProperty("status",ipetdigitalconndb.rs.getString("status"));
			jsonObject.addProperty("filename",ipetdigitalconndb.rs.getString("filename"));
			jsonObject.addProperty("manufacture",ipetdigitalconndb.rs.getString("manufacture"));
			jsonObject.addProperty("uploadpath",ipetdigitalconndb.rs.getString("uploadpath"));
			jsonObject.addProperty("resultpath",ipetdigitalconndb.rs.getString("resultpath"));
			jsonObject.addProperty("save_cmd",ipetdigitalconndb.rs.getString("save_cmd"));
			jsonObject.addProperty("jobid",ipetdigitalconndb.rs.getString("jobid"));
			jsonObject.addProperty("cre_dt",ipetdigitalconndb.rs.getString("cre_dt"));
			jsonArray.add(jsonObject);
		}
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	out.print(jsonArray);
	
%>



