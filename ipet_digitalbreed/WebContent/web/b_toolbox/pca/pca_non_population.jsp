<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String comment = request.getParameter("comment");
	String varietyid = request.getParameter("varietyid");
	String jobid = request.getParameter("jobid");		
	String jobid2 = runanalysistools.getCurrentDateTime();									// parameter로 받은게 아닌, 새로 생성되는 jobid
	String filename = request.getParameter("filename");
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");

	System.out.println();
	System.out.println("comment : " + comment);
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid : " + jobid);
	System.out.println("jobid2 : " + jobid2);
	System.out.println("filename : " + filename);
	System.out.println("rootPath : " + rootFolder);
	System.out.println();	
	
	String savePath = rootFolder + "uploads/database/db_input/" + jobid + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pca/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String db_savePath = "uploads/database/db_input/";
	String db_outputPath = "result/Breeder_toolbox_analyses/pca/";
	
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
	
	String PCA = "Rscript " +script_path+ "pca_plot.R " +savePath+ " " +outputPath+ " " +jobid2+ " " +filename+ " NA NA";
	
	System.out.println("PCA parameter(without population) : " + PCA);
			
	runanalysistools.execute(PCA);
	
	
	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String insertVcfinfo_sql="insert into pca_info_t(cropid,varietyid,filename,status,uploadpath,resultpath,comment,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','"+filename+"', 0,'"+db_savePath+"','"+db_outputPath+"','"+comment+"','"+jobid2+"','"+permissionUid+"',now());";	

	System.out.println("insertVcfinfo_sql : " + insertVcfinfo_sql);
	
	try{
			ipetdigitalconndb.stmt.executeUpdate(insertVcfinfo_sql);
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		System.out.println("AAAAAAAAAAAAAAA");
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}		
	
	
%>