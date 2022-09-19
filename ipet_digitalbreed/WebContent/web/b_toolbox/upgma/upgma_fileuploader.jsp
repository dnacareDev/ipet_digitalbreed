<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	int maxPostSize = 2147482624; // bytes
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String jobid_upgma = request.getParameter("jobid_upgma");	
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String populationPath = rootFolder + "uploads/Breeder_toolbox_analyses/upgma/";
	
	System.out.println("====================================");
	System.out.println("jobid_upgma : " + jobid_upgma);
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("rootFolder : " + rootFolder);
	System.out.println("populationPath : " + populationPath);
	System.out.println("====================================");
	
	InnorixUpload uploader = new InnorixUpload(request, response, maxPostSize, populationPath+jobid_upgma);

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
	String comment 			= uploader.getParameter("comment");
	String varietyid 		= uploader.getParameter("varietyid");
	String jobid_vcf 			= uploader.getParameter("jobid_vcf");
	String filename 		= uploader.getParameter("filename");
	
	
	String db_savePath = "uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/phylogenetic_tree/";
	String db_pupolationPath = "uploads/Breeder_toolbox_analyses/upgma/";
	
	
	File folder_populationPath = new File(populationPath+jobid_upgma);
	
	if (!folder_populationPath.exists()) {
		try {
			folder_populationPath.mkdirs(); 
			System.out.println("populationPath mkdirs");
	    } catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	String _run_retval = uploader.run();
	
	if (uploader.isUploadDone()) {	
		
		System.out.println();
		System.out.println("comment : " + comment);
		System.out.println("varietyid : " + varietyid);
		System.out.println("jobid_vcf : " + jobid_vcf);
		System.out.println("filename : " + filename);
		System.out.println();
		
		
		
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String insertUpgmaInfo_sql="insert into upgma_info_t(cropid,varietyid,filename,status,uploadpath,resultpath,populationpath,comment,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','"+filename+"', 0,'"+db_savePath+"','"+db_outputPath+"','"+db_pupolationPath+"','"+comment+"','"+jobid_upgma+"','"+permissionUid+"',now());";	

		System.out.println("insertUpgmaInfo_sql : " + insertUpgmaInfo_sql);
		
		try{
				ipetdigitalconndb.stmt.executeUpdate(insertUpgmaInfo_sql);
		}catch(Exception e){
    		System.out.println(e);
    	}finally { 
			System.out.println("AAAAAAAAAAAAAAA");
    		ipetdigitalconndb.stmt.close();
    		ipetdigitalconndb.conn.close();
    	}
		
	}
	
%>