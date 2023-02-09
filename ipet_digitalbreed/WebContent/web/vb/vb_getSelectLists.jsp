<%@page import="java.sql.SQLException, java.io.IOException"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>  
<%@ page import="com.google.gson.JsonObject, com.google.gson.JsonArray"%> 
  
<%

	//vb_features.jsp 페이지의 SnpEff, GWAS, Marker 등 탭에서 필요한 model(= DB resultset) 불러오기 

	String command = request.getParameter("command");
	String jobid = request.getParameter("jobid");
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	/*
	System.out.println(command);
	System.out.println(jobid);
	*/
	
	out.clear();
	
	switch(command) {
		case "GWAS":

			JsonArray GwasListJsonArr = new JsonArray();
			GwasListJsonArr = getGwasList(jobid);
			
			out.print(GwasListJsonArr);
			break;
			
		case "UPGMA":
			
			JsonArray UpgmaListJsonArr = new JsonArray();
			UpgmaListJsonArr = getUpgmaList(jobid);
			
			out.print(UpgmaListJsonArr);
			break;
		case "UPGMA_standard":
			
			JsonArray UpgmaStandardListJsonArr = getUpgmaStandardList(rootFolder, jobid);
			//System.out.println("standard");
			out.print(UpgmaStandardListJsonArr);
			break;	
	}
	
	
%>

<%! 
	public JsonArray getGwasList(String jobid) throws SQLException {
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		JsonArray jsonArr = new JsonArray();
		
		String sql = "select gwas.no as no, gwas.genotype_filename as filename, replace(gwas.phenotype_name, ',', '|') as phenotype_name, replace(gwas.model, ', ', '|') as model, gwas.comment as comment, gwas.jobid as jobid, DATE_FORMAT(gwas.cre_dt, '%Y-%m-%d') AS cre_dt from gwas_info_t gwas inner join vcfdata_info_t vcf on (gwas.vcfdata_no = vcf.no and gwas.refgenome_id = vcf.refgenome_id) where vcf.jobid='" +jobid+ "'and gwas.status=1;";
		//System.out.println(sql);
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

<%! 
	public JsonArray getUpgmaList(String jobid) throws SQLException {
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		JsonArray jsonArr = new JsonArray();
		
		String sql = "select upgma.no, upgma.filename, upgma.comment, upgma.jobid, DATE_FORMAT(upgma.cre_dt, '%Y-%m-%d') AS cre_dt from upgma_info_t as upgma inner join vcfdata_info_t as vcf on upgma.vcfdata_no = vcf.no where vcf.jobid ='"+jobid+"';";
		//System.out.println(sql);
		try{
			ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
			while (ipetdigitalconndb.rs.next()) { 
				JsonObject jsonObj = new JsonObject();
				jsonObj.addProperty("no", ipetdigitalconndb.rs.getString("no"));
				jsonObj.addProperty("filename", ipetdigitalconndb.rs.getString("filename"));
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

<%! 
	public JsonArray getUpgmaStandardList(String rootFolder, String jobid) throws IOException {
		
		String path = rootFolder+"result/Breeder_toolbox_analyses/phylogenetic_tree/";
		
		File fileRead = new File(path+"/"+jobid+"/"+jobid+"_Similarity_Table.csv");
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(fileRead), "UTF-8"));
		
		JsonArray jsonArr = new JsonArray();

		String line = br.readLine();
		while((line = br.readLine()) != null) {
			//System.out.println(line);
			String[] lineArr = line.split(",");
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", lineArr[0].replaceAll("\"", ""));
			jsonArr.add(jsonObject);
		}
		
		
		//System.out.println(jsonArr);
		return jsonArr;
	}
%>