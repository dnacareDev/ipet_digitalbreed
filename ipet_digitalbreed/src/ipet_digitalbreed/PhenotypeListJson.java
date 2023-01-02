package ipet_digitalbreed;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;
import java.io.*;
import java.util.*;

public class PhenotypeListJson {

	static IPETDigitalConnDB ipetdigitalconndb = null;

	public JSONArray getGenotypeListJson(String permissionUid, String varietyid) throws Exception
	{
		 ipetdigitalconndb = new IPETDigitalConnDB();	
		 JSONArray jsonArray = new JSONArray();

			try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();				

				//String sql="SELECT * FROM (SELECT @ROWNUM:=@ROWNUM+1 AS ROWNUM,  a.no, a.cropid, a.varietyid, a.sampleid, a.samplename, a.photo_status, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') AS cre_dt, DATE_FORMAT(a.act_dt, '%Y-%m-%d') AS act_dt FROM (SELECT @ROWNUM := 0) R, sampledata_info_t a  where creuser='"+permissionUid+"' and varietyid='"+varietyid+"') SUB ORDER BY ROWNUM DESC;";
				
				String sql="SELECT * FROM (SELECT @ROWNUM:=@ROWNUM+1 AS ROWNUM,  a.no, a.cropid, a.varietyid, a.sampleid, a.samplename, a.photo_status, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') AS cre_dt, DATE_FORMAT(a.act_dt, '%Y-%m-%d') AS act_dt FROM (SELECT @ROWNUM := 0) R, sampledata_info_t a  where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' order by sampleid asc) SUB ORDER BY ROWNUM DESC;";
				//String sql="SELECT * FROM (SELECT @ROWNUM:=@ROWNUM+1 AS ROWNUM,  a.no, a.cropid, a.varietyid, a.sampleid, a.samplename, a.photo_status, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') AS cre_dt, DATE_FORMAT(a.act_dt, '%Y-%m-%d') AS act_dt FROM (SELECT @ROWNUM := 0) R, sampledata_info_t a  where varietyid='"+varietyid+"' order by sampleid asc) SUB ORDER BY ROWNUM DESC;";
					
				String sql_trait=null;					
								
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
				
				while (ipetdigitalconndb.rs.next()) { 
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("displayno",ipetdigitalconndb.rs.getInt("ROWNUM"));
					jsonObject.put("selectfiles",ipetdigitalconndb.rs.getString("no"));
					jsonObject.put("cropid",ipetdigitalconndb.rs.getString("cropid"));
					jsonObject.put("varietyid",ipetdigitalconndb.rs.getString("varietyid"));
					jsonObject.put("sampleid",ipetdigitalconndb.rs.getString("sampleid"));
					jsonObject.put("samplename",ipetdigitalconndb.rs.getString("samplename"));
					jsonObject.put("photo_status",ipetdigitalconndb.rs.getString("photo_status"));
					jsonObject.put("cre_dt",ipetdigitalconndb.rs.getString("cre_dt"));
					jsonObject.put("act_dt",ipetdigitalconndb.rs.getString("act_dt"));					

					try{
						ipetdigitalconndb.stmt1 = ipetdigitalconndb.conn.createStatement();
						sql_trait="SELECT group_concat( value SEPARATOR  ',' ) as val FROM sampledata_traitval_t where sampleid='"+ipetdigitalconndb.rs.getString("sampleid")+"' GROUP BY sampleid order by sampleid desc;";
						
						ipetdigitalconndb.rs1=ipetdigitalconndb.stmt1.executeQuery(sql_trait);
						while (ipetdigitalconndb.rs1.next()) { 	
							int trait_cnt=0;		
							String[] traitvalue = ipetdigitalconndb.rs1.getString("val").split(",");							
					
							for(int i=0;i<traitvalue.length;i++) {		
								//jsonObject.put(trait_cnt+"_"+ipetdigitalconndb.rs.getString("varietyid"),traitvalue[i].trim());
								jsonObject.put(trait_cnt+"_key",traitvalue[i].trim());
								trait_cnt++;
							}							
						}
					}catch(Exception e){
						ipetdigitalconndb.stmt1.close();
						ipetdigitalconndb.rs1.close();
						System.out.println(e);
					}finally { 
						ipetdigitalconndb.stmt1.close();
						ipetdigitalconndb.rs1.close();
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
			
			return jsonArray;
	}

}
