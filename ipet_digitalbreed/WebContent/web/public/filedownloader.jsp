<%@ page language="java" contentType="text/html; charset=UTF-8" %>
<%@ page import="java.io.*"%>
<%@ page import="java.text.*" %>
<%@ page import="java.lang.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.net.*" %>
<%@page import="ipet_digitalbreed.*"%>    

 
<%
	request.setCharacterEncoding("UTF-8"); 

	String resultpath = request.getParameter("resultpath");
 	String filename = request.getParameter("filename");

    // 파일 업로드된 경로
    String root = request.getSession().getServletContext().getRealPath("/");
    String savepath = root+resultpath;

 	System.out.println("resultpath : " + resultpath);
 	System.out.println("filename : " + filename);
 	System.out.println("root : " + root);
 	System.out.println("savepath : " + savepath);

       
    InputStream in = null;
    OutputStream os = null;
    File file = null;
    boolean skip = false;
    String client = ""; 
 
    try{
 
        // 파일을 읽어 스트림에 담기
        try{
            file = new File(savepath, filename);
            in = new FileInputStream(file);
        }catch(FileNotFoundException fe){
			System.out.println("fe : " + fe);
            skip = true;
        }
  
         
        client = request.getHeader("User-Agent");
 
        // 파일 다운로드 헤더 지정
        response.reset() ;
        response.setContentType("application/octet-stream");
        response.setHeader("Content-Description", "JSP Generated Data");
 
 
        if(!skip){
 
             
            // IE
            if(client.indexOf("MSIE") != -1){
                response.setHeader ("Content-Disposition", "attachment; filename="+new String(filename.getBytes("KSC5601"),"ISO8859_1"));
 
            }else{
                // 한글 파일명 처리
                filename = new String(filename.getBytes("utf-8"),"iso-8859-1");
 
                response.setHeader("Content-Disposition", "attachment; filename=\"" + filename + "\"");
                response.setHeader("Content-Type", "application/octet-stream; charset=utf-8");
            } 
             
            response.setHeader ("Content-Length", ""+file.length() );
 
       
            os = response.getOutputStream();
            byte b[] = new byte[(int)file.length()];
            int leng = 0;
             
            while( (leng = in.read(b)) > 0 ){
                os.write(b,0,leng);
            }
 
        }else{
            response.setContentType("text/html;charset=UTF-8");
            out.println("<script language='javascript'>alert('File not found1.');history.back();</script>"); 
        }
         
        in.close();
        os.close();
 
    }catch(Exception e){
      e.printStackTrace();
    }
%>