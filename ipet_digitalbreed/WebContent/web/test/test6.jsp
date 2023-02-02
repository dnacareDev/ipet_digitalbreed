<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="com.google.gson.JsonObject" %>
<%@ page import="ipet_digitalbreed.*"%>  

<%

	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder+"uploads/database/db_input/";
	String outputPath = rootFolder+"result/database/genotype_statistics/";
	
	String permissionUid = "dnacare";
	String jobid = "20230202132011";
	
	

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
	        
	        /*
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
	        */
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
%>