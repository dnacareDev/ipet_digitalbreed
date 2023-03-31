<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    


<%

if (request.getMethod().equals("POST"))
{
	int maxPostSize = 2147482624; // bytes
	
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	

	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	String VcfPath = rootFolder + "uploads/database/db_input/";
	//String phenotypePath = rootFolder + "/uploads/GS/"+jobid_gs+"/train_pheno_1-9.txt";
	
	
	String savePath = rootFolder+"uploads/GS/Pheno/";
	 
	InnorixUpload uploader = new InnorixUpload(request, response, maxPostSize, savePath);

	String _action          = uploader.getParameter("_action");         // 동작 플래그
	String _orig_filename   = uploader.getParameter("_orig_filename");  // 원본 파일명
	String _new_filename    = uploader.getParameter("_new_filename");   // 저장 파일명
	String _filesize        = uploader.getParameter("_filesize");       // 파일 사이즈
	String _start_offset    = uploader.getParameter("_start_offset");   // 파일저장 시작지점
	String _end_offset      = uploader.getParameter("_end_offset");     // 파일저장 종료지점
	String _filepath        = uploader.getParameter("_filepath");       // 파일 저장경로
	String _el              = uploader.getParameter("el");              // 컨트롤 엘리먼트 ID
	String _type            = uploader.getParameter("type");            // 커스텀 정의 POST Param 1
	String _part            = uploader.getParameter("part");            // 커스텀 정의 POST Param 2
	String jobid_gs  = uploader.getParameter("jobid_gs");
	String jobid_training_vcf 		= uploader.getParameter("jobid_training_vcf");
	String filename_training_vcf 		= uploader.getParameter("filename_training_vcf");
	
	String phenotypePath = rootFolder + "/uploads/GS/Pheno/"+jobid_gs+"/";
	String outputdir = rootFolder + "/result/GS/";
	String outputPath = rootFolder + "result/GS/"+jobid_gs+"/";
	//System.out.println(jobid_pd);
	
	File folder_savePath = new File(savePath+jobid_gs);

	if (!folder_savePath.exists()) {
		try {
			folder_savePath.mkdir(); 
        } catch(Exception e) {
	    	e.getStackTrace();
		}        
	}
	
	uploader.setDirectory(savePath+jobid_gs);
    //uploader.setFileName(jobid_pd + ".vcf");
    //uploader.setFileName("primer_test.vcf");
	
    //uploader.setFileName(jobid_gs + "_phenotype-eucKr.csv");
    uploader.setFileName("GS_trait-eucKR.csv");
    
	String _run_retval = uploader.run();
	

	if (uploader.isUploadDone()) {	
		
		transferToUtf8(phenotypePath,jobid_gs);
		
		String vcf_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/database/db_input/" + jobid_training_vcf + "/";
		String gs_pheno_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/GS/Pheno/";
		
		File folder_outputdir = new File(outputdir+jobid_gs);

		if (!folder_outputdir.exists()) {
			try {
				folder_outputdir.mkdir(); 
		    } catch(Exception e){
			    e.getStackTrace();
			}        
		}
		
		String cmd = "Rscript " +script_path+ "gwas_samplecheck_final.R " +vcf_path+ " " +gs_pheno_path+ " " +outputdir+ " " +jobid_gs+ " " +filename_training_vcf+ " " +"GS_trait.csv";
		System.out.println("===========================================");
		System.out.println("GS parameter : " + cmd);
		System.out.println("===========================================");
		runanalysistools.execute(cmd, "cmd");
		
		/*
		File folder_savePath = new File(savePath+jobid_pd);

		if (!folder_savePath.exists()) {
			try {
				folder_savePath.mkdir(); 
	        } catch(Exception e) {
		    	e.getStackTrace();
			}        
		}
		//File from = new File(savePath+_orig_filename);
        //File to = new File(savePath+jobid_pd+"/"+_orig_filename);
		File from = new File(savePath+"GS_trait.csv");
        File to = new File(savePath+jobid_pd+"/GS_trait.csv");
 
        try {
            Files.move(from.toPath(), to.toPath(), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("File moved successfully.");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        */
		
	}
}
%>

<%!
private void transferToUtf8(String csvPath, String jobid) {
	
	System.out.println("transferToUtf8");

	try {
		File csvEucKr = new File(csvPath+"/GS_trait-eucKR.csv");
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(csvEucKr), "EUC-KR"));

		File csvUtf8 = new File(csvPath+"/GS_trait.csv");
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(csvUtf8), "UTF-8"));

		String line;
		for(int i=0 ; (line = br.readLine()) != null ; i++) {
			//System.out.println(line);
			
			String[] arr = line.split(",");
			
			for(int j=0 ; j<arr.length ; j++) {
				bw.write(arr[j]);
				if(j == arr.length -1) {
					bw.newLine();
				} else {
					bw.write(",");
				}
			}
		}
		bw.flush();
		bw.close();
		br.close();
		
		
	} catch(IOException e) {
		e.printStackTrace();
	}
}
%>