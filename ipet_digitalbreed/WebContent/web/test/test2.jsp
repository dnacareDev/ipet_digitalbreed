<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	//String permissionUid = session.getAttribute("permissionUid")+"";

	//String rootFolder = request.getSession().getServletContext().getRealPath("/");
	//String path = rootFolder+"result/database/genotype_statistics/20230112141338/";

	String jobid = "20230112141338";
	
	String gwas_pheno_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/gwas/";
	String jobid_gwas = "20230119184818";
	
	transferToUtf8(gwas_pheno_path,jobid_gwas);
	
	
%>

<%! 
	private void transferToUtf8(String csvPath, String jobid_gwas) {
	
		System.out.println("in function");
	
		try {
			File csvEucKr = new File(csvPath+jobid_gwas+"/"+jobid_gwas+"_phenotype-eucKr.csv");
			BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(csvEucKr), "EUC-KR"));

			File csvUtf8 = new File(csvPath+jobid_gwas+"/"+jobid_gwas+"_phenotype.csv");
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(csvUtf8), "UTF-8"));

			String line;
			for(int i=0 ; (line = br.readLine()) != null ; i++) {
				System.out.println(line);
				
				String[] arr = line.split(",");
				
				for(int j=0 ; j<arr.length ; j++) {
					bw.write(arr[j]);
					if(j == arr.length -1) {
						bw.newLine();
					} else {
						bw.write(",");
					}
				}
			}
			bw.flush();
			bw.close();
			br.close();
			
			
		} catch(IOException e) {
			e.printStackTrace();
		}
	}
%>
