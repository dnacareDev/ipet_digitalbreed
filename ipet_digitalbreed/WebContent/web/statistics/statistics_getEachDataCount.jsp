<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("variety_id");
	String tableName = request.getParameter("table_name");
	
	//System.out.println("permissionUid : " + permissionUid);
	//System.out.println("varietyid : " + varietyid);
	//System.out.println("tableName : " + tableName);

	

	String sql = "";
	int count = 0;
	
	switch(tableName) {
		case "genotype_data":
			//sql = "select count(*) as count from vcfdata_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			sql = "select count(*) as count from vcfdata_info_t where varietyid = '" +varietyid+ "';";
			//System.out.println(sql);
			try{
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
             	while (ipetdigitalconndb.rs.next()) { 
             		count = ipetdigitalconndb.rs.getInt("count");
             	}
             	out.clear();
             	out.print(count);
			} catch(Exception e) {
				e.printStackTrace();
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			break;
		case "phenotype_data":
			//sql = "select count(*) as count from sampledata_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			sql = "select count(*) as count from sampledata_info_t where varietyid = '" +varietyid+ "';";
			try{
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count = ipetdigitalconndb.rs.getInt("count");
             	}
				out.clear();
             	out.print(count);
			} catch(Exception e) {
				e.printStackTrace();
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			break;
		case "GWAS":
			//sql = "select count(*) as count from gwas_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			sql = "select count(*) as count from gwas_info_t where varietyid = '" +varietyid+ "';";
			try{
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count = ipetdigitalconndb.rs.getInt("count");
             	}
				out.clear();
             	out.print(count);
			} catch(Exception e) {
				e.printStackTrace();
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
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
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
			// sql 4번 써서 결과값을 더함. 한번에 처리할 쿼리문이 있다면 그걸 쓰는게 좋을듯 
			
			try{
				//sql = "select count(*) as count from pca_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
				sql = "select count(*) as count from pca_info_t where varietyid = '" +varietyid+ "';";
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count += ipetdigitalconndb.rs.getInt("count");
             	}
				
				//sql = "select count(*) as count from upgma_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
				sql = "select count(*) as count from upgma_info_t where varietyid = '" +varietyid+ "';";
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count += ipetdigitalconndb.rs.getInt("count");
             	}
				
				//sql = "select count(*) as count from genocore_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
				sql = "select count(*) as count from genocore_info_t where varietyid = '" +varietyid+ "';";
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count += ipetdigitalconndb.rs.getInt("count");
             	}
				
				//sql = "select count(*) as count from mini_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
				sql = "select count(*) as count from mini_info_t where varietyid = '" +varietyid+ "';";
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 	
             		count += ipetdigitalconndb.rs.getInt("count");
             	}
				
				out.clear();
				out.print(count);
			} catch(Exception e) {
				e.printStackTrace();
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			
			break;
		case "phenotype_analysis":
			// phenotype_analysis 미개발
			/*
			String sql = "select count(*) from vcfdata_info_t where creuser='" +permissionUid+ "' and varietyid = '" +varietyid+ "';";
			try{
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
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