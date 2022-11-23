<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	String jobid_pca = runanalysistools.getCurrentDateTime();
	out.clear();
	//System.out.println("jobid_pca : "+ jobid_pca);
	out.print(jobid_pca);
%>