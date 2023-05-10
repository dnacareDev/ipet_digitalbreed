<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@page import="com.google.gson.*"%>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("variety_id");
	
	//System.out.println("permissionUid : " + permissionUid);
	//System.out.println("varietyid : " + varietyid);
	JsonObject jsonObject = new JsonObject();

	//System.out.println(sql);
	try{
		/*
		String sql = "SELECT TABLE_NAME, TABLE_ROWS FROM INFORMATION_SCHEMA.TABLES WHERE TABLE_SCHEMA = 'digitalbreed'";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
       	while (ipetdigitalconndb.rs.next()) { 
       		jsonObject.addProperty(ipetdigitalconndb.rs.getString("TABLE_NAME"), ipetdigitalconndb.rs.getInt("TABLE_ROWS"));
       	}
       	*/
       	String sql = "SELECT 'pca_info_t' as TABLE_NAME, count(*) as TABLE_ROWS from pca_info_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'upgma_info_t' as TABLE_NAME, count(*) as TABLE_ROWS from upgma_info_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'genocore_info_t' as TABLE_NAME, count(*) as TABLE_ROWS from genocore_info_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'mini_info_t' as TABLE_NAME, count(*) as TABLE_ROWS from mini_info_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'ideogram_t' as TABLE_NAME, count(*) as TABLE_ROWS from ideogram_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'annotation_t' as TABLE_NAME, count(*) as TABLE_ROWS from annotation_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'structure_t' as TABLE_NAME, count(*) as TABLE_ROWS from structure_t";
       	sql += " UNION ALL ";
       	
       	
       	sql += "SELECT 'statistical_summary_t' as TABLE_NAME, count(*) as TABLE_ROWS from statistical_summary_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 't_test_t' as TABLE_NAME, count(*) as TABLE_ROWS from t_test_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'anova_t' as TABLE_NAME, count(*) as TABLE_ROWS from anova_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'phenotype_pca_t' as TABLE_NAME, count(*) as TABLE_ROWS from phenotype_pca_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'ideogram_t' as TABLE_NAME, count(*) as TABLE_ROWS from ideogram_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'correlation_t' as TABLE_NAME, count(*) as TABLE_ROWS from correlation_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'regression_t' as TABLE_NAME, count(*) as TABLE_ROWS from regression_t";
       	sql += " UNION ALL ";

       	
       	sql += "SELECT 'vcfdata_info_t' as TABLE_NAME, count(*) as TABLE_ROWS from vcfdata_info_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'sampledata_info_t' as TABLE_NAME, count(*) as TABLE_ROWS from sampledata_info_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'gwas_info_t' as TABLE_NAME, count(*) as TABLE_ROWS from gwas_info_t";
       	sql += " UNION ALL ";
       	sql += "SELECT 'genomic_selection_t' as TABLE_NAME, count(*) as TABLE_ROWS from genomic_selection_t";
       	sql += ";";
       	
       	//System.out.println(sql);
       	
       	ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
       	while (ipetdigitalconndb.rs.next()) { 
       		jsonObject.addProperty(ipetdigitalconndb.rs.getString("TABLE_NAME"), ipetdigitalconndb.rs.getInt("TABLE_ROWS"));
       	}

	} catch(Exception e) {
		e.printStackTrace();
	} finally { 
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	//System.out.println(jsonObject);
	
	int genotypeAnalysisCount = jsonObject.get("pca_info_t").getAsInt() + jsonObject.get("upgma_info_t").getAsInt() + jsonObject.get("genocore_info_t").getAsInt() + jsonObject.get("mini_info_t").getAsInt() + jsonObject.get("ideogram_t").getAsInt() + jsonObject.get("annotation_t").getAsInt() + jsonObject.get("structure_t").getAsInt();
	int phenotypeAnalysisCount = jsonObject.get("statistical_summary_t").getAsInt() + jsonObject.get("t_test_t").getAsInt() + jsonObject.get("anova_t").getAsInt() + jsonObject.get("phenotype_pca_t").getAsInt() + jsonObject.get("ideogram_t").getAsInt() + jsonObject.get("correlation_t").getAsInt() + jsonObject.get("regression_t").getAsInt();
	
	JsonObject tableRowList = new JsonObject();
	tableRowList.addProperty("genotype_data", jsonObject.get("vcfdata_info_t").getAsInt());
	tableRowList.addProperty("phenotype_data", jsonObject.get("sampledata_info_t").getAsInt());
	tableRowList.addProperty("GWAS", jsonObject.get("gwas_info_t").getAsInt());
	tableRowList.addProperty("GS", jsonObject.get("genomic_selection_t").getAsInt());
	tableRowList.addProperty("genotype_analysis", genotypeAnalysisCount);
	tableRowList.addProperty("phenotype_analysis", phenotypeAnalysisCount);
	out.clear();
	//out.print(jsonObject);
	out.print(tableRowList);
	
%>