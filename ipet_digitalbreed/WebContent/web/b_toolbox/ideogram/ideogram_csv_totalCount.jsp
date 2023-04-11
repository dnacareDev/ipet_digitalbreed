<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*, java.util.stream.Stream, java.util.stream.IntStream"%>
<%@ page import="com.google.gson.*" %>

<%
	response.setCharacterEncoding("EUC-KR");

	String jobid = request.getParameter("jobid");
	String resultpath = request.getParameter("resultpath");
	
	/*
	System.out.println(model_name);
	System.out.println(phenotype);
	System.out.println(jobid_param);
	*/
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	//System.out.println("cutOff : " + cutOffValue);
	JsonArray jsonArray = csvStream(rootFolder, jobid, resultpath);
	
	out.clear();
	out.print(jsonArray);
%>


<%!
private JsonArray csvStream(String rootFolder, String jobid, String resultpath) {
	String path = rootFolder + resultpath.replace("/ipet_digitalbreed/","");

	//System.out.println(path);
	
	//System.out.println("==================================");
	//System.out.println("CSV file (Stream class)");
	
	
	JsonArray jsonArray = new JsonArray();
	
	try {
		long beforeTime = System.currentTimeMillis();

		
        Stream<String> lines = Files.lines(Paths.get(path+"/"+jobid+"/"+jobid+"_totalcount.csv"))
									.skip(1)
									.filter(line -> Integer.parseInt(line.split(",")[1]) != 0);
          	
          	
          	
        lines.forEach(line -> {
        	
        	String[] lineArr = line.split(",");
        	
        	JsonObject jsonObject = new JsonObject();
        	jsonObject.addProperty("Chr", lineArr[0]);
        	jsonObject.addProperty("variant_count", lineArr[1]);
        	jsonArray.add(jsonObject);
        	
        	//System.out.println(line);
        });
          	

        //System.out.println(lines.count());
          	
        long afterTime = System.currentTimeMillis();
		
		//System.out.println("jobid : " +jobid+ ", time : " + (afterTime - beforeTime) + "ms");
		
		//System.out.println(jsonArray);
		
        lines.close();
	} catch(IOException e) {
		e.printStackTrace();
	} 
	
	//System.out.println("==================================");
	
	return jsonArray;
}
%>