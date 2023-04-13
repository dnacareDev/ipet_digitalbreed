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
	
	//System.out.println(phenotype);
	//System.out.println(model);
	//System.out.println(jobid);
	
	String cutOffValue = "-1";
	
	try{
		String sql="select cutoff_value from gwas_cutoff_t where jobid='"+ jobid +"' and model='"+ model +"' and phenotype='"+ phenotype +"' and creuser='"+permissionUid+"' ORDER BY gwas_cutoff_id DESC;";
		//System.out.println(sql);
		
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		
		ipetdigitalconndb.rs.last();
		//System.out.println(ipetdigitalconndb.rs.getRow());
		
		if(ipetdigitalconndb.rs.getRow() != 0) {
			//System.out.println("int 0");
			ipetdigitalconndb.rs.beforeFirst();
			ipetdigitalconndb.rs.next();
			cutOffValue =  ipetdigitalconndb.rs.getString("cutoff_value");
		} 
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	//System.out.println(cutOffValue);
	out.clear();
	out.print(cutOffValue);
	
%>