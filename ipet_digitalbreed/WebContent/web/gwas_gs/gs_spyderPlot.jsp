<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="com.google.gson.*" %>

<%
	//IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	//ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String jobid = request.getParameter("jobid");
	//String resultpath = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/result/GS/";
	String selected_row = request.getParameter("selected_row");
	
	String cmd = "Rscript /data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/GS_spyderplot.R "+ jobid +" "+ selected_row;
	
	System.out.println("cmd : " + cmd);
	runanalysistools.execute(cmd, "cmd");
	
	out.clear();
	out.print("1");
%>
