<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String permissionUid = session.getAttribute("permissionUid")+"";

	String deleteSql=null;
	
	String[] deleteitems = request.getParameterValues("params[]");
	String varietyid = request.getParameter("varietyid");
	String cropid = null;
	String sampleid = null;
	String newsampleid = null;

	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

		String cropidsql="select cropid from variety_t where varietyid='"+varietyid+"';";
					
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(cropidsql);
		
		while (ipetdigitalconndb.rs.next()) { 						
			cropid = ipetdigitalconndb.rs.getString("cropid");
		}
		
	}catch(Exception e){
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
	}					
		
	
	try{
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

		String newsampleidsql="select SUBSTRING(sampleid,3) as newsampleid from sampledata_info_t order by sampleid desc limit 1;";
					
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(newsampleidsql);
		
		while (ipetdigitalconndb.rs.next()) { 						
			newsampleid = ipetdigitalconndb.rs.getString("newsampleid");
		}
		
	}catch(Exception e){
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
	}	
	
	
	String[] change_target = deleteitems[0].split("\\n");
	String[] sampleinfo_array = null;
	
	Loop1 :
	for(int i=1;i<change_target.length;i++) {		
		sampleinfo_array = change_target[i].split(",");	
	   
	    
	    for(int j=0; j<sampleinfo_array.length; j++) { 
	    	System.out.println("splitData"+j+" : " + sampleinfo_array[j]); 
	    	
	    	if(j==4 && sampleinfo_array[j].equals("\"\"")){
	    		out.println("[필수입력] "+i+"번째 개체의 개체명을 입력해주세요.");	   
	    		break Loop1; 
	    	}
	    	
	    }
	    
    		
		if(!sampleinfo_array[0].replaceAll("\"","").equals("")){
			String updatesql="update ";				
		}
		else{
			String insertsql="insert into sampledata_info_t(cropid, varietyid, sampleid, samplename, photo_status, creuser, cre_dt) values('"+cropid+"','"+varietyid+"','"+newsampleid+"','"+sampleinfo_array[4]+"','0','"+permissionUid+"',now());";
			System.out.println("insertsql : " + insertsql);
			
		}
	}		
%>