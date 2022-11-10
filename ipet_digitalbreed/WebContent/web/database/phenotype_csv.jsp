<%@page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%><%@page import="java.util.*, java.io.*, java.sql.*, java.text.*"%><%@page import="ipet_digitalbreed.*"%><%
		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		java.util.Date currentTime = new java.util.Date( ); 
		Calendar c1 = Calendar.getInstance();
		String credate = sdf.format(c1.getTime());
		
		response.setContentType("application/csv; charset=utf-8");		 
		response.setContentType("application/csv");
		response.setHeader("Content-Disposition", "attachment; filename="+"phonotypeDB_"+credate+".csv");
		response.setHeader("Content-Transfer-Encoding", "binary;");
		response.setHeader("Pragma", "no-cache;");
		response.setHeader("Expires", "-1;");
		
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	 	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		String permissionUid = session.getAttribute("permissionUid")+"";
		String varietyid = request.getParameter("varietyid");
		ipetdigitalconndb = new IPETDigitalConnDB();			
		int traitcnt=0;
		String itemnameinfo_sql="select samplename from sampledata_info_t where varietyid='"+varietyid+"' and creuser='"+permissionUid+"'  order by no desc;";
		ArrayList<String> itemnameinfo_array = new ArrayList<>();
		try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();				
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(itemnameinfo_sql);
				
				while (ipetdigitalconndb.rs.next()) {				
					itemnameinfo_array.add(ipetdigitalconndb.rs.getString("samplename"));					
				}				
		}catch(Exception e){
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				System.out.print(e);
		}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
		}		
		String traitvalinfo_sql="select value from sampledata_traitval_t  where varietyid='"+varietyid+"' and creuser='"+permissionUid+"'   order by sampleno desc, seq asc;";
		ArrayList<String> traitvalinfo_array = new ArrayList<>();

		try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();				
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(traitvalinfo_sql);
				
				while (ipetdigitalconndb.rs.next()) {				
					traitvalinfo_array.add(ipetdigitalconndb.rs.getString("value"));					
				}				
		}catch(Exception e){
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				System.out.print(e);
		}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
		}				
		String headerinfo_sql="select traitname from sampledata_traitname_t where varietyid='"+varietyid+"' and creuser='"+permissionUid+"' order by seq asc;";		 
		out.print("개체명"+"\t");		
		int j=0;
		
		try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();				
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(headerinfo_sql);
				
				while (ipetdigitalconndb.rs.next()) { 
					traitcnt++;
					out.print(ipetdigitalconndb.rs.getString("traitname")+"\t");
				}				
		}catch(Exception e){
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				ipetdigitalconndb.conn.close();
				System.out.print(e);
		}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				ipetdigitalconndb.conn.close();
		}

		out.print("\n");
		
		int trait_loop_cnt=traitcnt;
		
		for(int i=0;i<itemnameinfo_array.size();i++) {
			
			out.print(itemnameinfo_array.get(i)+"\t");
			
			for(;j<traitcnt;j++) {
				out.print(traitvalinfo_array.get(j)+"\t");
			}			
			
			traitcnt+=trait_loop_cnt;
			out.print("\n");
		}
				
%>