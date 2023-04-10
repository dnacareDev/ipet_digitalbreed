<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="com.google.gson.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

<%
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	//RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String varietyid = request.getParameter("varietyid");
	
	String jobid_ideogram = request.getParameter("jobid_ideogram");
	String jobid_vcf = request.getParameter("jobid_vcf");
	String comment = request.getParameter("comment");
	String filename = request.getParameter("filename");
	
	/*
	System.out.println(varietyid);
	System.out.println(jobid_ideogram);
	System.out.println(jobid_vcf);
	System.out.println(comment);
	
	System.out.println(jobid_vfm);
	System.out.println(analysisModalRadioType1);
	System.out.println(removeDuplicateSites);
	System.out.println(sortPositions);
	System.out.println(AllowDuplicateSamples);
	System.out.println(missingToRefGenotype);
	*/	
	
	
	
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	String db_savePath = "uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/ideogram/";
	
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','Ideogram', 'New analysis', now());";
	System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	String sql = "insert into ideogram_t (cropid, varietyid, status, filename, comment, uploadpath, resultpath, jobid, creuser, cre_dt) ";
	sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+ filename +"', '"+ comment +"', '"+ db_savePath+"','"+db_outputPath+"', '"+jobid_ideogram+"','" +permissionUid+ "',now());";
	
	System.out.println(sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
%>