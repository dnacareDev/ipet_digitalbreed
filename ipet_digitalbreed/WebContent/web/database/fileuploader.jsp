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
	
	String db_savePath = "uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/database/genotype_statistics/";	

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
	/*String maf = uploader.getParameter("maf");
	String mindp = uploader.getParameter("mindp");
	String mingq = uploader.getParameter("mingq");	
	String missing = uploader.getParameter("missing");	*/
	String varietyid = uploader.getParameter("varietyid");
	
	String _run_retval = uploader.run();
	
	if (uploader.isUploadDone()) {	
		String genotype_sequence = script_path+"genotype_sequence_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;
		String genotype_statistics = script_path+"genotype_statistics_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
		String vcf_statistcs = script_path+"vcf_statistcs_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
		
		runanalysistools.execute(genotype_sequence);
		runanalysistools.execute(genotype_statistics);
		runanalysistools.execute(vcf_statistcs);

		FileReader fileReader = new FileReader(outputPath+jobid+"/"+jobid+"_vcf_statistics.csv");
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		
		String vcf_statistcs_data = bufferedReader.readLine();
	    String[] vcf_statistcs_data_strArr = vcf_statistcs_data.split(",");

		String refseq = vcf_statistcs_data_strArr[0];
		String samplecnt = vcf_statistcs_data_strArr[1];
		String variablecnt = vcf_statistcs_data_strArr[2];

		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String insertVcfinfo_sql="insert into vcfdata_info_t(cropid,varietyid,refgenome,uploadpath,filename,resultpath,comment,samplecnt,variablecnt,maf,mindp,mingq,ms,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','"+refseq+"','"+db_savePath+"','"+_new_filename+"','"+db_outputPath+"','"+comment+"','"+samplecnt+"','"+variablecnt+"','','','','','"+jobid+"','"+permissionUid+"',now());";	
		
		try{
				ipetdigitalconndb.stmt.executeUpdate(insertVcfinfo_sql);
		}catch(Exception e){
    		System.out.println(e);
    	}finally { 
			System.out.println("vcf file upload Success");
    		ipetdigitalconndb.stmt.close();
    		ipetdigitalconndb.conn.close();
    	}		
	}
	
%>