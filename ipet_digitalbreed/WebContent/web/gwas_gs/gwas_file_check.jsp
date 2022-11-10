<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	int maxPostSize = 2147482624; // bytes
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String jobid_gwas = runanalysistools.getCurrentDateTime();
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	System.out.println("====================================");
	System.out.println("jobid_gwas : " + jobid_gwas);
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("rootFolder : " + rootFolder);
	System.out.println("====================================");
	
	
	String gwas_pheno_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/gwas/";
	String outputdir = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/result/gwas/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/gwas/";
	
	System.out.println("===========================================");
	System.out.println("gwas_pheno_path : " + gwas_pheno_path);
	//System.out.println("outputdir : " + outputdir);
	System.out.println("script_path : " + script_path);
	System.out.println("===========================================");
	
	File folder_pheno_path = new File(gwas_pheno_path+jobid_gwas);

	if (!folder_pheno_path.exists()) {
	try{
		folder_pheno_path.mkdir(); 
        } 
        catch(Exception e){
	    e.getStackTrace();
		}        
	}
	
	InnorixUpload uploader = new InnorixUpload(request, response, maxPostSize, gwas_pheno_path+jobid_gwas);

	String _action          = uploader.getParameter("_action");         // 동작 플래그
	String _orig_filename   = uploader.getParameter("_orig_filename");  // 원본 파일명
	//String _orig_filename 	= jobid_gwas + "_phenotype.csv";
	String _new_filename    = uploader.getParameter("_new_filename");   // 저장 파일명
	//String _new_filename	= jobid_gwas + "_phenotype.csv";
	String _filesize        = uploader.getParameter("_filesize");       // 파일 사이즈
	String _start_offset    = uploader.getParameter("_start_offset");   // 파일저장 시작지점
	String _end_offset      = uploader.getParameter("_end_offset");     // 파일저장 종료지점
	String _filepath        = uploader.getParameter("_filepath");       // 파일 저장경로
	String _el              = uploader.getParameter("el");              // 컨트롤 엘리먼트 ID
	String _type            = uploader.getParameter("type");            // 커스텀 정의 POST Param 1
	String _part            = uploader.getParameter("part");            // 커스텀 정의 POST Param 2
	String comment 			= uploader.getParameter("comment");
	String varietyid 		= uploader.getParameter("varietyid");
	String jobid_vcf 		= uploader.getParameter("jobid_vcf");
	String filename 		= uploader.getParameter("filename");
	

    uploader.setFileName(jobid_gwas + "_phenotype.csv");
	
	String _run_retval = uploader.run();
	
	if (uploader.isUploadDone()) {	
		
		String vcf_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/database/db_input/" + jobid_vcf + "/";
		

		
		
		File folder_outputdir = new File(outputdir+jobid_gwas);

		if (!folder_outputdir.exists()) {
		try{
			folder_outputdir.mkdir(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
			}        
		}
		
		String Gwas = "Rscript " +script_path+ "gwas_samplecheck_final.R " +vcf_path+ " " +gwas_pheno_path+ " " +outputdir+ " " +jobid_gwas+ " " +filename+ " " +jobid_gwas+"_phenotype.csv";
		//String Gwas = "Rscript " +script_path+ "gwas_samplecheck_final.R " +vcf_path+ " " +gwas_pheno_path+ " " +outputdir+ " " +jobid_gwas+ " " +filename+ " " + _orig_filename;
		System.out.println("===========================================");
		System.out.println("Gwas parameter : " + Gwas);
		System.out.println("===========================================");
		runanalysistools.execute(Gwas);
		
		
	}
	
%>