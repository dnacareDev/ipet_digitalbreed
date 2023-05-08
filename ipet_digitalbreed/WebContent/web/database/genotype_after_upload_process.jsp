<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="ipet_digitalbreed.*"%> 
<%@ page import="org.apache.commons.exec.*" %> 

<%
	RunAnalysisTools runanalysistools = new RunAnalysisTools();

	String permissionUid = session.getAttribute("permissionUid")+"";
	String jobid = request.getParameter("jobid");
	String _orig_filename = request.getParameter("filename");
	//String comment = request.getParameter("comment");
	String varietyid = request.getParameter("varietyid");
	String refgenome = request.getParameter("refgenome");
	String annotation_filename = request.getParameter("annotation_filename");
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder+"uploads/database/db_input/";
	String outputPath = rootFolder+"result/database/genotype_statistics/";
	String refgenomePath = rootFolder+"uploads/reference_database/"+refgenome+"/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";	
	
	
	String genotype_sequence = script_path+"genotype_sequence_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;
	String genotype_statistics = script_path+"genotype_statistics_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
	String vcf_statistcs = script_path+"vcf_statistcs_final.sh "+savePath+" "+outputPath+" "+ jobid +" " + _orig_filename;		
	String snp_eff = "perl "+ script_path+"genotype_snpeff.pl "+savePath+jobid+"/ "+outputPath+" "+ jobid +" " + _orig_filename +" "+ refgenomePath +" "+ refgenome +" "+ annotation_filename;
	
	/*
	System.out.println("========genotype_sequence========");
	System.out.println(genotype_sequence);
	runanalysistools.execute(genotype_sequence, "cmd");
	System.out.println("========genotype_statistics========");
	System.out.println(genotype_statistics);
	runanalysistools.execute(genotype_statistics, "cmd");
	System.out.println("========vcf_statistcs========");
	System.out.println(vcf_statistcs);
	runanalysistools.execute(vcf_statistcs, "cmd");
	*/
	
	System.out.println("========genotype_sequence========");
	System.out.println(genotype_sequence);
	try {
		CommandLine cmdLine = CommandLine.parse(genotype_sequence);
		DefaultExecutor executor = new DefaultExecutor();
		executor.setExitValue(0);
		int exitValue = executor.execute(cmdLine);
	} catch(Exception e) {
		e.printStackTrace();
	}
	System.out.println("========genotype_statistics========");
	System.out.println(genotype_statistics);
	try {
		CommandLine cmdLine = CommandLine.parse(genotype_statistics);
		DefaultExecutor executor = new DefaultExecutor();
		executor.setExitValue(0);
		int exitValue = executor.execute(cmdLine);
	} catch(Exception e) {
		e.printStackTrace();
	}
	System.out.println("========vcf_statistcs========");
	System.out.println(vcf_statistcs);
	try {
		CommandLine cmdLine = CommandLine.parse(vcf_statistcs);
		DefaultExecutor executor = new DefaultExecutor();
		executor.setExitValue(0);
		int exitValue = executor.execute(cmdLine);
	} catch(Exception e) {
		e.printStackTrace();
	}
	
	
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
    
    bufferedReader.close();

	//String refseq = vcf_statistcs_data_strArr[0];
	String samplecnt = vcf_statistcs_data_strArr[1];
	String variablecnt = vcf_statistcs_data_strArr[2];
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	//String updateVcfinfo_sql="update vcfdata_info_t set status=1, refgenome='" +refgenome+ "', samplecnt='" +samplecnt+ "', variablecnt='" +variablecnt+ "' where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' and jobid='" +jobid+ "';";
	String updateVcfinfo_sql="update vcfdata_info_t set status=1, samplecnt='" +samplecnt+ "', variablecnt='" +variablecnt+ "' where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' and jobid='" +jobid+ "';";
	System.out.println(updateVcfinfo_sql);
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(updateVcfinfo_sql);
	}catch(Exception e){
   		System.out.println(e);
   	}
	
	
	
	// CSV => JSON 생성 & DB저장
	System.out.println("========CSV to Json & excuteUpdate start========");
	makeJsonFromCsv(outputPath, jobid, permissionUid);
	System.out.println("========CSV to Json & excuteUpdate end========"); 
	
	System.out.println("========save reference information start========");
	if(refgenome.equals("-")) {
		System.out.println("Non-referenece. make chromosome list stopped");
	} else {
		makeChrDataCsv(rootFolder, jobid, refgenome);
	}
	System.out.println("========save reference information end========");
	System.out.println("vcf file background process complete");
	
	
	
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
		        		insertSqlValuesPart.append(chr + "', ");
		        	} else if(i==1) {
		        		String position = chunks.get(1);
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
	            	ipetdigitalconndb.stmt.executeUpdate(insertSqlColumnPart+insertSqlValuesPart);
	            	insertSqlValuesPart.setLength(0);
	            } else {
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
		
		File fileRead2 = new File(rootFolder+"uploads/reference_database/"+refgenome+"/len/len.csv");
		File fileWrite = new File(path+"/"+jobid+"/"+jobid+"_chr_row_index_data.csv");
		
		System.out.println(rootFolder+"uploads/reference_database/"+refgenome+"/len/len.csv");
		
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