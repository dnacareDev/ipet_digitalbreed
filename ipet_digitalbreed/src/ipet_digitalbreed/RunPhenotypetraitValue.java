package ipet_digitalbreed;

import org.apache.poi.ss.usermodel.*;
import org.apache.poi.hssf.usermodel.*;
import org.apache.poi.xssf.usermodel.*;
import java.io.*;
import java.util.*;
import java.text.*;

public class RunPhenotypetraitValue {

	public void UpdateTraitValue(String filename, String varietyid, String userid) throws Exception
	{

		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();	

		int newsampleid=0;
		String conv_newsampleid = null;
		String trait_cnt_sql=null;
		int trait_cnt=0;
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
		
		try{
			ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
			trait_cnt_sql="select max(seq) as traitcnt from sampledata_traitname_t where varietyid='"+varietyid+"'";
						
			ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(trait_cnt_sql);
			
			while (ipetdigitalconndb.rs.next()) { 						
				trait_cnt = Integer.parseInt(ipetdigitalconndb.rs.getString("traitcnt"));
			}
	
		}catch(Exception e){
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				System.out.println("error : " + e);
		}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
		}				
		
		 try {
	            FileInputStream file = new FileInputStream(filename);
	            XSSFWorkbook workbook = new XSSFWorkbook(file);
	 
	            int rowindex=0;
	            int columnindex=0;
	            //시트 수 (첫번째에만 존재하므로 0을 준다)
	            //만약 각 시트를 읽기위해서는 FOR문을 한번더 돌려준다
	            XSSFSheet sheet=workbook.getSheetAt(0);
	            //행의 수
	            int rows=sheet.getPhysicalNumberOfRows();
	            
	            int newsampleid_rows=rows;	            
          
	            ArrayList<Integer> newsampleid_arr=new ArrayList<Integer>();
	            
	            for(int i=0;i<rows;i++) {	            	
	            	newsampleid_arr.add(newsampleid++);
	            }
	            
	            for(rowindex=0;rowindex<rows;rowindex++){
	                //행을읽는다
	                XSSFRow row=sheet.getRow(rowindex);
	                if(row !=null){
	                    //셀의 수
	                    int cells=row.getPhysicalNumberOfCells();
	                    
	                    for(columnindex=0; columnindex<=(trait_cnt+2); columnindex++){
	                        //셀값을 읽는다
	                        XSSFCell cell=row.getCell(columnindex);
	                        String value="";
	                        //셀이 빈값일경우를 위한 널체크
	                        if(cell==null){
	                            //continue;
	                        	value="";
	                        }else{
	                            //타입별로 내용 읽기
	                            switch (cell.getCellType()){
	                            case XSSFCell.CELL_TYPE_FORMULA:
	                                value=cell.getCellFormula();
	                                break;
	                            case XSSFCell.CELL_TYPE_NUMERIC:
	                                value=cell.getNumericCellValue()+"";
	                                break;
	                            case XSSFCell.CELL_TYPE_STRING:
	                                value=cell.getStringCellValue()+"";
	                                break;
	                            case XSSFCell.CELL_TYPE_BLANK:
	                                value=cell.getBooleanCellValue()+"";
	                                break;
	                            case XSSFCell.CELL_TYPE_ERROR:
	                                value=cell.getErrorCellValue()+"";
	                                break;
	                            }
	                        }
	                        
	                		String sampledata_info_sql=null;
	                		String actdt_sql=null;
	                		String sampledata_traitval_sql=null;
	                		String sample_no_sql=null;
	                		String sample_no=null;	     
	                		int columnindexcnt=1;
	                		
	                		if(columnindex==0) {
		                		try{
		                				newsampleid++;	  
		                				
		                				//conv_newsampleid = "s-"+String.format("%05d", newsampleid);	    
		                				
		                				conv_newsampleid = "s-"+String.format("%05d", newsampleid_arr.get(newsampleid_rows--));		                						                        
		                				
		                				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();	
		                				
		                				SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
		                				String cellValue = formateador.format(cell.getDateCellValue());
		                				
		                				actdt_sql="insert into sampledata_info_t(cropid, varietyid, sampleid, samplename, photo_status, creuser, cre_dt, act_dt) values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"','"+conv_newsampleid+"','','0','dnacare', now(),'"+cellValue+"');";
		                						                				
		                				ipetdigitalconndb.stmt.executeUpdate(actdt_sql);			                				
		                				//select no, samplename from sampledata_info_t where varietyid='v-00001' and samplename='test9' and creuser='dnacare';
		                				//insert into sampledata_traitval_t(cropid, varietyid, sampleid, sampleno, seq, value, creuser, cre_dt) values((select cropid from variety_t where varietyid='v-00001'), 'v-00001','s-00009','211','1','10', 'dnacare', now());
	
		                		}catch(Exception e){
		                				System.out.println(e);
		                				ipetdigitalconndb.stmt.close();
		                		}finally { 
		                				ipetdigitalconndb.stmt.close();
		                		} 
	                		}
	                		
	                		if(columnindex==1) {
		                		try{
		                				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();		
		                				
		                				sampledata_info_sql="update sampledata_info_t set samplename='"+value+"' where sampleid='"+conv_newsampleid+"'";				
		                				
		                				ipetdigitalconndb.stmt.executeUpdate(sampledata_info_sql);	

		                				//select no, samplename from sampledata_info_t where varietyid='v-00001' and samplename='test9' and creuser='dnacare';
		                				//insert into sampledata_traitval_t(cropid, varietyid, sampleid, sampleno, seq, value, creuser, cre_dt) values((select cropid from variety_t where varietyid='v-00001'), 'v-00001','s-00009','211','1','10', 'dnacare', now());
	
		                		}catch(Exception e){
		                				System.out.println(e);
		                				ipetdigitalconndb.stmt.close();
		                		}finally { 
		                				ipetdigitalconndb.stmt.close();
		                		} 
	                		}
	                		
	                		if(columnindex>1 && columnindex<=trait_cnt+1) {
	                			
	                			try{
	                				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	                				sample_no_sql="select no from sampledata_info_t where sampleid='"+conv_newsampleid+"'";
	                				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sample_no_sql);
	                				
	                				while (ipetdigitalconndb.rs.next()) { 						
	                					sample_no = ipetdigitalconndb.rs.getString("no");
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
	                				
	                				sampledata_traitval_sql="insert into sampledata_traitval_t(cropid, varietyid, sampleid, sampleno, seq, value, creuser, cre_dt) values((select cropid from variety_t where varietyid='"+varietyid+"'), '"+varietyid+"','"+conv_newsampleid+"','"+sample_no+"','"+(columnindex-1)+"','"+value+"', 'dnacare', now());";				
	                					                				
	                				ipetdigitalconndb.stmt.executeUpdate(sampledata_traitval_sql);	

		                		}catch(Exception e){
		                				ipetdigitalconndb.stmt.close();
		                		}finally { 
		                				ipetdigitalconndb.stmt.close();
		                		} 	                			
	                		}	                        
	                    }
	 
	                }
	            }
	 
	        }catch(Exception e) {
	            e.printStackTrace();
	        }finally { 
	        	ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				ipetdigitalconndb.conn.close();
	        } 
			
	}

}
