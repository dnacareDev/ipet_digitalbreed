<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<%
	RunAnalysisTools runanalysistools = new RunAnalysisTools();		

	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	String sql=null;
	
	String one_sampleno = request.getParameter("one_sampleno");
	String two_sampleno = request.getParameter("two_sampleno");
	String varietyid = request.getParameter("varietyid");
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");	
	String savePath = rootFolder+"uploads/database/phenotype_img/phenotype_spyderplot/";		
	String outputPath = rootFolder+"result/database/phenotype_img/phenotype_spyderplot/";	
	
	String script_path = "/data/apache-tomcat-9.0.64/webapps/ROOT/digitalbreed_script/";	
	
	String jobid = runanalysistools.getCurrentDateTime();		

	File folder_savePath = new File(savePath+jobid);

	if (!folder_savePath.exists()) {
	try{
		folder_savePath.mkdir(); 
        } 
        catch(Exception e){
	    e.getStackTrace();
		}        
	}

	File folder_outputPath = new File(outputPath+jobid);
	
	if (!folder_outputPath.exists()) {
		try{
			folder_outputPath.mkdir(); 
			} 
			catch(Exception e){
			e.getStackTrace();
		}        
	}
	
	File fromfile = new File(savePath+jobid+"/"+jobid+".txt");
	
	System.out.println(savePath+jobid+"/"+jobid+".txt");
	
	fromfile.createNewFile();
	
	FileWriter fw = new FileWriter(fromfile, true) ;
	
	try{		
		sql = "select traitname from sampledata_traitname_t where varietyid='"+varietyid+"' order by seq asc;";	
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);		    
	    	    
	    fw.write("Taxa"+"\t");				
	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		fw.write(ipetdigitalconndb.rs.getString("traitname")+"\t");			
	  	 }	  	 
	  	fw.write("\n");		
	}catch(Exception e){
		System.out.println(e);
	}	
		
	try{		
		sql = "select samplename from sampledata_info_t where no='"+one_sampleno+"';";	
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);	
	    
	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		fw.write(ipetdigitalconndb.rs.getString("samplename")+"\t");			
	  	 }	  		  	
	}catch(Exception e){
		System.out.println(e);
	}
	
	try{		
		sql = "select value from sampledata_traitval_t where sampleno='"+one_sampleno+"' order by seq asc;";	
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);	
	    
	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		fw.write(ipetdigitalconndb.rs.getString("value")+"\t");			
	  	 }
		  fw.write("\n");		
	}catch(Exception e){
		System.out.println(e);
	}
	
	try{		
		sql = "select samplename from sampledata_info_t where no='"+two_sampleno+"';";	
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);	
	    
	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		fw.write(ipetdigitalconndb.rs.getString("samplename")+"\t");			
	  	 }	  		  	
	}catch(Exception e){
		System.out.println(e);
	}
	
	try{		
		sql = "select value from sampledata_traitval_t where sampleno='"+two_sampleno+"' order by seq asc;";	
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);	
	    
	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		fw.write(ipetdigitalconndb.rs.getString("value")+"\t");			
	  	 }	  	 
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
  	fw.flush();
  	
	String spyerplot_cmd = "Rscript "+script_path+"phenotype_spyderplot_final.R "+savePath+" "+outputPath+" "+ jobid +" " + jobid+".txt";		
	
	runanalysistools.execute(spyerplot_cmd);
	
	out.println(jobid);
%>
