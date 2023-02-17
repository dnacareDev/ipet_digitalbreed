<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String chr = request.getParameter("chr");
	String jobid = request.getParameter("jobid");
	String model = request.getParameter("model");
	String phenotype = request.getParameter("phenotype");
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/gwas/";
	
	//System.out.println(chr);
	//System.out.println(jobid);
	//System.out.println(model);
	//System.out.println(phenotype);
	
	//System.out.println(path+jobid+"/"+"GAPIT.Association.GWAS_Results." +model+ "." +phenotype+ ".csv");
	
	File file = new File(path+jobid+"/"+"GAPIT.Association.GWAS_Results." +model+ "." +phenotype+ ".csv");
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
	
	JsonArray jsonArray = new JsonArray();
	
	String line = br.readLine();
	//System.out.println(line);
	out.clear();
	int i=0;
	while((line=br.readLine()) != null) {
		i++;
		
		String[] lineArr = line.split(",");
		//System.out.println(lineArr[1]);
		//System.out.println(chr);
		//if( lineArr[1].equals(chr) ) {
		if( lineArr[1].toUpperCase().equals(chr.toUpperCase()) ) {
			JsonObject jsonObject = new JsonObject();
			//jsonObject.addProperty("row_id", i);
			jsonObject.addProperty("selection", false);
			jsonObject.addProperty("SNP", lineArr[0]);
			jsonObject.addProperty("Chr", lineArr[1]);
			jsonObject.addProperty("Pos", lineArr[2]);
			jsonObject.addProperty("P-value", lineArr[3]);
			jsonObject.addProperty("MAF", lineArr[4]);
			jsonObject.addProperty("Nobs", lineArr[5]);
			jsonObject.addProperty("H&B.P.Value", lineArr[6]);
			jsonObject.addProperty("Effect", lineArr[7]);
			jsonArray.add(jsonObject);
		}
	}
	
	//System.out.println(jsonArray);
	out.print(jsonArray);
	br.close();
	
%>