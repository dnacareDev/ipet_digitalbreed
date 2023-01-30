<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String permissionUid = session.getAttribute("permissionUid")+"";


	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/database/genotype_statistics/";

	//String jobid = "20230130185914";
	String jobid = request.getParameter("jobid");
	
	//IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	//ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	
	File csvFile = new File(path+jobid+"/"+jobid+"_chr_row_index_data.csv");
	
	System.out.println("======================");
	System.out.println("read chr datalist file");
	System.out.println("======================");
	
	JsonArray jsonArray = new JsonArray();

	try {
		BufferedReader br = new BufferedReader(new FileReader(csvFile));
		
		String line = br.readLine();
		while( (line = br.readLine()) != null) {
			
			String[] arr = line.split(",");
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("chr", arr[0]);
			jsonObject.addProperty("vcfId_at_firstRow", arr[1]);
			jsonObject.addProperty("row_count", arr[2]);
			
			jsonArray.add(jsonObject);
		}
		
		
		out.print(jsonArray);
		
		br.close();
		
		
	} catch (IOException e) {
		e.printStackTrace();
	} 
	
	
%>


<%!
	public void readCSV(String jobid, String permissionUid, String path, int lineCount, String listLine) {
		
		
	}
%>