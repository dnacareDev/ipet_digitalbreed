<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>    
<%
	//IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	//ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
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
	System.out.println("gs params : " + sb);
	
	JsonObject jsonObject = new Gson().fromJson(sb.toString(), JsonObject.class);
	String variety_id = jsonObject.get("variety_id").getAsString();
	String comment = jsonObject.get("comment").getAsString();
	String jobid_gs = jsonObject.get("jobid_gs").getAsString();
	String jobid_training_vcf = jsonObject.get("jobid_training_vcf").getAsString();
	String filename_training_vcf = jsonObject.get("filename_training_vcf").getAsString();
	int radio_phenotype = jsonObject.get("radio_phenotype").getAsInt();
	String traitname_keys = jsonObject.get("traitname_keys").getAsString();
	String jobid_prediction_vcf = jsonObject.get("jobid_prediction_vcf").getAsString();
	String filename_prediction_vcf = jsonObject.get("filename_prediction_vcf").getAsString();
	String model_keys = jsonObject.get("model_keys").getAsString();
	String cre_date = jsonObject.get("cre_date").getAsString();
	String inv_date = jsonObject.get("inv_date").getAsString();
	String MAXNA = jsonObject.get("MAXNA").getAsString();
	String MAF = jsonObject.get("MAF").getAsString();
	boolean LD_checked = jsonObject.get("LD_checked").getAsBoolean();
	String LD = jsonObject.get("LD").getAsString();
	boolean ANO_checked = jsonObject.get("ANO_checked").getAsBoolean();
	String ANO = jsonObject.get("ANO").getAsString();
	String nFolds = jsonObject.get("nFolds").getAsString();
	String nTimes = jsonObject.get("nTimes").getAsString();
	
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	String VcfPath = rootFolder + "uploads/database/db_input/";
	//String phenotypePath = rootFolder + "/uploads/GS/"+jobid_gs+"/train_pheno_1-9.txt";
	String phenotypePath = rootFolder + "/uploads/GS/Pheno/"+jobid_gs+"/";
	String outputPath = rootFolder + "result/GS/"+jobid_gs+"/";
	
	
	File folder_phenotypePath = new File(phenotypePath);
	if (!folder_phenotypePath.exists()) {
		try {
			folder_phenotypePath.mkdirs(); 
	    } catch(Exception e){
		    e.getStackTrace();
		    e.toString();
		    System.out.println("mkdir fail - folder_phenotypePath");
		}        
	}
	System.out.println("phenotypePath : " + phenotypePath);
	
	File folder_outputPath = new File(outputPath);
	System.out.println("outputPath : " + outputPath);
	if (!folder_outputPath.exists()) {
		try {
			folder_outputPath.mkdirs(); 
	    } catch(Exception e){
		    e.getStackTrace();
		    e.toString();
		    System.out.println("mkdir fail - folder_outputPath");
		}       
		
	}
	
	writePhenotypeTxt(permissionUid, variety_id, phenotypePath, cre_date, inv_date);
	
	String vcf_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/database/db_input/" + jobid_training_vcf + "/";
	String gs_pheno_path = "/data/apache-tomcat-9.0.64/webapps/ipet_digitalbreed/uploads/GS/Pheno/";
	String outputdir = rootFolder + "/result/GS/";
	
	String cmd = "Rscript " +script_path+ "gwas_samplecheck_final.R " +vcf_path+ " " +gs_pheno_path+ " " +outputdir+ " " +jobid_gs+ " " +filename_training_vcf+ " " +"GS_trait.csv";
	System.out.println("===========================================");
	System.out.println("GS parameter : " + cmd);
	System.out.println("===========================================");
	runanalysistools.execute(cmd, "cmd");
	
	try {
		BufferedReader reader = new BufferedReader(new FileReader(outputdir+jobid_gs+"/"+jobid_gs+"_samplecheck.txt"));
		String line_br = reader.readLine();
		out.clear();
		out.print(line_br);
		reader.close();
		
		/*
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
		*/
	} catch(IOException e) {
		e.printStackTrace();
	}
	
%>

<%!
	public void writePhenotypeTxt(String permissionUid, String variety_id, String phenotypePath, String cre_date, String inv_date) throws SQLException {
	
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		
		try {
			File phenotypeTxt = new File(phenotypePath+"GS_trait.csv");
			BufferedWriter bw = new BufferedWriter(new FileWriter(phenotypeTxt));
			//BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(phenotypeTxt), "UTF-8"));
			//BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(phenotypeTxt), "EUC-KR"));
			//System.out.println(phenotypeTxt);
			
			
			//List<String> phenotype_traitname = new ArrayList<>();
			try {
				//String sql = "select * from sampledata_traitname_t where varietyid='"+ variety_id +"' and creuser ='"+ permissionUid +"';";
				String sql = "select * from sampledata_traitname_t where varietyid='"+ variety_id +"' and creuser ='"+ permissionUid +"';";
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
				//while (ipetdigitalconndb.rs.next()) {
				if(ipetdigitalconndb.rs.next()) {
					bw.write("Taxa,");
					while (true) {
						bw.write(ipetdigitalconndb.rs.getString("traitname"));
						if(ipetdigitalconndb.rs.next()) {
							bw.write(",");
						} else {
							break;
						}
					}
				}
				
			} catch (SQLException e) {
				e.getMessage();
				System.out.println("SQL exception - GS");
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				ipetdigitalconndb.conn.close();
			} 
			
			try {
				//String sql = "select a.cre_dt, a.act_dt, group_concat( b.value SEPARATOR  ',' ) as val from sampledata_info_t a";
				String sql = "select a.samplename, group_concat( b.value SEPARATOR  ',' ) as val from sampledata_info_t a";
				sql += " inner join sampledata_traitval_t b on a.sampleid=b.sampleid";
				sql += " where b.sampleid like '%s-%' and a.varietyid='"+ variety_id +"' and a.creuser ='"+ permissionUid +"'";
				if(!cre_date.isEmpty()) {
					sql += " and a.cre_dt between '"+ cre_date.split(" to ")[0] +"' and '"+ cre_date.split(" to ")[1] +"'"; 
				}
				if(!inv_date.isEmpty()) {
					sql += " and a.act_dt between '"+ inv_date.split(" to ")[0] +"' and '"+ inv_date.split(" to ")[1] +"'"; 
				}
				sql += " group by b.sampleid order by b.sampleid desc;";
				
				//String sql = "SELECT group_concat( value SEPARATOR  ',' ) as val FROM sampledata_traitval_t where sampleid like '%s-000%' and varietyid='"+ variety_id +"' and creuser='"+ permissionUid +"' GROUP BY sampleid order by sampleid desc;";
				System.out.println(sql);
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
				if(ipetdigitalconndb.rs.next()) {
					
					bw.newLine();
					
					while (true) {
						//phenotype_traitname.add(ipetdigitalconndb.rs.getString("traitname"));
						//bw.write(ipetdigitalconndb.rs.getString("val").replaceAll(",", "\t"));
						bw.write(ipetdigitalconndb.rs.getString("samplename")+",");
						bw.write(ipetdigitalconndb.rs.getString("val"));
						if(ipetdigitalconndb.rs.next()) {
							bw.newLine();
						} else {
							break;
						}
					}
				}
			} catch (SQLException e) {
				e.getMessage();
				System.out.println("SQL exception - GS");
			} finally {
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				ipetdigitalconndb.conn.close();
			}
			
			bw.flush();
			bw.close();
		} catch (IOException e) {
			e.getMessage();
			System.out.println("error - bufferedWriter | GS");
		}
	}
%>