<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*" %>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String permissionUid = request.getParameter("permissionUid");
	String varietyid = request.getParameter("variety_id");
	String jobid_gwas = request.getParameter("jobid_gwas");
	String comment = request.getParameter("comment");
	String jobid_vcf = request.getParameter("jobid_vcf");
	String filename_vcf = request.getParameter("filename_vcf");
	String traitname = request.getParameter("traitname");
	String[] traitname_arr = request.getParameterValues("traitname_arr");
	//String[] traitname_seq = request.getParameterValues("traitname_seq");
	String cre_date = request.getParameter("cre_date");
	String inv_date = request.getParameter("inv_date");
	String[] modelArr = request.getParameterValues("modelGroup");
	String phenotype = request.getParameter("phenotype");
	String radio_phenotype = request.getParameter("radio_phenotype");
	System.out.println("radio_phenotype :  "+ radio_phenotype);
	
	String[] cre_date_arr = cre_date.split(" to ");
	String[] inv_date_arr = inv_date.split(" to ");
	
	/*
	System.out.println("=========================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_gwas : " + jobid_gwas);
	System.out.println("comment : " + comment);
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("filename_vcf : " + filename_vcf);
	System.out.println("traitname : " + traitname);
	System.out.println("traitname_seq : " + Arrays.toString(traitname_seq));
	//System.out.println("cre_date : " + cre_date);
	System.out.println("cre_date_arr : " + Arrays.toString(cre_date_arr));
	//System.out.println("inv_date : " + inv_date);
	System.out.println("inv_date_arr : " + Arrays.toString(inv_date_arr));
	System.out.println("modelArr : " + Arrays.toString(modelArr));
	System.out.println("=========================================");
	*/
	
	//String savePath = rootFolder + "uploads/database/DB_input/" + jobid + "/";
	//String outputPath = rootFolder + "result/gwas/";
	String vcf_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/database/db_input/" + jobid_vcf + "/";
	String gwas_pheno_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/gwas/";
	String outputdir = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/result/gwas/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/db_input/";
	//String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/gwas/";
	String db_outputPath = "/ipet_digitalbreed/result/gwas/";
	
	/*
	System.out.println("===========================================");
	System.out.println("vcf_path : " + vcf_path);
	System.out.println("gwas_pheno_path : " + gwas_pheno_path);
	System.out.println("outputdir : " + outputdir);
	System.out.println("script_path : " + script_path);
	System.out.println("===========================================");
	*/

	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String insertGwasinfo_sql = "insert into gwas_info_t(cropid, varietyid, status, genotype_filename, phenotype_name, model, uploadpath, resultpath,comment, jobid, creuser,cre_dt) ";
	
	if(Integer.parseInt(radio_phenotype) == 0) {
		insertGwasinfo_sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+filename_vcf+"', '"+Arrays.toString(traitname_arr).replaceAll("\\[|\\]", "")+"', '"+Arrays.toString(modelArr).replaceAll("\\[|\\]", "")+"', '"+db_savePath+"','"+db_outputPath+"','"+comment+"','"+jobid_gwas+"','"+permissionUid+"',now());";
	} else {
		insertGwasinfo_sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+filename_vcf+"', '"+phenotype+"', '"+Arrays.toString(modelArr).replaceAll("\\[|\\]", "")+"', '"+db_savePath+"','"+db_outputPath+"','"+comment+"','"+jobid_gwas+"','"+permissionUid+"',now());";
	}
	

	System.out.println("insert gwas_info_t sql : " + insertGwasinfo_sql);
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(insertGwasinfo_sql);
	} catch(Exception e) {
		System.out.println(e);
	} finally { 
		System.out.println("AAAAAAAAAAAAAAA");
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	

	
	String GwasGapit = "Rscript " +script_path+ "gwas_gapit_final.R " +vcf_path+ " " +gwas_pheno_path+ " " +outputdir+ " " +jobid_gwas+ " " +filename_vcf+ " " +jobid_gwas+"_phenotype.csv ";
	for(int i=0 ; i<modelArr.length ; i++) {
		if(i == modelArr.length - 1) {
			GwasGapit += modelArr[i];
		} else {
			GwasGapit += modelArr[i]+",";
		}
	}
	System.out.println("=========================================");
	System.out.println("Gwasgapit parameter : " + GwasGapit);
	System.out.println("=========================================");
			
	runanalysistools.execute(GwasGapit, "cmd");

%>