<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="org.apache.commons.exec.*" %>  

<%

//if (request.getMethod().equals("POST")){
	System.out.println("VFM file_ext executed");
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();			

	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	String savePath = rootFolder+"uploads/database/db_input/";
	String outputPath = rootFolder+"result/database/genotype_statistics/";		
	String org_savePath = rootFolder+"result/Breeder_toolbox_analyses/merge/";


	String db_savePath = "uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/database/genotype_statistics/";	
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";	
	String java_cmd_path = "/usr/bin/java -cp ./:/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/WEB-INF/classes/:/data/apache-tomcat-9.0.64/lib/mysql-connector-java-8.0.16.jar ipet_digitalbreed.VcfToMysql ";
	 
	String jobid = request.getParameter("jobid");
	String _orig_filename = request.getParameter("vcf_filename");
	String comment = null;
	String variety_id = request.getParameter("variety_id");
	String refgenome = request.getParameter("refgenome");
	String refgenome_id = request.getParameter("refgenome_id");
	String annotation_filename = request.getParameter("annotation_filename");

	System.out.println("refgenome : " + refgenome);
	System.out.println("annotation_filename : " + annotation_filename);
	
	String refgenomePath = rootFolder+"uploads/reference_database/"+refgenome+"/";
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String SaveSql = "UPDATE vcf_file_merge_t SET save_cmd = '1' where jobid='" +jobid+ "';";
	
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

	String genotype_sequence = script_path+"genotype_sequence_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;
	String genotype_statistics = script_path+"genotype_statistics_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
	String vcf_statistcs = script_path+"vcf_statistcs_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;
	//String snp_eff = "Rscript "+ script_path+"genotype_snpeff.R "+savePath+jobid+"/ "+outputPath+" "+ jobid +" " + _orig_filename +" "+ refgenomePath +" "+ refgenome +" "+ annotation_filename;
	String snp_eff = "perl "+ script_path+"genotype_snpeff.pl "+savePath+jobid+"/ "+outputPath+" "+ jobid +" " + _orig_filename +" "+ refgenomePath +" "+ refgenome +" "+ annotation_filename;
	
	
	
	String insertVcfinfo_sql="insert into vcfdata_info_t(cropid,varietyid,status,refgenome,uploadpath,filename,resultpath,comment,samplecnt,variablecnt,maf,mindp,mingq,ms,jobid,creuser,cre_dt) values((select cropid from variety_t where varietyid='"+variety_id+"'),'"+variety_id+"',0,'-','"+db_savePath+"','"+_orig_filename+"','"+db_outputPath+"','"+comment+"','-','-','','','','','"+jobid+"','"+permissionUid+"',now());";
	System.out.println(insertVcfinfo_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(insertVcfinfo_sql);
	}catch(Exception e){
   		System.out.println(e);
   	}
	
	
	System.out.println("========genotype_sequence========");
	System.out.println("genotype_sequence :" + genotype_sequence);
	runanalysistools.execute(genotype_sequence, "cmd");
	System.out.println("========genotype_statistics========");
	System.out.println("genotype_statistics :" + genotype_statistics);
	runanalysistools.execute(genotype_statistics, "cmd");
	System.out.println("========vcf_statistcs========");
	System.out.println("vcf_statistcs :" + vcf_statistcs);
	runanalysistools.execute(vcf_statistcs, "cmd");
	
	if(!annotation_filename.equals("null")) {
		System.out.println("========snp_eff========");
		System.out.println(snp_eff);
		//runanalysistools.execute(snp_eff, "cmd");
		
		try {
			CommandLine cmdLine = CommandLine.parse(snp_eff);
			DefaultExecutor executor = new DefaultExecutor();
			executor.setExitValue(0);
			int exitValue = executor.execute(cmdLine);
		} catch(Exception e) {
			e.printStackTrace();
		}
	}
	
	
	FileReader fileReader = new FileReader(outputPath+jobid+"/"+jobid+"_vcf_statistics.csv");
	BufferedReader bufferedReader = new BufferedReader(fileReader);
	
	String vcf_statistcs_data = bufferedReader.readLine();
    String[] vcf_statistcs_data_strArr = vcf_statistcs_data.split(",");

	String refseq = vcf_statistcs_data_strArr[0];
	String samplecnt = vcf_statistcs_data_strArr[1];
	String variablecnt = vcf_statistcs_data_strArr[2];

	bufferedReader.close();
	
	//Statistics - Timeline
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+variety_id+"'),'"+variety_id+"','Genotype', 'New analysis', now());";
	//System.out.println(log_sql);
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	String updateVcfinfo_sql="update vcfdata_info_t set status=1, refgenome='" +refgenome+ "', refgenome_id=" +refgenome_id+ ", samplecnt='" +samplecnt+ "', variablecnt='" +variablecnt+ "' where creuser='"+permissionUid+"' and varietyid='"+variety_id+"' and jobid='" +jobid+ "';";
	//String updateVcfinfo_sql="update vcfdata_info_t set status=1, refgenome='" +refseq+ "', samplecnt='" +samplecnt+ "', variablecnt='" +variablecnt+ "' where creuser='"+permissionUid+"' and varietyid='"+variety_id+"' and jobid='" +jobid+ "';";
	System.out.println(updateVcfinfo_sql);
	
	try{
			ipetdigitalconndb.stmt.executeUpdate(updateVcfinfo_sql);
	}catch(Exception e){
   		System.out.println(e);
   		ipetdigitalconndb.stmt.close();
   		ipetdigitalconndb.conn.close();
   	}
	
	// CSV => JSON 생성 & DB저장
	System.out.println("========CSV to Json & excuteUpdate start========");
	//CsvToJson csvToJson = new CsvToJson();
	//csvToJson.getJson(outputPath, jobid, permissionUid);
	makeJsonFromCsv(outputPath, jobid, permissionUid);
	System.out.println("========CSV to Json & excuteUpdate end========"); 
	
	System.out.println("========save chromosome list start========");
	if(refgenome.equals("-")) {
		System.out.println("Non-referenece. make chromosome list stopped");
	} else {
		makeChrDataCsv(rootFolder, jobid, refgenome);
	}
	System.out.println("========save chromosome list end========");

	String updateVcfinfo2_sql="update vcfdata_info_t set status=2 where creuser='"+permissionUid+"' and varietyid='"+variety_id+"' and jobid='" +jobid+ "';";
	System.out.println(updateVcfinfo_sql);
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(updateVcfinfo_sql);
	}catch(Exception e){
   		System.out.println(e);
   	}finally { 
   		ipetdigitalconndb.stmt.close();
   		ipetdigitalconndb.conn.close();
   	}

