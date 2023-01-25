<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	RunAnalysisTools runanalysistools = new RunAnalysisTools();

	String permissionUid = session.getAttribute("permissionUid")+"";
	String jobid = request.getParameter("jobid");
	String _orig_filename = request.getParameter("filename");
	String comment = request.getParameter("comment");
	String varietyid = request.getParameter("varietyid");
	String refgenome = request.getParameter("refgenome");
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder+"uploads/database/db_input/";
	String outputPath = rootFolder+"result/database/genotype_statistics/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";	
	

	
	String genotype_sequence = script_path+"genotype_sequence_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;
	String genotype_statistics = script_path+"genotype_statistics_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
	String vcf_statistcs = script_path+"vcf_statistcs_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
	//String vcf_parsing = java_cmd_path+" " + "/data/apache-tomcat-9.0.64/webapps/"+db_outputPath+jobid+"/ "+ jobid +" " + permissionUid+ " &";		
	
	System.out.println("========genotype_sequence========");
	runanalysistools.execute(genotype_sequence, "cmd");
	System.out.println("========genotype_statistics========");
	runanalysistools.execute(genotype_statistics, "cmd");
	System.out.println("========vcf_statistcs========");
	runanalysistools.execute(vcf_statistcs, "cmd");
	
	FileReader fileReader = new FileReader(outputPath+jobid+"/"+jobid+"_vcf_statistics.csv");
	BufferedReader bufferedReader = new BufferedReader(fileReader);
	
	String vcf_statistcs_data = bufferedReader.readLine();
    String[] vcf_statistcs_data_strArr = vcf_statistcs_data.split(",");
    
    bufferedReader.close();

	//String refseq = vcf_statistcs_data_strArr[0];
	String samplecnt = vcf_statistcs_data_strArr[1];
	String variablecnt = vcf_statistcs_data_strArr[2];
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	//String updateVcfinfo_sql="update vcfdata_info_t set status=1, refgenome='" +refseq+ "', samplecnt='" +samplecnt+ "', variablecnt='" +variablecnt+ "' where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' and jobid='" +jobid+ "';";
	String updateVcfinfo_sql="update vcfdata_info_t set status=1, refgenome='" +refgenome+ "', samplecnt='" +samplecnt+ "', variablecnt='" +variablecnt+ "' where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' and jobid='" +jobid+ "';";
	System.out.println(updateVcfinfo_sql);
	
	try{
			ipetdigitalconndb.stmt.executeUpdate(updateVcfinfo_sql);
	}catch(Exception e){
   		System.out.println(e);
   		ipetdigitalconndb.stmt.close();
   		ipetdigitalconndb.conn.close();
   	}finally { 
   		ipetdigitalconndb.stmt.close();
   		ipetdigitalconndb.conn.close();
   	}
	
	
	
	// CSV => JSON 생성 & DB저장
	System.out.println("========CSV to Json start========");
	CsvToJson csvToJson = new CsvToJson();
	csvToJson.getJson(outputPath, jobid, permissionUid);
	System.out.println("========CSV to Json end========"); 
	

	/*
	// CSV => 행렬변환된 CSV파일 생성
	String csv_transpose = "Rscript " +script_path+ "genotype_sequence_bakground.R " +outputPath+" "+ jobid;
	
	System.out.println("========CSV transpose start========");
	System.out.println("csv_transpose : " + csv_transpose);
	runanalysistools.execute(csv_transpose, "cmd");
	System.out.println("========CSV transpose end========");
	*/
	System.out.println("vcf file background process complete");
	
	
	
%>