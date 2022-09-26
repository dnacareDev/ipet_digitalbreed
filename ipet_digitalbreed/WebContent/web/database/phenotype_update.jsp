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
	int newsampleid=0;
	String conv_newsampleid=null;
	String updatetraitsql=null;
	String inserttraitsql=null;
	String newsampleno=null;

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
			newsampleid = Integer.parseInt(ipetdigitalconndb.rs.getString("newsampleid"));
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
	
	
	try{
		
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		Loop1 :
		for(int i=1;i<change_target.length;i++) {		
			sampleinfo_array = change_target[i].split(",");	
		   
		    
		    for(int j=1; j<sampleinfo_array.length; j++) { 
		    			    	
		    	if(j==4 && sampleinfo_array[j].equals("\"\"")){
		    		out.println("[필수입력] "+i+"번째 개체의 개체명을 입력해주세요.");	   
		    		break Loop1; 
		    	}   
		    }
		        
		    newsampleid++;	  
		    conv_newsampleid = "s-"+String.format("%05d", newsampleid);	    
		    int traitno=1;
		    
			if(!sampleinfo_array[1].replaceAll("\"","").equals("")){
				String updatesql="update sampledata_info_t set samplename='"+sampleinfo_array[4].replaceAll("\"","")+"' where no='"+sampleinfo_array[1].replaceAll("\"","")+"'";
							
				ipetdigitalconndb.stmt.executeUpdate(updatesql);
				
				for(int j=5; j<sampleinfo_array.length; j++) { 
					updatetraitsql="update sampledata_traitval_t set value='"+sampleinfo_array[j].replaceAll("\"","").trim()+"' where sampleno='"+sampleinfo_array[1].replaceAll("\"","")+"' and seq='"+traitno+"'";
					System.out.println(updatetraitsql);
					traitno++;						
					ipetdigitalconndb.stmt.executeUpdate(updatetraitsql);
				}
			}
			else{
				String insertsql="insert into sampledata_info_t(cropid, varietyid, sampleid, samplename, photo_status, creuser, cre_dt) values('"+cropid+"','"+varietyid+"','"+conv_newsampleid+"','"+sampleinfo_array[4].replaceAll("\"","")+"','0','"+permissionUid+"',now());";						
				ipetdigitalconndb.stmt.executeUpdate(insertsql);	
		
				String newsampleidsql="select no from sampledata_info_t where sampleid='"+conv_newsampleid+"';";
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(newsampleidsql);
					
				while (ipetdigitalconndb.rs.next()) { 						
					newsampleno = ipetdigitalconndb.rs.getString("no");
				}
											
				for(int k=5; k<sampleinfo_array.length; k++) { 
					inserttraitsql="insert into sampledata_traitval_t(cropid, varietyid, sampleid, sampleno, seq, value, creuser, cre_dt) values('"+cropid+"','"+varietyid+"','"+conv_newsampleid+"','"+newsampleno+"','"+traitno+"', '"+sampleinfo_array[k].replaceAll("\"","").trim()+"','"+permissionUid+"',now());";
					System.out.println(inserttraitsql);

					traitno++;						
					ipetdigitalconndb.stmt.executeUpdate(inserttraitsql);
				}			
			}
		}	
		
	}catch(Exception e){
		System.out.println("error : " + e);
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}	
	
%>