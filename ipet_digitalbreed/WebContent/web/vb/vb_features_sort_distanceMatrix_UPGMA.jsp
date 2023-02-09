<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%

	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String permissionUid = session.getAttribute("permissionUid")+"";

	String standard_id = request.getParameter("standard_id");
	String upgma_jobid = request.getParameter("upgma_jobid");

	
	System.out.println("=======================================");
	System.out.println("standard_id : " + standard_id);
	System.out.println("upgma_jobid : " + upgma_jobid);
	System.out.println("=======================================");
	
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "result/Breeder_toolbox_analyses/phylogenetic_tree/" +upgma_jobid+ "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/phylogenetic_tree/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	
	System.out.println("=======================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("rootPath : " + rootFolder);
	System.out.println("savePath : " + savePath);
	System.out.println("outputPath : " + outputPath);
	System.out.println("script_path : " + script_path);
	System.out.println("=======================================");
	
	
	
	
	String sort_distance_matrix = "Rscript " +script_path+ "sort_Distance_Matrix.R " +savePath+ " " +outputPath+ " " +upgma_jobid+ " " +upgma_jobid+ "_Distance_Matrix.csv " + standard_id;
	System.out.println("sort_Distance_Matrix.R script : " + sort_distance_matrix);

	runanalysistools.execute(sort_distance_matrix, "cmd");
	
	
%>