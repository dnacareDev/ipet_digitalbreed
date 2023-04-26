<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("variety_id");
	String year = request.getParameter("year");
	String month = request.getParameter("month");
	
	//System.out.println(year);
	//System.out.println(month);
	
	List<Integer> list = new LinkedList<>();
	
	
	//String GWAS_sql = "select count(*) as count from gwas_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	//String filter_sql = "select count(*) as count from genotype_filter_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	String GWAS_sql = "select count(*) as count from gwas_info_t where varietyid = '" +varietyid+ "' and status=1";
	String GS_sql = "select count(*) as count from genomic_selection_t where varietyid = '" +varietyid+ "' and status=1";
	
	
	String filter_sql = "select count(*) as count from genotype_filter_t where varietyid = '" +varietyid+ "' and status=1";
	String sf_sql = "select count(*) as count from subset_filter_t where varietyid = '" +varietyid+ "' and status=1";
	String merge_sql = "select count(*) as count from vcf_file_merge_t where varietyid = '" +varietyid+ "' and status=1";
	
	//Genotype Analysis
	//String Genocore_sql = "select count(*) from genocore_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	//String mini_sql = "select count(*) from mini_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	//String PCA_sql = "select count(*) from pca_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	//String UPGMA_sql = "select count(*) from upgma_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	String Genocore_sql = "select count(*) from genocore_info_t where varietyid = '" +varietyid+ "' and status=1";
	String mini_sql = "select count(*) from mini_info_t where varietyid = '" +varietyid+ "' and status=1";
	String PCA_sql = "select count(*) from pca_info_t where varietyid = '" +varietyid+ "' and status=1";
	String UPGMA_sql = "select count(*) from upgma_info_t where varietyid = '" +varietyid+ "' and status=1";
	String anno_sql = "select count(*) from annotation_t where varietyid = '" +varietyid+ "' and status=1";
	String ideogram_sql = "select count(*) from ideogram_t where varietyid = '" +varietyid+ "' and status=1";
	String structure_sql = "select count(*) from structure_t where varietyid = '" +varietyid+ "' and status=1";
	
	String statistical_summary_sql = "select count(*) from statistical_summary_t where varietyid = '" +varietyid+ "'";
	String t_test_sql = "select count(*) from t_test_t where varietyid = '" +varietyid+ "'";
	String anova_sql = "select count(*) from anova_t where varietyid = '" +varietyid+ "'";
	String phenotype_pca_sql = "select count(*) from phenotype_pca_t where varietyid = '" +varietyid+"'";
	String correlation_sql = "select count(*) from correlation_t where varietyid = '" +varietyid+ "'";
	String regression_sql = "select count(*) from regression_t where varietyid = '" +varietyid+ "'";
	
	
	// year = "-1" -> Select all years
	if(!year.equals("-1")) {
		GWAS_sql += " and year(cre_dt) = '" +year+ "'";
		GS_sql += " and year(cre_dt) = '" +year+ "'";
		filter_sql += " and year(cre_dt) = '" +year+ "'";
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
		phenotype_pca_sql += " and year(cre_dt) = '" +year+ "'";
		correlation_sql += " and year(cre_dt) = '" +year+ "'";
		regression_sql += " and year(cre_dt) = '" +year+ "'";
	}
	
	// month = "-1" -> Select all month
	if(!month.equals("-1")) {
		GWAS_sql += " and month(cre_dt) = '" +month+ "'";
		GS_sql += " and month(cre_dt) = '" +month+ "'";
		filter_sql += " and month(cre_dt) = '" +month+ "'";
		sf_sql += " and month(cre_dt) = '" +month+ "'";
		merge_sql += " and month(cre_dt) = '" +month+ "'";
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
		phenotype_pca_sql += " and month(cre_dt) = '" +month+ "'";
		correlation_sql += " and month(cre_dt) = '" +month+ "'";
		regression_sql += " and month(cre_dt) = '" +month+ "'";
	}
	
	
	try{
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(GWAS_sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try{
		//System.out.println(GS_sql);
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(GS_sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try{
		
		//System.out.println("filter_sql : " + filter_sql);
		//ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(filter_sql);
		String sql = "select ( (" +filter_sql+ ") + (" +sf_sql+ ") + (" +merge_sql+ ") ) as count from dual";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	
	/*** genotype analysis -> 4개 count 합산 ***/
	try{
		
		String sql = "select ( (" +Genocore_sql+ ") + (" +mini_sql+ ") + (" +PCA_sql+ ") + (" +UPGMA_sql+ ") + (" +anno_sql+ ") + (" +ideogram_sql+ ") + (" +structure_sql +") ) as count from dual";
		//System.out.println("sum 7 countSql : " +sql);
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
	} catch (Exception e) {
		e.printStackTrace();
	}
	/*** genotype analysis -> 4개 count 합산 ***/
	
	
	//phenotype analaysis (현재 없음)
	try{
		String sql = "select ( (" +statistical_summary_sql+ ") + (" +t_test_sql+ ") + (" +anova_sql+ ") + (" +phenotype_pca_sql+ ") + (" +correlation_sql+ ") + (" +regression_sql +") ) as count from dual";
		//System.out.println(sql);
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	/*
	ipetdigitalconndb.rs.close();
	ipetdigitalconndb.stmt.close();
	ipetdigitalconndb.conn.close();
	*/
	//list.add(0);
	
	out.clear();
	out.print(list);
	
	

%>