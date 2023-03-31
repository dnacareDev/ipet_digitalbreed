<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String jobid_gs = request.getParameter("jobid_gs");
	//String outputdir = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/result/gwas/";
	//String outputdir = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/result/GS/Pheno/";
	String outputdir = rootFolder + "/result/GS/";
	
	System.out.println("===========================================");
	System.out.println("outputdir : " + outputdir);
	System.out.println("===========================================");
	
	try {
		BufferedReader reader = new BufferedReader(new FileReader(outputdir+jobid_gs+"/"+jobid_gs+"_samplecheck.txt"));
		String line = reader.readLine();
		out.clear();
		out.print(line);
		reader.close();
		
		/*
		String str;
		boolean first_line = true;
		while((str = reader.readLine()) != null) {
			if(first_line) {
				first_line = false;
				continue;
			}
			//System.out.println(str);
			out.print(str+",");
		}
		reader.close();
		*/
	} catch(IOException e) {
		e.printStackTrace();
	}
	//out.print(jobid_gwas);
%>