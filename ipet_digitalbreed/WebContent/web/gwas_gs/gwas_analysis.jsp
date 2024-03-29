<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*" %>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("variety_id");
	String jobid_gwas = request.getParameter("jobid_gwas");
	String comment = request.getParameter("comment");
	String jobid_vcf = request.getParameter("jobid_vcf");
	String filename_vcf = request.getParameter("filename_vcf");
	String[] traitname_arr = request.getParameterValues("traitname_arr[]");
	String cre_date = request.getParameter("cre_date");
	String inv_date = request.getParameter("inv_date");
	String[] model_arr = request.getParameterValues("model_arr[]");
	String phenotype = request.getParameter("phenotype");
	String radio_phenotype = request.getParameter("radio_phenotype");
	String refgenome = request.getParameter("refgenome");
	String refgenome_id = request.getParameter("refgenome_id");
	String vcfdata_no = request.getParameter("vcfdata_no");
	
	
	System.out.println("=========================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_gwas : " + jobid_gwas);
	System.out.println("comment : " + comment);
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("filename_vcf : " + filename_vcf);
	System.out.println("traitname_arr : " + Arrays.toString(traitname_arr));
	//System.out.println("traitname_seq : " + Arrays.toString(traitname_seq));
	//System.out.println("cre_date : " + cre_date);
	//System.out.println("cre_date_arr : " + Arrays.toString(cre_date_arr));
	//System.out.println("inv_date : " + inv_date);
	//System.out.println("inv_date_arr : " + Arrays.toString(inv_date_arr));
	System.out.println("modelArr : " + Arrays.toString(model_arr));
	System.out.println("radio_phenotype : " + radio_phenotype);
	System.out.println("refgenome : " + refgenome);
	System.out.println("vcfdata_no : " + vcfdata_no);
	System.out.println("=========================================");
	
	
	//String savePath = rootFolder + "uploads/database/DB_input/" + jobid + "/";
	//String outputPath = rootFolder + "result/gwas/";
	String vcf_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/database/db_input/" + jobid_vcf + "/";
	String gwas_pheno_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/gwas/";
	String outputdir = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/result/gwas/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/gwas/";
	
	
	System.out.println("===========================================");
	System.out.println("vcf_path : " + vcf_path);
	System.out.println("gwas_pheno_path : " + gwas_pheno_path);
	System.out.println("outputdir : " + outputdir);
	System.out.println("script_path : " + script_path);
	System.out.println("===========================================");
	

	
	//String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','GWAS', 'New analysis', now());";
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','GWAS', 'New analysis - "+filename_vcf+"', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	
	String insertGwasinfo_sql = "insert into gwas_info_t(cropid, varietyid, status, vcfdata_no, genotype_filename, refgenome_id, refgenome, phenotype_name, model, uploadpath, resultpath,comment, jobid, creuser,cre_dt) ";
	
	if(Integer.parseInt(radio_phenotype) == 0) {
		insertGwasinfo_sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, "+vcfdata_no+", '" +filename_vcf+ "', "+refgenome_id+", '"+refgenome+"', '"+Arrays.toString(traitname_arr).replaceAll("\\[|\\]| ", "")+"', '"+Arrays.toString(model_arr).replaceAll("\\[|\\]", "")+"', '"+db_savePath+"','"+db_outputPath+"','"+comment+"','"+jobid_gwas+"','"+permissionUid+"',now());";
	} else {
		insertGwasinfo_sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, "+vcfdata_no+", '" +filename_vcf+ "', "+refgenome_id+", '"+refgenome+"', '"+phenotype+"', '"+Arrays.toString(model_arr).replaceAll("\\[|\\]", "")+"', '"+db_savePath+"','"+db_outputPath+"','"+comment+"','"+jobid_gwas+"','"+permissionUid+"',now());";
	}
	
	System.out.println(jobid_gwas);

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
	for(int i=0 ; i<model_arr.length ; i++) {
		if(i == model_arr.length - 1) {
			GwasGapit += model_arr[i];
		} else {
			GwasGapit += model_arr[i]+",";
		}
	}
	System.out.println("=========================================");
	System.out.println("Gwasgapit parameter : " + GwasGapit);
	System.out.println("=========================================");
			
	runanalysistools.execute(GwasGapit, "cmd");

%>