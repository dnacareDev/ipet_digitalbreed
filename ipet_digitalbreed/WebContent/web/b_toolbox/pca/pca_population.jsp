<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		

	String jobid_vcf = request.getParameter("jobid_vcf");
	String jobid_pca = request.getParameter("jobid_pca");
	String filename = request.getParameter("filename");
	String population_name = request.getParameter("population_name");
	String varietyid = request.getParameter("varietyid");
	
	
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String inputPath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pca/";
	String populationPath = rootFolder + "uploads/Breeder_toolbox_analyses/pca/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	System.out.println("=========================");
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("jobid_pca : " + jobid_pca);
	System.out.println("filename : " + filename);
	System.out.println("population_name : " + population_name);
	System.out.println("=========================");
	
	System.out.println("=========================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("rootPath : " + rootFolder);
	System.out.println("inputPath : " + inputPath);
	System.out.println("outputPath : " + outputPath);
	System.out.println("populationPath : " + populationPath);
	System.out.println("script_path : " + script_path);
	System.out.println("=========================");

	
	
	File folder_outputPath = new File(outputPath+jobid_pca);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
			System.out.println("outputPath mkdirs");
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	
	String PCA = "Rscript " +script_path+ "pca_plot.R " +inputPath+ " " +outputPath+ " " +jobid_pca+ " " +filename+ " " +populationPath+ " " +population_name+ " " +permissionUid+ " " +varietyid;
	
	System.out.println("PCA parameter(with population) : " + PCA);
	
	runanalysistools.execute(PCA, "cmd");
	
	
	//String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','PCA', 'New analysis', now());";
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','PCA', 'New analysis(population) - "+filename+"', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
%>