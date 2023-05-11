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
	String jobid_vcf = request.getParameter("jobid_vcf");		
	String jobid_pca = request.getParameter("jobid_pca");		
	String filename = request.getParameter("filename");

	
	System.out.println("=======================================");
	System.out.println("comment : " + comment);
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("jobid_pca : " + jobid_pca);
	System.out.println("filename : " + filename);
	System.out.println("=======================================");
	
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pca/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String db_savePath = "uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/pca/";
	
	
	System.out.println("=======================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("rootPath : " + rootFolder);
	System.out.println("savePath : " + savePath);
	System.out.println("outputPath : " + outputPath);
	System.out.println("script_path : " + script_path);
	System.out.println("=======================================");
	
	System.out.println("=======================================");
	System.out.println("db_savePath : " + db_savePath);
	System.out.println("db_outputPath : " + db_outputPath);
	System.out.println("=======================================");
	
	
	
	File folder_outputPath = new File(outputPath+jobid_pca);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	
	//String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','PCA', 'New analysis', now());";
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','PCA', 'New analysis(non-population) - "+filename+"', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
	}
	

	// insert 구문을 먼저(status=0)
	String insertPcainfo_sql="insert into pca_info_t(cropid,varietyid,filename,status,uploadpath,resultpath,comment,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','"+filename+"', 0,'"+db_savePath+"','"+db_outputPath+"','"+comment+"','"+jobid_pca+"','"+permissionUid+"',now());";	
	System.out.println("insertPcainfo_sql : " + insertPcainfo_sql);
	
	try {
		ipetdigitalconndb.stmt.executeUpdate(insertPcainfo_sql);
	} catch (Exception e){
		System.out.println(e);
	} finally { 
		System.out.println("AAAAAAAAAAAAAAA");
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}		
	
	String PCA = "Rscript " +script_path+ "pca_plot.R " +savePath+ " " +outputPath+ " " +jobid_pca+ " " +filename+ " NA NA " +permissionUid+ " " + varietyid;
	System.out.println("PCA parameter(without population) : " + PCA);

	runanalysistools.execute(PCA, "cmd");
	
	
	
	
%>