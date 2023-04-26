<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String chr = request.getParameter("chr");
	//String position = request.getParameter("position");
	//int position = Integer.parseInt(request.getParameter("position"));
	String jobid = request.getParameter("jobid");
	int vcf_id = Integer.parseInt(request.getParameter("vcf_id"));
	
	//System.out.println(chr);
	//System.out.println(position);
	//System.out.println(jobid);
	//System.out.println(vcf_id);

	if(chr.isEmpty() || chr == null || jobid.isEmpty() || jobid == null || request.getParameter("vcf_id").isEmpty() ) {
		return;
	}
	
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	JsonArray jsonArray = new JsonArray();
	List<String> keyList = new ArrayList<>();
	
	List<String> columnList = new ArrayList<>();
	
	//long beforeTime = System.currentTimeMillis();
	try {
		
	
		//String sql = "select * from vcfviewer_t where vcf_id<"+(vcf_id+45)+" and vcf_id>="+(vcf_id)+ " and chr='" +chr+ "' and jobid ='" +jobid+ "';";
		//String sql = "select * from vcfviewer_t where vcf_id<"+(vcf_id+45)+" and vcf_id>"+(vcf_id-18)+ " and chr='" +chr+ "' and jobid ='" +jobid+ "' limit 45;";
		String sql = "select * from vcfviewer_t where vcf_id<"+(vcf_id+28)+" and vcf_id>"+(vcf_id-18)+ " and chr='" +chr+ "' and jobid ='" +jobid+ "';";
		//String sql = "select * from vcfviewer_t where vcf_id<"+(vcf_id+45)+" and vcf_id>"+(vcf_id-45)+ " and chr='" +chr+ "' and jobid ='" +jobid+ "';";
		System.out.println(sql);
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		
		
		int vcf_id_row = 0;
		int totalCount = 0;
		while(ipetdigitalconndb.rs.next()) {
			if(Integer.parseInt(ipetdigitalconndb.rs.getString("vcf_id")) == vcf_id) {
				//System.out.println("base : " + ipetdigitalconndb.rs.getRow());
				vcf_id_row = ipetdigitalconndb.rs.getRow();
				ipetdigitalconndb.rs.last();
				//System.out.println("last : " + ipetdigitalconndb.rs.getRow());
				totalCount = ipetdigitalconndb.rs.getRow();
				
				break;
			}
		}
		int beforeCount = vcf_id_row - 1;
		int afterCount = totalCount - vcf_id_row;
		
		/*
		System.out.println("vcf_id_row : "+ vcf_id_row);
		System.out.println("totalCount : "+ totalCount);
		System.out.println("beforeCount : "+ beforeCount);
		System.out.println("afterCount : "+ afterCount);
		*/
		
		ipetdigitalconndb.rs.beforeFirst();
		
		/*
		while(ipetdigitalconndb.rs.next()) {
			
			if((totalCount > 45)) {
				
				if(beforeCount > 17 && ipetdigitalconndb.rs.getRow() <= vcf_id_row - 17 ) {
				//if(beforeCount > 17 && ipetdigitalconndb.rs.getRow() <= vcf_id_row - 45 + afterCount ) {
					
					System.out.println("before : " + ipetdigitalconndb.rs.getRow());
					continue;
					
				} else {
					
					if(afterCount > 29 && vcf_id_row + 29 <= ipetdigitalconndb.rs.getRow() && 46 <= ipetdigitalconndb.rs.getRow()) {
						//System.out.println("after : " + ipetdigitalconndb.rs.getRow());
						continue;
					} 
				}
				
			}
			
			//System.out.println(totalCount - (beforeCount + 1 + afterCount));
			//System.out.println("rows : " + ipetdigitalconndb.rs.getRow());
			
			JsonObject jsonObject = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
			
			if(ipetdigitalconndb.rs.getRow() == vcf_id_row) {
				keyList.addAll(jsonObject.keySet());
			}
			
			//System.out.println(ipetdigitalconndb.rs.getRow());
			//System.out.println(columnList);
			//columnList.add((ipetdigitalconndb.rs.getRow()-1), ipetdigitalconndb.rs.getString("position"));
			columnList.add(ipetdigitalconndb.rs.getString("position"));
			
			jsonArray.add(jsonObject);
		}
		*/
		
		for(int i=0 ; ipetdigitalconndb.rs.next() ; i++) {
			JsonObject jsonObject = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
			
			if(i == 0) {
				keyList.addAll(jsonObject.keySet());
			}
			
			columnList.add(i, ipetdigitalconndb.rs.getString("position"));
			
			jsonArray.add(jsonObject);
		}
		/*
		*/
		
	
	} catch (Exception e) {
		System.out.println("error - vb_features_getBrowserData - " + e);
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	//System.out.println(jsonArray);
	//long afterTime = System.currentTimeMillis();
	//System.out.println("sqlTimeGap : " + (afterTime - beforeTime));
	
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