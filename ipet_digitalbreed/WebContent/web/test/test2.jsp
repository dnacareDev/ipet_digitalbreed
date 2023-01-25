<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String permissionUid = session.getAttribute("permissionUid")+"";

	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/database/genotype_statistics/20230112141338/";

	String jobid = "20230112141338";
	
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	
	File txtFile = new File(path+"20230112141338_genotype_matrix_viewer.csv");
	System.out.println("read csv file");
	
	try {
		BufferedReader br = new BufferedReader(new FileReader(txtFile));
		
		
		//br.readLine();
		
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
            for(int i = 0; i < columns.size(); i++) {
                obj.addProperty(columns.get(i), chunks.get(i));
            }
            */
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
        
			System.out.println(insertSqlColumnPart+insertSqlValuesPart);
		
			break;
			/* 
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
            
            */
            
		}
		
		br.close();
		
		
	} catch (IOException e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
%>
