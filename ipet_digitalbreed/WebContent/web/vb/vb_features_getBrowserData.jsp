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
		//String sql = "select * from vcfviewer_t where vcf_id<"+(vcf_id+28)+" and vcf_id>"+(vcf_id-18)+ " and chr='" +chr+ "' and jobid ='" +jobid+ "';";
		String sql = "select * from vcfviewer_t where vcf_id<"+(vcf_id+45)+" and vcf_id>"+(vcf_id-45)+ " and chr='" +chr+ "' and jobid ='" +jobid+ "';";
		System.out.println(sql);
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		
		
		int current_row = 0;
		int totalCount = 0;
		while(ipetdigitalconndb.rs.next()) {
			if(Integer.parseInt(ipetdigitalconndb.rs.getString("vcf_id")) == vcf_id) {
				//System.out.println("base : " + ipetdigitalconndb.rs.getRow());
				current_row = ipetdigitalconndb.rs.getRow();
				ipetdigitalconndb.rs.last();
				//System.out.println("last : " + ipetdigitalconndb.rs.getRow());
				totalCount = ipetdigitalconndb.rs.getRow();
				
				break;
			}
		}
		int beforeCount = current_row - 1;
		int afterCount = totalCount - current_row;
		
		/*
		System.out.print("current_row : "+ current_row);
		System.out.print(" | totalCount : "+ totalCount);
		System.out.print(" | beforeCount : "+ beforeCount);
		System.out.println(" | afterCount : "+ afterCount);
		*/
		
		
		ipetdigitalconndb.rs.beforeFirst();
		
		/*
		if(totalCount > 45) {
			// beforeCount 17개 이상 -> beforeCount가 17개가 되도록 앞의 일부를 자른다
			if(beforeCount > 17) {
				if(afterCount<27) {
					// afterCount 27개 이하 -> 처음부터 45개 count
					for(int i=0 ; ipetdigitalconndb.rs.next() && i<45 ; i++) {
						
						//System.out.println(i);
						
						JsonObject jsonObject = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
						
						if(i == 0) {
							keyList.addAll(jsonObject.keySet());
						}
						
						columnList.add(i, ipetdigitalconndb.rs.getString("position"));
						
						jsonArray.add(jsonObject);
					}
				} else {
					ipetdigitalconndb.rs.absolute(beforeCount - 17);
					System.out.println(ipetdigitalconndb.rs.getRow());
					
					for(int i=0 ; ipetdigitalconndb.rs.next() && i<45 ; i++) {
						JsonObject jsonObject = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
						
						if(i == 0) {
							keyList.addAll(jsonObject.keySet());
						}
						
						columnList.add(i, ipetdigitalconndb.rs.getString("position"));
						
						jsonArray.add(jsonObject);
					}
				}
				
			} else {
				for(int i=0 ; ipetdigitalconndb.rs.next() && i<45 ; i++) {
					
					//System.out.println(i);
					
					JsonObject jsonObject = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
					
					if(i == 0) {
						keyList.addAll(jsonObject.keySet());
					}
					
					columnList.add(i, ipetdigitalconndb.rs.getString("position"));
					
					jsonArray.add(jsonObject);
				}
				System.out.println("else end");
			}
		} else {
			// totalCount 45개 이하
			for(int i=0 ; ipetdigitalconndb.rs.next() ; i++) {
				JsonObject jsonObject = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
				
				if(i == 0) {
					keyList.addAll(jsonObject.keySet());
				}
				
				columnList.add(i, ipetdigitalconndb.rs.getString("position"));
				
				jsonArray.add(jsonObject);
			}
		}
		*/
		
		/*
		if(totalCount > 45) {
			if(beforeCount > 17) {
				if(afterCount >= 27) {
					ipetdigitalconndb.rs.absolute(beforeCount - 17);
					//System.out.println(ipetdigitalconndb.rs.getRow());
				} else {
					ipetdigitalconndb.rs.absolute(afterCount);
				}
			} 
		} 
		*/
		if(totalCount > 45 && beforeCount > 17) {
			if(afterCount >= 27) {
				ipetdigitalconndb.rs.absolute(beforeCount - 17);
			} else {
				ipetdigitalconndb.rs.absolute(afterCount);
			}
		}
		
		for(int i=0 ; ipetdigitalconndb.rs.next() && i<45 ; i++) {
			JsonObject jsonObject = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
			
			if(i == 0) {
				keyList.addAll(jsonObject.keySet());
			}
			
			columnList.add(i, ipetdigitalconndb.rs.getString("position"));
			
			jsonArray.add(jsonObject);
		}
		
		
		
		
		
		/*
		for(int i=0 ; ipetdigitalconndb.rs.next() ; i++) {
			JsonObject jsonObject = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
			
			if(i == 0) {
				keyList.addAll(jsonObject.keySet());
			}
			
			columnList.add(i, ipetdigitalconndb.rs.getString("position"));
			
			jsonArray.add(jsonObject);
		}
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