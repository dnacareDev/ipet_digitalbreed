<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	int maxPostSize = 2147482624; // bytes
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	String jobid = runanalysistools.getCurrentDateTime();		
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	String savePath = rootFolder+"uploads/database/db_input/";
	String outputPath = rootFolder+"result/database/genotype_statistics/";	
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	File folder_savePath = new File(savePath+jobid);

	if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdir(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}

	File folder_outputPath = new File(outputPath+jobid);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdir(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	InnorixUpload uploader = new InnorixUpload(request, response, maxPostSize, savePath+jobid);

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
	String comment = uploader.getParameter("comment");
	String maf = uploader.getParameter("maf");
	String mindp = uploader.getParameter("mindp");
	String mingq = uploader.getParameter("mingq");	
	String missing = uploader.getParameter("missing");	
	
	String _run_retval = uploader.run();
	
	if (uploader.isUploadDone()) {	
		
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		//insert into vcfdata_info_t values('2','f-00002','c-00002','v-00002','IRGSPv1.0.fasta','/uploads/database/db_input/','test.vcf','/result/database/genotype_statistics/','고추(내수용) SNP 분석 raw data 업로드 파일(vcf)','35','562313','1','2','3','4','20220813142535','master',now());

		String insertVcfinfo_sql="insert into vcfdata_info_t values ";
		
		String genotype_sequence = script_path+"genotype_sequence_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;
		String genotype_statistics = script_path+"genotype_statistics_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;

		runanalysistools.execute(genotype_sequence);
		runanalysistools.execute(genotype_statistics);		
	}

	/*
		./genotype_sequence_final.sh /data/apache-tomcat-9.0.64/webapps/ROOT/ipet_digitalbreed/uploads/database/db_input/ /data/apache-tomcat-9.0.64/webapps/ROOT/ipet_digitalbreed/result/database/genotype_statistics/ 20220813142535 test.vcf

		./genotype_statistics_final.sh /data/apache-tomcat-9.0.64/webapps/ROOT/ipet_digitalbreed/uploads/database/db_input/ /data/apache-tomcat-9.0.64/webapps/ROOT/ipet_digitalbreed/result/database/genotype_statistics/ 20220813142535 test.vcf
	*/
%>