<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>
<%@page import="com.google.gson.JsonObject, com.google.gson.JsonArray"%>

<%
	
	
	
	String varietyid = request.getParameter("varietyid");
	String jobid_anova = request.getParameter("jobid_anova");
	String comment = request.getParameter("comment");
	
	String traitname = request.getParameter("traitname");
	String seq = request.getParameter("seq");
	String row = request.getParameter("row");
	
	/*
	System.out.println();
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_t_test : " + jobid_t_test);
	System.out.println("comment : " + comment);
	System.out.println("traitname : " + traitname);
	System.out.println("seq : " + Arrays.toString(seq));
	System.out.println("samplename : " + samplename);
	System.out.println("sampleno : " + sampleno);
	System.out.println("row : " + row);
	System.out.println();	
	*/

	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/phenotype_data/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pheno/anova/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	
	
	File folder_savePath = new File(savePath+jobid_anova);
	System.out.println("folder_savePath : " + folder_savePath);
	
	if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}

	File folder_outputPath = new File(outputPath+jobid_anova);
	System.out.println("folder_outputPath : " + folder_outputPath);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	
	String cmd = "Rscript " +script_path+ "Phenotype_ANOVA.R " +jobid_anova+ " " +savePath+jobid_anova+ " GS_traits.csv null null null null null null " +seq+ " " +outputPath+ " FALSE";
	//cmd += row + " " +seq + " " + outputPath +" FALSE";
	
	System.out.println("cmd : " + cmd);
			
	
	CommandLine cmdLine = CommandLine.parse(cmd);
	DefaultExecutor executor = new DefaultExecutor();
	executor.setExitValue(0);
	int exitValue = executor.execute(cmdLine);
	if(exitValue == 0) {
		System.out.println("Success");
	} else {
		System.out.println("Fail");
	}
	/*
	*/
	
%>
