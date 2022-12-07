<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="ipet_digitalbreed.*"%>
<%@ page import="org.json.simple.*" %>    
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
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		//String sql = "";
		
		String GWAS_sql = "select 'GWAS' as category, genotype_filename as filename, comment, jobid, cre_dt from gwas_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
		String filter_sql = "select 'genotype_filter_t' as category, filename, '-' as comment, jobid, cre_dt from genotype_filter_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
		String Genocore_sql = "select 'Core selection' as category, filename, comment, jobid, cre_dt from genocore_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
		String mini_sql = "select 'Minimal marker' as category, filename, comment, jobid, cre_dt from mini_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
		String PCA_sql = "select 'PCA' as category, filename, comment, jobid, cre_dt from pca_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
		String UPGMA_sql = "select 'UPGMA clustering' as category, filename, comment, jobid, cre_dt from upgma_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=1";
		
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
		
		String sql = "(" +GWAS_sql+ ") UNION (" +filter_sql+ ") UNION (" +Genocore_sql+ ") UNION (" +mini_sql+ ") UNION (" +PCA_sql+ ") UNION (" +UPGMA_sql +")  order by cre_dt DESC;";
		
		
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
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	//System.out.println(jsonArray);
	
	out.clear();
	out.print(jsonArray);
	
	

%>