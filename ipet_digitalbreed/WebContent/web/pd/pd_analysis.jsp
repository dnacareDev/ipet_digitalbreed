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
	
	//System.out.println("primer_design params : " + sb);
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
	
	//List<String> enzymes = new Gson().fromJson(jsonObject.get("sequence"), ArrayList.class);
	
	
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
	String ref_fasta_path = rootFolder + "uploads/reference_database/" + refgenome +"/fasta/"+ fasta_filename;
	
	
	File folder_outputPath = new File(outputPath+jobid_pd);
	if (!folder_outputPath.exists()) {
		try {
			folder_outputPath.mkdirs(); 
	    } catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	File primer_savePath = new File(rootFolder+"uploads/primer_design/"+jobid_pd+"/");
	if (!primer_savePath.exists()) {
		try{
			primer_savePath.mkdir(); 
	    } catch(Exception e){
		    e.getStackTrace();
		}        
	}
	//System.out.println(primer_savePath);
	JsonArray enzyme = jsonObject.get("enzymes").getAsJsonArray();
	//System.out.println(enzyme);
	File enzymeCSV = new File(primer_savePath+"/"+jobid_pd+"_enzymes.csv");
	try {
		BufferedWriter bw = new BufferedWriter(new FileWriter(enzymeCSV));
		
		for(int i=0 ; i<enzyme.size() ; i++) {
			if(i==0) {
				Iterator<String> iterator = enzyme.get(0).getAsJsonObject().keySet().iterator();
				while (iterator.hasNext()) {
				    String key = iterator.next();
				    //System.out.print(key);
				    bw.write(key);
				    if(iterator.hasNext()) {
				    	bw.write(",");
				    } else {
				    	bw.newLine();
				    }
				}
			}
			
			Iterator<String> iterator = enzyme.get(0).getAsJsonObject().keySet().iterator();
			while (iterator.hasNext()) {
			    String key = iterator.next();
			    bw.write(enzyme.get(i).getAsJsonObject().get(key).getAsString());
			    
			    if(iterator.hasNext()) {
			    	bw.write(",");
			    } else if(i  != enzyme.size()) {
			    	bw.newLine();
			    }
			}
		}
		bw.flush();
		bw.close();
	} catch (IOException e) {
		e.getMessage();
		System.out.println("error - bufferedWriter | primer_design CSV");
	}
	
	
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
	
	

	
	System.out.println("script : " + script);
	
	switch(jsonObject.get("upload_method").getAsString()) {
		case "Genomic_DB":
			String genomic_db = "Rscript " +script_path+script +" 1 "+ outputPath +" "+ jobid_pd +" "+ ref_fasta_path +" "+ Length_Min +" "+ Length_Max +" "+ GCcontent_Min +" "+ GCcontent_Max +" "+ TM_Min +" "+ TM_Max +" "+ Size_Min +" "+ Size_Max +" "+ savePath +" "+ filename;
			if(marker_category.equals("CAPs")) {
				genomic_db += " "+ enzymeCSV.toString();
			}
			genomic_db(genomic_db, jsonObject);
			break;
		case "Direct_Input":
			
			File sequenceFasta = new File(primer_savePath+"/"+jobid_pd+".fasta");
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(sequenceFasta), "UTF-8"));
			//BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(sequenceFasta), "EUC-KR"));
			//bw.write(">A");
			//bw.newLine();
			bw.write(sequence);
			bw.close();
			
			savePath = primer_savePath+"/";
			//System.out.println("savePath : " + savePath);
			filename = jobid_pd+".fasta";
			
			String direct_input = "Rscript " +script_path+script +" 2 "+ outputPath +" "+ jobid_pd +" "+ ref_fasta_path +" "+ Length_Min +" "+ Length_Max +" "+ GCcontent_Min +" "+ GCcontent_Max +" "+ TM_Min +" "+ TM_Max +" "+ Size_Min +" "+ Size_Max +" "+ savePath +" "+ filename;
			if(marker_category.equals("CAPs")) {
				direct_input += " "+ enzymeCSV.toString();
			}
			direct_input(direct_input, jsonObject);
			break;
		case "File_Upload":
			//savePath = "/ipet_digitalbreed/uploads/primer_design/"+jobid_pd+"/";
			savePath = rootFolder+"uploads/primer_design/"+jobid_pd+"/";
			String file_upload = "Rscript " +script_path+script +" 3 "+ outputPath +" "+ jobid_pd +" "+ ref_fasta_path +" "+ Length_Min +" "+ Length_Max +" "+ GCcontent_Min +" "+ GCcontent_Max +" "+ TM_Min +" "+ TM_Max +" "+ Size_Min +" "+ Size_Max +" "+ savePath +" "+ filename;
			if(marker_category.equals("CAPs")) {
				file_upload += " "+ enzymeCSV.toString();
			}
			file_upload(file_upload, jsonObject);
			break;
	}
	
	
%>

<%! 
	private void genomic_db(String cmd, JsonObject jsonObject) throws Exception {
		System.out.println("cmd : " + cmd);
		
		RunAnalysisTools runanalysistools = new RunAnalysisTools();
		runanalysistools.execute(cmd, "cmd");
		
	}
%>

<%! 
	private void direct_input(String cmd, JsonObject jsonObject) throws Exception {
		System.out.println("cmd : " + cmd);
		
		RunAnalysisTools runanalysistools = new RunAnalysisTools();
		runanalysistools.execute(cmd, "cmd");
	}
%>

<%! 
	private void file_upload(String cmd, JsonObject jsonObject) throws Exception {
		System.out.println("cmd : " + cmd);
		
		RunAnalysisTools runanalysistools = new RunAnalysisTools();
		runanalysistools.execute(cmd, "cmd");
		
	}
%>