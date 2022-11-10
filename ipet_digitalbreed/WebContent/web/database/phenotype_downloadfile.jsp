<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	request.setCharacterEncoding("UTF-8"); 

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String selecfilenameSql = null;
	String variety = request.getParameter("varietyid");
	String orgfilename = null;
	
	String downloadpath = rootFolder+"uploads/database/phenotype_data/template/";

	try{
		
		selecfilenameSql = "select templatefilename from variety_t where varietyid='"+variety+"';";	    
		
		
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(selecfilenameSql);	
	    
	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		orgfilename = ipetdigitalconndb.rs.getString("templatefilename");
	  	 }
	  	 
	
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}	


    InputStream in = null;
    OutputStream os = null;
    File file = null;
    String client = "";
    
    
    try{
	    try{
	        file = new File(downloadpath, orgfilename);
	        in = new FileInputStream(file);
	    }catch(FileNotFoundException fe){
	    }
	    
	    client = request.getHeader("User-Agent");
	    // 파일 다운로드 헤더 지정
	    response.reset() ;
	    response.setContentType("application/vnd.ms-excel");
	    response.setHeader("Content-Description", "JSP Generated Data");
	   
	    out.clear();
	    out=pageContext.pushBody();
	    
      
	        // IE
	        if(client.indexOf("MSIE") != -1){
	            response.setHeader ("Content-Disposition", "attachment; filename="+orgfilename);
	
	        }else{
	            // 한글 파일명 처리
	            //orgfilename = new String(orgfilename.getBytes("utf-8"),"iso-8859-1");
	            orgfilename = new String(orgfilename.getBytes("utf-8"),"iso-8859-1");
	            response.setHeader("Content-Disposition", "attachment; filename=\"" + orgfilename + "\"");
	            response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
	        } 
	         
	        response.setHeader ("Content-Length", ""+file.length() );	

	        os = response.getOutputStream();
	        byte b[] = new byte[(int)file.length()];
	        int leng = 0;
	         
	        while( (leng = in.read(b)) > 0 ){
	            os.write(b,0,leng);
	        }
	
	        in.close();
	        os.close();
    }catch(Exception e){
    	System.out.println(e);
        e.printStackTrace();
    }   
%>
