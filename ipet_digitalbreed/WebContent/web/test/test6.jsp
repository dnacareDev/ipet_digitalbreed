<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="ipet_digitalbreed.*"%>  

<%

	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder+"uploads/database/db_input/";
	String outputPath = rootFolder+"result/database/genotype_statistics/";
	
	String permissionUid = "dnacare";
	String jobid = "20230202132011";
	
	

%>