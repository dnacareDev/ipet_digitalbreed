package ipet_digitalbreed;

import org.json.simple.JSONArray;
import org.json.simple.JSONObject;

public class GwasListJson {

	static IPETDigitalConnDB ipetdigitalconndb = null;
	
	// GWAS
	public JSONArray getGwasListJson(String permissionUid, String varietyid) throws Exception
	{
		 ipetdigitalconndb = new IPETDigitalConnDB();	
		 JSONArray jsonArray = new JSONArray();
		 
			try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

				//String sql="select no, cropid, status, genotype_filename, phenotype_name, model, uploadpath, resultpath, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt  from gwas_info_t where creuser='"+permissionUid+"' and varietyid='"+varietyid+"' order by no desc;";
				String sql="select no, cropid, status, genotype_filename, phenotype_name, model, uploadpath, resultpath, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt  from gwas_info_t where varietyid='"+varietyid+"' order by no desc;";
				//System.out.println("list sql " + sql);
				
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("no",ipetdigitalconndb.rs.getString("no"));
					jsonObject.put("cropid",ipetdigitalconndb.rs.getString("cropid"));
					jsonObject.put("status",ipetdigitalconndb.rs.getString("status"));
					jsonObject.put("genotype_filename",ipetdigitalconndb.rs.getString("genotype_filename"));
					jsonObject.put("phenotype_name",ipetdigitalconndb.rs.getString("phenotype_name"));
					jsonObject.put("model",ipetdigitalconndb.rs.getString("model"));
					jsonObject.put("uploadpath",ipetdigitalconndb.rs.getString("uploadpath"));
					jsonObject.put("resultpath",ipetdigitalconndb.rs.getString("resultpath"));
					jsonObject.put("comment",ipetdigitalconndb.rs.getString("comment"));
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