%>



<%! 
	private void makeJsonFromCsv(String outputPath, String jobid, String permissionUid) throws SQLException {
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
		File excelFile = new File(outputPath+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
		
		System.out.println("file read and write start");
		
		try {
			
			BufferedReader br = new BufferedReader(new FileReader(excelFile), 524288);				// buffer 512kb
			
			String line = br.readLine();		// 첫줄
			
			List<String> columns = Arrays.asList(line.split(","));;
			
			
			System.out.println("column size : " + columns.size());
			
			
			//String insertSqlColumnPart = "insert into vcfviewer_t (jobid, row_index, contents, creuser) values ('";
			String insertSqlColumnPart = "insert into vcfviewer_t (chr, position, jobid, row_index, contents, creuser) values ('";
			StringBuilder insertSqlValuesPart = new StringBuilder();
			
			int count = 0;
			line = br.readLine();		// 첫줄 스킵용
			while (line != null) {
				
				count++;
	
				JsonObject obj = new JsonObject(); 
	            List<String> chunks = Arrays.asList(line.split(","));

	            for(int i = 0; i < columns.size(); i++) {
		        	if(i==0) {
		        		String chr = chunks.get(0);
		        		//obj.addProperty("chr", chr);
		        		insertSqlValuesPart.append(chr + "', ");
		        	} else if(i==1) {
		        		String position = chunks.get(1);
		        		//obj.addProperty("position", position);
		        		insertSqlValuesPart.append(position + ", '");
		        	} else {
		        		obj.addProperty(columns.get(i), chunks.get(i));
		        	}
		        }
	            //System.out.println(obj);
	            
	            
	            // 파일 내용 insert
	            insertSqlValuesPart.append(jobid+ "'," +count+ ",'" +obj.toString()+ "','" +permissionUid+ "')");
	            
	            line = br.readLine();
	            if(line == null || count % 1000 == 0) {
	            	System.out.println("1000 inserts executed & count passed - " + count);
	            	//System.out.println(insertSqlColumnPart+insertSqlValuesPart);
	            	//System.out.println("String length - " + (insertSqlColumnPart+insertSqlValuesPart).length() );
	            	ipetdigitalconndb.stmt.executeUpdate(insertSqlColumnPart+insertSqlValuesPart);
	            	//insertSqlValuesPart = "";
	            	insertSqlValuesPart.setLength(0);
	            } else {
	            	//insertSqlValuesPart += ",('";
	            	insertSqlValuesPart.append(",('");
	            }
	            
	            
			}
			
			br.close();
			
		} catch (Exception e) {
			System.out.println(e);
			e.printStackTrace();
		} finally {
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
	}
%>

<%!
	private void makeChrDataCsv(String rootFolder, String jobid, String refgenome) throws IOException, SQLException {
		String path = rootFolder+"result/database/genotype_statistics/";
		
		//File fileRead = new File(path+"/"+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
		File fileRead2 = new File(rootFolder+"uploads/reference_database/"+refgenome+"/len/len.csv");
		File fileWrite = new File(path+"/"+jobid+"/"+jobid+"_chr_row_index_data.csv");
		
		System.out.println(rootFolder+"uploads/reference_database/"+refgenome+"/len/len.csv");
		
		//BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(fileRead), "UTF-8"));
		BufferedReader br2 = new BufferedReader(new InputStreamReader(new FileInputStream(fileRead2), "UTF-8"));
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileWrite), "UTF-8"));
		
		bw.write("chr,vcfId_at_firstRow,row_count,length");
		bw.newLine();
		
		br2.readLine();
		String line = br2.readLine();
		
		for(int i=0 ; true ; i++) {
			//System.out.println(line);
			
			String[] line_arr = line.split(",");
			String chr = line_arr[0];
			String len = line_arr[1];
			
			String vcf_id = getVcfId(chr, jobid);
			String row_count = getChrCount(chr, jobid);
			
			System.out.println(chr + "," + vcf_id + "," + row_count + "," + len);
			bw.write(chr + "," + vcf_id + "," + row_count + "," + len);
			if((line=br2.readLine()) != null) {
				bw.newLine();
			} else {
				break;
			}
		}
		
		br2.close();
		
		bw.flush();
		bw.close();
	}
