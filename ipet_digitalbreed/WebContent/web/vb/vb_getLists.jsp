<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>  
<%@ page import="com.google.gson.JsonObject, com.google.gson.JsonArray"%> 
  
<%

	//vb_features.jsp 페이지의 SnpEff, GWAS, Marker 등 탭에서 필요한 model(= DB resultset) 불러오기 

	String command = request.getParameter("command");
	String jobid = request.getParameter("jobid");
	
	/*
	System.out.println(command);
	System.out.println(jobid);
	*/
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	out.clear();
	
	switch(command) {
		case "GWAS":

			String sql="select * from vcfdata_info_t where jobid = '" +jobid+ "';";
			//System.out.println(sql);
			String refgenome = null;
			String cropid = null;
			String varietyid = null;
			try{
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 
					//System.out.println("count++");
					cropid = ipetdigitalconndb.rs.getString("cropid");
					varietyid = ipetdigitalconndb.rs.getString("varietyid");
					refgenome = ipetdigitalconndb.rs.getString("refgenome");
				}
			}catch(Exception e){
				System.out.println(e);
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			
			JsonArray jsonArr = new JsonArray();
			
			// phenotype, model의 comma 텍스트를 그대로 사용시 dataset에 적용하려 할때 제대로 받지 못한다. -> 구분자를 |로 변경
			sql = "select genotype_filename, replace(phenotype_name, ',', '|') as phenotype_name, replace(model, ', ', '|') as model, comment, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt from gwas_info_t where status=1 and refgenome='"+refgenome+ "' and cropid='" +cropid+ "' and varietyid='" +varietyid+   "';";
			System.out.println(sql);
			try{
				ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
				while (ipetdigitalconndb.rs.next()) { 
					JsonObject jsonObj = new JsonObject();
					jsonObj.addProperty("filename", ipetdigitalconndb.rs.getString("genotype_filename"));
					jsonObj.addProperty("phenotype_name", ipetdigitalconndb.rs.getString("phenotype_name"));
					jsonObj.addProperty("model", ipetdigitalconndb.rs.getString("model"));
					jsonObj.addProperty("comment", ipetdigitalconndb.rs.getString("comment"));
					jsonObj.addProperty("jobid", ipetdigitalconndb.rs.getString("jobid"));
					jsonObj.addProperty("cre_dt", ipetdigitalconndb.rs.getString("cre_dt"));
					jsonArr.add(jsonObj);
				}
				
				// cropid, varietyid, regenome 정보가 필요하면 jsonObject를 하나 더 만들어 jsonArray에 붙인다(지금은 필요없음)
			}catch(Exception e){
				System.out.println(e);
			}finally{
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
			out.print(jsonArr);
			break;
			
		case "SnpEff":
			break;
	}
	
	
	
	
	
	
	
%>