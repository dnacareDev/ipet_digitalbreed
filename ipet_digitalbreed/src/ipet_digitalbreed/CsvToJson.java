package ipet_digitalbreed;

import java.io.BufferedReader;
import java.io.File;
import java.io.FileReader;
import java.sql.SQLException;
import java.util.Arrays;
import java.util.List;

import com.google.gson.JsonObject;

public class CsvToJson {
	public void getJson(String outputPath, String jobid, String permissionUid) throws SQLException {
		
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
		File excelFile = new File(outputPath+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
		
		System.out.println("file read and write start");
		
		try {
			
			BufferedReader br = new BufferedReader(new FileReader(excelFile), 524288);				// buffer 512kb
			
			String line = br.readLine();		// 첫줄
			
			List<String> columns = null;
			columns = Arrays.asList(line.split(","));
			
			System.out.println("column size : " + columns.size());
			
			
			String insertSqlColumnPart = "insert into vcfviewer_t (jobid, row_index, contents, creuser) values ('";
			StringBuilder insertSqlValuesPart = new StringBuilder();
			
			int count = 0;
			line = br.readLine();		// 첫줄 스킵용
			while (line != null) {
				
				count++;

				JsonObject obj = new JsonObject(); 
                List<String> chunks = Arrays.asList(line.split(","));
                //System.out.println(chunks.size());
                
                for(int i = 0; i < columns.size(); i++) {
                    obj.addProperty(columns.get(i), chunks.get(i));
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
}
