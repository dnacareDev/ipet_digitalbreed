<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	String permissionUid = null;
	
	String username = request.getParameter("user-name");
	String userpassword = request.getParameter("user-password");
	
	String validresult=null;
	//String user_type = null;

	try{		
		String sql = "select count(*) as resultcnt from user_t where uid='"+username+"' and pw='"+userpassword+"';";
		//String sql = "select count(*) as resultcnt, user_type from user_t where uid='"+username+"' and pw='"+userpassword+"';";	
		System.out.println(sql);
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);		    	    	    

	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		validresult = ipetdigitalconndb.rs.getString("resultcnt");
	  	 }	  	 
	  	 
	  	 if(validresult.equals("0")){	 		 
	  		out.println("<script>alert('The password you entered is incorrect.'); window.history.back(); </script>");
	  		//permissionUid = "dnacare";
	  		//session.setAttribute("permissionUid", permissionUid);
	  		//response.sendRedirect("/ipet_digitalbreed/web/mainboard.jsp");	  		
	  	 }
	  	 else{
	  		permissionUid = username;
	  		session.setAttribute("permissionUid", permissionUid);
	  		//session.setAttribute("user_type", user_type);
	  		// 세션 60분 유지
	  		session.setMaxInactiveInterval(60*60);
	  		
	  		//response.sendRedirect("/ipet_digitalbreed/web/mainboard.jsp");
	  		response.sendRedirect("/ipet_digitalbreed/web/index.jsp");
	  	 }
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}

%>