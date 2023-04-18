<%@page import="com.google.gson.JsonObject"%>
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
	String jobid_t_test = request.getParameter("jobid_t_test");
	String comment = request.getParameter("comment");
	//String[] traitname = request.getParameter("traitname").split(",");
	//String[] seq = request.getParameter("seq").split(",");
	//String[] samplename = request.getParameter("samplename").split(",");
	//String[] sampleno = request.getParameter("sampleno").split(",");
	
	String traitname = request.getParameter("traitname");
	String seq = request.getParameter("seq");
	String samplename = request.getParameter("samplename");
	String sampleno = request.getParameter("sampleno");
	String[] traitnameArr = traitname.split(",");
	String[] seqArr = seq.split(",");
	String[] samplenameArr = samplename.split(",");
	String[] samplenoArr = sampleno.split(",");
	
	/*
	System.out.println();
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_t_test : " + jobid_t_test);
	System.out.println("comment : " + comment);
	System.out.println("traitname : " + traitname);
	System.out.println("seq : " + Arrays.toString(seq));
	System.out.println("samplename : " + Arrays.toString(samplename));
	System.out.println("sampleno : " + Arrays.toString(sampleno));
	System.out.println();	
	*/

	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/phenotype_data/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pheno/t-test/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/phenotype_data/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/pheno/t-test/";
	
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','T-test', 'New analysis', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	String sql = "insert into t_test_t (cropid, varietyid, status, comment, analysis_number, phenotype, uploadpath, resultpath, jobid, creuser, cre_dt) ";
	sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+comment+"', '" +samplenameArr.length+ "', '" +traitname+ "', '" +db_savePath+"','"+db_outputPath+"', '"+jobid_t_test+"','" +permissionUid+ "',now());";
	
	System.out.println("sql : " + sql);
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(sql);
	} catch(Exception e) {
		System.out.println(e);
	} finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}

	
	
%>
