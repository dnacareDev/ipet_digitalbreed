<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@page import="com.google.gson.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>


<%
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/phenotype_data/";
	//String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pheno/statistical_summary/";
	//String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String jobid = request.getParameter("jobid");
    
	JsonObject jsonObject = readPhenotypeTxt(savePath, jobid);
    
	System.out.println(jsonObject);
	
    out.clear();
    out.print(jsonObject);
	
%>


<%! 
//public String[] readPhenotypeTxt(String savePath, String jobid) throws IOException {
public JsonObject readPhenotypeTxt(String savePath, String jobid) throws IOException {
	
	File file = new File(savePath+jobid+"/GS_traits.csv");
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));
	
	String line = br.readLine();
	int analysis_number = 0;
	int column_count = line.split(",").length; 
	
	String traitname = line.split(",")[1];
	String traitname_key = 2+"";
	
	while((line = br.readLine()) != null) {
		analysis_number++;
	}
	
	
	br.close();
	//System.out.println(traitname);
	//System.out.println(traitname_keys);
	//System.out.println(analysis_number);
	
	JsonObject jsonObject = new JsonObject();
    jsonObject.addProperty("traitname", traitname);
    jsonObject.addProperty("seq", traitname_key);
    jsonObject.addProperty("analysis_number", analysis_number+"");
	
	return jsonObject;
}
%>

