<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="com.google.gson.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

<%
	
	//IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	//ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	//RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	
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
	System.out.println(jobid_vcf_1);
	System.out.println(filename_vcf_1);
	System.out.println(jobid_vcf_2);
	System.out.println(filename_vcf_2);
	//JsonArray jsonArray = new Gson().fromJson(merged_vcf, JsonArray.class);
	
	/*
	System.out.println(jobid_vfm);
	System.out.println(analysisModalRadioType1);
	System.out.println(removeDuplicateSites);
	System.out.println(sortPositions);
	System.out.println(AllowDuplicateSamples);
	System.out.println(missingToRefGenotype);
	*/
	
	int concatenate_count = 0;
	if(removeDuplicateSites.equals("on") && sortPositions.equals("off")) {
		concatenate_count = 1;
	}
	if(sortPositions.equals("off") && sortPositions.equals("on")) {
		concatenate_count = 2;
	} 
	if(removeDuplicateSites.equals("on") && sortPositions.equals("on")) {
		concatenate_count = 3;
	}
	if(removeDuplicateSites.equals("off") && sortPositions.equals("off")) {
		concatenate_count = -1;
	}
	
	int merge_count = 0;
	if(AllowDuplicateSamples.equals("on") && missingToRefGenotype.equals("off")) {
		merge_count = 1;
	}
	if(AllowDuplicateSamples.equals("off") && missingToRefGenotype.equals("on")) {
		merge_count = 2;
	} 
	if(AllowDuplicateSamples.equals("on") && missingToRefGenotype.equals("on")) {
		merge_count = 3;
	}
	if(AllowDuplicateSamples.equals("off") && missingToRefGenotype.equals("off")) {
		merge_count = -1;
	}
	
	
	
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String vcfPath = rootFolder + "uploads/database/db_input/";
	//String vcfPath2 = rootFolder + "uploads/database/db_input/" + jsonArray.get(1) + "/";
	//String subsetSavePath = rootFolder + "uploads/Breeder_toolbox_analyses/subset/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/merge/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	//String db_savePath = "uploads/database/db_input/";
	//String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/merge/";
	
	
	
	
	File folder_outputPath = new File(outputPath+jobid_vfm);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	
	String cmd = "Rscript " +script_path+ "breedertoolbox_merge.R "+ vcfPath+jobid_vcf_1 +"/ "+ filename_vcf_1 +" "+ vcfPath+jobid_vcf_2 +"/ "+ filename_vcf_2 +" "+ outputPath +" "+ jobid_vfm;
	
	if(analysisModalRadioType1.equals("concatenate")) {
		cmd += " 1 "+ concatenate_count +" ";
		
	} else if(analysisModalRadioType1.equals("merge")) {
		cmd += " 2 "+ merge_count +" ";
	} else {
		cmd += " --typo--";
	}
	
	
	
	System.out.println("merge params : " + cmd);
	//runanalysistools.execute(SF, "cmd");
	
	try {
		CommandLine cmdLine = CommandLine.parse(cmd);
		DefaultExecutor executor = new DefaultExecutor();
		executor.setExitValue(0);
		int exitValue = executor.execute(cmdLine);
		if(exitValue == 0) {
			System.out.println("Success");
			/*
			String updateSql = "update vcf_file_merge_t set status=1 where jobid='" +jobid_vfm+ "';";
			System.out.println(updateSql);
			try{
				ipetdigitalconndb.stmt.executeUpdate(updateSql);
			} catch(Exception e) {
				System.out.println(e);
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			} 
			*/
		} else {
			System.out.println("Fail");
			/*
			String updateSql = "update vcf_file_merge_t set status=2 where jobid='" +jobid_vfm+ "';";
			System.out.println(updateSql);
			try{
				ipetdigitalconndb.stmt.executeUpdate(updateSql);
			} catch(Exception e) {
				System.out.println(e);
			} finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			} 
			*/
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	
	
	
	
%>