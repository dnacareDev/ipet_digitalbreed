<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

<%
	
	
	
	String jobid_ideogram = request.getParameter("jobid_ideogram");
	String varietyid = request.getParameter("varietyid");
	String jobid_vcf = request.getParameter("jobid_vcf");
	String filename = request.getParameter("filename");
	String refgenome = request.getParameter("refgenome");
	//String refgenome = request.getParameter("refgenome").equals("null") ? "non" : request.getParameter("refgenome");
	String annotation_filename = request.getParameter("annotation_filename");
	
	String CM_Plot_Bin_Size = request.getParameter("CM_Plot_Bin_Size");
	
	/*
	System.out.println();
	System.out.println("jobid_ideogram : " + jobid_ideogram);
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("filename : " + filename);
	System.out.println("refgenome : " + refgenome);
	System.out.println("annotation_filename : " + annotation_filename);
	System.out.println("CM_Plot_Bin_Size : " + CM_Plot_Bin_Size);
	System.out.println();	
	*/

	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/ideogram/";
	//String annotationPath = rootFolder + "uploads/reference_database/"+refgenome+"/";
	String annotationPath = refgenome.equals("null") ? "non" : rootFolder + "uploads/reference_database/"+refgenome+"/";
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

	File folder_outputPath = new File(outputPath+jobid_ideogram);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	
	
	//String cmd = "Rscript " +script_path+ "breedertoolbox_ideogram_final.R " +savePath+ " " +outputPath+ " " +jobid_ideogram +" "+ filename +" "+ CM_Plot_Bin_Size +" "+ annotationPath +" "+ annotation_filename;
	String cmd = "Rscript " +script_path+ "breedertoolbox_ideogram_final.R " +savePath+ " " +outputPath+ " " +jobid_ideogram +" "+ filename +" "+ CM_Plot_Bin_Size +" "+ annotationPath +" "+ permissionUid +" "+ varietyid;
	
	System.out.println("ideogram cmd : " + cmd);
	
	
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