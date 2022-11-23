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
	String varietyid = request.getParameter("varietyid");

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
	    		
		String genotype_sequence = script_path+"genotype_sequence_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;
		String genotype_statistics = script_path+"genotype_statistics_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
		String vcf_statistcs = script_path+"vcf_statistcs_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
		String vcf_parsing = java_cmd_path+" " + "/data/apache-tomcat-9.0.64/webapps/"+db_outputPath+jobid+"/ "+ jobid +" " + permissionUid+ " &";		
				
		runanalysistools.execute(genotype_sequence, "cmd");
		runanalysistools.execute(genotype_statistics, "cmd");
		runanalysistools.execute(vcf_statistcs, "cmd");
		runanalysistools.execute(vcf_parsing, "java");
		
		try {	
			Process process = null;
			Runtime runtime = Runtime.getRuntime();		
			process = Runtime.getRuntime().exec(vcf_parsing);				
			process.getErrorStream().close(); 
			process.getInputStream().close(); 
			process.getOutputStream().close(); 
	    } catch (Exception e) {
			System.out.println(e);
	        e.printStackTrace();
	    }
		
		FileReader fileReader = new FileReader(outputPath+jobid+"/"+jobid+"_vcf_statistics.csv");
		BufferedReader bufferedReader = new BufferedReader(fileReader);
		
		String vcf_statistcs_data = bufferedReader.readLine();
	    String[] vcf_statistcs_data_strArr = vcf_statistcs_data.split(",");

		String refseq = vcf_statistcs_data_strArr[0];
		String samplecnt = vcf_statistcs_data_strArr[1];
		String variablecnt = vcf_statistcs_data_strArr[2];

		
		
		String insertVcfinfo_sql="insert into vcfdata_info_t(cropid,varietyid,refgenome,uploadpath,filename,resultpath,comment,samplecnt,variablecnt,maf,mindp,mingq,ms,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','"+refseq+"','"+db_savePath+"','"+_orig_filename+"','"+db_outputPath+"','"+comment+"','"+samplecnt+"','"+variablecnt+"','','','','','"+jobid+"','"+permissionUid+"',now());";	

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
//}
%>