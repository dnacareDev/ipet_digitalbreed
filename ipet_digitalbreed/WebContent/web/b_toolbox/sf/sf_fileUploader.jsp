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
	
	
	String savePath = rootFolder+"uploads/Breeder_toolbox_analyses/subset/";
	 
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
	String jobid_sf  = uploader.getParameter("jobid_sf");
	
	//System.out.println(jobid_pd);
	
	//uploader.setDirectory(savePath+jobid_sf);
	String _run_retval = uploader.run();
	

	if (uploader.isUploadDone()) {	
		
		//transferToUtf8(phenotypePath,jobid_gs);
		
		File folder_savePath = new File(savePath+jobid_sf);

		if (!folder_savePath.exists()) {
			try {
				folder_savePath.mkdir(); 
	        } catch(Exception e) {
		    	e.getStackTrace();
			}        
		}
		File from = new File(savePath+_orig_filename);
        File to = new File(savePath+jobid_sf+"/"+_orig_filename);
 
        try {
            Files.move(from.toPath(), to.toPath(), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("File moved successfully.");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        
	}
}
%>

