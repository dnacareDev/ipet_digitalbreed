<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="com.google.gson.*" %>

<%
	//IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	//ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	//RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
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
	
	System.out.println("primer_design params : " + sb);
	JsonObject jsonObject = new Gson().fromJson(sb.toString(), JsonObject.class);
	
	String marker_category = jsonObject.get("marker_category").getAsString();
	String comment = jsonObject.get("comment").getAsString();
	//String marker_name = jsonObject.get("marker_name").getAsString();
	String upload_method = jsonObject.get("upload_method").getAsString();
	String jobid_vcf = jsonObject.get("jobid_vcf").getAsString();
	String filename = jsonObject.get("filename").getAsString();
	String refgenome_id = jsonObject.get("refgenome_id").getAsString();
	String refgenome = jsonObject.get("refgenome").getAsString();
	String fasta_filename = jsonObject.get("fasta_filename").getAsString();
	String sequence = jsonObject.get("sequence").getAsString();
	String Length_Min = jsonObject.get("Length_Min").getAsString();
	String Length_Max = jsonObject.get("Length_Max").getAsString();
	String GCcontent_Min = jsonObject.get("GCcontent_Min").getAsString();
	String GCcontent_Max = jsonObject.get("GCcontent_Max").getAsString();
	String TM_Min = jsonObject.get("TM_Min").getAsString();
	String TM_Max = jsonObject.get("TM_Max").getAsString();
	String Size_Min = jsonObject.get("Size_Min").getAsString();
	String Size_Max = jsonObject.get("Size_Max").getAsString();
	String jobid_pd = jsonObject.get("jobid_pd").getAsString();
	
	
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/db_input/" + jobid_vcf + "/";
	String outputPath = rootFolder + "result/primer_design/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	String script = "";
	System.out.println("marker_category : " + marker_category);
	switch(marker_category) {
		case "KASP":
			script = "primer_design_KASP_final.R";
			break;
		case "CAPs":
			script = "primer_design_CAPS_final.R";
			break;
		default:
			script = "--typo--";
	}
	
	String ref_fasta_path = rootFolder + "uploads/reference_database/" + refgenome +"/fasta/"+ fasta_filename;
	
	/*
	System.out.println("=======================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("rootPath : " + rootFolder);
	System.out.println("savePath : " + savePath);
	System.out.println("outputPath : " + outputPath);
	System.out.println("script_path : " + script_path);
	System.out.println("=======================================");
	*/
	File folder_outputPath = new File(outputPath+jobid_pd);
	
	if (!folder_outputPath.exists()) {
		try {
			folder_outputPath.mkdirs(); 
	    } catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	System.out.println("script : " + script);
	
	switch(jsonObject.get("upload_method").getAsString()) {
		case "Genomic_DB":
			String genomic_db = "Rscript " +script_path+script +" 1 "+ outputPath +" "+ jobid_pd +" "+ ref_fasta_path +" "+ Length_Min +" "+ Length_Max +" "+ GCcontent_Min +" "+ GCcontent_Max +" "+ TM_Min +" "+ TM_Max +" "+ Size_Min +" "+ Size_Max +" "+ savePath +" "+ filename;
			genomic_db(genomic_db, jsonObject);
			break;
		case "Direct_Input":
			
			File folder_savePath = new File(rootFolder+"uploads/primer_design/"+jobid_pd+"/");
			System.out.println(folder_savePath);
			if (!folder_savePath.exists()) {
				try{
					folder_savePath.mkdir(); 
			    } catch(Exception e){
				    e.getStackTrace();
				}        
			}
			
			File sequenceFasta = new File(folder_savePath+"/"+jobid_pd+".fasta");
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(sequenceFasta), "UTF-8"));
			//bw.write(">A");
			//bw.newLine();
			bw.write(sequence);
			bw.close();
			
			savePath = folder_savePath+"/";
			//System.out.println("savePath : " + savePath);
			filename = jobid_pd+".fasta";
			
			String direct_input = "Rscript " +script_path+script +" 2 "+ outputPath +" "+ jobid_pd +" "+ ref_fasta_path +" "+ Length_Min +" "+ Length_Max +" "+ GCcontent_Min +" "+ GCcontent_Max +" "+ TM_Min +" "+ TM_Max +" "+ Size_Min +" "+ Size_Max +" "+ savePath +" "+ filename;
			direct_input(direct_input, jsonObject);
			break;
		case "File_Upload":
			//savePath = "/ipet_digitalbreed/uploads/primer_design/"+jobid_pd+"/";
			savePath = rootFolder+"uploads/primer_design/"+jobid_pd+"/";
			String file_upload = "Rscript " +script_path+script +" 3 "+ outputPath +" "+ jobid_pd +" "+ ref_fasta_path +" "+ Length_Min +" "+ Length_Max +" "+ GCcontent_Min +" "+ GCcontent_Max +" "+ TM_Min +" "+ TM_Max +" "+ Size_Min +" "+ Size_Max +" "+ savePath +" "+ filename;
			file_upload(file_upload, jsonObject);
			break;
	}
	
	
%>

<%! 
	private void genomic_db(String cmd, JsonObject jsonObject) throws Exception {
		System.out.println("cmd : " + cmd);
		
		RunAnalysisTools runanalysistools = new RunAnalysisTools();
		runanalysistools.execute(cmd, "cmd");
		/*
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String sql = "update primer_design_t set status = 1 where jobid = '" +jsonObject.get("jobid_pd").getAsString()+ "';";

		System.out.println("sql : " + sql);
		
		try{
			ipetdigitalconndb.stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println(e);
		} finally { 
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
		*/
		
	}
%>

<%! 
	private void direct_input(String cmd, JsonObject jsonObject) throws Exception {
		System.out.println("cmd : " + cmd);
		
		RunAnalysisTools runanalysistools = new RunAnalysisTools();
		runanalysistools.execute(cmd, "cmd");
		/*
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String sql = "update primer_design_t set status = 1 where jobid = '" +jsonObject.get("jobid_pd").getAsString()+ "';";

		System.out.println("sql : " + sql);
		
		try{
			ipetdigitalconndb.stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println(e);
		} finally { 
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
		*/
	}
%>

<%! 
	private void file_upload(String cmd, JsonObject jsonObject) throws Exception {
		System.out.println("cmd : " + cmd);
		
		RunAnalysisTools runanalysistools = new RunAnalysisTools();
		runanalysistools.execute(cmd, "cmd");
		
		/*
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String sql = "update primer_design_t set status = 1 where jobid = '" +jsonObject.get("jobid_pd").getAsString()+ "';";

		System.out.println("sql : " + sql);
		
		try{
			ipetdigitalconndb.stmt.executeUpdate(sql);
		} catch(Exception e) {
			System.out.println(e);
		} finally { 
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
		*/
	}
%>