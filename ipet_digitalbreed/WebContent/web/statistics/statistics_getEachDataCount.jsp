<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("variety_id");
	String tableName = request.getParameter("table_name");
	
	if(tableName == "genotype_data"){
		System.out.println("permissionUid : " + permissionUid);
		System.out.println("varietyid : " + varietyid);
		System.out.println("tableName : " + tableName);
	}

	

	String sql = "";
	int count = 0;
	
	switch(tableName) {
		case "genotype_data":
			System.out.println("tableName - " + tableName);
			sql = "select count(*) as count from vcfdata_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			try{
				ipetdigitalconndb.stmt.executeQuery(sql);
             	while (ipetdigitalconndb.rs.next()) { 	
             		count = ipetdigitalconndb.rs.getInt("count");
             	}
			} catch(Exception e) {
				System.out.println("genotype_data error");
				e.printStackTrace();
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			break;
		case "phenotype_data":
			sql = "select count(*) from sampledata_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			try{
				ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count = ipetdigitalconndb.rs.getInt("count");
             	}
			} catch(Exception e) {
				System.out.println("phenotype_data error");
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			break;
		case "GWAS":
			sql = "select count(*) from gwas_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			try{
				ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count = ipetdigitalconndb.rs.getInt("count");
             	}
			} catch(Exception e) {
				System.out.println("GWAS error");
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			break;
		case "GS":
			// GS테이블 아직 미개발
			/*
			sql = "select count(*) from vcfdata_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			try{
				ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count = ipetdigitalconndb.rs.getInt("count");
             	}
			} catch(Exception e) {
				System.out.println("GS error");
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			*/
			break;
		case "genotype_analysis":
			// 쿼리문 미완성. 4개 테이블 count를 모두 합쳐야 함
			/*
			sql = "select count(*) from vcfdata_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			try{
				ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count = ipetdigitalconndb.rs.getInt("count");
             	}
			} catch(Exception e) {
				System.out.println("genotype_analysis error");
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			*/
			break;
		case "phenotype_analysis":
			// phenotype_analysis 미개발
			/*
			String sql = "select count(*) from vcfdata_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			try{
				ipetdigitalconndb.stmt.executeQuery(sql);
			} catch(Exception e) {
				System.out.println("phenotype_analysis error");
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			*/
			break;
	}
	
%>