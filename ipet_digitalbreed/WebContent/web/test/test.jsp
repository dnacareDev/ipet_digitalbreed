<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = "result/database/genotype_statistics/20230112165329/browser_data/";

	
	
	File excelFile = new File(rootFolder+path+"20230112165329_genotype_matrix_file.txt");
	
	System.out.println("read txt file");
	
	try {
		BufferedReader br = new BufferedReader(new FileReader(excelFile), 524288);
		br.readLine();
		
		
	} catch (IOException e) {
		e.printStackTrace();
	}
	
	
	/*
	try {
		
		BufferedReader br = new BufferedReader(new FileReader(excelFile), 524288);
		br.readLine();
		
		out.clear();
		String line = br.readLine();
		while(line != null) {
			String chr_pos = line.substring(0, line.indexOf(","));
			if( Integer.parseInt(chr_pos.substring(1, line.indexOf("_"))) == 1 ) {

				String position = chr_pos.substring(line.indexOf("_")+1, chr_pos.length());
				System.out.println(chr_pos);
				out.print(position);
				
				line = br.readLine();
				if(line != null) {
					out.print(",");
				}
			} else {
				line = br.readLine();
			}
		}
		
		System.out.println("end");
		
	} catch (IOException e) {
		e.printStackTrace();
	}
	*/
%>