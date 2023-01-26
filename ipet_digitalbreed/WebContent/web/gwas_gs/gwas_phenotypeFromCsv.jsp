<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.nio.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	String jobid_gwas = request.getParameter("jobid_gwas");
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	System.out.println("====================================");
	System.out.println("jobid_gwas : " + jobid_gwas);
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("rootFolder : " + rootFolder);
	System.out.println("====================================");
	
	
	String gwas_pheno_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/gwas/";
	String outputdir = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/result/gwas/";
	
	System.out.println("===========================================");
	System.out.println("gwas_pheno_path : " + gwas_pheno_path);
	System.out.println("outputdir : " + outputdir);
	System.out.println("===========================================");
	
	File folder_pheno_path = new File(gwas_pheno_path+jobid_gwas);

	if (!folder_pheno_path.exists()) {
	try{
		folder_pheno_path.mkdir(); 
        } 
        catch(Exception e){
	    e.getStackTrace();
		}        
	}
	
	out.clear();
	
	List<List<String>> list = new ArrayList<List<String>>();
	File csv = new File(gwas_pheno_path+jobid_gwas+"/"+jobid_gwas+"_phenotype.csv");
	BufferedReader br = null;
	try {
		//br = new BufferedReader(new FileReader(csv));
		br = new BufferedReader(new InputStreamReader(new FileInputStream(csv), "UTF-8"));
		String line = "";
		
		if((line=br.readLine()) != null) {
			out.print(line.substring(line.indexOf(",")+1));
		}
		
	} catch (FileNotFoundException e) {
		e.printStackTrace();
	} catch (IOException e) {
		e.printStackTrace();
	} finally {
		try {
			if(br != null) {br.close();}
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
	//out.clear();
	//System.out.print(list);
	//out.print(list);
%>