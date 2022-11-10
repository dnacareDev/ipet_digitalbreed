<%@ page language="java" contentType="text/html; charset=EUC-KR" pageEncoding="EUC-KR"%>
<%@page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@page import="org.apache.poi.ss.usermodel.*,org.apache.poi.hssf.usermodel.*,org.apache.poi.xssf.usermodel.*"%>
<%@page import="ipet_digitalbreed.*"%>   
<%
	try{

		SimpleDateFormat sdf = new SimpleDateFormat("yyyyMMddHHmmss");
		java.util.Date currentTime = new java.util.Date( ); 
		Calendar c1 = Calendar.getInstance();
		String credate = sdf.format(c1.getTime());
		IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	 	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

		String permissionUid = session.getAttribute("permissionUid")+"";
		String varietyid = request.getParameter("varietyid");

		ipetdigitalconndb = new IPETDigitalConnDB();	
		
		int traitcnt=0;
		int traitcnt_header=2;

		String itemnameinfo_sql="select samplename, act_dt from sampledata_info_t where varietyid='"+varietyid+"' and creuser='"+permissionUid+"' order by no desc;";
		
		ArrayList<String> itemnameinfo_array = new ArrayList<>();
		ArrayList<String> act_dt_array = new ArrayList<>();

		try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();				
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(itemnameinfo_sql);
				
				while (ipetdigitalconndb.rs.next()) {				
					itemnameinfo_array.add(ipetdigitalconndb.rs.getString("samplename"));			
					act_dt_array.add(ipetdigitalconndb.rs.getString("act_dt"));			
				}				
		}catch(Exception e){
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				System.out.println(e);
		}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
		}
	
		
		String traitvalinfo_sql="select value from sampledata_traitval_t  where varietyid='"+varietyid+"' and creuser='"+permissionUid+"'  order by sampleno desc, seq asc;";
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
				System.out.println(e);
		}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
		}
				
		
		String headerinfo_sql="select traitname from sampledata_traitname_t where varietyid='"+varietyid+"' and creuser='"+permissionUid+"' order by seq asc;";


		
		Workbook wb = new XSSFWorkbook();
		Sheet sheet = wb.createSheet("phenotype database");
		Row row = null;
		Cell cell = null;
		int rowNum = 0;
		
		row = sheet.createRow(rowNum++);

		CellStyle cellStyle = row.getSheet().getWorkbook().createCellStyle();
		cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
		
		cellStyle.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle.setBorderBottom(HSSFCellStyle.BORDER_THIN);

		cellStyle.setFillForegroundColor(IndexedColors.LEMON_CHIFFON.getIndex());
		cellStyle.setFillPattern(CellStyle.SOLID_FOREGROUND);
				
		CellStyle cellStyle_trait = row.getSheet().getWorkbook().createCellStyle();
		cellStyle_trait.setAlignment(CellStyle.ALIGN_CENTER);
	
		cellStyle_trait.setBorderRight(HSSFCellStyle.BORDER_THIN);
		cellStyle_trait.setBorderLeft(HSSFCellStyle.BORDER_THIN);
		cellStyle_trait.setBorderTop(HSSFCellStyle.BORDER_THIN);
		cellStyle_trait.setBorderBottom(HSSFCellStyle.BORDER_THIN);
		
		Font font = wb.createFont();
		font.setFontName("맑은 고딕"); //폰트이름
		font.setFontHeight((short)200); //폰트 size -> 260 = 13point
		font.setBold(true); // Bold 설정		
			
		Font font_trait = wb.createFont();
		font_trait.setBold(false); // Bold 설정
		
		cellStyle.setFont(font); // 위에 선언한 font 적용
				
		cellStyle_trait.setFont(font_trait); // 위에 선언한 font 적용
		cell = row.createCell(0);
		cell.setCellValue("조사일자");
		cell.setCellStyle(cellStyle);		
		cell = row.createCell(1);
		cell.setCellValue("개체명");
		cell.setCellStyle(cellStyle);
		 
		int j=0;
		
		try{
				ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();				
				ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(headerinfo_sql);
				
				while (ipetdigitalconndb.rs.next()) { 					
					cell = row.createCell(traitcnt_header);
					cell.setCellValue(ipetdigitalconndb.rs.getString("traitname"));
					traitcnt++;
					traitcnt_header++;
					cell.setCellStyle(cellStyle);
				}				
		}catch(Exception e){
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				ipetdigitalconndb.conn.close();
				System.out.println(e);
		}finally { 
				ipetdigitalconndb.stmt.close();
				ipetdigitalconndb.rs.close();
				ipetdigitalconndb.conn.close();
		}

		int trait_loop_cnt=traitcnt;
		int cnt=0;		
		
		System.out.println(trait_loop_cnt);
		
		for(int i=0;i<itemnameinfo_array.size();i++) {
			row = sheet.createRow(rowNum++);
			cell = row.createCell(cnt);
			cell.setCellValue(act_dt_array.get(i));
			System.out.println(act_dt_array.get(i));
			cell.setCellStyle(cellStyle_trait);
			cnt++;
			cell = row.createCell(cnt);
			cell.setCellValue(itemnameinfo_array.get(i));
			cell.setCellStyle(cellStyle_trait);
			cnt++;
			for(;j<traitcnt;j++) {
				
				System.out.println(traitvalinfo_array.get(j));
				cell = row.createCell(cnt++);
				cell.setCellValue(traitvalinfo_array.get(j));
				cell.setCellStyle(cellStyle_trait);
			}			
			cnt=0;
			traitcnt+=trait_loop_cnt;			
		}
				
		response.setContentType("ms-vnd/excel");
		response.setHeader("Content-Disposition", "attachment;filename="+credate+".xlsx");
		
		 wb.write(response.getOutputStream());
	     wb.close();
	}catch(Exception e){		
		System.out.println(e);
	}
	
%>