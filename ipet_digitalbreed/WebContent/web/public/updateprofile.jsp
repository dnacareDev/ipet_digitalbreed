<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
		String username = request.getParameter("username");		
		String oldpasswd = request.getParameter("old-passwd");
		String newpasswd1 = request.getParameter("con-password");
		String aname = request.getParameter("aname");
		String email = request.getParameter("email");
		
		boolean result=false;

		try{		
			String select_old_info_sql = "select uid from user_t where uid='"+username+"' and pw='"+oldpasswd+"'";	
			ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(select_old_info_sql);		    	    	    
	
		  	 while (ipetdigitalconndb.rs.next()) { 		
		  		result=true;
		  	 }	  	 
		  	
		}catch(Exception e){
			result=false;
			System.out.println(e);
		}finally { 
			ipetdigitalconndb.rs.close();
			ipetdigitalconndb.stmt.close();
		}		
		
		if(result){
			try{		
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();	
				
				String update_userinfo="update user_t set pw='"+newpasswd1+"', email='"+email+"', name='"+aname+"' where uid='"+username+"';";	
				ipetdigitalconndb.stmt.executeUpdate(update_userinfo);				
			}catch(Exception e){
				ipetdigitalconndb.stmt.close();
			}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();			
			}
		}
			
		out.println(result);
%>