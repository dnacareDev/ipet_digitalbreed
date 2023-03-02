<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	String chr = request.getParameter("chr");
	String position = request.getParameter("position");
	String flanking_sequence_jobid = request.getParameter("flanking_sequence_jobid");
	String flanking_sequence_size = request.getParameter("flanking_sequence_size");
	String vcf_jobid = request.getParameter("vcf_jobid");
	String refgenome = request.getParameter("refgenome");
	String filename = request.getParameter("filename");
	String fasta_filename = request.getParameter("fasta_filename");
	//String gff_filename = request.getParameter("gff_filename");
	//String cds_filename = request.getParameter("cds_filename");
	//String protein_filename = request.getParameter("protein_filename");
	
	//System.out.println(chr);
	//System.out.println(flanking_sequence_jobid);
	//System.out.println(flanking_sequence_size);
	//System.out.println(vcf_jobid);
	//System.out.println(refgenome);
	//System.out.println(filename);
	//System.out.println(fasta_filename);
	//System.out.println(gff_filename);
	//System.out.println(cds_filename);
	//System.out.println(protein_filename);
	
	String refgenome_file_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/reference_database/" +refgenome+ "/fasta/" +fasta_filename;
	String vcf_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/database/db_input/" + vcf_jobid + "/";
	String outputdir = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/result/variants_browser/flanking/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	File folder_savePath = new File(outputdir+flanking_sequence_jobid);
	
	if (!folder_savePath.exists()) {
		try {
			folder_savePath.mkdir(); 
	    } catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	//String flankingSequenceCmd = "Rscript "+ script_path +"variants_browser_flanking_sequence.R "+ vcf_path +" "+ outputdir +" "+ flanking_sequence_jobid +" "+ filename +" "+ fasta_filename +" "+ chr +" "+ position +" "+ flanking_sequence_size;
	String flankingSequenceCmd = "Rscript "+ script_path +"variants_browser_flanking_sequence.R "+ vcf_path +" "+ outputdir +" "+ flanking_sequence_jobid +" "+ filename +" "+ refgenome_file_path +" "+ chr +" "+ position +" "+ flanking_sequence_size;
	
	System.out.println("flankingSequenceCmd : " + flankingSequenceCmd);
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();
	runanalysistools.execute(flankingSequenceCmd, "cmd");
	
	
	
	File sequenceFile = new File(outputdir+flanking_sequence_jobid+"/"+flanking_sequence_jobid+"_for_flnking.csv");
	
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(sequenceFile)));
	
	out.clear();
	out.print(br.readLine());
	br.close();
	
%>