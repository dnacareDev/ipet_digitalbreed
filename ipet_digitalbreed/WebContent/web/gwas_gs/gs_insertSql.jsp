<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*" %>
<%@ page import="ipet_digitalbreed.*"%>
<%@ page import="com.google.gson.*" %>
    
<%

	request.setCharacterEncoding("UTF-8");

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	StringBuilder sb = new StringBuilder();
	String line = null;
	try {
		BufferedReader br = request.getReader();
		while ((line = br.readLine()) != null) {
			sb.append(line);
		}
	} catch (Exception e) {
		e.printStackTrace();
	}
	
	System.out.println(sb);
	JsonObject jsonObject = new Gson().fromJson(sb.toString(), JsonObject.class);
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String variety_id = jsonObject.get("variety_id").getAsString();
	String comment = jsonObject.get("comment").getAsString();
	String jobid_gs = jsonObject.get("jobid_gs").getAsString();
	String jobid_training_vcf = jsonObject.get("jobid_training_vcf").getAsString();
	String filename_training_vcf = jsonObject.get("filename_training_vcf").getAsString();
	int radio_phenotype = jsonObject.get("radio_phenotype").getAsInt();
	String traitname = "";
	//String traitname = jsonObject.get("traitname").getAsString();
	String traitname_keys = jsonObject.get("traitname_keys").getAsString();
	String jobid_prediction_vcf = jsonObject.get("jobid_prediction_vcf").getAsString();
	String filename_prediction_vcf = jsonObject.get("filename_prediction_vcf").getAsString();
	//System.out.println(enzymes);
	
	/*
	System.out.println("=========================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("varietyid : " + varietyid);
	System.out.println("vcf_filename : " + vcf_filename);
	System.out.println("marker_category : " + marker_category);
	System.out.println("jobid_pd : " + jobid_pd);
	System.out.println("=========================================");
	*/
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/db_input/";
	String db_outputPath = "/ipet_digitalbreed/result/GS/";
	/*
	System.out.println("===========================================");
	System.out.println("outputdir : " + db_savePath);
	System.out.println("script_path : " + db_outputPath);
	System.out.println("===========================================");
	*/
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String phenotypePath = rootFolder + "/uploads/GS/Pheno/"+jobid_gs+"/";
	
	if(radio_phenotype == 0 ) {
		traitname = jsonObject.get("traitname").getAsString();
	} else {
		traitname = readPhenotypeTxt(phenotypePath);
	}
	
	
	//String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+variety_id+"'),'"+variety_id+"','Genomic Selection', 'New analysis', now());";
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+variety_id+"'),'"+variety_id+"','Genomic Selection', 'New analysis - "+filename_training_vcf+"', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	String sql = "insert into genomic_selection_t (cropid, varietyid, status, phenotype, training_genotype, prediction_genotype, comment, uploadpath, resultpath, jobid, creuser, cre_dt) ";
	//sql += "values((select cropid from variety_t where varietyid='"+variety_id+"'), '"+variety_id+"', 0, '"+ traitname +"', '"+  filename_training_vcf+"', '"+ filename_prediction_vcf +"', '" +comment+ "', '"  +db_savePath+"','"+db_outputPath+"', '"+jobid_gs+"','" +permissionUid+ "',now());";
	sql += "values((select cropid from variety_t where varietyid='"+variety_id+"'), '"+variety_id+"', 0, '"+ traitname +"', '"+  filename_training_vcf+"', '"+ filename_prediction_vcf +"', '" +comment+ "', '"  +db_savePath+"','"+db_outputPath+"', '"+jobid_gs+"','" +permissionUid+ "',now());";

	
	System.out.println("sql : " + sql);
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(sql);
	} catch(Exception e) {
		System.out.println(e);
	} finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}

%>

<%! 
	public String readPhenotypeTxt(String phenotypePath) throws IOException {
	
	File file = new File(phenotypePath+"GS_trait.csv");
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
	
	String line = br.readLine();
	String[] columns = line.split(",");
	
	String traitname = "";
	for(int i=1 ; i<columns.length ; i++) {
		//System.out.println(i);
		traitname += columns[i];
		if(i != columns.length -1) {
			traitname += ",";
		}
	}
	
	br.close();
	
	return traitname;
}
%>