package ipet_digitalbreed;

import java.io.BufferedReader;
import java.io.BufferedWriter;
import java.io.File;
import java.io.FileReader;
import java.io.FileWriter;
import java.util.Arrays;
import java.util.List;

import com.google.gson.JsonObject;

public class CsvToJson {
	public void getJson(String outputPath, String jobid) {
	
		File excelFile = new File(outputPath+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");

		System.out.println("file read and write start");
		
		try {
			
			BufferedReader br = new BufferedReader(new FileReader(excelFile));
			BufferedWriter bw = new BufferedWriter(new FileWriter(outputPath+jobid+"/"+jobid+"_genotype_matrix.json"));
			
			bw.write("[");
			
			
			String line = br.readLine();		// 첫줄 (json key)
			List<String> columns = null;
			columns = Arrays.asList(line.split(","));
			
			
			/*
			List<String> columns = new LinkedList<>();
			for(int i=0 ; i<line.split(",").length ; i++) {
				columns.add("c"+i);
			}
			*/
			
			
			
			line = br.readLine();		// 첫줄 스킵
			
			int count = 0;
			while (line != null) {
				
				count++;
				if(count % 100000 == 0) {
					System.out.println("count passed - " + count);
				}

				
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
		} catch (Exception e) {
			e.printStackTrace();
		} 
	}
	
}
