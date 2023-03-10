<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*, java.util.stream.Stream"%> 
<%@ page import="com.google.gson.*" %>

<%
	String mRNA_id = request.getParameter("mRNA_id");
	String refgenome = request.getParameter("refgenome");
	String annotation_filename = request.getParameter("annotation_filename");
	
	//System.out.println(mRNA_id);
	//System.out.println(refgenome);
	//System.out.println(annotation_filename);
	
	long beforeTime = System.currentTimeMillis();
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder + "/uploads/reference_database/" +refgenome+ "/annotation/";
	
	JsonObject result = new JsonObject();
	JsonObject mRna_id = new JsonObject();
	JsonArray attributes = new JsonArray();
	
	//System.out.println(Paths.get(path+annotation_filename));
	
	
	Stream<String> lines = Files.lines(Paths.get(path+annotation_filename))
								.filter((item) -> item.contains(mRNA_id));
	
	//System.out.println(lines);
	
	lines.forEach(line -> {
		//System.out.println("line : " + line);
		
		if(!line.isEmpty()) {
			String[] lineArr = line.split("\t");
			result.addProperty("mRna_id", lineArr[0]);
			
			String[] attributesArr = lineArr[1].split(";");
			for(int i=0 ; i<attributesArr.length ; i++) {
				attributes.add(attributesArr[i]);
			}
			result.add("attributes", attributes);
			
			//result.add(attributes, value)			
		}
	});
	//out.print(description);
	
				
	long afterTime = System.currentTimeMillis();
	
	
	out.clear();
	out.print(result);
	//System.out.println(result);
	System.out.println("read annotation time : " + (afterTime -  beforeTime) + "ms");
%>