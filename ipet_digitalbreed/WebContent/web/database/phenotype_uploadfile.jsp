<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>

<%
	String path = request.getRealPath("/"); 
	int size = 1024 * 1024 * 10;
	String file = "";
	String originFile = "";
	String filename = "";

	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String jobid = runanalysistools.getCurrentDateTime();

	String savePath = rootFolder+"uploads/database/phenotype_data/"+jobid+"/";	
		
	File folder_savePath = new File(savePath);

	if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdir(); 
	    }catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	try {
		MultipartRequest multi = new MultipartRequest(request, savePath, size, "UTF-8", new DefaultFileRenamePolicy());		
		
		String variety = multi.getParameter("variety");
		originFile = multi.getFilesystemName("ajaxFile"); 		
		
		RunPhenotypetraitValue runphenotypetraitvalue = new RunPhenotypetraitValue();
		
		runphenotypetraitvalue.UpdateTraitValue(savePath+originFile, variety, permissionUid);		
		
		
		
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+variety+"'),'"+variety+"','Phenotype', 'New excel list uploaded', now());";
		//System.out.println(log_sql);
		
		try{
			ipetdigitalconndb.stmt.executeUpdate(log_sql);
		}catch(Exception e){
			System.out.println(e);
		}finally { 
    		ipetdigitalconndb.stmt.close();
    		ipetdigitalconndb.conn.close();
    	}

	} catch (Exception e){
		System.out.println(e);
		e.printStackTrace();
	}
%>