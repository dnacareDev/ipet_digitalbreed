<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*, java.util.stream.Stream, java.util.stream.IntStream"%> 
<% 
	// CSV파일을 읽을때 일반적인 readLine과 Stream클래스를 사용했을때의 효율 비교
	// 속도와 메모리 모두 비교
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/gwas/";

	String jobid = "20230303142523";		// GWAS
	
	csvStream(rootFolder, jobid);
	
%>

<%!
	private void csvStream(String rootFolder, String jobid) {
		//String path = rootFolder + "/uploads/reference_database/CsGojo-0_v1_HC/fasta/";
		String path = rootFolder + "/result/GWAS/";

		
		System.out.println("==================================");
		System.out.println("CSV file (Stream class)");
		
		
		List<String> example = new ArrayList<>();
		
		try {
			long startMem = Runtime.getRuntime().freeMemory();
			long beforeTime = System.currentTimeMillis();
	
			
           	Stream<String> lines = Files.lines(Paths.get(path+"/"+jobid+"/GAPIT.Association.GWAS_Results.CMLM.과장1.csv"))
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