<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>


<%

if (request.getMethod().equals("POST"))
{
	int maxPostSize = 2147482624; // bytes
	
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/phenotype_data/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pheno/anova/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
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
	String jobid  			= uploader.getParameter("jobid");
	String varietyid 		= uploader.getParameter("varietyid");
	String comment 		= uploader.getParameter("comment");
	//String filename 		= uploader.getParameter("filename");
	
	
	//System.out.println(filename);
	//uploader.setDirectory(savePath+jobid);
	
    //uploader.setFileName(jobid_gs + "_phenotype-eucKr.csv");
    //uploader.setFileName("GS_trait-ANSI.csv");
    
	String _run_retval = uploader.run();
	

	if (uploader.isUploadDone()) {	
		
		File folder_savePath = new File(savePath+jobid);

		if (!folder_savePath.exists()) {
			try {
				folder_savePath.mkdir(); 
	        } catch(Exception e) {
		    	e.getStackTrace();
			}        
		}
		
		File folder_outputdir = new File(outputPath+jobid);

		if (!folder_outputdir.exists()) {
			try {
				folder_outputdir.mkdir(); 
		    } catch(Exception e){
			    e.getStackTrace();
			}        
		}
		
		File from = new File(savePath+_orig_filename);
        File to = new File(savePath+jobid+"/"+_orig_filename);
 
        try {
            Files.move(from.toPath(), to.toPath(), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("File moved successfully.");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        
        transferToUtf8(savePath, jobid, _orig_filename);
		
	}
}
%>

<%!
private void transferToUtf8(String csvPath, String jobid, String _orig_filename) {
	
	System.out.println("transferToUtf8");

	try {
		File csvANSI = new File(csvPath+jobid+"/"+_orig_filename);
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(csvANSI), "EUC-KR"));

		File csvUtf8 = new File(csvPath+jobid+"/GS_traits.csv");
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

