package ipet_digitalbreed;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class GenotypeListJson {

	static IPETDigitalConnDB ipetdigitalconndb = null;

	public JSONArray getGenotypeListJson(String permissionUid, String varietyid) throws Exception
	{
		 ipetdigitalconndb = new IPETDigitalConnDB();	
		 JSONArray jsonArray = new JSONArray();

			try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

				String sql="select no, uploadpath, filename,resultpath, comment, refgenome, cropid, samplecnt, variablecnt, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt  from vcfdata_info_t where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' order by no desc;";

				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("selectfiles",ipetdigitalconndb.rs.getString("no"));
					jsonObject.put("uploadpath",ipetdigitalconndb.rs.getString("uploadpath"));
					jsonObject.put("filename",ipetdigitalconndb.rs.getString("filename"));
					jsonObject.put("resultpath",ipetdigitalconndb.rs.getString("resultpath"));
					jsonObject.put("comment",ipetdigitalconndb.rs.getString("comment"));
					jsonObject.put("refgenome",ipetdigitalconndb.rs.getString("refgenome"));
					jsonObject.put("cropid",ipetdigitalconndb.rs.getString("cropid"));
					jsonObject.put("samplecnt",ipetdigitalconndb.rs.getString("samplecnt"));
					jsonObject.put("variablecnt",ipetdigitalconndb.rs.getString("variablecnt"));
					jsonObject.put("jobid",ipetdigitalconndb.rs.getString("jobid"));
					jsonObject.put("cre_dt",ipetdigitalconndb.rs.getString("cre_dt"));
					jsonArray.add(jsonObject);
				}
			}catch(Exception e){
				System.out.println(e);
			}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				ipetdigitalconndb.conn.close();
			}
			return jsonArray;
	}

}
