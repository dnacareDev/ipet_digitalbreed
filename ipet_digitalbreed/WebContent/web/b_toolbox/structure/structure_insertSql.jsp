<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String varietyid = request.getParameter("varietyid");
	String jobid_structure = request.getParameter("jobid_structure");
	String comment = request.getParameter("comment");
	String jobid_vcf = request.getParameter("jobid_vcf");
	String vcfdata_no = request.getParameter("vcfdata_no");
	String filename = request.getParameter("filename");
	String refgenome = request.getParameter("refgenome");
	String annotation_filename = request.getParameter("annotation_filename");
	
	String iteration_number = request.getParameter("iteration-number");
	String Number_of_K = request.getParameter("Number_of_K");
	String Burn_IN = request.getParameter("Burn_IN");
	String MCMC = request.getParameter("MCMC");
	
	/*
	System.out.println("====================================");
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_structure : " + jobid_structure);
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("filename : " + filename);
	System.out.println("refgenome : " + refgenome);
	System.out.println("annotation_filename : " + annotation_filename);
	System.out.println(iteration_number);
	System.out.println(Number_of_K);
	System.out.println(Burn_IN);
	System.out.println(MCMC);
	System.out.println("====================================");	
	*/
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/structure/";
	String annotationPath = rootFolder + "uploads/reference_database/"+refgenome+"/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/structure/";
	
	
	
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','STRUCTURE', 'New analysis - "+filename+"', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	String sql = "insert into structure_t (cropid, varietyid, status, vcfdata_no, filename, comment, number_of_k, uploadpath, resultpath, jobid, creuser, cre_dt) ";
	sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+vcfdata_no+"', '" +filename+"', '"+ comment +"', '"+ Number_of_K +"', '"+ db_savePath+"','"+db_outputPath+"', '"+jobid_structure+"','" +permissionUid+ "',now());";

	System.out.println();
	System.out.println("sql : " + sql);
	System.out.println();
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(sql);
	} catch(Exception e) {
		System.out.println(e);
	} finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
%>