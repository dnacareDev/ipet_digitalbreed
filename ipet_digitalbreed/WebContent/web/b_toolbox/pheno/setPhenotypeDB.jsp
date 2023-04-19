<%@page import="com.google.gson.JsonObject, com.google.gson.JsonArray"%>
<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>

<%
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
	
	
	JsonArray phenotypeDB = getAllPhenotype(permissionUid, cre_date, inv_date);
	
	//int analysis_number = phenotypeDB.size();
	out.clear();
	out.print(phenotypeDB);
	
%>

<%!
private JsonArray getAllPhenotype(String permissionUid, String[] cre_date, String[] inv_date) throws SQLException {
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	JsonArray phenotypeDB = new JsonArray();
	
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
		
		//System.out.println(sql);
		
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		
		for(int i=1 ; ipetdigitalconndb.rs.next() ; i++) {
			
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("row", i);
			jsonObject.addProperty("samplename", ipetdigitalconndb.rs.getString("samplename"));
			jsonObject.addProperty("cre_dt", ipetdigitalconndb.rs.getString("cre_dt").split(" ")[0]);
			jsonObject.addProperty("act_dt", ipetdigitalconndb.rs.getString("act_dt"));
			String[] valueArr = ipetdigitalconndb.rs.getString("val").split(",", Integer.MAX_VALUE);
			for(int j=0 ; j<valueArr.length ; j++) {
				jsonObject.addProperty("seq_"+(j+1), valueArr[j]);
			}
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

