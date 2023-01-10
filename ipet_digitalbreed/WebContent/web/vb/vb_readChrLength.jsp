<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.JsonObject, com.google.gson.JsonArray"%> 
<%
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String chr_num = request.getParameter("chr_num");
	//System.out.println("chr_num : " + chr_num);
	String chr_leftpad = String.format("%02d", Integer.parseInt(chr_num));
	//System.out.println(s);

	
	File file = new File(rootFolder+"uploads/database/db_input/20230105184938/참조유전체_Annuum_v1_6.vcf");
	
	try {
		JsonArray jsonArray = new JsonArray();
		JsonObject jsonObject = new JsonObject();
		
		BufferedReader br = new BufferedReader(new FileReader(file));
		
		out.clear();
		String line;
		while( (line = br.readLine()) != null) {
			//System.out.println(line);
			//System.out.println(line.substring(0,2) != "##");
			if(!line.substring(0,2).equals("##"))	break;
			
			
			if(line.contains("##contig")) {
				//System.out.println(line);
				String property = line.substring( line.indexOf("chr"), line.indexOf("chr") + 5);
				String value = line.substring(line.indexOf("length=")+7, line.length()-1);
				//System.out.println(line.substring( line.indexOf("chr"), line.indexOf("chr") + 5));
				//System.out.println(line.substring(line.indexOf("length=")+7, line.length()-1));
				jsonObject.addProperty(property, value);
			}
			
			/*
			// ##contig=<ID=chr01,length=309102287> | chr01의 길이정보 추출
			if(line.contains("contig") && line.contains("chr"+chr_leftpad)) {
				out.print(line.substring( line.indexOf("length=")+7, line.length()-1) );
			}
			*/
		}
		
		//System.out.println("end");
		out.print(jsonObject);
		
	} catch (IOException e) {
		e.printStackTrace();
	}
	
%>