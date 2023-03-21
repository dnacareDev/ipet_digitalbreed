<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*" %>
<%@ page import="ipet_digitalbreed.*"%>
<%@ page import="com.google.gson.*" %>
    
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	StringBuilder sb = new StringBuilder();
	String line = null;
	try {
		BufferedReader br = request.getReader();
		while ((line = br.readLine()) != null) {
			sb.append(line);
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	//System.out.println(sb);
	JsonObject jsonObject = new Gson().fromJson(sb.toString(), JsonObject.class);
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = jsonObject.get("varietyid").getAsString();
	String filename = jsonObject.get("filename").getAsString();
	String comment = jsonObject.get("comment").getAsString();
	String marker_category = jsonObject.get("marker_category").getAsString();
	String jobid_pd = jsonObject.get("jobid_pd").getAsString();
	/*
	System.out.println("=========================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("varietyid : " + varietyid);
	System.out.println("vcf_filename : " + vcf_filename);
	System.out.println("marker_category : " + marker_category);
	System.out.println("jobid_pd : " + jobid_pd);
	System.out.println("=========================================");
	*/
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/primer_design/";
	/*
	System.out.println("===========================================");
	System.out.println("outputdir : " + db_savePath);
	System.out.println("script_path : " + db_outputPath);
	System.out.println("===========================================");
	*/
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','Primer design', 'New analysis', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	
	String sql = "insert into primer_design_t (cropid, varietyid, status, filename, comment, marker_category, uploadpath, resultpath, jobid, creuser, cre_dt) ";
	sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+filename+"', '" +comment+ "', '" +marker_category+ "', '"+db_savePath+"','"+db_outputPath+"', '"+jobid_pd+"','" +permissionUid+ "',now());";

	
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