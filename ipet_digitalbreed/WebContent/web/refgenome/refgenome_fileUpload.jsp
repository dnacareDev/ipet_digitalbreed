<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="com.oreilly.servlet.MultipartRequest, com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.multipart.Part, com.oreilly.servlet.multipart.ParamPart, com.oreilly.servlet.multipart.FilePart, com.oreilly.servlet.multipart.MultipartParser" %> 
<%@ page import="com.google.gson.*" %>
<%@ page import="ipet_digitalbreed.*"%>    


<%
	String permissionUid = session.getAttribute("permissionUid")+"";

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	
	JsonObject jsonObj = new JsonObject();
	
	
	
	int sizeLimit = 2147482624;
	String fsl = File.separator;
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String rootPath = rootFolder+"uploads/reference_database/";
	String savePath = "";
	
		
	MultipartParser mp = new MultipartParser(request, sizeLimit);
	mp.setEncoding("UTF-8");
	
	Part part;
	while ((part=mp.readNextPart()) != null) {
		String name = part.getName();
		System.out.println(name);
		
		// parameters
		if(part.isParam()) {
			ParamPart paramPart = (ParamPart) part;
			String value = paramPart.getStringValue();
			
			//System.out.println("param: name=" + name + ", value=" + value);
			
			if(name.equals("refgenomeParam")) {
				savePath = value;
				File dir = new File(rootPath+fsl+savePath);
				if(!dir.exists()) {
					dir.mkdir();
				} 
			}
			
			jsonObj.addProperty(name, value);
			
				
		} 
		// files
		else if(part.isFile()) {
			FilePart filePart = (FilePart) part;
			filePart.setRenamePolicy(new DefaultFileRenamePolicy()); //중복파일
			
			String fileName = filePart.getFileName();
			if(fileName != null) {
				System.out.println("file: name=" + name + ", filename=" +fileName+ ", path=" +rootPath+savePath);
				File dir = new File(rootPath+fsl+savePath+fsl+name);
				
				// name == fasta || gff || cds || protein
				jsonObj.addProperty(name+"FileName", fileName);
				
				//System.out.println("dir: "+ dir);
				
				if(!dir.exists()) {
					dir.mkdir();
					
					long size = filePart.writeTo(dir);
					//System.out.println("write??");
				} else {
					//System.out.println("it's not directory");
				}
			} else {
				// input type이 file이지만 비어있는 parameter
				//System.out.println("file; name=" + name + "; EMPTY");
			}
			
		}
	}
		
	
	System.out.println(jsonObj);
	
	String sql="insert into reference_genome_t(crop_name, refgenome, gff, author, creuser, cre_dt) values('" +jsonObj.get("cropParam").getAsString()+ "', '" +jsonObj.get("refgenomeParam").getAsString()+ "', '" +jsonObj.get("gffParam").getAsString()+ "', '" +jsonObj.get("authorParam").getAsString()+ "', '" +permissionUid+ "', now());";
	System.out.println(sql);
	try{
		ipetdigitalconndb.stmt.executeUpdate(sql);
	}catch(Exception e){
		System.out.println(e);
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	
	
	/*
	try{
		MultipartRequest multi = new MultipartRequest(request, savePath, sizeLimit,"UTF-8",new DefaultFileRenamePolicy());

        String crop= multi.getParameter("crop"); 
        String refgenome= multi.getFilesystemName("refgenome"); 
        String gff = multi.getOriginalFileName("gff"); 
        File refgenomeFile = multi.getFile("refgenomeFile");
         
        //로직 처리 
         
        //out.print("통신 시 결과값");
         
     } catch(Exception e) {
         out.print(e.getMessage());
     }
	*/
	 
	RunAnalysisTools runanalysistools = new RunAnalysisTools();

	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";
	String refgenomeScript = "Rscript " +script_path+ "reference_database_final.R " +rootPath+fsl+savePath+fsl+ " " +jsonObj.get("fastaFileName")+ " " +jsonObj.get("cdsFileName")+ " " +jsonObj.get("proteinFileName");
	
	System.out.println("=========================================");
	System.out.println("Gwasgapit parameter : " + refgenomeScript);
	System.out.println("=========================================");
			
	runanalysistools.execute(refgenomeScript, "cmd");
%>