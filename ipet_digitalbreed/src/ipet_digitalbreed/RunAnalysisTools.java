package ipet_digitalbreed;

import java.util.*;
import java.io.*;
import java.text.SimpleDateFormat;

public class RunAnalysisTools {

	public String getCurrentDateTime() {
		Date today = new Date();
		Locale currentLocale = new Locale("KOREAN", "KOREA");
		String pattern = "yyyyMMddHHmmss"; //hhmmss로 시간,분,초만 뽑기도 가능
		SimpleDateFormat formatter = new SimpleDateFormat(pattern,
				currentLocale);
		return formatter.format(today);
	}
	
	public void execute(String cmd, String cmd_flag) {
	    Process process = null;
	    Runtime runtime = Runtime.getRuntime();
	    StringBuffer successOutput = new StringBuffer(); // suc string buffer
	    StringBuffer errorOutput = new StringBuffer(); //  err string buffer
	    BufferedReader successBufferReader = null; // suc buffer
	    BufferedReader errorBufferReader = null; //  err buffer
	    String msg = null; // msg
	 
	    List<String> cmdList = new ArrayList<String>();
	 
	    if(cmd_flag.equals("cmd")) {
	    	cmdList.add("/bin/sh");
	    	//cmdList.add("/bin/bash");
			cmdList.add("-c");
	    }
	        
	    // cmd setting
	    cmdList.add(cmd);
	    String[] array = cmdList.toArray(new String[cmdList.size()]);
	       
		try { 
			// cmd exec
			if(cmd_flag.equals("cmd")) {
				process = runtime.exec(array);
			}
			else {
				process = runtime.exec(cmd);				
			}

			successBufferReader = new BufferedReader(new InputStreamReader(process.getInputStream(), "EUC-KR"));
	 
	        while ((msg = successBufferReader.readLine()) != null) {
	            //successOutput.append(msg + System.getProperty("line.separator"))
	        	System.out.println(msg);
	        }
	        
	        errorBufferReader = new BufferedReader(new InputStreamReader(process.getErrorStream(), "EUC-KR"));
	        
			while ((msg = errorBufferReader.readLine()) != null) {
	            //errorOutput.append(msg + System.getProperty("line.separator"));
				System.out.println(msg);
	        }

			if(cmd_flag.equals("cmd")) {
				process.waitFor();
			}
			
	        if (process.exitValue() == 0) {
	            System.out.println("Success "+"\n");
	            //System.out.println(successOutput.toString());
	        } else {
	            System.out.println("Fail "+"\n");
	            //System.out.println(errorOutput.toString());
	        }
	  
	    } catch (IOException e) {
	    	System.out.println("error");
	    } catch (InterruptedException e) {
	       	System.out.println("error");
	    } finally {
	        try {
	        	//process.destroy();
	            if (process != null) process.destroy();
	            if (successBufferReader != null) successBufferReader.close();
	            if (errorBufferReader != null) errorBufferReader.close();
	        } catch (IOException e1) {
	        	System.out.println("error");
	        }
	    }
	}
}
