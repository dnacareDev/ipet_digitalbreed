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
	String traitname = request.getParameter("traitname");
	String seq = request.getParameter("seq");
	String[] samplename = request.getParameter("samplename").split(",");
	String[] sampleno = request.getParameter("sampleno").split(",");
	
	
	System.out.println();
	System.out.println("varietyid : " + varietyid);
	System.out.println("jobid_t_test : " + jobid_t_test);
	System.out.println("comment : " + comment);
	System.out.println("traitname : " + traitname);
	System.out.println("seq : " + seq);
	System.out.println("samplename : " + Arrays.toString(samplename));
	System.out.println("sampleno : " + Arrays.toString(sampleno));
	System.out.println();	
	

	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/db_input/phenotype_data/";
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
	//writePhenotypeTxt(permissionUid, varietyid, sampleno, seq);
	
	/*
	String cmd = "Rscript " +script_path+ "breedertoolbox_annotation.R " +savePath+ " " +outputPath+ " " +jobid_anno +" "+ filename +" "+ annotationPath +" "+ annotation_filename;
	
	System.out.println("annotation parameter : " + cmd);
			
	
	CommandLine cmdLine = CommandLine.parse(cmd);
	DefaultExecutor executor = new DefaultExecutor();
	executor.setExitValue(0);
	int exitValue = executor.execute(cmdLine);
	if(exitValue == 0) {
		System.out.println("Success");
	} else {
		System.out.println("Fail");
	}
	*/
	
%>

<%!
	public void writePhenotypeTxt(String permissionUid, String varietyid, String[] sampleno, String seq) throws SQLException {
		
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		try {
			//String sql = "select b.value from sampledata_info_t as a inner join sampledata_traitval_t as b on a.no = b.sampleno where a.varietyid='v-00001' and a.no=1252 and b.seq=1;";
			String sql = "select b.value from sampledata_info_t as a inner join sampledata_traitval_t as b on a.no = b.sampleno where a.varietyid='v-00001' and ";
			//a.no=1252 and b.seq=1;";
			
			for(int i=0 ; i<sampleno.length ; i++) {
				sql += "a.no="+sampleno[i]+" ";
			}
			
			ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		} catch(SQLException e) {
			e.getStackTrace();
		} finally {
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.rs.close();
			ipetdigitalconndb.conn.close();
		}
	
		/*
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		try {
			File phenotypeTxt = new File(phenotypePath+"GS_trait.csv");
			//BufferedWriter bw = new BufferedWriter(new FileWriter(phenotypeTxt));
			BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(phenotypeTxt), "UTF-8"));
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
		*/
	}
%>