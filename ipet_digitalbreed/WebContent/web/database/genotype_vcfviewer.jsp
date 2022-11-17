<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	String jobid = request.getParameter("jobid");

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	
	JSONArray jsonArray = new JSONArray();
	
	try {
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		String headerSql = "select 'position', GROUP_CONCAT(distinct accession order by no SEPARATOR ';') as alleles from accession_t where jobid='" +jobid+"' order by no;";
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(headerSql);
		while(ipetdigitalconndb.rs.next()) {
			JsonObject jsonObj = new JsonObject();
			jsonObj.addProperty("column_0", ipetdigitalconndb.rs.getString("position"));
			String[] tokens = ipetdigitalconndb.rs.getString("alleles").split(";");
			for(int i=0 ; i<tokens.length ; i++) {
				jsonObj.addProperty("column_"+(i+1), tokens[i]);
			}
			jsonArray.add(jsonObj);
		}
	} catch (Exception e) {
		e.printStackTrace();
	} 
	
	List<String> chrnoList = new LinkedList<>();
	
	try {
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		String chrnoSql = "select distinct chrno from chr_pos_t order by no;";
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(chrnoSql);
		while(ipetdigitalconndb.rs.next()) {
			chrnoList.add(ipetdigitalconndb.rs.getString("chrno"));
		}
	} catch (Exception e) {
		e.printStackTrace();
	} 
	
	//System.out.println(chrnoList);
	
	for(int i=0 ; i<chrnoList.size() ; i++) {
		try {
			ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
			String sql = "select concat(chrno, '_', pos) as chrno_pos, GROUP_CONCAT(genotype order by no SEPARATOR ';') as genotype  from accession_t where jobid='" +jobid+ "' and chrno='" +chrnoList.get(i)+ "' group by pos;";
			//System.out.println("sql : " + sql);
			ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
			while(ipetdigitalconndb.rs.next()) {
				JsonObject jsonObj = new JsonObject();
				jsonObj.addProperty("column_0", ipetdigitalconndb.rs.getString("chrno_pos"));
				String[] tokens = ipetdigitalconndb.rs.getString("genotype").split(";");
				for(int j=0 ; j<tokens.length ; j++) {
					jsonObj.addProperty("column_"+(j+1), tokens[j]);
				}
				jsonArray.add(jsonObj);
			}
			
		} catch (Exception e) {
			e.printStackTrace();
		} finally {
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.rs.close();
			ipetdigitalconndb.conn.close();
		}	
	}
	
	//System.out.println(jsonArray);
	out.clear();
	out.print(jsonArray);
	
%>