<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	String permissionUid = session.getAttribute("permissionUid")+"";	
	String varietyid = request.getParameter("varietyid");

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	String deleteSql=null;
	
	String[] deleteitems = request.getParameterValues("params[]");
	
	//System.out.println(Arrays.toString(deleteitems));
	
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','Phenotype PCA', 'Delete " +deleteitems.length;
	if(deleteitems.length > 1) {
		log_sql += " rows', now());";
	} else {
		log_sql += " row', now());";
	}
	System.out.println(log_sql);
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}

	try{
		for (int i = 0; i < deleteitems.length; i++) {
			deleteSql = "delete from phenotype_pca_t where no='"+deleteitems[i]+"';";	    
		    ipetdigitalconndb.stmt.executeUpdate(deleteSql);
		}
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}	
	
%>