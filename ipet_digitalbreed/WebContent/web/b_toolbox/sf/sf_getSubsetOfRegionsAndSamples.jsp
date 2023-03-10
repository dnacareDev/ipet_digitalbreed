<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String permissionUid = session.getAttribute("permissionUid")+"";


	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/database/genotype_statistics/";

	String jobid = request.getParameter("jobid");

	JsonObject result = new JsonObject();
	
	File chrFile = new File(path+jobid+"/"+jobid+"_chr_row_index_data.csv");

	try {
		BufferedReader br = new BufferedReader(new FileReader(chrFile));
		
		JsonArray jsonArray = new JsonArray();
		
		String line = br.readLine();
		while( (line = br.readLine()) != null) {
			
			String[] arr = line.split(",");
			
			//System.out.println(Arrays.toString(arr));
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("chromosome", arr[0]);
			//jsonObject.addProperty("vcfId_at_firstRow", arr[1]);
			//jsonObject.addProperty("row_count", arr[2]);
			jsonObject.addProperty("length", Integer.parseInt(arr[3]));
			
			jsonArray.add(jsonObject);
		}
		
		result.add("chr", jsonArray);
		br.close();
		
		
	} catch (IOException e) {
		e.printStackTrace();
	} 
	
	File sampleFile = new File(path+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
	
	try {
		BufferedReader br = new BufferedReader(new FileReader(sampleFile));
		
		JsonArray jsonArray = new JsonArray();

		String line = br.readLine();
		String[] columns = line.split(",");
		for(int i=4 ; i<columns.length ; i++) {
			//System.out.println(columns[i]);
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("sample", columns[i]);
			jsonArray.add(jsonObject);
		}
		
		result.add("sample", jsonArray);
		br.close();
		
		
	} catch (IOException e) {
		e.printStackTrace();
	} 
	
	out.clear();
	out.print(result);
	
%>

