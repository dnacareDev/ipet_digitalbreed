<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

<%
	
	
	
	String jobid_idiogram = request.getParameter("jobid_idiogram");
	String jobid_vcf = request.getParameter("jobid_vcf");
	String filename = request.getParameter("filename");
	String refgenome = request.getParameter("refgenome");
	String annotation_filename = request.getParameter("annotation_filename");
	
	String iteration_range = request.getParameter("iteration-range");
	String Number_of_K = request.getParameter("Number_of_K");
	String MCMC = request.getParameter("MCMC");
	
	/*
	System.out.println();
	System.out.println("jobid_idiogram : " + jobid_idiogram);
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("filename : " + filename);
	System.out.println("refgenome : " + refgenome);
	System.out.println("annotation_filename : " + annotation_filename);
	System.out.println();	
	*/
	System.out.println(iteration_range);
	System.out.println(Number_of_K);
	System.out.println(MCMC);

	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/annotation/";
	String annotationPath = rootFolder + "uploads/reference_database/"+refgenome+"/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	
	File folder_savePath = new File(savePath);
	
	if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}

	File folder_outputPath = new File(outputPath+jobid_idiogram);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	/*
	System.out.println();
	System.out.println("script_path : " + script_path);
	System.out.println("savePath : " + savePath);
	System.out.println("outputPath : " + outputPath);
	System.out.println();
	*/
	
	
	
	String cmd = "Rscript " +script_path+ "breedertoolbox_annotation.R " +savePath+ " " +outputPath+ " " +jobid_idiogram +" "+ filename +" "+ annotationPath +" "+ annotation_filename;
	
	System.out.println("annotation parameter : " + cmd);
			
	
	CommandLine cmdLine = CommandLine.parse(cmd);
	DefaultExecutor executor = new DefaultExecutor();
	executor.setExitValue(0);
	int exitValue = executor.execute(cmdLine);
	if(exitValue == 0) {
		System.out.println("Success");
	} else {
		System.out.println("Fail");
	}
	
	
%>