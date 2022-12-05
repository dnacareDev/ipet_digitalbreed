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
	
	String sql = "";
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		sql = "select count(*) as count from gwas_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=0;";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	/*
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		sql = "select count(*) as count from gwas_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=0;";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	*/
	list.add(3);
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		sql = "select count(*) as count from genotype_filter_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=0;";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		list.add(ipetdigitalconndb.rs.getInt("count"));
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	
	// genotype analysis 4개 합산
	int count = 0;
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		sql = "select count(*) as count from pca_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=0;";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		count += ipetdigitalconndb.rs.getInt("count");
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		sql = "select count(*) as count from upgma_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=0;";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		count += ipetdigitalconndb.rs.getInt("count");
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		sql = "select count(*) as count from genocore_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=0;";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		count += ipetdigitalconndb.rs.getInt("count");
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		sql = "select count(*) as count from mini_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "' and status=0;";
		
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
     	while (ipetdigitalconndb.rs.next()) { 
     		count += ipetdigitalconndb.rs.getInt("count");
     	}
		
	} catch (Exception e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	list.add(count);
	// genotype analysis 4개 합산
	
	
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
	list.add(2);
	
	out.clear();
	out.print(list);
	
	

%>