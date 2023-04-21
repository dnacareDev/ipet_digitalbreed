<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>    
<%@ page import="org.apache.commons.exec.*" %>


<%

if (request.getMethod().equals("POST"))
{
	int maxPostSize = 2147482624; // bytes
	
	
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	

	String permissionUid = session.getAttribute("permissionUid")+"";	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String savePath = rootFolder + "uploads/database/phenotype_data/";
	String outputPath = rootFolder + "result/Breeder_toolbox_analyses/pheno/t-test/";
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	
	InnorixUpload uploader = new InnorixUpload(request, response, maxPostSize, savePath);

	String _action          = uploader.getParameter("_action");         // 동작 플래그
	String _orig_filename   = uploader.getParameter("_orig_filename");  // 원본 파일명
	String _new_filename    = uploader.getParameter("_new_filename");   // 저장 파일명
	String _filesize        = uploader.getParameter("_filesize");       // 파일 사이즈
	String _start_offset    = uploader.getParameter("_start_offset");   // 파일저장 시작지점
	String _end_offset      = uploader.getParameter("_end_offset");     // 파일저장 종료지점
	String _filepath        = uploader.getParameter("_filepath");       // 파일 저장경로
	String _el              = uploader.getParameter("el");              // 컨트롤 엘리먼트 ID
	String _type            = uploader.getParameter("type");            // 커스텀 정의 POST Param 1
	String _part            = uploader.getParameter("part");            // 커스텀 정의 POST Param 2
	String jobid_t_test  			= uploader.getParameter("jobid_t_test");
	String jobid  			= uploader.getParameter("jobid");
	String varietyid 		= uploader.getParameter("varietyid");
	String comment 		= uploader.getParameter("comment");
	//String filename 		= uploader.getParameter("filename");
	
	
	//System.out.println(filename);
	//uploader.setDirectory(savePath+jobid);
	
    //uploader.setFileName(jobid_gs + "_phenotype-eucKr.csv");
    //uploader.setFileName("GS_trait-ANSI.csv");
    
	String _run_retval = uploader.run();
	

	if (uploader.isUploadDone()) {	
		
		File folder_savePath = new File(savePath+jobid_t_test);

		if (!folder_savePath.exists()) {
			try {
				folder_savePath.mkdir(); 
	        } catch(Exception e) {
		    	e.getStackTrace();
			}        
		}
		
		File folder_outputdir = new File(outputPath+jobid_t_test);

		if (!folder_outputdir.exists()) {
			try {
				folder_outputdir.mkdir(); 
		    } catch(Exception e){
			    e.getStackTrace();
			}        
		}
		
		File from = new File(savePath+_orig_filename);
        File to = new File(savePath+jobid_t_test+"/"+_orig_filename);
 
        try {
            Files.move(from.toPath(), to.toPath(), StandardCopyOption.REPLACE_EXISTING);
            System.out.println("File moved successfully.");
        } catch (IOException ex) {
            ex.printStackTrace();
        }
        
        transferToUtf8(savePath, jobid_t_test, _orig_filename);
        
        /*
        String[] sqlInfo = readPhenotypeTxt(savePath, jobid);
        String traitname = sqlInfo[0];
        String seq = sqlInfo[1];
        String analysis_number = sqlInfo[2];
        
        insertSql(permissionUid, varietyid, jobid, comment, traitname, seq, analysis_number);
        
        String cmd = "Rscript " +script_path+ "Phenotype_t-test.R " +jobid+ " " +savePath+jobid+ " GS_traits.csv null " +seq+ " " +outputPath;
    	
    	System.out.println("cmd : " + cmd);
    			
    	
    	CommandLine cmdLine = CommandLine.parse(cmd);
    	DefaultExecutor executor = new DefaultExecutor();
    	executor.setExitValue(0);
    	int exitValue = executor.execute(cmdLine);
    	if(exitValue == 0) {
    		System.out.println("Success");
    	} else {
    		System.out.println("Fail");
    	}
    	*/
		
	}
}
%>

<%!
private void transferToUtf8(String csvPath, String jobid, String _orig_filename) {
	
	System.out.println("transferToUtf8");

	try {
		File csvANSI = new File(csvPath+jobid+"/"+_orig_filename);
		BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(csvANSI), "EUC-KR"));

		File csvUtf8 = new File(csvPath+jobid+"/GS_traits.csv");
		BufferedWriter bw = new BufferedWriter(new OutputStreamWriter(new FileOutputStream(csvUtf8), "UTF-8"));

		String line;
		for(int i=0 ; (line = br.readLine()) != null ; i++) {
			//System.out.println(line);
			
			String[] arr = line.split(",");
			
			for(int j=0 ; j<arr.length ; j++) {
				bw.write(arr[j]);
				if(j == arr.length -1) {
					bw.newLine();
				} else {
					bw.write(",");
				}
			}
		}
		bw.flush();
		bw.close();
		br.close();
		
		
	} catch(IOException e) {
		e.printStackTrace();
	}
}
%>

<%! 
public String[] readPhenotypeTxt(String savePath, String jobid) throws IOException {
	
	File file = new File(savePath+jobid+"/GS_traits.csv");
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file), "UTF-8"));
	
	String line = br.readLine();
	int analysis_number = 0;
	int column_count = line.split(",").length; 
	
	String traitname = "";
	String traitname_keys = "";
	for(int i=2 ; i<=column_count ; i++) {
		//System.out.println(i);
		traitname += line.split(",")[i-1];
		traitname_keys += i;
		if(i != column_count) {
			traitname_keys += ",";
		}
	}
	
	while((line = br.readLine()) != null) {
		analysis_number++;
	}
	
	
	br.close();
	//System.out.println(traitname);
	//System.out.println(traitname_keys);
	//System.out.println(analysis_number);
	
	String[] sqlInfo = {traitname, traitname_keys, analysis_number+""};
	
	//return traitname_keys;
	return sqlInfo;
}
%>

<%!
private void insertSql(String permissionUid, String varietyid, String jobid, String comment, String traitname, String seq, String analysis_number) throws SQLException {
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String db_savePath = "/ipet_digitalbreed/uploads/database/phenotype_data/";
	String db_outputPath = "/ipet_digitalbreed/result/Breeder_toolbox_analyses/pheno/t-test/";
	
	String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+varietyid+"'),'"+varietyid+"','T-test', 'New analysis', now());";
	//System.out.println(log_sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(log_sql);
	}catch(Exception e){
		System.out.println(e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	String sql = "insert into t_test_t (cropid, varietyid, status, comment, analysis_number, phenotype, uploadpath, resultpath, jobid, creuser, cre_dt) ";
	sql += "values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"', 0, '"+comment+"', '" +analysis_number+ "', '" +traitname+ "', '" +db_savePath+"','"+db_outputPath+"', '"+jobid+"','" +permissionUid+ "',now());";
	
	System.out.println("sql : " + sql);
	
	try{
		ipetdigitalconndb.stmt.executeUpdate(sql);
	} catch(Exception e) {
		System.out.println(e);
	} finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
}
%>