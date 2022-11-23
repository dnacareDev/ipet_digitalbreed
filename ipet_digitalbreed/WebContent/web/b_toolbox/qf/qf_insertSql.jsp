<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*" %>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String permissionUid = request.getParameter("permissionUid");
	String varietyid = request.getParameter("variety_id");
	String jobid_qf = request.getParameter("jobid_qf");
	String filename = request.getParameter("file_name");
	
	System.out.println("=========================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_qf : " + jobid_qf);
	System.out.println("filename : " + filename);
	System.out.println("=========================================");
	
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/quality/";
	
	System.out.println("===========================================");
	System.out.println("outputdir : " + db_savePath);
	System.out.println("script_path : " + db_outputPath);
	System.out.println("===========================================");
	
	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String sql = "insert into genotype_filter_t (cropid, varietyid, status, filename, manufacture, uploadpath, resultpath, save_cmd, jobid, creuser, cre_dt) ";
	sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+filename+"', 'quality', '"+db_savePath+"','"+db_outputPath+"','0', '"+jobid_qf+"','" +permissionUid+ "',now());";

	
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