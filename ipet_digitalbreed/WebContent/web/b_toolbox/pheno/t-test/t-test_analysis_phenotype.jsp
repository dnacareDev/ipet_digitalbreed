<%@page import="com.google.gson.JsonObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

<%
	
	
	
	String varietyid = request.getParameter("varietyid");
	String jobid_t_test = request.getParameter("jobid_t_test");
	String comment = request.getParameter("comment");
	//String[] traitname = request.getParameter("traitname").split(",");
	//String[] seq = request.getParameter("seq").split(",");
	String traitname = request.getParameter("traitname");
	String seq = request.getParameter("seq");
	String[] traitnameArr = traitname.split(",");
	String[] seqArr = seq.split(",");
	String[] cre_date = request.getParameter("cre_date").split(" to ");
	String[] inv_date = request.getParameter("inv_date").split(" to ");
	
	/*
	System.out.println();
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_t_test : " + jobid_t_test);
	System.out.println("comment : " + comment);
	System.out.println("traitname : " + traitname);
	System.out.println("seq : " + Arrays.toString(seq));
	System.out.println("samplename : " + Arrays.toString(samplename));
	System.out.println("sampleno : " + Arrays.toString(sampleno));
	System.out.println();	
	*/

	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/phenotype_data/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pheno/t-test/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	
	
	File folder_savePath = new File(savePath+jobid_t_test);
	
	if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}

	File folder_outputPath = new File(outputPath+jobid_t_test);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	Map<String, JsonObject> phenotypeDB = getAllPhenotype(permissionUid, cre_date, inv_date);
	
	//System.out.println(phenotypeDB);
	//System.out.println(phenotypeDB.get("1209"));
	
	//writePhenotypeTxt(jobid_t_test, savePath, phenotypeDB, traitname, seq);
	writePhenotypeTxt(jobid_t_test, savePath, phenotypeDB, traitnameArr, seqArr);
	
	String cmd = "Rscript " +script_path+ "Phenotype_t-test.R " +jobid_t_test+ " " +savePath+jobid_t_test+ " GS_traits.csv ";
	
	for(int i=1 ; i<=phenotypeDB.size() ; i++) {
		cmd += i;
		if(i == phenotypeDB.size()) {
			cmd +=" ";
		} else {
			cmd +=",";
		}
	}
	
	System.out.println("cmd : " + cmd);
			
	
	CommandLine cmdLine = CommandLine.parse(cmd);
	DefaultExecutor executor = new DefaultExecutor();
	executor.setExitValue(0);
	int exitValue = executor.execute(cmdLine);
	if(exitValue == 0) {
		System.out.println("Success");
	} else {
		System.out.println("Fail");
	}
	/*
	*/
	
%>

<%!
private Map<String, JsonObject> getAllPhenotype(String permissionUid, String[] cre_date, String[] inv_date) throws SQLException {
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	Map<String, JsonObject> phenotypeDB = new LinkedHashMap<>();
	
	try {
		String sql = "select a.no, a.samplename, a.cre_dt, a.act_dt, group_concat( b.value SEPARATOR  ',' ) as val from sampledata_info_t as a inner join sampledata_traitval_t as b on a.no = b.sampleno where a.varietyid='v-00001'";
		
		if(cre_date.length == 2) {
			sql += " and a.cre_dt between '"+ cre_date[0] +"' and '"+ cre_date[1] +"'"; 
		} else if(!cre_date[0].isEmpty()) {
			sql += " and DATE(a.cre_dt) = '"+ cre_date[0] +"'";
		}
		
		if(inv_date.length == 2) {
			sql += " and a.act_dt between '"+ inv_date[0] +"' and '"+ inv_date[1] +"'"; 
		} else if(!inv_date[0].isEmpty()) {
			sql += " and DATE(a.act_dt) = '"+ inv_date[0] +"'";
		}
		
		sql += " and a.creuser='"+ permissionUid +"' group by b.sampleid order by b.sampleid desc;";
		
		System.out.println(sql);
		
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		
		while(ipetdigitalconndb.rs.next()) {
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("samplename", ipetdigitalconndb.rs.getString("samplename"));
			jsonObject.addProperty("cre_dt", ipetdigitalconndb.rs.getString("cre_dt").split(" ")[0]);
			jsonObject.addProperty("act_dt", ipetdigitalconndb.rs.getString("act_dt"));
			String[] valueArr = ipetdigitalconndb.rs.getString("val").split(",", Integer.MAX_VALUE);
			for(int i=0 ; i<valueArr.length ; i++) {
				jsonObject.addProperty("seq_"+(i+1), valueArr[i]);
			}
			phenotypeDB.put(ipetdigitalconndb.rs.getString("no"), jsonObject);
		}
		
	} catch(SQLException e) {
		e.getStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	return phenotypeDB;
}
%>

<%!
	public void writePhenotypeTxt(String jobid_t_test, String savePath, Map<String, JsonObject> phenotypeDB, String[] traitnameArr, String[] seqArr) throws SQLException {
		
		try {
			File phenotypeTxt = new File(savePath+jobid_t_test+"/GS_trait.csv");
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(phenotypeTxt), "UTF-8"));
			
			bw.write("Taxa,");
			for(int i=0 ; i<traitnameArr.length ; i++) {
				bw.write(traitnameArr[i]);
				if(i != traitnameArr.length -1) {
					bw.write(",");
				}
			}
			bw.newLine();
			
			/*
			for(int i=0 ; i<sampleno.length ; i++) {
				System.out.println(phenotypeDB.get(sampleno[i]));
				//System.out.println(phenotypeDB.get(sampleno[i]).get("samplename"));
				bw.write(phenotypeDB.get(sampleno[i]).get("samplename").getAsString()+",");
				for(int j=0 ; j<seq.length ; j++) {
					bw.write(phenotypeDB.get(sampleno[i]).get("seq_"+seq[j]).getAsString());
					if(j != seq.length -1) {
						bw.write(",");
					}
				}
				bw.newLine();
			}
			*/
			
			Iterator<String> iterator = phenotypeDB.keySet().iterator();
			
			while(iterator.hasNext()) {
				String key = iterator.next();
			    
		    	bw.write(phenotypeDB.get(key).get("samplename").getAsString()+",");
				for(int j=0 ; j<seqArr.length ; j++) {
					bw.write(phenotypeDB.get(key).get("seq_"+seqArr[j]).getAsString());
					if(j != seqArr.length -1) {
						bw.write(",");
					}
				}
				if(iterator.hasNext()) {
					bw.newLine();
				}
			}
			
			bw.flush();
			bw.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
	}
%>