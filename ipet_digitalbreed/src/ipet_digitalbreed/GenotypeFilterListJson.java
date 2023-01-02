package ipet_digitalbreed;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class GenotypeFilterListJson {

	static IPETDigitalConnDB ipetdigitalconndb = null;

	public JSONArray getGenotypeFilterListJson(String permissionUid, String varietyid) throws Exception
	{
		 ipetdigitalconndb = new IPETDigitalConnDB();	
		 JSONArray jsonArray = new JSONArray();

			try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

				String sql="SELECT no, status, filename, manufacture, uploadpath, resultpath, save_cmd, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt FROM genotype_filter_t  where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' ORDER BY no DESC;";
				//String sql="SELECT no, status, filename, manufacture, uploadpath, resultpath, save_cmd, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt FROM genotype_filter_t  where varietyid='"+varietyid+"' ORDER BY no DESC;";
				
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("no",ipetdigitalconndb.rs.getInt("no"));
					jsonObject.put("status",ipetdigitalconndb.rs.getString("status"));
					jsonObject.put("filename",ipetdigitalconndb.rs.getString("filename"));
					jsonObject.put("manufacture",ipetdigitalconndb.rs.getString("manufacture"));
					jsonObject.put("uploadpath",ipetdigitalconndb.rs.getString("uploadpath"));
					jsonObject.put("resultpath",ipetdigitalconndb.rs.getString("resultpath"));
					jsonObject.put("save_cmd",ipetdigitalconndb.rs.getString("save_cmd"));
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
