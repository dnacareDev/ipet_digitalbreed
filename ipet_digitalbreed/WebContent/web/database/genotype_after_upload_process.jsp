<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="com.google.gson.JsonObject" %>
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
   	}finally { 
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
	makeChrDataCsv(rootFolder, jobid);
	System.out.println("========save chromosome list end========");

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
	            //System.out.println(chunks.size());
	            
	            for(int i = -2; i < columns.size(); i++) {
	            	if(i==-2) {
	            		String chr = chunks.get(0).substring(0, chunks.get(0).lastIndexOf("_"));
	            		//obj.addProperty("chr", chr);
	            		insertSqlValuesPart.append(chr + "', ");
	            	} else if(i==-1) {
	            		String position = chunks.get(0).substring(chunks.get(0).lastIndexOf("_")+1, chunks.get(0).length());
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
	private void makeChrDataCsv(String rootFolder, String jobid) throws IOException, SQLException {
		String path = rootFolder+"result/database/genotype_statistics/";
		
		File fileRead = new File(path+"/"+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
		File fileWrite = new File(path+"/"+jobid+"/"+jobid+"_chr_row_index_data.csv");
		
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(fileRead), "UTF-8"));
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileWrite), "UTF-8"));
		
		bw.write("chr,vcfId_at_firstRow,row_count");
		bw.newLine();
		
		
		List<List<String>> chrList = new ArrayList<>();
		
		br.readLine();
		String line = br.readLine();
		
		for(int i=1, chrListCount=0 ; true ; i++) {
			//System.out.println(line);
			String chr = line.substring(0, line.indexOf("_"));
			
			if(i==1) {
				String vcf_id = getVcfId(chr, jobid);

				chrList.add( Arrays.asList(chr, vcf_id, "") );
				bw.write( chr + "," + vcf_id + ",");
				
				System.out.println("chr : " + chr + "& vcf_id : " + vcf_id);
				
			}
			
			//System.out.println(chr);
			if( !(chr.equals( chrList.get(chrListCount).get(0) )) ) {
				
				
				if(chrListCount == 0) {
					chrList.get(chrListCount).set(2, String.valueOf(i-1));
					bw.write(String.valueOf(i-1));
				} else {
					chrList.get(chrListCount).set(2, String.valueOf(i));
					bw.write(String.valueOf(i));
				}
				
				chrListCount++;
				bw.newLine();
				
				i=0;
				//chrList.add( Arrays.asList(line.substring(0, line.indexOf("_")), String.valueOf(i), "") );
			}
			
			
			if( (line = br.readLine()) == null ) {
				chrList.get(chrListCount).set(2, String.valueOf(i+1));
				bw.write(String.valueOf(i+1));
				break;
			}
		}
		//System.out.println(chrList);
		//System.out.println("end");
		
		br.close();
		
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