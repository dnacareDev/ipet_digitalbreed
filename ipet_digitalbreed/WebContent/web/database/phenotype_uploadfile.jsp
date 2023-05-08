<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="com.oreilly.servlet.multipart.DefaultFileRenamePolicy" %>
<%@ page import="com.oreilly.servlet.MultipartRequest" %>
<%@ page import="org.apache.poi.xssf.usermodel.*" %>
<%@ page import="com.google.gson.*" %>

<%
	String path = request.getRealPath("/"); 
	int size = 1024 * 1024 * 10;
	String file = "";
	String originFile = "";
	String filename = "";

	RunAnalysisTools runanalysistools = new RunAnalysisTools();		
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String jobid = runanalysistools.getCurrentDateTime();

	String savePath = rootFolder+"uploads/database/phenotype_data/"+jobid+"/";	
		
	File folder_savePath = new File(savePath);

	if (!folder_savePath.exists()) {
		try{
			folder_savePath.mkdir(); 
	    }catch(Exception e){
		    e.getStackTrace();
		}        
	}
	
	try {
		MultipartRequest multi = new MultipartRequest(request, savePath, size, "UTF-8", new DefaultFileRenamePolicy());		
		
		String variety = multi.getParameter("variety");
		originFile = multi.getFilesystemName("ajaxFile"); 		
		
		//RunPhenotypetraitValue runphenotypetraitvalue = new RunPhenotypetraitValue();
		//runphenotypetraitvalue.UpdateTraitValue(savePath+originFile, variety, permissionUid);		
		
		insertSqlFromExcel(savePath+originFile, variety, permissionUid);
		
		
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		
		String log_sql="insert into log_t(logid, cropid, varietyid, menuname, comment, cre_dt) values('" +permissionUid+ "', (select cropid from variety_t where varietyid='"+variety+"'),'"+variety+"','Phenotype', 'New excel list uploaded', now());";
		//System.out.println(log_sql);
		
		try{
			ipetdigitalconndb.stmt.executeUpdate(log_sql);
		}catch(Exception e){
			System.out.println(e);
		}finally { 
    		ipetdigitalconndb.stmt.close();
    		ipetdigitalconndb.conn.close();
    	}

	} catch (Exception e){
		System.out.println(e);
		e.printStackTrace();
	}
%>

