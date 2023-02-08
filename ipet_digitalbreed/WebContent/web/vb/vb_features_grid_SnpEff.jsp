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
	String path = rootFolder+"result/database/genotype_statistics/";
	
	//System.out.println(chr);
	//System.out.println(jobid);
	
	//System.out.println(path+jobid+"/"+jobid+"_snpeff.csv");
	
	File file = new File(path+jobid+"/"+jobid+"_snpeff.csv");
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
	
	JsonArray jsonArray = new JsonArray();
	
	String line = br.readLine();
	
	out.clear();
	while((line=br.readLine()) != null) {
		
		String[] lineArr = line.split(",");
		
		if( lineArr[0].equals(chr) ) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("chr", lineArr[0]);
			jsonObject.addProperty("pos", lineArr[1]);
			jsonObject.addProperty("impact", lineArr[2]);
			jsonObject.addProperty("effect_classic", lineArr[3]);
			jsonObject.addProperty("gene_id", lineArr[4]);
			jsonObject.addProperty("description", lineArr[5]);
			jsonArray.add(jsonObject);
		}
	}
	
	out.print(jsonArray);
	br.close();
%>