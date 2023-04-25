<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*, java.util.stream.Stream, java.util.stream.IntStream"%>
<%@ page import="com.google.gson.*" %>

<%
	response.setCharacterEncoding("UTF-8");

	String jobid = request.getParameter("jobid");
	int number_of_k = Integer.parseInt(request.getParameter("number_of_k"));
	
	/*
	System.out.println(jobid);
	System.out.println(number_of_k);
	*/
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	//System.out.println("cutOff : " + cutOffValue);
	JsonArray jsonArray = csvStream(rootFolder, jobid, number_of_k);

	//System.out.println(jsonArray);
	out.clear();
	out.print(jsonArray);
	/*
	*/
%>

<%!
private JsonArray csvStream(String rootFolder, String jobid, int number_of_k ) {
	String path = rootFolder + "/result/Breeder_toolbox_analyses/structure/";

	//System.out.println("==================================");
	//System.out.println("CSV file (Stream class)");
	
	JsonArray jsonArray = new JsonArray();
	
	try {
		//long beforeTime = System.currentTimeMillis();

		
        Stream<String> lines = Files.lines(Paths.get(path+"/"+jobid+"/table/"+number_of_k+"_clu.csv"))
									.skip(1);
									//.filter(line -> Double.parseDouble(line.split(",")[3]) < Double.parseDouble(cutOffValue));
          	
        lines.forEach(line -> {
        	
        	String[] lineArr = line.split(",");
        	
        	JsonObject jsonObject = new JsonObject();
        	jsonObject.addProperty("Sample_Name", lineArr[0]);
        	for(int i=1 ; i<=number_of_k ; i++) {
        		jsonObject.addProperty("Cluster"+i, lineArr[i]);
        	}
        	jsonArray.add(jsonObject);
        	//System.out.println(line);
        });
          	

        //System.out.println(lines.count());
          	
        //long afterTime = System.currentTimeMillis();
		//System.out.println("jobid : " +jobid+ ", time : " + (afterTime - beforeTime) + "ms");
		
		//System.out.println(jsonArray);
		
        lines.close();
	} catch(IOException e) {
		e.printStackTrace();
	} 
	/*
	*/
	
	//System.out.println("==================================");
	return jsonArray;
}
%>