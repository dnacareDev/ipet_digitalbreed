<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String chr = request.getParameter("chr");
	String jobid = request.getParameter("jobid");
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/Breeder_toolbox_analyses/minimalmarker/";
	
	//System.out.println(jobid);
	
	//System.out.println(path+jobid+"/"+jobid+"_marker_final.csv");
	
	File file = new File(path+jobid+"/"+jobid+"_marker_final.csv");
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
	
	JsonArray jsonArray = new JsonArray();
	
	String line = br.readLine();
	//System.out.println(line);
	out.clear();
	while((line=br.readLine()) != null) {
		String[] lineArr = line.split(",");
		//System.out.println(lineArr[1]);
		//System.out.println(chr);
		//if( lineArr[0].equals(chr) ) {
		JsonObject jsonObject = new JsonObject();
			//jsonObject.addProperty("row_id", lineArr[1]+ "_" +lineArr[2]);
			jsonObject.addProperty("row_id", lineArr[2]);
			jsonObject.addProperty("selection", false);
			jsonObject.addProperty("chr", lineArr[0]);
			jsonObject.addProperty("pos", lineArr[1]);
			jsonObject.addProperty("REF", lineArr[3]);
			jsonObject.addProperty("ALT", lineArr[4]);
			jsonArray.add(jsonObject);
		//}
	}
	
	//System.out.println(jsonArray);
	out.print(jsonArray);
	br.close();
	
%>