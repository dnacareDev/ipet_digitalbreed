<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	//String permissionUid = session.getAttribute("permissionUid")+"";

	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/database/genotype_statistics/";

	String jobid= "20230130171154";
	
	File fileRead = new File(path+"/"+jobid+"/"+jobid+"_genotype_matrix_viewer.csv");
	File fileWrite = new File(path+"/"+jobid+"/"+jobid+"_chr_row_index_data.csv");
	
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(fileRead), "UTF-8"));
	BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(fileWrite), "UTF-8"));
	
	bw.write("chr,vcfId_at_firstRow,row_count");
	bw.newLine();
	
	
	List<List<String>> chrList = new ArrayList<>();
	//chrList.add(Arrays.asList("chr", "row_index_start", "row_index_end"));
	
	br.readLine();
	String line = br.readLine();
	
	for(int i=1, chrListCount=0 ; true ; i++) {
		//System.out.println(line);
		String chr = line.substring(0, line.indexOf("_"));

		if(i==1) {
			String vcf_id = getVcfId(chr, jobid);

			chrList.add( Arrays.asList(chr, vcf_id, "") );
			bw.write( chr + "," + vcf_id + ",");
		}
		
		//System.out.println(chr);
		if( !(chr.equals( chrList.get(chrListCount).get(0) )) ) {
			
			
			if(chrListCount == 0) {
				chrList.get(chrListCount).set(2, String.valueOf(i-1));
				bw.write(String.valueOf(i-1));
			} else {
				chrList.get(chrListCount).set(2, String.valueOf(i));
				bw.write(String.valueOf(i));
			}
			
			chrListCount++;
			bw.newLine();
			
			i=0;
			//chrList.add( Arrays.asList(line.substring(0, line.indexOf("_")), String.valueOf(i), "") );
		}
		
		
		if( (line = br.readLine()) == null ) {
			chrList.get(chrListCount).set(2, String.valueOf(i+1));
			bw.write(String.valueOf(i+1));
			break;
		}
	}
	//System.out.println(chrList);
	//System.out.println("end");
	
	br.close();
	
	bw.flush();
	bw.close();
	
	
%>

<%! 
private String  getVcfId(String chr, String jobid) throws SQLException {
	
	
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	try{
		String sql = "select vcf_id from vcfviewer_t where chr='" +chr+ "' and jobid='"+jobid+"' limit 1;";
		//System.out.println(sql);
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		
		ipetdigitalconndb.rs.next();
		String vcf_id = ipetdigitalconndb.rs.getString("vcf_id");
		//System.out.println(vcf_id);
		return vcf_id;
		
	}catch(Exception e){
		System.out.println("getVcfId error");
   		System.out.println(e);
		return "1";
   	}finally { 
   		ipetdigitalconndb.stmt.close();
   		ipetdigitalconndb.conn.close();
   	}

} 
%>