<%!
private void insertSqlFromExcel(String filename, String varietyid, String permissionUid) throws SQLException {
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

	
	int new_sampleid=1;
	String conv_newsampleid = null;
	String trait_cnt_sql=null;
	int trait_cnt=0;
	
	String cropid = "";
	try {
		String cropidSql = "select cropid from variety_t where varietyid='"+varietyid+"'";
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(cropidSql);
		if(ipetdigitalconndb.rs.next()) {
			cropid = ipetdigitalconndb.rs.getString("cropid");
		}
	} catch(Exception e){
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		System.out.println(e);
	}
	System.out.println("cropid : "+ cropid);
	
	try {
		String newsampleidsql="select SUBSTRING(sampleid,3) as newsampleid from sampledata_info_t order by sampleid desc limit 1;";
						
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(newsampleidsql);
		if(ipetdigitalconndb.rs.next()) {
			new_sampleid = Integer.parseInt(ipetdigitalconndb.rs.getString("newsampleid")) + 1;
		}
	
	}catch(Exception e){
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.rs.close();
			System.out.println(e);
	}	
	
	try{
		trait_cnt_sql="select max(seq) as traitcnt from sampledata_traitname_t where varietyid='"+varietyid+"'";
					
		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(trait_cnt_sql);
		ipetdigitalconndb.rs.next();
		trait_cnt = Integer.parseInt(ipetdigitalconndb.rs.getString("traitcnt"));

	}catch(Exception e){
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.rs.close();
			System.out.println("error : " + e);
	}				
	
	
    JsonArray jsonArray = new JsonArray();
    
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
        //System.out.println(rows);
        
        
        for(rowindex=1;rowindex<rows;rowindex++){
        	XSSFRow row=sheet.getRow(rowindex);
        	//System.out.println(row);
        	if(row !=null){
        		JsonObject jsonObject = new JsonObject();
        		JsonArray traitArr = new JsonArray();
        		
        		int cells=row.getPhysicalNumberOfCells();
                
                for(columnindex=0; columnindex<(trait_cnt+2); columnindex++){
                	//System.out.println("columnindex : " + columnindex);
                    //셀값을 읽는다
                    XSSFCell cell=row.getCell(columnindex);
                    //System.out.println("cell : " + cell);
                    
                    String value="";
                    //셀이 빈값일경우를 위한 널체크
                    if(cell==null) {
                        //continue;
                    	value="";
                    } else {
                        //타입별로 내용 읽기
                        switch (cell.getCellType()){
                            case XSSFCell.CELL_TYPE_FORMULA:
                                value=cell.getCellFormula();
                                break;
                            case XSSFCell.CELL_TYPE_NUMERIC:
                            	if(columnindex==1) {
                            		//columnindex == 1(개체명)일때 정수를 double로 변환해서 서로 matching이 안되는 문제. -> 강제 int화
                            		value=(int)cell.getNumericCellValue()+"";
                            	} else {
                            		value=cell.getNumericCellValue()+"";
                            	}
                                break;
                            case XSSFCell.CELL_TYPE_STRING:
                                value=cell.getStringCellValue()+"";
                                break;
                            case XSSFCell.CELL_TYPE_BLANK:
                                //value=cell.getBooleanCellValue()+"";
                            	value="";
                                break;
                            case XSSFCell.CELL_TYPE_ERROR:
                                value=cell.getErrorCellValue()+"";
                                break;
                        }
                        //System.out.println(value);
                    }
                    //System.out.println(value);
                    
                    if(columnindex == 0) {
                    	
                    	System.out.println(value);
                    	/*
                    	SimpleDateFormat formateador = new SimpleDateFormat("yyyy-MM-dd");
        				String cellValue = formateador.format(value);
        				jsonObject.addProperty("act_dt", cellValue);
                    	*/
                    	jsonObject.addProperty("act_dt", value);
                    } else if(columnindex == 1) {
                    	jsonObject.addProperty("samplename", value);
                    } else {
                    	traitArr.add(value);
                    }
                }
                jsonObject.addProperty("sampleid", "s-"+String.format("%05d", new_sampleid++));
                jsonObject.add("traitArr", traitArr);
                //System.out.println(jsonObject);
                jsonArray.add(jsonObject);
        	}
        }
        
	
	    workbook.close();
     
    }catch(Exception e) {
    	e.printStackTrace();
    }
    
	//System.out.println(jsonArray);
	
	
	//for(int i=0 ; i<jsonArray.size() ; i++) {
	for(int i=jsonArray.size()-1 ; i>=0 ; i--) {
		try {
			String insertSql_info = "insert into sampledata_info_t(cropid, varietyid, sampleid, samplename, photo_status, act_dt, creuser, cre_dt) values";
			insertSql_info += "('"+cropid+"', '"+varietyid+"','"+jsonArray.get(i).getAsJsonObject().get("sampleid").getAsString()+"','"+jsonArray.get(i).getAsJsonObject().get("samplename").getAsString()+"','0','"+jsonArray.get(i).getAsJsonObject().get("act_dt").getAsString()+"','"+permissionUid+"', now());";
			//System.out.println(insertSql_info);
			ipetdigitalconndb.stmt.executeUpdate(insertSql_info);
			
			int lastInsertedId = 0;
			String nextKeySql = "SELECT LAST_INSERT_ID() as id;";
			//System.out.println(nextKeySql);
			ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(nextKeySql);
			ipetdigitalconndb.rs.first();
			//System.out.println(ipetdigitalconndb.rs.getInt(1));
			lastInsertedId = ipetdigitalconndb.rs.getInt(1);
			
			
			String insertSql_traits = "insert into sampledata_traitval_t(cropid, varietyid, sampleid, sampleno, seq, value, creuser, cre_dt) values (";
			
			JsonArray traitArr = jsonArray.get(i).getAsJsonObject().get("traitArr").getAsJsonArray();
			
			StringBuilder insertSql_traits_values = new StringBuilder();
			for(int j=0 ; j<traitArr.size() ; j++) {
				insertSql_traits_values.append("'"+cropid+"', '"+varietyid+"','"+jsonArray.get(i).getAsJsonObject().get("sampleid").getAsString()+"', "+lastInsertedId+", "+(j+1)+ ", '"+traitArr.get(j).getAsString()+"', '"+permissionUid+"', now()");
				if(j != traitArr.size() -1) {
					insertSql_traits_values.append("),(");
				} else {
					insertSql_traits_values.append(");");
				}
			}
			
			//System.out.println(insertSql_traits + insertSql_traits_values);
			ipetdigitalconndb.stmt.executeUpdate(insertSql_traits + insertSql_traits_values);

			
		} catch (Exception e) {
			e.getMessage();
		}
	}
	
}
%>