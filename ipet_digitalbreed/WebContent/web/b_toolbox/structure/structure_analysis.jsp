<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

<%
	
	
	String varietyid = request.getParameter("varietyid");
	String jobid_structure = request.getParameter("jobid_structure");
	String jobid_vcf = request.getParameter("jobid_vcf");
	String filename = request.getParameter("filename");
	String refgenome = request.getParameter("refgenome");
	String annotation_filename = request.getParameter("annotation_filename");
	
	String iteration_number = request.getParameter("iteration-number");
	String Number_of_K = request.getParameter("Number_of_K");
	String Burn_IN = request.getParameter("Burn_IN");
	String MCMC = request.getParameter("MCMC");
	
	/*
	System.out.println("====================================");
	System.out.println("jobid_structure : " + jobid_structure);
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("filename : " + filename);
	System.out.println("refgenome : " + refgenome);
	System.out.println("annotation_filename : " + annotation_filename);
	System.out.println(iteration_number);
	System.out.println(Number_of_K);
	System.out.println(Burn_IN);
	System.out.println(MCMC);
	System.out.println("====================================");	
	*/
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/structure/";
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

	File folder_outputPath = new File(outputPath+jobid_structure);
	
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
	
	
	
	String cmd = "perl " +script_path+ "breedertoolbox_STRUCTURE_total_running.pl " +savePath+ " "+ filename +" "+ jobid_structure +" "+ outputPath+jobid_structure +" "+ Number_of_K +" "+ Burn_IN +" "+ MCMC +" "+ iteration_number +" "+ permissionUid +" "+ varietyid;
	
	System.out.println();
	System.out.println("STRUCTURE parameter : " + cmd);
	System.out.println();
	
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