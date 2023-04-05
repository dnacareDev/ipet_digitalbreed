<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*, java.util.stream.Stream, java.util.stream.IntStream"%> 
<% 
	// CSV파일을 읽을때 일반적인 readLine과 Stream클래스를 사용했을때의 효율 비교
	// 속도와 메모리 모두 비교
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/database/genotype_statistics/";

	//String jobid = "20230202163316";		// 6.14MB
	//String jobid = "20230203131925";		// 97.4MB
	//String jobid = "20221221115015";		// 1.38GB
	String jobid = "20230322094220";		// GWAS
	
	int csvReadLine = 0;
	int csvStream = 1;
	
	int myChoice = 1;
	
	if(myChoice == csvReadLine) {
		csvReadLine(path, jobid);
	} else if(myChoice == csvStream) {
		csvStream(rootFolder, jobid);
	}
	
%>

<%!
	private void csvReadLine(String path, String jobid) {
	
		System.out.println("==================================");
		System.out.println("CSV file (readLine)");
	
		
		
		try {
			long beforeTime = System.currentTimeMillis();

			File csvFile = new File(path+"/"+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
			BufferedReader br = new BufferedReader(new FileReader(csvFile));
			
			String line;
			for(int i=0 ; (line = br.readLine()) != null ; i++) {
				if(5000<=i && i<= 10000) {
					//System.out.println(line);
				}
			}
			
			br.close();
			
			long afterTime = System.currentTimeMillis();
			
			System.out.println("jobid : " +jobid+ ", fileSize : " + ( Files.size(csvFile.toPath())/(1024 * 1024) ) + "MB, time : " + (afterTime - beforeTime) + "ms");
		} catch(IOException e) {
			e.printStackTrace();
		} 
		
		System.out.println("==================================");
	}
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
	
			
			//Stream<String> lines = Files.lines(Paths.get(path+"/"+jobid+"/"+jobid+"_genotype_matrix_viewer.csv"));
			//String specificLine = lines.skip(0).findFirst().get();
            //System.out.println(specificLine);
			
            /*
            Stream<String> lines = Files.lines(Paths.get(path+"/"+jobid+"/"+jobid+"_genotype_matrix_viewer.csv"))
            							.skip(5000)
            							.limit(5000);
           	*/
           	Stream<String> lines = Files.lines(Paths.get(path+"/"+jobid+"/GAPIT.Association.GWAS_Results.MLM.Yield.csv"))
										//.skip(5000)
										.limit(50);
           	
           	/*
           	Stream<String> lines = Files.lines(Paths.get(path+"CsGojo-0_v1.LG1-9.fasta"))
           								.filter(t -> t.contains(">"));
           	*/

           	//Stream<String> lines = Files.lines(Paths.get(path+"../split/pep/pep.txt"));
           	
           	
           	lines.forEach(line -> {
	                System.out.println(line);
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