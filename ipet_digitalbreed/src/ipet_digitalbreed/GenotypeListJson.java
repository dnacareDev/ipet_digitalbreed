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

				//String sql="SELECT * FROM (SELECT @ROWNUM:=@ROWNUM+1 AS ROWNUM,  a.no, a.uploadpath, a.filename, a.resultpath, a.comment, a.refgenome, a.cropid, a.samplecnt, a.variablecnt, a.jobid, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') AS cre_dt FROM (SELECT @ROWNUM := 0) R, vcfdata_info_t a  where a.creuser='"+permissionUid+"' and a.varietyid='"+varietyid+"') SUB ORDER BY ROWNUM DESC;";
				String sql="SELECT * FROM (SELECT @ROWNUM:=@ROWNUM+1 AS ROWNUM,  a.no, a.uploadpath, a.filename, a.resultpath, a.comment, a.refgenome, a.cropid, a.samplecnt, a.variablecnt, a.jobid, DATE_FORMAT(a.cre_dt, '%Y-%m-%d') AS cre_dt FROM (SELECT @ROWNUM := 0) R, vcfdata_info_t a  where a.varietyid='"+varietyid+"') SUB ORDER BY ROWNUM DESC;";
				
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 
					JSONObject jsonObject = new JSONObject();
					jsonObject.put("displayno",ipetdigitalconndb.rs.getInt("ROWNUM"));
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
