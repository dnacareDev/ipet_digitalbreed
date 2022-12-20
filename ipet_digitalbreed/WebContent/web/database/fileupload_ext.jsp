<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%

//if (request.getMethod().equals("POST")){
	int maxPostSize = 2147482624; // bytes	
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();			

	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	String savePath = rootFolder+"uploads/database/db_input/";
	String outputPath = rootFolder+"result/database/genotype_statistics/";		
	String org_savePath = rootFolder+"result/Breeder_toolbox_analyses/quality/";


	String db_savePath = "uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/database/genotype_statistics/";	
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";	
	String java_cmd_path = "/usr/bin/java -cp ./:/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/WEB-INF/classes/:/data/apache-tomcat-9.0.64/lib/mysql-connector-java-8.0.16.jar ipet_digitalbreed.VcfToMysql ";
	 
	String jobid = request.getParameter("jobid");
	String _orig_filename = request.getParameter("vcf_filename");
	String comment = null;
	String variety_id = request.getParameter("variety_id");

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String SaveSql = "UPDATE genotype_filter_t SET save_cmd = '1' where jobid='" +jobid+ "';";
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(SaveSql);
	}catch(Exception e){
		System.out.println(e);
	}		
	
	
	   try{


		 BufferedReader reader = new BufferedReader(new FileReader(org_savePath+jobid+"/comment.txt"));
 
        String str;
        while ((str = reader.readLine()) != null) {
            comment=str;
        }
 
        reader.close();
	   }catch(Exception e){
		    e.getStackTrace();
		}      
		
		File folder_savePath = new File(savePath+jobid);

		if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdir(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
			}        
		}

		File folder_outputPath = new File(outputPath+jobid);
		
		if (!folder_outputPath.exists()) {
			try{
				folder_outputPath.mkdir(); 
				} 
				catch(Exception e){
				e.getStackTrace();
			}        
		}

		
		try{
			/*
		    File file = new File(org_savePath+jobid+"/"+_orig_filename+".recode.vcf");
		    File newFile = new File(savePath+jobid+"/"+_orig_filename+".recode.vcf");
			*/
			File file = new File(org_savePath+jobid+"/"+_orig_filename);
		    File newFile = new File(savePath+jobid+"/"+_orig_filename);
			
		    FileInputStream input = new FileInputStream(file);
		    FileOutputStream output = new FileOutputStream(newFile);
		
		    byte[] buf = new byte[1024];
		
		    int readData;
		    while ((readData = input.read(buf)) > 0) {
		        output.write(buf, 0, readData);
		    }

	   		input.close();
	   		output.close();
		}catch(Exception e){

		}
	    /*	
		String genotype_sequence = script_path+"genotype_sequence_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename+".recode.vcf";
		String genotype_statistics = script_path+"genotype_statistics_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename+".recode.vcf";		
		String vcf_statistcs = script_path+"vcf_statistcs_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename+".recode.vcf";		
		//String vcf_parsing = java_cmd_path+" " + "/data/apache-tomcat-9.0.64/webapps/"+db_outputPath+jobid+"/ "+ jobid +" " + permissionUid+ " &";		
		*/	
		String genotype_sequence = script_path+"genotype_sequence_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;
		String genotype_statistics = script_path+"genotype_statistics_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
		String vcf_statistcs = script_path+"vcf_statistcs_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;
		
		System.out.println("genotype_sequence :" + genotype_sequence);
		System.out.println("genotype_statistics :" + genotype_statistics);
		System.out.println("vcf_statistcs :" + vcf_statistcs);
		
		
		
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

		String refseq = vcf_statistcs_data_strArr[0];
		String samplecnt = vcf_statistcs_data_strArr[1];
		String variablecnt = vcf_statistcs_data_strArr[2];

		
		//Statistics - Timeline
		String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','Genotype', 'New analysis', now());";
		//System.out.println(log_sql);
		
		try{
			ipetdigitalconndb.stmt.executeUpdate(log_sql);
		}catch(Exception e){
			System.out.println(e);
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
		
		
		String insertVcfinfo_sql="insert into vcfdata_info_t(cropid,varietyid,refgenome,uploadpath,filename,resultpath,comment,samplecnt,variablecnt,maf,mindp,mingq,ms,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+variety_id+"'),'"+variety_id+"','"+refseq+"','"+db_savePath+"','"+_orig_filename+".recode.vcf"+"','"+db_outputPath+"','"+comment+"','"+samplecnt+"','"+variablecnt+"','','','','','"+jobid+"','"+permissionUid+"',now());";	
		//String insertVcfinfo_sql="insert into vcfdata_info_t(cropid,varietyid,refgenome,uploadpath,filename,resultpath,comment,samplecnt,variablecnt,maf,mindp,mingq,ms,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+variety_id+"'),'"+variety_id+"','"+refseq+"','"+db_savePath+"','"+_orig_filename+"','"+db_outputPath+"','"+comment+"','"+samplecnt+"','"+variablecnt+"','','','','','"+jobid+"','"+permissionUid+"',now());";
		
		System.out.println("insertVcfinfo_sql : " + insertVcfinfo_sql);
		
		try{
			ipetdigitalconndb.stmt.executeUpdate(insertVcfinfo_sql);
		}catch(Exception e){
    		System.out.println(e);
    		ipetdigitalconndb.stmt.close();
    		ipetdigitalconndb.conn.close();
    	}finally { 
			System.out.println("vcf file upload Success");
    		ipetdigitalconndb.stmt.close();
    		ipetdigitalconndb.conn.close();
    	}	
		
		// CSV => JSON파일 생성
		System.out.println("========CSV to Json start========");
		CsvToJson csvToJson = new CsvToJson();
		csvToJson.getJson(outputPath, jobid, permissionUid);
		System.out.println("========CSV to Json end========");
		

		
		// CSV => 행렬변환된 CSV파일 생성
		String csv_transpose = "Rscript " +script_path+ "genotype_sequence_bakground.R " +outputPath+" "+ jobid;
		
		System.out.println("========CSV transpose start========");
		System.out.println("csv_transpose : " + csv_transpose);
		runanalysistools.execute(csv_transpose, "cmd");
		System.out.println("========CSV transpose end========");
		

		
//}
%>