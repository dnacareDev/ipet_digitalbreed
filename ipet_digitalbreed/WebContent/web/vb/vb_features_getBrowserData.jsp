<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String chr = request.getParameter("chr");
	//String position = request.getParameter("position");
	int position = Integer.parseInt(request.getParameter("position"));
	String jobid = request.getParameter("jobid");
	
	//System.out.println(chr);
	//System.out.println(position);
	//System.out.println(jobid);

	if( !(jobid.equals("20230112165422") || jobid.equals("20230111165341")) ) {
		System.out.println("현재 jobid = 20230112165422 만 적용 (양배추 품종 - Final.merge.PKH.recode.vcf)");
		return;
	}
	
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	JsonArray jsonArray = new JsonArray();
	List<String> keyList = new ArrayList<>();
	
	List<String> columnList = new ArrayList<>();
	
	try {
		
		String sql = "select * from vcfviewer_t where position >= " + (position-50000) + " and position <= " +(position+50000)+ " and chr=" +chr+ " and jobid ='" +jobid+ "';";
		System.out.println(sql);
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		
		for(int i=0 ; ipetdigitalconndb.rs.next() ; i++) {
			JsonObject jsonObject = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
			//jsonObject.addProperty("chr", ipetdigitalconndb.rs.getInt("chr"));
			//jsonObject.addProperty("position", ipetdigitalconndb.rs.getInt("position"));
			//System.out.println(jsonObject);
			
			if(i == 0) {
				//keyList = new ArrayList<>(jsonObject.keySet());
				keyList.addAll(jsonObject.keySet());
			}
			
			columnList.add(i, ipetdigitalconndb.rs.getString("position"));
			
			jsonArray.add(jsonObject);
		}
		
		//out.clear();
		//out.print(jsonArray);
		
	} catch (SQLException e) {
		System.out.println("error - vb_features_getBrowserData - " + e);
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	//System.out.println(jsonArray);
	
	JsonArray varintBrowserArray = inversion(keyList, columnList, jsonArray);
	
	//System.out.println("varintBrowserArray : " + varintBrowserArray);
	
	out.clear();
	out.print(varintBrowserArray);
%>

<%! 
	public JsonArray inversion(List<String> keyList, List<String> columnList, JsonArray jsonArray) {
	
		//System.out.println("keyList : " + keyList);
		//System.out.println("columnList : " + columnList);
		//System.out.println("jsonArray : " + jsonArray.get(0));
		
		JsonArray varintBrowserArray = new JsonArray();
		
		for(int i=1 ; i<keyList.size() ; i++) {
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("id", keyList.get(i));
			for(int j=0 ; j<columnList.size() ; j++) {
				jsonObject.addProperty(columnList.get(j), jsonArray.get(j).getAsJsonObject().get(keyList.get(i)).getAsString());
			}
			varintBrowserArray.add(jsonObject);
		}
		
		return varintBrowserArray;
	}
%>