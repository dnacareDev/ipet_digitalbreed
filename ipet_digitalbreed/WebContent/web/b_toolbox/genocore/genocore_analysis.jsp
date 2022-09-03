<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String jobid = request.getParameter("jobid");		
	String jobid2 = runanalysistools.getCurrentDateTime();									// parameter로 받은게 아닌, 새로 생성되는 jobid
	String filename = request.getParameter("filename");
	String uploadPath = request.getParameter("uploadpath");
	String rootFolder = request.getSession().getServletContext().getRealPath("/");

	System.out.println();
	System.out.println("jobid : " + jobid);
	System.out.println("jobid2 : " + jobid2);
	System.out.println("filename : " + filename);
	System.out.println("rootPath : " + rootFolder);
	System.out.println();	
	
	
	//pca를 genocore로 변경
	String savePath = rootFolder + "uploads/database/db_input/" + jobid + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/genocore/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	File folder_savePath = new File(savePath);
	
	if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}

	File folder_outputPath = new File(outputPath+jobid2);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	System.out.println();
	System.out.println("script_path : " + script_path);
	System.out.println("savePath : " + savePath);
	System.out.println("outputPath : " + outputPath);
	System.out.println();
	
	String PCA = "Rscript " +script_path+ "breedertoolbox_genocore_final.R " +savePath+ " " +outputPath+ " " +jobid2+ " " +filename+ " NA NA";
	
	System.out.println("PCA parameter(without population) : " + PCA);
			
	runanalysistools.execute(PCA);
	
%>