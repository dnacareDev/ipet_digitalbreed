<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		

	String jobid_vcf = request.getParameter("jobid_vcf");
	String jobid_upgma = request.getParameter("jobid_upgma");
	String filename = request.getParameter("filename");
	String population_name = request.getParameter("population_name");
	
	
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String inputPath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/phylogenetic_tree/";
	String populationPath = rootFolder + "uploads/Breeder_toolbox_analyses/upgma/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	System.out.println("=========================");
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("jobid_upgma : " + jobid_upgma);
	System.out.println("filename : " + filename);
	System.out.println("population_name : " + population_name);
	System.out.println("=========================");
	
	System.out.println("=========================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("rootPath : " + rootFolder);
	System.out.println("inputPath : " + inputPath);
	System.out.println("outputPath : " + outputPath);
	System.out.println("populationPath : " + populationPath);
	System.out.println("script_path : " + script_path);
	System.out.println("=========================");

	
	
	File folder_outputPath = new File(outputPath+jobid_upgma);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
			System.out.println("outputPath mkdirs");
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	
	String UPGMA = "Rscript " +script_path+ "phylogenetic_tree.R " +inputPath+ " " +outputPath+ " " +jobid_upgma+ " " +filename+ " " +populationPath+ " " +population_name;
	
	System.out.println("UPGMA parameter(with population) : " + UPGMA);
	
	runanalysistools.execute(UPGMA);
	
%>