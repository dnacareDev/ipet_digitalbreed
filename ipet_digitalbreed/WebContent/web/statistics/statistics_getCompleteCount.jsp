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
	String filter_sql = "select count(*) as count from genotype_filter_t where varietyid = '" +varietyid+ "' and status=1";
	
	//Genotype Analysis
	//String Genocore_sql = "select count(*) from genocore_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	//String mini_sql = "select count(*) from mini_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	//String PCA_sql = "select count(*) from pca_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	//String UPGMA_sql = "select count(*) from upgma_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
	String Genocore_sql = "select count(*) from genocore_info_t where varietyid = '" +varietyid+ "' and status=1";
	String mini_sql = "select count(*) from mini_info_t where varietyid = '" +varietyid+ "' and status=1";
	String PCA_sql = "select count(*) from pca_info_t where varietyid = '" +varietyid+ "' and status=1";
	String UPGMA_sql = "select count(*) from upgma_info_t where varietyid = '" +varietyid+ "' and status=1";
	
	
	// year = "-1" -> Select all years
	if(!year.equals("-1")) {
		GWAS_sql += " and year(cre_dt) = '" +year+ "'";
		filter_sql += " and year(cre_dt) = '" +year+ "'";
		Genocore_sql += " and year(cre_dt) = '" +year+ "'";
		mini_sql += " and year(cre_dt) = '" +year+ "'";
		PCA_sql += " and year(cre_dt) = '" +year+ "'";
		UPGMA_sql += " and year(cre_dt) = '" +year+ "'";
	}
	
	// month = "-1" -> Select all month
	if(!month.equals("-1")) {
		GWAS_sql += " and month(cre_dt) = '" +month+ "'";
		filter_sql += " and month(cre_dt) = '" +month+ "'";
		Genocore_sql += " and month(cre_dt) = '" +month+ "'";
		mini_sql += " and month(cre_dt) = '" +month+ "'";
		PCA_sql += " and month(cre_dt) = '" +month+ "'";
		UPGMA_sql += " and month(cre_dt) = '" +month+ "'";
	}
	
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		//System.out.println("GWAS_sql : " + GWAS_sql);
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(GWAS_sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	//GS count(미개발. 하드코딩)
	list.add(0);
	/*
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		sql = "select count(*) as count from gwas_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1;";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	*/
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		//System.out.println("filter_sql : " + filter_sql);
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(filter_sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	
	/*** genotype analysis -> 4개 count 합산 ***/
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String sql = "select ( (" +Genocore_sql+ ") + (" +mini_sql+ ") + (" +PCA_sql+ ") + (" +UPGMA_sql +") ) as count from dual";
		//System.out.println("sum 4 countSql : " +sql);
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
	} catch (Exception e) {
		e.printStackTrace();
	}
	/*** genotype analysis -> 4개 count 합산 ***/
	
	
	//phenotype analaysis (현재 없음)
	/*
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		sql = "select count(*) as count from gwas_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	*/
	list.add(0);
	
	out.clear();
	out.print(list);
	
	

%>