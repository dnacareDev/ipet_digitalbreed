<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="com.google.gson.*" %>

<%
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String jobid = request.getParameter("jobid");
	String resultPath = rootFolder+"result/Breeder_toolbox_analyses/structure";
	
	
	System.out.println("====================================");
	System.out.println("jobid : " + jobid);
	System.out.println("====================================");	
	
	JsonArray jsonArray = htmlList(resultPath, jobid);
	
	out.clear();
	out.print(jsonArray);
%>

<%!
	private JsonArray htmlList(String resultPath, String jobid) {
	    
		JsonArray jsonArray = new JsonArray();
		
		// 현재 작업 디렉터리의 파일 리스트 출력
		File resultPathFile = new File(resultPath+"/"+jobid+"/plot/"); 
		System.out.println(resultPath+"/"+jobid+"/plot/");
		File[] list = resultPathFile.listFiles();
		
		for (int i = 0; i < list.length; i++) {
			
			
			if(list[i].getName().contains(".html")) {
				//System.out.println(list[i].getName());
				JsonObject jsonObject = new JsonObject();
				jsonObject.addProperty("file_name", list[i].getName().replaceAll(".html", ""));
				jsonArray.add(jsonObject);
			}
	 	}
		
		//System.out.println(jsonArray);
		
		return jsonArray;
	
	}
%>