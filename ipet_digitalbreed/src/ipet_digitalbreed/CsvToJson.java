package ipet_digitalbreed;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileNotFoundException;
import java.io.FileReader;
import java.io.FileWriter;
import java.io.IOException;
import java.util.Arrays;
import java.util.List;

import com.google.gson.JsonArray;
import com.google.gson.JsonObject;

public class CsvToJson {
	public void getJson(String outputPath, String jobid) throws IOException {
	
		// create an array called datasets
        JsonArray datasets = new JsonArray();
		
		File excelFile = new File(outputPath+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");

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
	
	                for(int i = 0; i < columns.size(); i++) {
	                    obj.addProperty(columns.get(i), chunks.get(i));
	                }
	                datasets.add(obj); 
	            } 
            }
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
	}
}
