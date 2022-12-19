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
	File fromfile_full = new File(savePath+jobid+"/"+jobid+"_full.txt");
	
	fromfile.createNewFile();
	fromfile_full.createNewFile();
	
	FileWriter fw = new FileWriter(fromfile, true) ;
	FileWriter fw_full = new FileWriter(fromfile_full, true) ;

	int traitcnt=0;
	
	try{		
			sql = "select traitname from sampledata_traitname_t where varietyid='"+varietyid+"' order by seq asc;";	
			System.out.println(sql);
			ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);		    
					
			fw.write("Taxa"+"\t");
			fw_full.write("Taxa"+"\t");

			 while (ipetdigitalconndb.rs.next()) { 		
				fw.write(ipetdigitalconndb.rs.getString("traitname")+"\t");		
				fw_full.write(ipetdigitalconndb.rs.getString("traitname")+"\t");	
				traitcnt++;
			 }	  	 
			fw.write("\n");
			fw_full.write("\n");
		}catch(Exception e){
			System.out.println(e);
		}finally { 
			ipetdigitalconndb.rs.close();
		}
			
	try{		
		sql = "select samplename from sampledata_info_t where no='"+one_sampleno+"';";	
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);	
	    System.out.println(sql);
	    
	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		 System.out.println(ipetdigitalconndb.rs.getString("samplename"));
	  		fw.write(ipetdigitalconndb.rs.getString("samplename")+"\t");			
	  	 }	  		  	
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.rs.close();
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
	}finally { 
		ipetdigitalconndb.rs.close();
	}
	
	try{		
		sql = "select samplename from sampledata_info_t where no='"+two_sampleno+"';";	
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);	
	    
	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		fw.write(ipetdigitalconndb.rs.getString("samplename")+"\t");			
	  	 }	  		  	
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.rs.close();
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
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.stmt.close();
		//ipetdigitalconndb.conn.close();
	}
	
  	fw.flush();  	
  	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();  	

	ArrayList<String> fullsamplename = new ArrayList<>();
	ArrayList<String> fulltraitval = new ArrayList<>();
	
  	try{		
		sql = "select a.samplename, b.value from sampledata_info_t a, sampledata_traitval_t b where a.varietyid='"+varietyid+"' and a.no=b.sampleno order by b.sampleno desc, b.seq asc;";	
	    ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);	

	  	 while (ipetdigitalconndb.rs.next()) { 		
	  		fullsamplename.add(ipetdigitalconndb.rs.getString("samplename"));
	  		fulltraitval.add(ipetdigitalconndb.rs.getString("value"));
	  	 }	  	 
	}catch(Exception e){
		System.out.println(e);
	}finally { 
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.conn.close();
	}
	
	int j=0;
	int traitcnt_loop=traitcnt;

  	for(int i=0;i<fullsamplename.size();) { 
  		
  		fw_full.write(fullsamplename.get(i)+"\t");			

  		for(;j<traitcnt_loop;j++) {   	  		
  			fw_full.write(fulltraitval.get(j)+"\t");
  			i++;
  		}
		fw_full.write("\n");
		traitcnt_loop +=traitcnt;  		
	}
  	
  	fw_full.flush();  	
  	
	String spyerplot_cmd = "Rscript "+script_path+"phenotype_spyderplot_final.R "+savePath+" "+outputPath+" "+ jobid +" " + jobid+".txt"+" " + jobid+"_full.txt";		
	
	runanalysistools.execute(spyerplot_cmd, "cmd");
	
	out.println(jobid);
%>
