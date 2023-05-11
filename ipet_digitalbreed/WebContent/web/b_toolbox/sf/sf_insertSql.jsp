<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="com.google.gson.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

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
	//JsonObject jsonObject = new JsonParser().parseString(sb.toString()).getAsJsonObject();
	// 문자열 => jsonArray
	//JsonArray array = new Gson().fromJson("JsonArray 문자열", JsonArray.class);	
	JsonObject jsonObject = new Gson().fromJson(sb.toString(), JsonObject.class);
	//System.out.println(jsonObject);
	System.out.println();
	
	String varietyid = jsonObject.get("variety_id").getAsString();
	String refgenome_id = jsonObject.get("refgenome_id").getAsString();
	String jobid_vcf = jsonObject.get("jobid_vcf").getAsString();
	String jobid_sf = jsonObject.get("jobid_sf").getAsString();
	String file_name = jsonObject.get("file_name").getAsString();
	JsonObject jsonObject_region = new Gson().fromJson(jsonObject.get("region"), JsonObject.class);
	JsonArray jsonArray_sample = new Gson().fromJson(jsonObject.get("sample_arr"), JsonArray.class);
	
	//System.out.println(jobid_vcf);
	//System.out.println(jobid_sf);
	//System.out.println(filename);
	//System.out.println(jsonObject_region);
	//System.out.println(jsonArray_sample);
	
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String subsetSavePath = rootFolder + "uploads/Breeder_toolbox_analyses/subset/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/subset/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String db_savePath = "uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/subset/";
	
	
	//String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','Subset Filter', 'New analysis', now());";
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','Subset Filter', 'New analysis - "+file_name+"', now());";
	System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	String sql = "insert into subset_filter_t (cropid, varietyid, refgenome_id, status, filename, manufacture, uploadpath, resultpath, save_cmd, jobid, creuser, cre_dt) ";
	sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', " +refgenome_id+ ", 0, '"+file_name+"', 'subset', '"+db_savePath+"','"+db_outputPath+"','0', '"+jobid_sf+"','" +permissionUid+ "',now());";
	
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