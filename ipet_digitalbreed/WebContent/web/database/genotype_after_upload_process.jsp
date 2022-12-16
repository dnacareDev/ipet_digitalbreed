<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	RunAnalysisTools runanalysistools = new RunAnalysisTools();

	String permissionUid = session.getAttribute("permissionUid")+"";
	String jobid = request.getParameter("jobid");
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String outputPath = rootFolder+"result/database/genotype_statistics/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";	

	
	// CSV => JSON파일 생성
	System.out.println("========CSV to Json start========");
	CsvToJson csvToJson = new CsvToJson();
	csvToJson.getJson(outputPath, jobid, permissionUid);
	System.out.println("========CSV to Json end========"); 
	
	
	// CSV => 행렬변환된 CSV파일 생성
	String csv_transpose = "Rscript " +script_path+ "genotype_sequence_bakground.R " +outputPath+" "+ jobid;
	
	System.out.println("========CSV transpose start========");
	System.out.println("csv_transpose : " + csv_transpose);
	runanalysistools.execute(csv_transpose, "cmd");
	System.out.println("========CSV transpose end========");
%>