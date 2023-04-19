<%@page import="com.google.gson.JsonObject"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	
	String varietyid = request.getParameter("varietyid");
	String jobid = request.getParameter("jobid");
	String comment = request.getParameter("comment");
	String traitname_independent = request.getParameter("traitname_independent");
	String seq_independent = request.getParameter("seq_independent");
	String traitname_dependent = request.getParameter("traitname_dependent");
	String seq_dependent = request.getParameter("seq_dependent");
	String[] cre_date = request.getParameter("cre_date").split(" to ");
	String[] inv_date = request.getParameter("inv_date").split(" to ");
	
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
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pheno/t-test/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	
	Map<String, JsonObject> phenotypeDB = getAllPhenotype(permissionUid, cre_date, inv_date);
	
	int analysis_number = phenotypeDB.size();
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/phenotype_data/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/pheno/regression/";
	
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','Correlation Analysis', 'New analysis', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	String sql = "insert into regression_t (cropid, varietyid, status, comment, analysis_number, phenotype_independent, phenotype_dependent, uploadpath, resultpath, jobid, creuser, cre_dt) ";
	sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+comment+"', '" +analysis_number+ "', '" +traitname_independent+ "', '" +traitname_dependent+ "', '" +db_savePath+"','"+db_outputPath+"', '"+jobid+"','" +permissionUid+ "',now());";
	
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

