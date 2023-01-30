<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%
	String permissionUid = session.getAttribute("permissionUid")+"";

	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/database/genotype_statistics/20230112165329/browser_data/";

	String key1 = request.getParameter("key1");
	
	System.out.println(key1);
	
	out.print(key1);
	
	
%>


<%!
	public void readCSV(String jobid, String permissionUid, String path, int lineCount, String listLine) {
		
	}
%>