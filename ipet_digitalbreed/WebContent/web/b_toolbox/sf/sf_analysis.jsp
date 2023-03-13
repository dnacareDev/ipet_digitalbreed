<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	//IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String jobid_vcf = request.getParameter("jobid_vcf");
	String file_name = request.getParameter("file_name");
	String jobid_qf = request.getParameter("jobid_qf");
	
	
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/quality/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	/*
	//String db_savePath = "uploads/database/db_input/";
	//String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/quality/";
	
	
	System.out.println("=======================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("rootPath : " + rootFolder);
	System.out.println("savePath : " + savePath);
	System.out.println("outputPath : " + outputPath);
	System.out.println("script_path : " + script_path);
	System.out.println("=======================================");
	
	//System.out.println("=======================================");
	//System.out.println("db_savePath : " + db_savePath);
	//System.out.println("db_outputPath : " + db_outputPath);
	//System.out.println("=======================================");
	
	File folder_outputPath = new File(outputPath+jobid_qf);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	String QF = "Rscript " +script_path+ "breedertoolbox_quality.R " +savePath+ " " +outputPath+ " " +jobid_qf+ " " +file_name+ " " +variant_type+ " " +allelic_type+ " " +missing+ " "	+maf+ " " +minDP+ " " +minGQ+ " " +thin;
	System.out.println("Quality Filter parameter : " + QF);

	runanalysistools.execute(QF, "cmd");
	*/
%>