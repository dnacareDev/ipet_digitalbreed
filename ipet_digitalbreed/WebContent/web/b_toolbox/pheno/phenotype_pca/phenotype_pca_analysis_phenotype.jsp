<%@page import="com.google.gson.JsonObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>
<%@page import="com.google.gson.*"%>

<%
	String varietyid = request.getParameter("varietyid");
	String jobid = request.getParameter("jobid");
	String comment = request.getParameter("comment");
	String traitname = request.getParameter("traitname");
	String seq = request.getParameter("seq");
	JsonArray phenotypeDB = new Gson().fromJson(request.getParameter("phenotypeDB"), JsonArray.class);
	
	/*
	System.out.println();
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_t_test : " + jobid_t_test);
	System.out.println("comment : " + comment);
	System.out.println("traitname : " + traitname);
	System.out.println("seq : " + seq);
	System.out.println();	
	*/

	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/phenotype_data/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pheno/phenotype_pca/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	
	
	File folder_savePath = new File(savePath+jobid);
	
	if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}

	File folder_outputPath = new File(outputPath+jobid);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	List<String> traitNames = getAllTraitNames(permissionUid, varietyid);
	
	writePhenotypeTxt(jobid, savePath, phenotypeDB, traitNames);
	
	String cmd = "Rscript " +script_path+ "Phenotype_PCA.R " +jobid+ " " +savePath+jobid+ " GS_traits.csv " +seq+ " " +outputPath;
	
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
private List<String> getAllTraitNames(String permissionUid, String varietyid) throws SQLException {


	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	List<String> traitNames = new ArrayList<>();

	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

		String cropvari_sql = "select traitname from sampledata_traitname_t where varietyid='" +varietyid+ "' and creuser='" +permissionUid+ "' order by seq asc;";
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(cropvari_sql);
		
		int i=0;
		while (ipetdigitalconndb.rs.next()) { 	
			traitNames.add(ipetdigitalconndb.rs.getString("traitname"));
		}
	}catch(Exception e){
		System.out.println(e);
	}finally { 
    	ipetdigitalconndb.stmt.close();
    	ipetdigitalconndb.rs.close();
    	ipetdigitalconndb.conn.close();
    }

	return traitNames;
}
%>

<%!
	public void writePhenotypeTxt(String jobid_t_test, String savePath, JsonArray phenotypeDB, List<String> traitNames) throws SQLException {
	
	
		try {
			File phenotypeTxt = new File(savePath+jobid_t_test+"/GS_traits.csv");
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(phenotypeTxt), "UTF-8"));
			
			int traitSize = traitNames.size();
			
			bw.write("Taxa,");
			for(int i=0 ; i<traitSize; i++) {
				//bw.write(phenotypeDB.get(0).getAsJsonObject().get("seq_"+(i+1)).getAsString());
				bw.write(traitNames.get(i));
				if(i != traitSize -1) {
					bw.write(",");
				}
			}
			bw.newLine();
			
			int sampleSize = phenotypeDB.size();
			
			for(int i=0 ; i<sampleSize ; i++) {
				bw.write(phenotypeDB.get(i).getAsJsonObject().get("samplename").getAsString()+",");
				for(int j=0 ; j<traitSize ; j++) {
					bw.write(phenotypeDB.get(i).getAsJsonObject().get("seq_"+(j+1)).getAsString());
					if(j != traitSize -1) {
						bw.write(",");
					}
				}
				if(i != sampleSize - 1) {
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