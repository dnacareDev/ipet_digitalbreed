package ipet_digitalbreed;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class MinimalMarkerListJson {

	static IPETDigitalConnDB ipetdigitalconndb = null;

	public JSONArray getMinimalMarkerListJson(String permissionUid, String varietyid) throws Exception
	{
		 ipetdigitalconndb = new IPETDigitalConnDB();	
		 JSONArray jsonArray = new JSONArray();

			try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

				String sql="select no, uploadpath, filename, resultpath, comment, status, cropid, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt  from genocore_info_t where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' order by no desc;";

				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("no",ipetdigitalconndb.rs.getString("no"));
					jsonObject.put("file_name",ipetdigitalconndb.rs.getString("filename"));
					jsonObject.put("status",ipetdigitalconndb.rs.getString("status"));
					jsonObject.put("uploadpath",ipetdigitalconndb.rs.getString("uploadpath"));
					jsonObject.put("resultpath",ipetdigitalconndb.rs.getString("resultpath"));
					jsonObject.put("comment",ipetdigitalconndb.rs.getString("comment"));
					jsonObject.put("cropid",ipetdigitalconndb.rs.getString("cropid"));
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
