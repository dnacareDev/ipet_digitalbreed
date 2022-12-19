<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%> 

<%
	String jobid = request.getParameter("jobid");
	String command = request.getParameter("command");
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();

	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String outputPath = rootFolder+"result/database/genotype_statistics/";
	
	
	System.out.println("jobid : " + jobid);
	System.out.println("command : "+ command);
	
	switch(command) {
		case "header":
			
			try {
				File file = new File(outputPath+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
				BufferedReader br = new BufferedReader(new FileReader(file));
				
				String line = br.readLine();
				
				//List<String> columns = null;
				//columns = Arrays.asList(line.split(","));
				
				out.clear();
				out.print(line);
				
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			break;
			
		case "filter":
			
			try {
				File file = new File(outputPath+jobid+"/"+jobid+"_genotype_matrix.csv");
				BufferedReader br = new BufferedReader(new FileReader(file));
				
				String line = br.readLine();
				
				//List<String> columns = null;
				//columns = Arrays.asList(line.split(","));
				
				out.clear();
				out.print(line);
				
				br.close();
			} catch (IOException e) {
				e.printStackTrace();
			}
			
			break;
			
		case "rowThisPage":
			String startRow = request.getParameter("startRow");
			System.out.println("startRow : " + startRow);
			
			try {
				JSONArray jsonArray = new JSONArray();
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
				
				String sql = "select contents from vcfviewer_t where jobid = '" +jobid+ "' and row_index >= " +startRow+ " limit 100;";
				System.out.println("sql : " + sql);
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 
					JsonObject jsonObj = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
					
					jsonArray.add(jsonObj);
					
					//System.out.println(jsonObj);
				}
				
				//System.out.println(jsonArray);
				System.out.println("jsonArray length (thispage) : " + jsonArray.size());
				out.print(jsonArray);
				
			} catch(Exception e) {
				e.printStackTrace();
			} finally {
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				ipetdigitalconndb.conn.close();
			}
			
			break;
	}
	
	
	
	
%>