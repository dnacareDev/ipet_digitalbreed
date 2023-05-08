<%@page import="java.sql.SQLException"%>
<%@page import="org.json.simple.JSONArray"%>
<%@page import="ipet_digitalbreed.*"%>    
<%@page language="java" contentType="application/json; charset=UTF-8" pageEncoding="UTF-8"%>
<%@page import="org.json.simple.JSONObject"%>
<%@page import="com.google.gson.JsonObject, com.google.gson.JsonArray"%>
<%
	response.setHeader("Access-Control-Allow-Origin", "*");
	response.setHeader("Access-Control-Allow-Credentials", "true");
	response.setHeader("Access-Control-Allow-Methods", "GET, OPTIONS");
	response.setHeader("Access-Control-Allow-Headers", "Authorization,DNT,X-Mx-ReqToken,Keep-Alive,User-Agent,X-Requested-With,If-Modified-Since,Cache-Control,Content-Type");
	response.setContentType("application/json");

	//long beforeTime = System.currentTimeMillis();
	

	String permissionUid = session.getAttribute("permissionUid")+"";
	String varietyid = request.getParameter("varietyid");

	//PhenotypeListJson phenotypelistjson = new PhenotypeListJson();
	//JSONArray PhenotypeListJsonValues = phenotypelistjson.getGenotypeListJson(permissionUid, varietyid);
	//out.print(PhenotypeListJsonValues.toJSONString());
	
	
	//JsonArray PhenotypeListJsonValues = phenotypelistjson.getPhenotypeListJson(permissionUid, varietyid);
	
	JsonArray PhenotypeListJsonValues = getPhenotypeListJson(permissionUid, varietyid);
	out.clear();
	out.print(PhenotypeListJsonValues);
	
	//long afterTime = System.currentTimeMillis();
	//System.out.println("time : " + (afterTime - beforeTime) + "ms");
%>

<%!
private JsonArray getPhenotypeListJson(String permissionUid, String varietyid) throws SQLException {
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();				
	
	JsonArray jsonArray = new JsonArray();
	
	try{
		

		
		//String sql="SELECT * FROM (SELECT @ROWNUM:=@ROWNUM+1 AS ROWNUM,  a.no, a.cropid, a.varietyid, a.sampleid, a.samplename, a.photo_status, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') AS cre_dt, DATE_FORMAT(a.act_dt, '%Y-%m-%d') AS act_dt FROM (SELECT @ROWNUM := 0) R, sampledata_info_t a  where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' order by sampleid asc) SUB ORDER BY ROWNUM DESC;";
		String sql="SELECT a.no, a.cropid, a.varietyid, a.sampleid, a.samplename, a.photo_status, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') AS cre_dt, DATE_FORMAT(a.act_dt, '%Y-%m-%d') AS act_dt, group_concat( b.value SEPARATOR  ',' ) as val FROM sampledata_info_t a INNER JOIN sampledata_traitval_t b ON a.sampleid=b.sampleid where a.creuser='"+permissionUid+"' and a.varietyid='"+varietyid+"' group by b.sampleid ORDER BY a.no DESC;";
		//String sql="SELECT * FROM (SELECT @ROWNUM:=@ROWNUM+1 AS ROWNUM, a.no, a.cropid, a.varietyid, a.sampleid, a.samplename, a.photo_status, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') AS cre_dt, DATE_FORMAT(a.act_dt, '%Y-%m-%d') AS act_dt, group_concat( b.value SEPARATOR  ',' ) as val FROM (SELECT @ROWNUM := 0) R, sampledata_info_t a INNER JOIN sampledata_traitval_t b ON a.sampleid=b.sampleid where a.creuser='"+permissionUid+"' and a.varietyid='"+varietyid+"' group by b.sampleid order by sampleid asc) SUB ORDER BY ROWNUM DESC;";
		
		System.out.println(sql);
		
		//String sql_trait=null;					
						
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
		
		
		for(int i=1 ; ipetdigitalconndb.rs.next() ; i++) { 
			JsonObject jsonObject = new JsonObject();
			jsonObject.addProperty("displayno",i);
			jsonObject.addProperty("selectfiles",ipetdigitalconndb.rs.getString("no"));
			jsonObject.addProperty("cropid",ipetdigitalconndb.rs.getString("cropid"));
			jsonObject.addProperty("varietyid",ipetdigitalconndb.rs.getString("varietyid"));
			jsonObject.addProperty("sampleid",ipetdigitalconndb.rs.getString("sampleid"));
			jsonObject.addProperty("samplename",ipetdigitalconndb.rs.getString("samplename"));
			jsonObject.addProperty("photo_status",ipetdigitalconndb.rs.getString("photo_status"));
			jsonObject.addProperty("cre_dt",ipetdigitalconndb.rs.getString("cre_dt"));
			jsonObject.addProperty("act_dt",ipetdigitalconndb.rs.getString("act_dt"));					

			//System.out.println(ipetdigitalconndb.rs.getString("val"));
			String[] traitArr = ipetdigitalconndb.rs.getString("val").split(",");
			for(int j=0 ; j<traitArr.length ; j++) {
				jsonObject.addProperty(j+"_key",traitArr[j].trim());
			}
			
			jsonArray.add(jsonObject);
		}
	}catch(Exception e){
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
	//System.out.println(jsonArray);
	
	return jsonArray;
}
%>



