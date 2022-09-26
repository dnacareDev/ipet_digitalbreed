<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<%@ page import="ipet_digitalbreed.*"%>
<%@ page import="java.util.*"%>      
<%@ page import="org.json.simple.*"%>      
  
<%
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();

		String varietyid = request.getParameter("varietyid");
		JSONArray jsonArray = new JSONArray();
		String cropvari_sql = "select seq, traitname, varietyid from sampledata_traitname_t where varietyid='"+varietyid+"' order by seq asc;";
		 try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(cropvari_sql);
				
				while (ipetdigitalconndb.rs.next()) { 	
					JSONObject jsonObject = new JSONObject();				
					jsonObject.put(ipetdigitalconndb.rs.getString("seq")+"_"+ipetdigitalconndb.rs.getString("varietyid"),ipetdigitalconndb.rs.getString("traitname"));
					jsonArray.add(jsonObject);
				}
				
			}catch(Exception e){
				System.out.println(e);
			}finally { 
        		ipetdigitalconndb.stmt.close();
        		ipetdigitalconndb.rs.close();
        		ipetdigitalconndb.conn.close();
        	}
		 out.println(jsonArray);
%>

					