<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	int maxPostSize = 2147482624; // bytes
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	

	
	
	//String jobid = request.getParameter("jobid");
	// 새로 만든 jobid
	String jobid2 = runanalysistools.getCurrentDateTime();		
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String populationPath = rootFolder + "uploads/Breeder_toolbox_analyses/pca/";

	
	
	InnorixUpload uploader = new InnorixUpload(request, response, maxPostSize, populationPath+jobid2);

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
	String varietyid = uploader.getParameter("varietyid");
	String jobid = uploader.getParameter("jobid");
	String filename = uploader.getParameter("filename");
	//String uploadpath = uploader.getParameter("uploadpath");
	
	
	System.out.println();
	System.out.println("rootPath : " + rootFolder);
	System.out.println("jobid : " + jobid);
	System.out.println("jobid2 : " + jobid2);
	System.out.println();	
	
	String inputPath = rootFolder + "uploads/database/db_input/" + jobid + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pca/";
	
	String db_savePath = "uploads/database/db_input/";
	//String db_outputPath = "result/Breeder_toolbox_analyses/pca/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/pca/";
	String db_pupolationPath = "uploads/Breeder_toolbox_analyses/pca/";
	
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	File folder_inputPath = new File(inputPath);

	if (!folder_inputPath.exists()) {
		try{
			folder_inputPath.mkdirs(); 
			System.out.println("inputPath mkdirs");
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}

	File folder_outputPath = new File(outputPath+jobid2);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
			System.out.println("outputPath mkdirs");
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	
	File folder_populationPath = new File(populationPath+jobid2);
	
	if (!folder_populationPath.exists()) {
		try{
			folder_populationPath.mkdirs(); 
			System.out.println("populationPath mkdirs");
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	
	
	
	
	
	String _run_retval = uploader.run();
	
	if (uploader.isUploadDone()) {	
		
		System.out.println();
		System.out.println("script_path : " + script_path);
		System.out.println("inputPath : " + inputPath);
		System.out.println("outputPath : " + outputPath);
		System.out.println("populationPath : " + populationPath);
		System.out.println();
		
		System.out.println();
		System.out.println("comment : " + comment);
		System.out.println("varietyid : " + varietyid);
		System.out.println("jobid : " + jobid);
		System.out.println("filename : " + filename);
		//System.out.println("uploadpath : " + uploadpath);
		System.out.println();
		
		// 이 구문을 population path로 바꿔야 함
		String PCA = "Rscript " +script_path+ "pca_plot.R " +inputPath+ " " +outputPath+ " " +jobid2+ " " +filename+ " " +populationPath+ " " +_orig_filename;
		
		System.out.println("PCA parameter(with population) : " + PCA);
				
				
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		//String insertVcfinfo_sql="insert into vcfdata_info_t(cropid,varietyid,refgenome,uploadpath,filename,resultpath,comment,samplecnt,variablecnt,maf,mindp,mingq,ms,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','"+refseq+"','"+db_savePath+"','"+_new_filename+"','"+db_outputPath+"','"+comment+"','"+samplecnt+"','"+variablecnt+"','','','','','"+jobid+"','"+permissionUid+"',now());";	
		//System.out.println("insertVcfinfo_sql : " + insertVcfinfo_sql);
		
		String insertPcainfo_sql="insert into pca_info_t(cropid,varietyid,filename,status,uploadpath,resultpath,populationpath,comment,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','"+filename+"', 0,'"+db_savePath+"','"+db_outputPath+"','"+db_pupolationPath+"','"+comment+"','"+jobid2+"','"+permissionUid+"',now());";	

		System.out.println("insertPcainfo_sql : " + insertPcainfo_sql);
		
		try{
				ipetdigitalconndb.stmt.executeUpdate(insertPcainfo_sql);
		}catch(Exception e){
    		System.out.println(e);
    	}finally { 
			System.out.println("AAAAAAAAAAAAAAA");
    		ipetdigitalconndb.stmt.close();
    		ipetdigitalconndb.conn.close();
    	}
		

		runanalysistools.execute(PCA);
	}
	
%>