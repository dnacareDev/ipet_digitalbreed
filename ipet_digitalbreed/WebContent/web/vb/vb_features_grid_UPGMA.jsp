<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%

	String jobid = request.getParameter("jobid");
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/Breeder_toolbox_analyses/phylogenetic_tree/";
	
	File fileRead = new File(path+"/"+jobid+"/"+jobid+"_Similarity_Table.csv");
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(fileRead), "UTF-8"));
	
	JsonArray jsonArr = new JsonArray();
	
	String line = br.readLine();
	while((line = br.readLine()) != null) {
		//System.out.println(line);
		String[] lineArr = line.split(",");
		JsonObject jsonObject = new JsonObject();
		for(int i=0 ; i<lineArr.length ; i++) {
			jsonObject.addProperty("id", lineArr[0].replaceAll("\"", ""));
			jsonObject.addProperty("population", lineArr[1]);
			jsonObject.addProperty("similarity", lineArr[2]);
		}
		
		jsonArr.add(jsonObject);
	}
	
	
	//System.out.println(jsonArr);
	out.print(jsonArr);
%>