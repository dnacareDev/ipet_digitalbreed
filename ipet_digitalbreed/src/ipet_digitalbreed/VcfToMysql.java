package ipet_digitalbreed;

import java.util.*;
import java.io.*;
import java.sql.*;

public class VcfToMysql {

	static IPETDigitalConnDB ipetdigitalconndb = null;
	
	public static void main(String[] args)  throws Exception {
		
		//String jobid="20221112211631";
		//String creuser="dnacare";
		
		String savePath = args[0];
		String jobid = args[1];
		String creuser = args[2];
		
		///result/database/genotype_statistics/20221112211631/20221112211631_genotype_matrix.csv		
		 
		ipetdigitalconndb = new IPETDigitalConnDB();	
		
		BufferedReader file = null;
		
		    try {
		    	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		    	
		    	
			    file = new BufferedReader(new FileReader(savePath+jobid+"_genotype_matrix.csv"));
				
			    
			    String line = "";
			    
		      //while ((line = file.readLine()) != null) {
		        line = file.readLine();
		        String[] position_data = line.split(",");
		        String position_sql=null;
		        
		        String status_sql="insert into vcf_parsing_status_t(jobid, status, creuser, cre_dt) values('"+jobid+"','1/3','"+creuser+"',now());";
	        	
	        	ipetdigitalconndb.stmt.executeUpdate(status_sql);
	        	
		        for(int i=1;i<position_data.length;i++) {	
		        	position_sql="insert into chr_pos_t(jobid, chrno, pos, creuser, cre_dt) values('"+jobid+"','"+position_data[i].substring(0,position_data[i].indexOf("_"))+"','"+position_data[i].substring(position_data[i].indexOf("_")+1)+"','"+creuser+"',now());";
		        	
		        	ipetdigitalconndb.stmt.executeUpdate(position_sql);
		        	
		        	System.out.println(position_sql);
		        }
		        
		        status_sql="update vcf_parsing_status_t set status='2/3' where jobid='"+jobid+"'";
	        	
	        	ipetdigitalconndb.stmt.executeUpdate(status_sql);
	        	
		        line = file.readLine();
		        
		        String[] alleles_data = line.split(",");		        
		        String alleles_sql=null;
		        int i=1;
		        for(int j=1;j<alleles_data.length;j++) {
		        	alleles_sql="insert into alleles_t(jobid, chrno, pos, genotype, creuser, cre_dt) values('"+jobid+"','"+position_data[i].substring(0,position_data[i].indexOf("_"))+"','"+position_data[i].substring(position_data[i].indexOf("_")+1)+"','"+alleles_data[j]+"','"+creuser+"',now());";
		        	System.out.println(alleles_sql);
		        	ipetdigitalconndb.stmt.executeUpdate(alleles_sql);
		        	i++;
		        }
		        
		        status_sql="update vcf_parsing_status_t set status='3/3' where jobid='"+jobid+"'";
	        	
	        	ipetdigitalconndb.stmt.executeUpdate(status_sql);
	        	
		        String accession_sql=null;
		        
		        while ((line = file.readLine()) != null) {
		        	i=1;
		        	String[] accession_data = line.split(",");			        
		        	//System.out.println(accession_data.length);	
		        	for(int k=1;k<accession_data.length;k++) {
		        		accession_sql="insert into accession_t(jobid, chrno, pos, accession, genotype, creuser, cre_dt) values('"+jobid+"','"+position_data[i].substring(0,position_data[i].indexOf("_"))+"','"+position_data[i].substring(position_data[i].indexOf("_")+1)+"','"+accession_data[0]+"','"+accession_data[k]+"','"+creuser+"',now());";
		        		System.out.println(accession_sql);	
		        		ipetdigitalconndb.stmt.executeUpdate(accession_sql);
		        		i++;
			        }
		        	
		        }
		        
		        String finish_status_sql="update vcf_parsing_status_t set status='t' where jobid='"+jobid+"'";
	        	
	        	ipetdigitalconndb.stmt.executeUpdate(finish_status_sql);
	        	
		    }catch(Exception e){
				System.out.println(e);
			}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.conn.close();
			}
		

	}	
}