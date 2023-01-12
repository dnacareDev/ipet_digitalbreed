<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*"%>
<%@ page import="ipet_digitalbreed.*"%>
<%@ page import="org.json.simple.*" %>    
<%

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String variety_id = request.getParameter("variety_id");
	String currentYear = request.getParameter("currentYear");
	
	List<Integer> list = new LinkedList<>();
	
	for(int i=1 ; i<=12 ; i++) {
		try{
			//String sql = "select count(*) as count from vcfdata_info_t where creuser='" +permissionUid+ "' and varietyid='" +variety_id+ "' and year(cre_dt) = '" +currentYear+ "' and month(cre_dt) = '" +i+ "';";
			String sql = "select count(*) as count from vcfdata_info_t where varietyid='" +variety_id+ "' and year(cre_dt) = '" +currentYear+ "' and month(cre_dt) = '" +i+ "';";
			//System.out.println(sql);
			
			ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
	     	while (ipetdigitalconndb.rs.next()) { 
	     		list.add(ipetdigitalconndb.rs.getInt("count"));
	     	}
			
		} catch (Exception e) {
			e.printStackTrace();
		}
	}
	
	ipetdigitalconndb.stmt.close();
	ipetdigitalconndb.conn.close();
	
	out.clear();
	out.print(list);
	
	

%>