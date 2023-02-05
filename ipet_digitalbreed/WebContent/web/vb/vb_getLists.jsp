<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>  
<%@ page import="com.google.gson.JsonObject, com.google.gson.JsonArray"%> 
  
<%

	//vb_features.jsp 페이지의 SnpEff, GWAS, Marker 등 탭에서 필요한 model(= DB resultset) 불러오기 

	String command = request.getParameter("command");
	String jobid = request.getParameter("jobid");
	
	/*
	System.out.println(command);
	System.out.println(jobid);
	*/
	
	out.clear();
	
	switch(command) {
		case "GWAS":

			JsonArray jsonArr = new JsonArray();
			jsonArr = getGwasList(jobid);
			
			out.print(jsonArr);
			break;
			
		case "SnpEff":
			break;
	}
	
	
%>

<%! 
	public JsonArray getGwasList(String jobid) throws SQLException {
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		JsonArray jsonArr = new JsonArray();
		
		String sql = "select gwas.no as no, gwas.genotype_filename as filename, replace(gwas.phenotype_name, ',', '|') as phenotype_name, replace(gwas.model, ', ', '|') as model, gwas.comment as comment, gwas.jobid as jobid, DATE_FORMAT(gwas.cre_dt, '%Y-%m-%d') AS cre_dt from gwas_info_t gwas inner join vcfdata_info_t vcf on (gwas.vcfdata_no = vcf.no and gwas.refgenome_id = vcf.refgenome_id) where vcf.jobid='" +jobid+ "'and gwas.status=1;";
		System.out.println(sql);
		try{
			ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
			while (ipetdigitalconndb.rs.next()) { 
				JsonObject jsonObj = new JsonObject();
				jsonObj.addProperty("no", ipetdigitalconndb.rs.getString("no"));
				jsonObj.addProperty("filename", ipetdigitalconndb.rs.getString("filename"));
				jsonObj.addProperty("phenotype_name", ipetdigitalconndb.rs.getString("phenotype_name"));
				jsonObj.addProperty("model", ipetdigitalconndb.rs.getString("model"));
				jsonObj.addProperty("comment", ipetdigitalconndb.rs.getString("comment"));
				jsonObj.addProperty("jobid", ipetdigitalconndb.rs.getString("jobid"));
				jsonObj.addProperty("cre_dt", ipetdigitalconndb.rs.getString("cre_dt"));
				jsonArr.add(jsonObj);
			}
		}catch(Exception e){
			System.out.println(e);
		} finally {
			ipetdigitalconndb.rs.close();
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
		

		return jsonArr;
	}
%>