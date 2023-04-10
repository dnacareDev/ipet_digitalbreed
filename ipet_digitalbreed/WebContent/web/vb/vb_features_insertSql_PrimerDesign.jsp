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
	
	String Category = request.getParameter("Category");
	String comment = request.getParameter("comment");
	
	String jobid_vcf = request.getParameter("jobid_vcf");
	String filename_vcf = request.getParameter("filename_vcf");
	String refgenome = request.getParameter("refgenome");
	String fasta_filename = request.getParameter("fasta_filename");
	String jobid_pd = request.getParameter("jobid_pd");
	String chr_info = request.getParameter("chr_info");
	String varietyid = request.getParameter("varietyid");
	
	String enzymes = request.getParameter("enzymes");
	
	JsonArray jsonArray_enzymes = new Gson().fromJson(enzymes, JsonArray.class);
	StringBuilder enzymes_stringified = new StringBuilder();
	for(int i=0 ; i<jsonArray_enzymes.size() ; i++) {
		enzymes_stringified.append(jsonArray_enzymes.get(i).getAsJsonObject().get("Enzyme").getAsString());
		if(i != jsonArray_enzymes.size()-1) {
			enzymes_stringified.append(",");
		}
	}
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String db_savePath = "/ipet_digitalbreed/uploads/database/db_input/";
	//String db_outputPath = "/ipet_digitalbreed/result/primer_design/";
	String db_outputPath = "/ipet_digitalbreed/result/variants_browser/primer/";
	
	
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','Primer design', 'New analysis', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	String sql = "insert into primer_design_t (cropid, varietyid, status, filename, comment, marker_category, restriction_enzymes, uploadpath, resultpath, jobid, creuser, cre_dt) ";
	
	sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+filename_vcf+"', '" +comment+ "', '" +Category+ "', '" +enzymes_stringified+ "','" +db_savePath+"','"+db_outputPath+"', '"+jobid_pd+"','" +permissionUid+ "',now());";
	//sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+filename_vcf+"', '" +comment+ "', '" +Category+ "', '','" +db_savePath+"','"+db_outputPath+"', '"+jobid_pd+"','" +permissionUid+ "',now());"; 

	
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