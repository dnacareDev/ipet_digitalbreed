<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*" %>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	String jobid_gwas = runanalysistools.getCurrentDateTime();
	out.clear();
	System.out.println("jobid_gwas : "+ jobid_gwas);
	out.print(jobid_gwas);
%>