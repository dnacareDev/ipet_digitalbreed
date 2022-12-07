<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="ipet_digitalbreed.*"%>
<%@ page import="java.util.*"%>      
<%@ page import="org.json.simple.*, org.json.simple.parser.*, com.google.gson.*" %>    
<%
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();

		String varietyid = request.getParameter("varietyid");
		
		JSONArray jsonArray = new JSONArray();
		

		try{
			ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

			String cropvari_sql = "select traitname from sampledata_traitname_t where varietyid='" +varietyid+ "' order by seq asc;";
			System.out.println("cropvari_sql : " + cropvari_sql);
			ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(cropvari_sql);
			
			int i=0;
			while (ipetdigitalconndb.rs.next()) { 	
				JsonObject jsonObj = new JsonObject();
				jsonObj.addProperty("traitname", ipetdigitalconndb.rs.getString("traitname"));
				jsonObj.addProperty("traitname_key", i++);
				jsonArray.add(jsonObj);
			}
		}catch(Exception e){
			System.out.println(e);
		}finally { 
       		ipetdigitalconndb.stmt.close();
       		ipetdigitalconndb.rs.close();
       		ipetdigitalconndb.conn.close();
       	}
		
		out.clear();
		out.print(jsonArray);
		
		/*
		JSONArray jsonArray = new JSONArray();
		
		//String cropvari_sql = "select seq, traitname, varietyid from sampledata_traitname_t where varietyid='" +varietyid+ "' order by seq asc;";
		String cropvari_sql = "select traitname from sampledata_traitname_t where varietyid='" +varietyid+ "' order by seq asc;";
		try{
			ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
				
			System.out.println("cropvari_sql : " + cropvari_sql);
				
			ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(cropvari_sql);
			while (ipetdigitalconndb.rs.next()) { 	
				jsonArray.add(ipetdigitalconndb.rs.getString("traitname"));
			}
			
		}catch(Exception e){
			System.out.println(e);
		}finally { 
       		ipetdigitalconndb.stmt.close();
       		ipetdigitalconndb.rs.close();
       		ipetdigitalconndb.conn.close();
       	}
		 
		//System.out.println(jsonArray);
		out.clear();
		out.print(jsonArray);
		*/
%>