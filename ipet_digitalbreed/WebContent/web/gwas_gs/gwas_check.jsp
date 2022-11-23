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
	//String jobid_gwas = request.getParameter("jobid_gwas");
	String jobid_gwas = runanalysistools.getCurrentDateTime();
	String comment = request.getParameter("comment");
	String jobid_vcf = request.getParameter("jobid_vcf");
	String filename_vcf = request.getParameter("filename_vcf");
	//String traitname = request.getParameter("traitname");
	String[] traitname_arr = request.getParameterValues("traitname_arr");
	String traitname_key = request.getParameter("traitname_key_arr"); 
	String[] traitname_key_arr = traitname_key.replaceAll("\\[|\\]", "").split(",");
	String cre_date = request.getParameter("cre_date");
	String inv_date = request.getParameter("inv_date");
	String[] modelArr = request.getParameterValues("modelGroup");
	
	String[] cre_date_arr = cre_date.split(" to ");
	String[] inv_date_arr = inv_date.split(" to ");
	
	
	System.out.println("=========================================");
	System.out.println("permissionUid : " + permissionUid);
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_gwas : " + jobid_gwas);
	System.out.println("comment : " + comment);
	System.out.println("jobid_vcf : " + jobid_vcf);
	System.out.println("filename_vcf : " + filename_vcf);
	//System.out.println("traitname : " + traitname);
	System.out.println("traitname_arr : " + Arrays.toString(traitname_arr));
	System.out.println("traitname_key_arr : " + Arrays.toString(traitname_key_arr));
	//System.out.println("cre_date : " + cre_date);
	System.out.println("cre_date_arr : " + Arrays.toString(cre_date_arr));
	//System.out.println("inv_date : " + inv_date);
	System.out.println("inv_date_arr : " + Arrays.toString(inv_date_arr));
	System.out.println("modelArr : " + Arrays.toString(modelArr));
	System.out.println("=========================================");

	
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
	
	
	
	File folder_pheno_path = new File(gwas_pheno_path+jobid_gwas);

	if (!folder_pheno_path.exists()) {
	try{
		folder_pheno_path.mkdir(); 
        } 
        catch(Exception e){
	    e.getStackTrace();
		}        
	}
	
	File file = new File(gwas_pheno_path+"/"+jobid_gwas+"/"+jobid_gwas+"_phenotype.csv");
	
	file.createNewFile();
	
	
	BufferedWriter fw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(file), "utf-8"));
	//FileWriter fw = new FileWriter(file, true) ;
	
	int traitcnt = 0;
	String traitname_sql=null;
	try{		
		traitname_sql = "select traitname from sampledata_traitname_t where varietyid='"+varietyid+"' order by seq asc;";	
		System.out.println(traitname_sql);
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(traitname_sql);		    
				
		fw.write("Taxa"+",");

		while (ipetdigitalconndb.rs.next()) {
			if(Arrays.asList(traitname_key_arr).contains(traitcnt+"")) {
				//System.out.println(ipetdigitalconndb.rs.getString("traitname"));
				
				if((traitcnt+"").equals(traitname_key_arr[traitname_key_arr.length-1])) {
					fw.write(ipetdigitalconndb.rs.getString("traitname"));
				} else {
					fw.write(ipetdigitalconndb.rs.getString("traitname")+",");
				}
			}
			
			//fw.write(ipetdigitalconndb.rs.getString("traitname")+",");		
			traitcnt++;
		}	  	 
		fw.write("\n");
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.rs.close();
	}
	
	
	ArrayList<String> fullsamplename = new ArrayList<>();
	ArrayList<String> fulltraitval = new ArrayList<>();
	try {
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		//String sql = "select no, cropid, varietyid, sampleid, samplename, photo_status, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt from sampledata_info_t where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' order by no desc;";
		//String sql = "select sampleid, samplename from sampledata_info_t where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' ";
		String sql = "select i.samplename, group_concat( v.value SEPARATOR  ',' ) as val from sampledata_info_t i inner join sampledata_traitval_t v on i.sampleid = v.sampleid where i.creuser = '" +permissionUid+ "' and i.varietyid='"+varietyid+"' ";
		
		if(cre_date_arr.length == 2) {
			sql += "and date(DATE_FORMAT(i.cre_dt, '%Y-%m-%d')) between '" +cre_date_arr[0]+ "' and '" +cre_date_arr[1]+ "' ";
		} else if(cre_date_arr.length == 1 && cre_date_arr[0] != "") {
			sql += "and date(DATE_FORMAT(i.cre_dt, '%Y-%m-%d')) = '" +cre_date_arr[0] + "' ";
		}
		
		if(inv_date_arr.length == 2) {
			sql += "and date(DATE_FORMAT(i.act_dt, '%Y-%m-%d')) between '" +inv_date_arr[0]+ "' and '" +inv_date_arr[1]+ "' ";
		} else if(inv_date_arr.length == 1 && inv_date_arr[0] != "") {
			sql += "and date(DATE_FORMAT(i.act_dt, '%Y-%m-%d')) = '" +inv_date_arr[0] + "' ";
		}
		
		sql += "group by v.sampleid order by i.no asc;";
		
		System.out.println("sql : " + sql);
		
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		
		while (ipetdigitalconndb.rs.next()) {
			fullsamplename.add(ipetdigitalconndb.rs.getString("samplename"));
	  		fulltraitval.add(ipetdigitalconndb.rs.getString("val"));
		}
	}catch(Exception e){
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		//ipetdigitalconndb.conn.close();
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		//ipetdigitalconndb.conn.close();
	}
	
	
	try {
		System.out.println("fullsamplename : " + fullsamplename);
		System.out.println("fulltraitval : " + fulltraitval);
		for(int i=0;i<fullsamplename.size();i++) {
	  		fw.write(fullsamplename.get(i)+",");
			//System.out.println("i : " + i);
			
			String[] traitVal = fulltraitval.get(i).split(",");
			for(int j=0 ; j<traitVal.length ; j++) {
				
				//System.out.println(Arrays.toString(traitname_key_arr));
				//System.out.println(j+"");
				
				if(Arrays.asList(traitname_key_arr).contains( Integer.toString(j)+"")) {
					//System.out.println("j : " + j);
					//System.out.print(traitVal[j] + " ");
					if( (j+"").equals(traitname_key_arr[traitname_key_arr.length -1])) {
						fw.write(traitVal[j]);
					} else {
						fw.write(traitVal[j]+",");
					}
				}
			}
			fw.write("\n");
			//System.out.println();
			
	  		//fw.write(fulltraitval.get(i)+",");
			//fw.write("\n");
		}	
	} catch (Exception e) {
		e.printStackTrace();
	}
  	
	
	fw.flush();	
	fw.close();
	
	/* 
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String insertGwasinfo_sql = "insert into gwas_info_t(cropid, varietyid, status, genotype_filename, phenotype_name, model, uploadpath, resultpath,comment, jobid, creuser,cre_dt) ";
	insertGwasinfo_sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+filename_vcf+"', '"+Arrays.toString(traitname_arr).replaceAll("\\[|\\]", "")+"', '"+Arrays.toString(modelArr).replaceAll("\\[|\\]", "")+"', '"+db_savePath+"','"+db_outputPath+"','"+comment+"','"+jobid_gwas+"','"+permissionUid+"',now());";

	
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
	*/
	
	File folder_outputdir = new File(outputdir+jobid_gwas);

	if (!folder_outputdir.exists()) {
	try{
		folder_outputdir.mkdir(); 
        } 
        catch(Exception e){
	    e.getStackTrace();
		}        
	}
	
	String Gwas = "Rscript " +script_path+ "gwas_samplecheck_final.R " +vcf_path+ " " +gwas_pheno_path+ " " +outputdir+ " " +jobid_gwas+ " " +filename_vcf+ " " +jobid_gwas+"_phenotype.csv";
	System.out.println("===========================================");
	System.out.println("Gwas parameter : " + Gwas);
	System.out.println("===========================================");
	runanalysistools.execute(Gwas, "cmd");

	try {
		BufferedReader reader = new BufferedReader(new FileReader(outputdir+jobid_gwas+"/"+jobid_gwas+"_samplecheck.txt"));
		out.clear();
		String str;
		boolean first_line = true;
		while((str = reader.readLine()) != null) {
			if(first_line) {
				first_line = false;
				continue;
			}
			//System.out.println(str);
			out.print(str+",");
		}
		reader.close();	
	} catch(IOException e) {
		e.printStackTrace();
	}
	
	out.print(jobid_gwas);
%>