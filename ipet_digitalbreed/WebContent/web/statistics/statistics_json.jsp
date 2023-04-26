<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="ipet_digitalbreed.*"%>
<%@ page import="org.json.simple.*" %>    
<%@ page import="com.google.gson.*" %>
<%

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	
	//System.out.println(varietyid);
	//System.out.println(year);
	//System.out.println(month);
	
	JSONArray jsonArray = new JSONArray();
	
	try{
		//String sql = "";
		
		String GWAS_sql = "select 'GWAS' as category, genotype_filename as filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from gwas_info_t where varietyid = '" +varietyid+ "' and status=1";
		String GS_sql = "select 'GS' as category, training_genotype as filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from genomic_selection_t where varietyid = '" +varietyid+ "' and status=1";
		String qf_sql = "select manufacture as category, filename, '-' as comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from genotype_filter_t where varietyid = '" +varietyid+ "' and status=1";
		String sf_sql = "select manufacture as category, filename, '-' as comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from subset_filter_t where varietyid = '" +varietyid+ "' and status=1";
		String merge_sql = "select manufacture as category, filename, '-' as comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from vcf_file_merge_t where varietyid = '" +varietyid+ "' and status=1";
		String Genocore_sql = "select 'Core selection' as category, filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from genocore_info_t where varietyid = '" +varietyid+ "' and status=1";
		String mini_sql = "select 'Minimal marker' as category, filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from mini_info_t where varietyid = '" +varietyid+ "' and status=1";
		String PCA_sql = "select 'PCA' as category, filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from pca_info_t where varietyid = '" +varietyid+ "' and status=1";
		String UPGMA_sql = "select 'UPGMA clustering' as category, filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from upgma_info_t where varietyid = '" +varietyid+ "' and status=1";
		String anno_sql = "select 'Annotation' as category, filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from annotation_t where varietyid = '" +varietyid+ "' and status=1";
		String ideogram_sql = "select 'Ideogram' as category, filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from ideogram_t where varietyid = '" +varietyid+ "' and status=1";
		String structure_sql = "select 'STRUCTURE' as category, filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from structure_t where varietyid = '" +varietyid+ "' and status=1";
		String statistical_summary_sql = "select 'Statistical Summary' as category, '-' as filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from statistical_summary_t where varietyid = '" +varietyid+ "'";
		String t_test_sql = "select 'T-test' as category, '-' as filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from t_test_t where varietyid = '" +varietyid+ "'";
		String anova_sql = "select 'One-way ANOVA' as category, '-' as filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from anova_t where varietyid = '" +varietyid+ "'";
		String phenotype_PCA_sql = "select 'Phenotype PCA' as category, '-' as filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from phenotype_pca_t where varietyid = '" +varietyid+ "'";
		String correlation_sql = "select 'Correlation' as category, '-' as filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from correlation_t where varietyid = '" +varietyid+ "'";
		String regression_sql = "select 'Regression' as category, '-' as filename, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') as cre_dt from regression_t where varietyid = '" +varietyid+ "'";
		
		// year = "-1" -> Select all years
		if(!year.equals("-1")) {
			GWAS_sql += " and year(cre_dt) = '" +year+ "'";
			GS_sql += " and year(cre_dt) = '" +year+ "'";
			qf_sql += " and year(cre_dt) = '" +year+ "'";
			sf_sql += " and year(cre_dt) = '" +year+ "'";
			merge_sql += " and year(cre_dt) = '" +year+ "'";
			Genocore_sql += " and year(cre_dt) = '" +year+ "'";
			mini_sql += " and year(cre_dt) = '" +year+ "'";
			PCA_sql += " and year(cre_dt) = '" +year+ "'";
			UPGMA_sql += " and year(cre_dt) = '" +year+ "'";
			anno_sql += " and year(cre_dt) = '" +year+ "'";
			ideogram_sql += " and year(cre_dt) = '" +year+ "'";
			structure_sql += " and year(cre_dt) = '" +year+ "'";
			statistical_summary_sql += " and year(cre_dt) = '" +year+ "'";
			t_test_sql += " and year(cre_dt) = '" +year+ "'";
			anova_sql += " and year(cre_dt) = '" +year+ "'";
			phenotype_PCA_sql += " and year(cre_dt) = '" +year+ "'";
			correlation_sql += " and year(cre_dt) = '" +year+ "'";
			regression_sql += " and year(cre_dt) = '" +year+ "'";
		}
		
		// month = "-1" -> Select all month
		if(!month.equals("-1")) {
			GWAS_sql += " and month(cre_dt) = '" +month+ "'";
			GS_sql += " and month(cre_dt) = '" +month+ "'";
			qf_sql += " and month(cre_dt) = '" +month+ "'";
			sf_sql += " and year(cre_dt) = '" +year+ "'";
			merge_sql += " and year(cre_dt) = '" +year+ "'";
			Genocore_sql += " and month(cre_dt) = '" +month+ "'";
			mini_sql += " and month(cre_dt) = '" +month+ "'";
			PCA_sql += " and month(cre_dt) = '" +month+ "'";
			UPGMA_sql += " and month(cre_dt) = '" +month+ "'";
			anno_sql += " and month(cre_dt) = '" +month+ "'";
			ideogram_sql += " and month(cre_dt) = '" +month+ "'";
			structure_sql += " and month(cre_dt) = '" +month+ "'";
			statistical_summary_sql += " and month(cre_dt) = '" +month+ "'";
			t_test_sql += " and month(cre_dt) = '" +month+ "'";
			anova_sql += " and month(cre_dt) = '" +month+ "'";
			phenotype_PCA_sql += " and month(cre_dt) = '" +month+ "'";
			correlation_sql += " and month(cre_dt) = '" +month+ "'";
			regression_sql += " and month(cre_dt) = '" +month+ "'";
		}
		
		String sql = "(" +GWAS_sql+ ") UNION (" +GS_sql+ ") UNION (" +qf_sql+ ") UNION (" +sf_sql+ ") UNION (" +merge_sql+ ") UNION (" +Genocore_sql+ ") UNION (" +mini_sql+ ") UNION (" +PCA_sql+ ") UNION (" +UPGMA_sql+ ") UNION (" +anno_sql+ ") UNION (" +ideogram_sql+ ") UNION (" +structure_sql+ ") UNION (" +statistical_summary_sql+ ") UNION (" +t_test_sql+ ") UNION (" +anova_sql+ ") UNION (" +phenotype_PCA_sql+ ") UNION (" +correlation_sql+ ") UNION (" +regression_sql +")  order by cre_dt DESC;";
		
		System.out.println(t_test_sql);
		//System.out.println(sql);
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		
     		JSONObject jsonObject = new JSONObject();
     		
     		jsonObject.put("category",ipetdigitalconndb.rs.getString("category"));
     		jsonObject.put("filename",ipetdigitalconndb.rs.getString("filename"));
     		jsonObject.put("comment",ipetdigitalconndb.rs.getString("comment"));
     		jsonObject.put("jobid",ipetdigitalconndb.rs.getString("jobid"));
     		jsonObject.put("cre_dt",ipetdigitalconndb.rs.getString("cre_dt"));
     		jsonArray.add(jsonObject);
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	//System.out.println(jsonArray);
	
	out.clear();
	out.print(jsonArray);
	
	

%>