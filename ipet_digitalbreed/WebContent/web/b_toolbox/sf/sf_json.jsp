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

		//String sql="select vcf.no, vcf.refgenome_id, ref.refgenome, ref.gff, vcf.filename, vcf.comment, vcf.samplecnt, vcf.variablecnt, vcf.jobid, DATE_FORMAT(vcf.cre_dt, '%Y-%m-%d') as cre_dt from vcfdata_info_t vcf inner join reference_genome_t ref on vcf.refgenome_id = ref.refgenome_id where (vcf.status=1 or vcf.status=2 ) and vcf.creuser='" +permissionUid+ "' and vcf.varietyid='" +varietyid+ "' order by no DESC;";
		String sql="select * from subset_filter_t where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' ORDER BY no DESC;";
		System.out.println(sql);
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		while (ipetdigitalconndb.rs.next()) { 
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("no", ipetdigitalconndb.rs.getInt("no"));
			jsonObject.addProperty("cropid", ipetdigitalconndb.rs.getString("cropid"));
			jsonObject.addProperty("varietyid", ipetdigitalconndb.rs.getString("varietyid"));
			jsonObject.addProperty("refgenome_id", ipetdigitalconndb.rs.getInt("refgenome_id"));
			jsonObject.addProperty("status", ipetdigitalconndb.rs.getString("status"));
			jsonObject.addProperty("filename", ipetdigitalconndb.rs.getString("filename"));
			jsonObject.addProperty("manufacture", ipetdigitalconndb.rs.getString("manufacture"));
			jsonObject.addProperty("uploadpath", ipetdigitalconndb.rs.getString("uploadpath"));
			jsonObject.addProperty("resultpath", ipetdigitalconndb.rs.getString("resultpath"));
			jsonObject.addProperty("save_cmd", ipetdigitalconndb.rs.getString("save_cmd"));
			jsonObject.addProperty("jobid", ipetdigitalconndb.rs.getString("jobid"));
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