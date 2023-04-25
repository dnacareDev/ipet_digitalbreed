<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@page import="com.google.gson.*"%>

<%
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String[] jobid_items = request.getParameter("jobid_items").split(",");
	String varietyid = request.getParameter("varietyid");

	//System.out.println(Arrays.toString(jobid_items));
	//System.out.println(varietyid);
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	
	String updateSql_QF = "UPDATE genotype_filter_t SET save_cmd='0'";
	String updateSql_SF = "UPDATE subset_filter_t SET save_cmd='0'";
	String updateSql_MERGE = "UPDATE vcf_file_merge_t SET save_cmd='0'";
	//String deleteSql_QF = "DELETE FROM genotype_filter_t";
	String updateSqlCondition = createSqlCondition(permissionUid, jobid_items);
	
	System.out.println(updateSqlCondition);
	
	//JsonObject jsonObject = new JsonObject();
	
	
	try{
	    int countQF = ipetdigitalconndb.stmt.executeUpdate(updateSql_QF+updateSqlCondition);
	    int countSF = ipetdigitalconndb.stmt.executeUpdate(updateSql_SF+updateSqlCondition);
	    int countMERGE = ipetdigitalconndb.stmt.executeUpdate(updateSql_MERGE+updateSqlCondition);
	    
	    //jsonObject.addProperty("qf", countQF);
	    //jsonObject.addProperty("sf", countSF);
	    //jsonObject.addProperty("merge", countMERGE);
	    //jsonObject.addProperty("total", countQF+countSF+countMERGE);
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	//out.clear();
	//out.print(jsonObject);
	
	
%>

<%!
private String createSqlCondition(String permissionUid, String[] jobid_items) {
	String sqlCondition = " WHERE (";
	
	for(int i=0 ; i<jobid_items.length ; i++) {
		sqlCondition += "jobid='"+jobid_items[i]+"'";
		if(i != jobid_items.length -1) {
			sqlCondition += " OR ";
		} else {
			sqlCondition += ")";
		}
	}
	
	sqlCondition += " AND creuser='"+permissionUid+"' AND save_cmd='1'";
	
	return sqlCondition;
	
}
%>