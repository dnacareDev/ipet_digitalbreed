<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>
<%@page import="com.google.gson.JsonObject, com.google.gson.JsonArray"%>

<%
	
	
	
	String varietyid = request.getParameter("varietyid");
	String jobid_t_test = request.getParameter("jobid_t_test");
	String comment = request.getParameter("comment");
	//String[] traitname = request.getParameter("traitname").split(",");
	//String[] seq = request.getParameter("seq").split(",");
	//String[] samplename = request.getParameter("samplename").split(",");
	//String[] sampleno = request.getParameter("sampleno").split(",");
	
	String traitname = request.getParameter("traitname");
	String seq = request.getParameter("seq");
	String row = request.getParameter("row");
	String samplename = request.getParameter("samplename");
	String sampleno = request.getParameter("sampleno");
	String[] traitnameArr = traitname.split(",");
	String[] seqArr = seq.split(",");
	String[] rowArr = row.split(",");
	String[] samplenameArr = samplename.split(",");
	String[] samplenoArr = sampleno.split(",");
	
	/*
	System.out.println();
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_t_test : " + jobid_t_test);
	System.out.println("comment : " + comment);
	System.out.println("traitname : " + traitname);
	System.out.println("seq : " + Arrays.toString(seq));
	System.out.println("samplename : " + samplename);
	System.out.println("sampleno : " + sampleno);
	System.out.println("row : " + row);
	System.out.println();	
	*/

	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/phenotype_data/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pheno/t-test/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	
	
	File folder_savePath = new File(savePath+jobid_t_test);
	System.out.println("folder_savePath : " + folder_savePath);
	
	if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}

	File folder_outputPath = new File(outputPath+jobid_t_test);
	System.out.println("folder_outputPath : " + folder_outputPath);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdirs(); 
	        } 
	        catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	JsonArray phenotypeDB = getAllPhenotype(permissionUid, varietyid);
	//System.out.println(phenotypeDB);
	
	List<String> traitNames = getAllTraitNames(permissionUid, varietyid);
	
	
	writePhenotypeTxt(jobid_t_test, savePath, phenotypeDB, traitNames);
	
	String cmd = "Rscript " +script_path+ "Phenotype_t-test.R " +jobid_t_test+ " " +savePath+jobid_t_test+ " GS_traits.csv ";
	cmd += row + " " +(Integer.parseInt(seq)+1) + " " + outputPath;
	
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
private JsonArray getAllPhenotype(String permissionUid, String varietyid) throws SQLException {
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	//Map<String, JsonObject> phenotypeDB = new HashMap<>();
	JsonArray phenotypeDB = new JsonArray();
	
	try {
		String sql = "select a.no, a.samplename, a.cre_dt, a.act_dt, group_concat( b.value SEPARATOR  ',' ) as val from sampledata_info_t as a inner join sampledata_traitval_t as b on a.no = b.sampleno where a.varietyid='v-00001' and a.creuser='"+ permissionUid +"' and a.varietyid='" +varietyid+ "' group by b.sampleid order by no desc;";
		//System.out.println(sql);
		
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		
		while(ipetdigitalconndb.rs.next()) {
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("no", ipetdigitalconndb.rs.getString("no"));
			jsonObject.addProperty("samplename", ipetdigitalconndb.rs.getString("samplename"));
			jsonObject.addProperty("cre_dt", ipetdigitalconndb.rs.getString("cre_dt").split(" ")[0]);
			jsonObject.addProperty("act_dt", ipetdigitalconndb.rs.getString("act_dt"));
			String[] valueArr = ipetdigitalconndb.rs.getString("val").split(",", Integer.MAX_VALUE);
			for(int i=0 ; i<valueArr.length ; i++) {
				jsonObject.addProperty("seq_"+(i+1), valueArr[i]);
			}
			//phenotypeDB.put(ipetdigitalconndb.rs.getString("no"), jsonObject);
			phenotypeDB.add(jsonObject);
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
			
			//int traitSize = phenotypeDB.get(0).getAsJsonObject().size()-4;
			
			bw.write("Taxa,");
			for(int i=0 ; i<traitNames.size() ; i++) {
				//bw.write(phenotypeDB.get(0).getAsJsonObject().get("seq_"+(i+1)).getAsString());
				bw.write(traitNames.get(i));
				if(i != traitNames.size() -1) {
					bw.write(",");
				}
			}
			bw.newLine();
			
			int sampleSize = phenotypeDB.size();
			
			for(int i=0 ; i<sampleSize ; i++) {
				bw.write(phenotypeDB.get(i).getAsJsonObject().get("samplename").getAsString()+",");
				for(int j=0 ; j<traitNames.size() ; j++) {
					bw.write(phenotypeDB.get(i).getAsJsonObject().get("seq_"+(j+1)).getAsString());
					if(j != traitNames.size() -1) {
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