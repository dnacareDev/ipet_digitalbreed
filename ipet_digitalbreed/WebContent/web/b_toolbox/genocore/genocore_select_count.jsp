<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String count = request.getParameter("count");
	String jobid = request.getParameter("jobid");	
	String filename = request.getParameter("filename");	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");

	System.out.println();
	System.out.println("jobid : " + jobid);
	System.out.println("rootPath : " + rootFolder);
	System.out.println();	
	
	
	//String inputPath = rootFolder + "uploads/database/db_input/" + jobid + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/genocore/" + jobid + "/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	System.out.println();
	System.out.println("script_path : " + script_path);
	System.out.println("outputPath : " + outputPath);
	System.out.println();
	
	//String Genocore = "Rscript " +script_path+ "breedertoolbox_genocore_final.R " +savePath+ " " +outputPath+ " " +jobid2+ " " +filename;
	String genocoreCount = "Rscript " + script_path+ "breedertoolbox_genocore_filtering_final.R " +outputPath+ " " +filename+ " " +count;
	
	System.out.println("genocoreCount parameter : " + genocoreCount);
			
	runanalysistools.execute(genocoreCount, "cmd");
	

		
	
%>