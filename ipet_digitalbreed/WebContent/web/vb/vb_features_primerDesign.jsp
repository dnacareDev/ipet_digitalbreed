<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="com.google.gson.*" %> 
<%@ page import="org.apache.commons.exec.*" %>

<%

	String jobid_vcf = request.getParameter("jobid_vcf");
	String filename_vcf = request.getParameter("filename_vcf");
	String refgenome = request.getParameter("refgenome");
	String fasta_filename = request.getParameter("fasta_filename");
	String jobid_pd = request.getParameter("jobid_pd");
	String chr_info = request.getParameter("chr_info");
	String enzymes = request.getParameter("enzymes");
	
	String Category = request.getParameter("Category");
	//String comment = request.getParameter("comment");	
	
	JsonArray jsonArray = new Gson().fromJson(chr_info, JsonArray.class);
	JsonArray jsonArray_enzymes = new Gson().fromJson(enzymes, JsonArray.class);
	
	String Length_Min = request.getParameter("Length_Min");
	String Length_Max = request.getParameter("Length_Max");
	String GCcontent_Min = request.getParameter("GCcontent_Min");
	String GCcontent_Max = request.getParameter("GCcontent_Max");
	String TM_Min = request.getParameter("TM_Min");
	String TM_Max = request.getParameter("TM_Max");
	String Size_Min = request.getParameter("Size_Min");
	String Size_Max = request.getParameter("Size_Max");
	/*
	System.out.println(Category);
	System.out.println(comment);
	System.out.println(Length_Min);
	System.out.println(Length_Max);
	System.out.println(GCcontent_Min);
	System.out.println(GCcontent_Max);
	System.out.println(TM_Min);
	System.out.println(TM_Max);
	System.out.println(Size_Min);
	System.out.println(Size_Max);
	*/
	//System.out.println(jsonArray_enzymes);
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String vcfPath = rootFolder + "uploads/database/db_input/"+jobid_vcf+"/";	
	//String savePath = rootFolder +"uploads/primer_design/"+jobid_pd+"/";
	String savePath = rootFolder +"uploads/variants_browser/primer/"+jobid_pd+"/";
	//String outputPath = rootFolder + "result/primer_design/";
	String outputPath = rootFolder + "result/variants_browser/primer/";
	String refgenomePath = rootFolder + "uploads/reference_database/" + refgenome + "/fasta/" + fasta_filename;
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	
	File folder_savePath = new File(savePath);
	if (!folder_savePath.exists()) {
		try {
			System.out.println("make " +folder_savePath+ " : " + folder_savePath.mkdirs());
			//System.out.println(folder_savePath.mkdirs()); 
        } catch(Exception e) {
        	e.getStackTrace();
		}        
	}
	
	
	File enzymeCSV = new File(savePath+"/"+jobid_pd+"_enzymes.csv");
	try {
		BufferedWriter bw = new BufferedWriter(new FileWriter(enzymeCSV));
		
		for(int i=0 ; i<jsonArray_enzymes.size() ; i++) {
			if(i==0) {
				Iterator<String> iterator = jsonArray_enzymes.get(0).getAsJsonObject().keySet().iterator();
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
			
			Iterator<String> iterator = jsonArray_enzymes.get(0).getAsJsonObject().keySet().iterator();
			while (iterator.hasNext()) {
			    String key = iterator.next();
			    bw.write(jsonArray_enzymes.get(i).getAsJsonObject().get(key).getAsString());
			    
			    if(iterator.hasNext()) {
			    	bw.write(",");
			    } else if(i  != jsonArray_enzymes.size()) {
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
	
	
	
	File folder_outputPath = new File(outputPath+jobid_pd);
	if (!folder_outputPath.exists()) {
		try {
			System.out.println("make " +folder_outputPath+ " : " + folder_outputPath.mkdirs());
        } catch(Exception e) {
        	e.getStackTrace();
		}        
	}
	
	fileWrite(savePath, jsonArray);
	
	String cmd = "Rscript "+ script_path +"variants_browser_primer_design.R "+ vcfPath +" "+ outputPath +" "+ jobid_pd +" "+ filename_vcf +" "+ refgenomePath +" "+ savePath +" pos.txt ";
	if(Category.equals("KASP")) {
		cmd += "200";
	} else if(Category.equals("CAPs")) {
		cmd += "500";
	} else {
		// 나머지 2개가 추가되면 붙임. 현재 임시로 0
		cmd += "0";
	}
	System.out.println("cmd : " + cmd);

	
	
	try {
		CommandLine cmdLine = CommandLine.parse(cmd);
		DefaultExecutor executor = new DefaultExecutor();
		executor.setExitValue(0);
		int exitValue = executor.execute(cmdLine);
		if(exitValue == 0) {
			System.out.println("Success");
		} else {
			System.out.println("Fail");
		}
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	//System.out.println("next cmd??");
	
	String script = "";
	System.out.println("marker_category : " + Category);
	switch(Category) {
		case "KASP":
			script = "primer_design_KASP_final.R";
			break;
		case "CAPs":
			script = "primer_design_CAPS_final.R";
			break;
		default:
			script = "--typo--";
	}
	
	//String cmd_fileUpload = "Rscript " +script_path+script +" 3 "+ outputPath +" "+ jobid_pd +" "+ refgenomePath +" "+ Length_Min +" "+ Length_Max +" "+ GCcontent_Min +" "+ GCcontent_Max +" "+ TM_Min +" "+ TM_Max +" "+ Size_Min +" "+ Size_Max +" "+ vcfPath +" "+ savePath+"pos.txt";
	String cmd_fileUpload = "Rscript " +script_path+script +" 3 "+ outputPath +" "+ jobid_pd +" "+ refgenomePath +" "+ Length_Min +" "+ Length_Max +" "+ GCcontent_Min +" "+ GCcontent_Max +" "+ TM_Min +" "+ TM_Max +" "+ Size_Min +" "+ Size_Max +" "+ outputPath+jobid_pd+"/ "+ jobid_pd+"_for_flnking.csv" ;
	System.out.println("cmd_fileUpload : " + cmd_fileUpload);
	
	try {
		CommandLine cmdLine2 = CommandLine.parse(cmd_fileUpload);
		DefaultExecutor executor2 = new DefaultExecutor();
		executor2.setExitValue(0);
		int exitValue2 = executor2.execute(cmdLine2);
		if(exitValue2 == 0) {
			System.out.println("Success");
		} else {
			System.out.println("Fail");
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	
%>

<%!
public void fileWrite(String savePath, JsonArray jsonArray) throws IOException {
	
	//System.out.println(jsonArray);
	
	BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(savePath+"pos.txt"), "UTF-8"));
	
	for(int i=0 ; i<jsonArray.size(); i++) {
		//bw.write(jsonArray.get(i).getAsJsonObject().get("chr").getAsString()+"\t"+jsonArray.get(i).getAsJsonObject().get("pos").getAsString());
		bw.write(jsonArray.get(i).getAsJsonObject().get("chr").getAsString()+","+jsonArray.get(i).getAsJsonObject().get("pos").getAsString());
		if(i != jsonArray.size() -1) {
			bw.newLine();
		}
	}
	
	bw.flush();
	bw.close();
	
}
%>