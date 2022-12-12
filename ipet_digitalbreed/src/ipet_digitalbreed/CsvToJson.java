package ipet_digitalbreed;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Stream;

import org.json.simple.JSONObject;

import com.google.gson.JsonObject;

public class CsvToJson {
	public void getJson(String outputPath, String jobid) {
	
		//Timestamp timestamp = new Timestamp(System.currentTimeMillis());
		
		// create an array called datasets
        //JsonArray datasets = new JsonArray();
		
		File excelFile = new File(outputPath+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");

		System.out.println("file read and write start");
		
		/*
		// 첫줄 읽기. json key
		List<String> columns = null;
		Path path = Paths.get(outputPath+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
		try {
			Stream<String> stream = Files.lines(path);
			// 1. 파일 Stream 생성
 
            // 2. 3번째 라인 찾기
            //String nthLine = stream.skip(2).findFirst().get();
			String nthLine = stream.findFirst().get();
 
            // 3. 결과 출력
            //System.out.println(nthLine);  // line 3
			columns = Arrays.asList(nthLine.split(","));
			//System.out.println(columns);
			
            stream.close();
		} catch (IOException e) {
			e.printStackTrace();
		} 
		*/
		
		try {
			
			BufferedReader br = new BufferedReader(new FileReader(excelFile));
			BufferedWriter bw = new BufferedWriter(new FileWriter(outputPath+jobid+"/"+jobid+"_genotype_matrix.json"));
			
			bw.write("[");
			
			
			String line = br.readLine();		// 첫줄 (json key)
			List<String> columns = null; 
			columns = Arrays.asList(line.split(","));
			
			
			//br.readLine();		// 첫줄 스킵
			
			while (line != null) {
				JsonObject obj = new JsonObject(); 
                List<String> chunks = Arrays.asList(line.split(","));
                //System.out.println(chunks.size());
                
                for(int i = 0; i < columns.size(); i++) {
                    obj.addProperty(columns.get(i), chunks.get(i));
                }
                
                line = br.readLine();
                if(line == null) {
                	bw.write(obj.toString()+"]");
                	bw.flush();
                } else {
                	bw.write(obj.toString()+",");
                	bw.flush();
                }
			}
			bw.close();
			/*
			JSONObject jsonObject = new JSONObject();
			jsonObject.put("column_1","CsvToJson");
			
			bw.write("[");
			bw.write(jsonObject.toString()+",");
			bw.flush(); // write로 담은 내용 출력 후, 버퍼를 비움.
			//bw.close(); 
			bw.write(jsonObject.toString()+",");
			bw.flush(); // write로 담은 내용 출력 후, 버퍼를 비움.
			bw.write(jsonObject.toString()+",");
			bw.flush(); // write로 담은 내용 출력 후, 버퍼를 비움.
			bw.write(jsonObject.toString()+",");
			bw.flush(); // write로 담은 내용 출력 후, 버퍼를 비움.
			bw.write(jsonObject.toString() +"]");
			bw.flush(); // write로 담은 내용 출력 후, 버퍼를 비움.
			bw.close(); 
			*/
			
			/*
			String line = "";
			//sb.delete(0, sb.length());
			boolean flag = true; 
			List<String> columns = null; 
			
			while ((line = br.readLine()) != null) {
				if (flag) {
	            	flag = false; 
	                //process header 
	                columns = Arrays.asList(line.split(","));
	            } else {
	            	
	            }
			}
			*/
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			
		}
		
		
		/*
		System.out.println("file read start");
		try (BufferedReader br = new BufferedReader(new FileReader(excelFile)))  {
			
			
            String line;
            boolean flag = true; 
            List<String> columns = null; 
            while ((line = br.readLine()) != null) {
	            if (flag) {
	            	flag = false; 
	                //process header 
	                columns = Arrays.asList(line.split(","));
	            } else {
	                //to store the object temporarily
	                JsonObject obj = new JsonObject(); 
	                List<String> chunks = Arrays.asList(line.split(","));
	                System.out.println(chunks.size());
	
	                for(int i = 0; i < columns.size(); i++) {
	                    obj.addProperty(columns.get(i), chunks.get(i));
	                }
	                datasets.add(obj); 
	            } 
            }
            System.out.println("file read end");
        } catch(FileNotFoundException fnfe) {
            System.out.println("File not found.");
        } catch(IOException io) {
            System.out.println("Cannot read file.");
        }


        String jsonString = datasets.toString();

        try {
        	BufferedWriter bw = new BufferedWriter(new FileWriter(outputPath+jobid+"/"+jobid+"_genotype_matrix.json"));   //할당된 버퍼에 값 넣어주기
	        bw.write(jsonString);   //버퍼에 있는 값 전부 출력
	        bw.flush();
	        bw.close();
        } catch (IOException e) {
        	e.printStackTrace();
        }
        */
	}
	
}
