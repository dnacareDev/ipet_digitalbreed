<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%

	String permissionUid = session.getAttribute("permissionUid")+"";
	String jobid = request.getParameter("jobid");
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String outputPath = rootFolder+"result/database/genotype_statistics/";

	
	
	System.out.println("========CSV to Json start========");
	//CsvToJson csvToJson = new CsvToJson();
	//csvToJson.getJson(outputPath, jobid);
	System.out.println("========CSV to Json end========");
%>