<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String phenotype = request.getParameter("phenotype");
	String model = request.getParameter("model");
	String jobid = request.getParameter("jobid");
	double cutOffValue = Double.parseDouble(request.getParameter("cutOffValue"));
	
	//System.out.println(phenotype);
	//System.out.println(model);
	//System.out.println(jobid);
	//System.out.println(cutOffValue);
	
	int count = 0;
	
	try{
		String sql="select cutoff_value from gwas_cutoff_t where jobid='"+ jobid +"' and model='"+ model +"' and phenotype='"+ phenotype +"' and creuser='"+permissionUid+"' ORDER BY gwas_cutoff_id DESC;";
		System.out.println(sql);
		
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		
		ipetdigitalconndb.rs.last();
		System.out.println(ipetdigitalconndb.rs.getRow());
		
		count = ipetdigitalconndb.rs.getRow(); 
	}catch(Exception e){
		System.out.println(e);
	}
	
	
	if(count == 0) {
		try{
			String sql="insert into gwas_cutoff_t(jobid, model, phenotype, cutoff_value, creuser) values ('";
			sql += jobid +"', '"+ model +"', '"+ phenotype +"', "+ cutOffValue +", '"+ permissionUid +"');";
			//System.out.println("insert sql : " + sql);
			
			ipetdigitalconndb.stmt.executeUpdate(sql);
			
		}catch(Exception e){
			System.out.println(e);
		}finally { 
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
	} else {
		try{
			String sql="update gwas_cutoff_t set cutoff_value ="+ cutOffValue + " where jobid='"+ jobid +"' and model='"+ model +"' and phenotype='"+ phenotype +"' and creuser='"+permissionUid+"' ORDER BY gwas_cutoff_id DESC;";
			//System.out.println("update sql : " + sql);
			
			ipetdigitalconndb.stmt.executeUpdate(sql);
			
		}catch(Exception e){
			System.out.println(e);
		}finally { 
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
	}
	
	
%>