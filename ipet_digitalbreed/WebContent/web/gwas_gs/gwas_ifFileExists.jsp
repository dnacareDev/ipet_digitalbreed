<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*" %>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String resultpath = rootFolder+"result/gwas/";
	String model_name = request.getParameter("model_name");
	String jobid_param = request.getParameter("jobid_param");
	String value = request.getParameter("value");				// value = select로 선택한 phenotype값
	
	out.clear();
	
	//System.out.println(model_name);
	//System.out.println(resultpath+jobid_param+"/"+model_name+ "_" +value+ ".html");
	
	
	File file;
	
	if(model_name.equals("Multi")) {
		String isQQ = request.getParameter("isQQ");
		//System.out.println(isQQ);
		
		if(isQQ.equals("QQ")) {
			file = new File(resultpath+jobid_param+"/multi_QQ_" +value+ ".html");
		} else {
			file = new File(resultpath+jobid_param+"/multi_" +value+ ".html");
		}
		
	} else if(model_name.equals("QQ")) {
		
		String QQ_model = request.getParameter("QQ_model");
		
		file = new File(resultpath+jobid_param+"/QQ_"+QQ_model+ "_" +value+ ".html");
	} else {
		file = new File(resultpath+jobid_param+"/"+model_name+ "_" +value+ ".html");					// Multiple Model, QQ Plot 이외의 모델 선택. 
	}
	
	//System.out.println(file.toString());
	
	//File file = new File(resultpath+jobid_param+"/"+model_name+ "_" +value+ ".html");
	if(file.exists()) {
		//System.out.println("true");
		out.print("exists");
	} else {
		//System.out.println("false");
		out.print("not exist");
	}
%>