%>

<%! 
private String  getVcfId(String chr, String jobid) throws SQLException {
	
	
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	try{
		String sql = "select vcf_id from vcfviewer_t where chr='" +chr+ "' and jobid='"+jobid+"' limit 1;";
		//System.out.println(sql);
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		
		ipetdigitalconndb.rs.next();
		String vcf_id = ipetdigitalconndb.rs.getString("vcf_id");
		//System.out.println(vcf_id);
		return vcf_id;
		
	}catch(Exception e){
		System.out.println("getVcfId error");
   		System.out.println(e);
		return "1";
   	}finally { 
   		ipetdigitalconndb.stmt.close();
   		ipetdigitalconndb.conn.close();
   	}

} 
%>

<%! 
private String getChrCount(String chr, String jobid) throws SQLException {
	
	
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	try{
		String sql = "select count(*) as count from vcfviewer_t where chr='" +chr+ "' and jobid='"+jobid+"' limit 1;";
		//System.out.println(sql);
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		
		ipetdigitalconndb.rs.next();
		String count = ipetdigitalconndb.rs.getString("count");
		//System.out.println(vcf_id);
		return count;
		
	}catch(Exception e){
		System.out.println("getChrCount error");
   		System.out.println(e);
		return "1";
   	}finally { 
   		ipetdigitalconndb.stmt.close();
   		ipetdigitalconndb.conn.close();
   	}

} 
%>