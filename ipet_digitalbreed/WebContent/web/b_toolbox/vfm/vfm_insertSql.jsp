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
	
	String variety_id = request.getParameter("variety_id");
	String jobid_vfm = request.getParameter("jobid_vfm");
	
	String analysisModalRadioType1 = request.getParameter("analysisModalRadioType1");
	String removeDuplicateSites = request.getParameter("removeDuplicateSites") == null ? "off" : "on";
	String sortPositions = request.getParameter("sortPositions") == null ? "off" : "on";
	String AllowDuplicateSamples = request.getParameter("AllowDuplicateSamples") == null ? "off" : "on";
	String missingToRefGenotype = request.getParameter("missingToRefGenotype") == null ? "off" : "on";
	
	
	String vcf_1 = request.getParameter("vcf_1");
	String jobid_vcf_1 = vcf_1.split(",")[0];
	String filename_vcf_1 = vcf_1.split(",")[1];
	String vcf_2 = request.getParameter("vcf_2");
	String jobid_vcf_2 = vcf_2.split(",")[0];
	String filename_vcf_2 = vcf_2.split(",")[1];
	String refgenome_id = request.getParameter("refgenome_id");
	
	System.out.println("refgenome_id : " + refgenome_id);
	
	/*
	System.out.println(jobid_vcf_1);
	System.out.println(filename_vcf_1);
	System.out.println(jobid_vcf_2);
	System.out.println(filename_vcf_2);
	
	System.out.println(jobid_vfm);
	System.out.println(analysisModalRadioType1);
	System.out.println(removeDuplicateSites);
	System.out.println(sortPositions);
	System.out.println(AllowDuplicateSamples);
	System.out.println(missingToRefGenotype);
	*/	
	
	
	
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String vcfPath = rootFolder + "uploads/database/db_input/";
	//String vcfPath2 = rootFolder + "uploads/database/db_input/" + jsonArray.get(1) + "/";
	//String subsetSavePath = rootFolder + "uploads/Breeder_toolbox_analyses/subset/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/merge/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String db_savePath = "uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/merge/";
	
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+variety_id+"'),'"+variety_id+"','Subset Filter', 'New analysis', now());";
	System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	String sql = "insert into vcf_file_merge_t (cropid, varietyid, refgenome_id, status, filename, manufacture, uploadpath, resultpath, save_cmd, jobid, creuser, cre_dt) ";
	sql += "values((select cropid from variety_t where varietyid='"+variety_id+"'), '"+variety_id+"', " +refgenome_id+ ", 0, '"+jobid_vfm+"_merge.vcf', 'merge', '"+db_savePath+"','"+db_outputPath+"','0', '"+jobid_vfm+"','" +permissionUid+ "',now());";
	//sql += "values((select cropid from variety_t where varietyid='"+variety_id+"'), '"+variety_id+"', 0, 0, '"+jobid_vfm+"_merge.vcf"+"', 'merge', '"+db_savePath+"','"+db_outputPath+"','0', '"+jobid_vfm+"','" +permissionUid+ "',now());";
	
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