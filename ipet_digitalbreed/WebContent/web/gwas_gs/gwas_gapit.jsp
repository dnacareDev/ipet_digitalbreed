<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*, java.util.stream.Stream, java.util.stream.IntStream"%>
<%@ page import="com.google.gson.*" %>

<%
	response.setCharacterEncoding("EUC-KR");

	String model_name = request.getParameter("model_name");
	String phenotype = request.getParameter("phenotype");
	String jobid_param = request.getParameter("jobid_param");
	String cutOff = request.getParameter("cutOff");
	
	/*
	System.out.println(model_name);
	System.out.println(phenotype);
	System.out.println(jobid_param);
	*/
	System.out.println(cutOff);
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	//System.out.println("cutOff : " + cutOffValue);
	
	JsonArray jsonArray = new JsonArray();
	if(cutOff.equals("-1")) {
		String cutOffValue = cutOff(rootFolder, model_name, phenotype, jobid_param);
		//System.out.println("default");
		jsonArray = csvStream(rootFolder, model_name, phenotype, jobid_param, cutOffValue);
	} else {
		//System.out.println("cutOff");
		//System.out.println(Math.pow(10, -Double.parseDouble(cutOff)) + "");
		String cutOffValue = Math.pow(10, -Double.parseDouble(cutOff)) + "";
		//jsonArray = csvStream(rootFolder, model_name, phenotype, jobid_param, cutOff);
		jsonArray = csvStream(rootFolder, model_name, phenotype, jobid_param, cutOffValue);
	}
	
	out.clear();
	out.print(jsonArray);
%>

<%!
private String cutOff(String rootFolder, String model_name, String phenotype, String jobid) {
	
	String path = rootFolder + "/result/gwas/";
	
	String cutOffValue = "";
	try {
		
        Stream<String> lines = Files.lines(Paths.get(path+"/"+jobid+"/cutoff.txt"))
          								.filter(line -> line.contains(model_name) && line.contains(phenotype) && line.contains("bonferroniCutOff(0.05)"));
        
        cutOffValue = lines.findFirst().get().split(",")[3];
          	
        lines.close();
        
	} catch(IOException e) {
		e.printStackTrace();
	} 
	return cutOffValue;
}
%>

<%!
private JsonArray csvStream(String rootFolder, String model_name, String phenotype, String jobid, String cutOffValue) {
	//String path = rootFolder + "/uploads/reference_database/CsGojo-0_v1_HC/fasta/";
	String path = rootFolder + "/result/gwas/";

	//System.out.println(cutOffValue);
	
	//System.out.println("==================================");
	//System.out.println("CSV file (Stream class)");
	
	
	JsonArray jsonArray = new JsonArray();
	
	try {
		long beforeTime = System.currentTimeMillis();

		
        Stream<String> lines = Files.lines(Paths.get(path+"/"+jobid+"/GAPIT.Association.GWAS_Results."+model_name+"."+phenotype+".csv"))
									.skip(1)
       								//.filter(line -> Math.log10(Double.parseDouble(line.split(",")[3])) > Double.parseDouble(cutOffValue));
									.filter(line -> Double.parseDouble(line.split(",")[3]) < Double.parseDouble(cutOffValue));
          	
          	
          	
        lines.forEach(line -> {
        	
        	String[] lineArr = line.split(",");
        	
        	JsonObject jsonObject = new JsonObject();
        	jsonObject.addProperty("SNP", lineArr[0]);
        	jsonObject.addProperty("Chr", lineArr[1]);
        	jsonObject.addProperty("Pos", lineArr[2]);
        	jsonObject.addProperty("P-value", lineArr[3]);
        	jsonObject.addProperty("MAF", lineArr[4]);
        	jsonObject.addProperty("nobs", lineArr[5]);
        	jsonObject.addProperty("H&B.P.Value", lineArr[6]);
        	jsonObject.addProperty("Effect", lineArr[7]);
        	jsonArray.add(jsonObject);
        	//System.out.println(line);
            //System.out.println(Math.log10(Double.parseDouble(line.split(",")[3])));
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