<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="com.google.gson.*" %>
<%@ page import="org.apache.commons.exec.*" %>

<%
	//IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	//ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String jobid = request.getParameter("jobid");
	String selected_row = request.getParameter("selected_row");
	
	String cmd = "Rscript /data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/GS_spyderplot.R "+ jobid +" "+ selected_row;
	
	System.out.println("cmd : " + cmd);
	//runanalysistools.execute(cmd, "cmd");
	try {
		CommandLine cmdLine = CommandLine.parse(cmd);
		DefaultExecutor executor = new DefaultExecutor();
		executor.setExitValue(0);
		int exitValue = executor.execute(cmdLine);
		if(exitValue == 0) {
			System.out.println("Success");
		} else {
			System.out.println("Fail");
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	
	//out.clear();
	//out.print("1");
%>
