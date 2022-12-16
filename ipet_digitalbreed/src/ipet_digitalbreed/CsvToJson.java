package ipet_digitalbreed;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.io.IOException;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import com.google.gson.JsonObject;

public class CsvToJson {
	public void getJson(String outputPath, String jobid, String permissionUid) throws SQLException {
		
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		
	
		File excelFile = new File(outputPath+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
		
		System.out.println("file read and write start");
		
		try {
			
			
			BufferedReader br = new BufferedReader(new FileReader(excelFile), 524288);				// buffer 512kb
			
			String line = br.readLine();		// 첫줄
			
			/*
			List<String> columns = new LinkedList<>();
			columns.add("chr_pos");
			columns.add("Reference");
			for(int i=2 ; i<Arrays.asList(line.split(",")).size() ; i++) {
				columns.add("c"+i);
			}
			*/
			List<String> columns = null;
			columns = Arrays.asList(line.split(","));
			
			System.out.println("column size : " + columns.size());
			
			
			String insertSqlColumnPart = "insert into vcfviewer_t (jobid, row_index, contents, creuser) values ('";
			StringBuilder insertSqlValuesPart = new StringBuilder();
			
			int count = 0;
			line = br.readLine();		// 첫줄 스킵용
			while (line != null) {
				JsonObject obj = new JsonObject(); 
                List<String> chunks = Arrays.asList(line.split(","));
                //System.out.println(chunks.size());
                
                for(int i = 0; i < columns.size(); i++) {
                    obj.addProperty(columns.get(i), chunks.get(i));
                }
                //System.out.println(obj);
                // 파일 내용 insert
                //String insertFileContentSql = "insert into vcfviewer_t (jobid, row_index, contents, creuser) values ('" +jobid+ "'," +count+ ",'" +obj.toString()+ "','" +permissionUid+ "')";
                //ipetdigitalconndb.stmt.executeUpdate(insertFileContentSql);

                //insertSqlValuesPart += jobid+ "'," +count+ ",'" +obj.toString()+ "','" +permissionUid+ "')";
                insertSqlValuesPart.append(jobid+ "'," +count+ ",'" +obj.toString()+ "','" +permissionUid+ "')");
                
                count++;
                //System.out.println(count);
                line = br.readLine();
                if(line == null || count % 5000 == 0) {
                	System.out.println("5000 inserts executed & count passed - " + count);
                	//System.out.println( (insertSqlColumnPart+insertSqlValuesPart).length() );
                	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
                	ipetdigitalconndb.stmt.executeUpdate(insertSqlColumnPart+insertSqlValuesPart);
                	//insertSqlValuesPart = "";
                	insertSqlValuesPart.setLength(0);
                } else {
                	//insertSqlValuesPart += ",('";
                	insertSqlValuesPart.append(",('");
                }
			}
			
			br.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		} finally {
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.conn.close();
		}
		
		// json 파일을 통째로 읽으면 메모리 감당이 안됨
		// DB에 저장하고 서버사이드로 돌린다
		/*
		File excelFile = new File(outputPath+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");

		System.out.println("file read and write start");
		
		try {
			
			BufferedReader br = new BufferedReader(new FileReader(excelFile), 32768);				// buffer 32kb
			
			String line = br.readLine();		// 첫줄 (json key)
			
			
//			List<String> columns = null;
//			columns = Arrays.asList(line.split(","));
			
			
			List<String> columns = new LinkedList<>();
			columns.add("chr_pos");
			columns.add("Reference");
			for(int i=2 ; i<Arrays.asList(line.split(",")).size() ; i++) {
				columns.add("c"+i);
			}
			

			System.out.println("column size : " + columns.size());
			
			int page = 45000000 / columns.size();
			
			
			line = br.readLine();		// 다음줄을 while 이전에 읽는다. 코드 마지막에 line check가 있어서 미리 읽어야 함
			

			int fileCount = 0;
			BufferedWriter bw_$ = new BufferedWriter(new FileWriter(outputPath+jobid+"/"+jobid+"_genotype_matrix_" +fileCount+ ".json"), 32768);

			int count = 0;
			while (line != null) {
				//if(count % 10000 == 0) {
				if(count % page == 0) {
					System.out.println(jobid+"_genotype_matrix_" +fileCount+ ".json created");
					bw_$ = new BufferedWriter(new FileWriter(outputPath+jobid+"/"+jobid+"_genotype_matrix_" +fileCount+ ".json"), 32768);
					bw_$.write("[");
					fileCount++;
				}
				
				JsonObject obj = new JsonObject(); 
                List<String> chunks = Arrays.asList(line.split(","));
                //System.out.println(chunks.size());
                
                for(int i = 0; i < columns.size(); i++) {
                    obj.addProperty(columns.get(i), chunks.get(i));
                }
                
                count++;
                line = br.readLine();
                //if(line == null || count % 10000 == 0) {
                if(line == null || count % page == 0) {
                	System.out.println("count passed - " + count);
                	bw_$.write(obj.toString()+"]");
                	bw_$.flush();
                } else {
                	bw_$.write(obj.toString()+",");
                }
			}
			bw_$.close();
		} catch (Exception e) {
			e.printStackTrace();
		}
		*/ 
	}
	
}
