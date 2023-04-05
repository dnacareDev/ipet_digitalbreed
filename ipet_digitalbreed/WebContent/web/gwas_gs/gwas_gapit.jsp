<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*, java.util.stream.Stream, java.util.stream.IntStream"%>
<%
	response.setCharacterEncoding("EUC-KR");

	String model_name = request.getParameter("model_name");
	String phenotype = request.getParameter("phenotype");
	String jobid_param = request.getParameter("jobid_param");
	
	
	System.out.println(model_name);
	System.out.println(phenotype);
	System.out.println(jobid_param);
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	csvStream(rootFolder, model_name, phenotype, jobid_param);
%>

<%!
	private void csvStream(String rootFolder, String model_name, String phenotype, String jobid) {
		//String path = rootFolder + "/uploads/reference_database/CsGojo-0_v1_HC/fasta/";
		String path = rootFolder + "/result/GWAS/";

		
		System.out.println("==================================");
		System.out.println("CSV file (Stream class)");
		
		
		List<String> example = new ArrayList<>();
		
		try {
			long startMem = Runtime.getRuntime().freeMemory();
			long beforeTime = System.currentTimeMillis();
	
			
           	Stream<String> lines = Files.lines(Paths.get(path+"/"+jobid+"/GAPIT.Association.GWAS_Results."+model_name+"."+phenotype+".csv"))
										.skip(1)
										//.limit(50);
           								.filter(line -> Math.pow(10, Double.parseDouble(line.split(",")[3])) > 5); 
           	
           	
           	
           	lines.forEach(line -> {
	                //System.out.println(line);
	                System.out.println(Math.pow(10, Double.parseDouble(line.split(",")[3])));
	        });
           	
           
           	//System.out.println(lines.count());
           	
            long afterTime = System.currentTimeMillis();
			
			System.out.println("jobid : " +jobid+ ", time : " + (afterTime - beforeTime) + "ms");
			
			
			long endMem = Runtime.getRuntime().freeMemory();
			long memConsumed = startMem - endMem;
			System.out.println("Memory consumed by lines variable: " + (memConsumed / (1024 * 1024)) + " MB");
            lines.close();
		} catch(IOException e) {
			e.printStackTrace();
		} 
		
		System.out.println("==================================");
	}
%>