<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="com.drew.imaging.jpeg.JpegMetadataReader"%>
<%@ page import="com.drew.metadata.Directory"%>
<%@ page import="com.drew.metadata.Metadata"%>
<%@ page import="com.drew.metadata.Tag"%>
<%@ page import="com.drew.metadata.exif.ExifSubIFDDirectory"%>
<%@ page import="com.drew.metadata.exif.GpsDirectory"%>


<%

if (request.getMethod().equals("POST"))
{
	int maxPostSize = 2147482624; // bytes	
	
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	String savePath = rootFolder+"uploads/database/phenotype_img/";		
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
	String comment = uploader.getParameter("comment");
	String no = uploader.getParameter("no");
	String varietyid = uploader.getParameter("varietyid");
	
	String _run_retval = uploader.run();
	
	if (uploader.isUploadDone()) {	

		File folder_savePath = new File(savePath+no);

		if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdir(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
			}        
		}

	    File from = new File(savePath+_orig_filename);
        File to = new File(savePath+no+"/"+_orig_filename);
               
        try {
            Files.move(from.toPath(), to.toPath(), StandardCopyOption.REPLACE_EXISTING);
        }
        catch (IOException ex) {
            ex.printStackTrace();
        }
       
        String gps_value = null;
        java.util.Date date = null;
        
        Metadata metadata = JpegMetadataReader.readMetadata(to);
		ExifSubIFDDirectory directory = metadata.getDirectory (ExifSubIFDDirectory.class);
        GpsDirectory gpsDirectory = metadata.getDirectory(GpsDirectory.class);
     
    	try {
			date = directory.getDate(ExifSubIFDDirectory.TAG_DATETIME_ORIGINAL);

			if(date.equals(null)){
				date = new java.util.Date();						
			}
		}catch(Exception e){
			date = new java.util.Date();
			}
    	
    	SimpleDateFormat simpleDateFormat = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");
    	
    	try {
			gps_value = String.valueOf(gpsDirectory.getGeoLocation());
		}catch(Exception e){
			gps_value="nothing";
		}
    	
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String insertphoto_sql="insert into sampledata_img_t(sampleno, comment, photogps, photodate, filename, creuser, cre_dt) values("+no+", '"+comment+"', '"+gps_value+"', '"+simpleDateFormat.format(date)+"', '"+_orig_filename+"', 'dnacare', now());";	
		
		String updatephoto_sql="update sampledata_info_t set photo_status='1' where no="+no;			
		
		try{
			ipetdigitalconndb.stmt.executeUpdate(insertphoto_sql);
			ipetdigitalconndb.stmt.executeUpdate(updatephoto_sql);
		}catch(Exception e){
    		System.out.println(e);	
    		ipetdigitalconndb.stmt.close();
    		ipetdigitalconndb.conn.close();
    	}finally { 
			System.out.println("vcf file upload Success");
    		ipetdigitalconndb.stmt.close();
    		ipetdigitalconndb.conn.close();
    	}
	}
}
%>