<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%
	String permissionUid = session.getAttribute("permissionUid")+"";

	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"result/database/genotype_statistics/20230112165329/browser_data/";

	String jobid = "20230112165329";
	
	
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	
	File txtFile = new File(path+"20230112165329_genotype_matrix_file.txt");
	System.out.println("==============");
	System.out.println("read list file");
	System.out.println("==============");
	
	try {
		BufferedReader br = new BufferedReader(new FileReader(txtFile));
		
		int lineCount = 1;
		
		String listLine = "";
		while( (listLine = br.readLine()) != null) {
			
			int txtLength = listLine.length();
			String extension = listLine.substring(txtLength - 3, txtLength);
			
			if(extension.equals("csv")) {
				//System.out.println("CSV file");
				
				readCSV(jobid, permissionUid, path, lineCount++, listLine);
				
				/*
				if(chrCount != 1) {
					continue;
				}
				
				
				File csvFile = new File(rootFolder + path + chrCount++ + "_genotype_matrix.csv");
				
				
				BufferedReader csvBr = new BufferedReader(new FileReader(csvFile), 524288);
				String csvLine = csvBr.readLine();
				int count2 = 0;
				
				String insertSnpColumnPartSql = "insert into variant_snp_t (jobid, chr, row_no, pos_index, genotype, creuser) values ";
				StringBuilder insertSnpValuesPartSql = new StringBuilder();
				
				while( csvLine != null) {
					count2++;
					
					if(count2 == 1) {
						System.out.println(count2);
						csvLine = csvBr.readLine();
						continue;
					} else if (count2 == 2) {
						System.out.println(count2);
						System.out.println(csvLine);
						
						String[] posArr = csvLine.split(",");
						//System.out.println(Arrays.toString(posArr));
						
						String insertPosColumnPartSql = "insert into variant_pos_t (jobid, chr, row_no, pos_index, position, creuser) values ";
						StringBuilder insertPosValuesPartSql = new StringBuilder();
						
						//int posIndex = 1;
						for(int i=1 ; i<posArr.length ; i++) {
							if(i != posArr.length -1 ) {
								insertPosValuesPartSql.append("('" +jobid+ "', " +chrCount+ ", 0, " +i+", " +posArr[i]+ ", '" +permissionUid+ "'), ");
							} else {
								insertPosValuesPartSql.append("('" +jobid+ "', " +chrCount+ ", 0, " +i+", " +posArr[i]+ ", '" +permissionUid+ "');");
							}
						}
						//System.out.println(insertPosColumnPartSql+insertPosValuesPartSql);
					}  else if (count2 == 3) {
						System.out.println(count2);
						//System.out.println(csvLine);
						String[] posArr = csvLine.split(",");
						System.out.println(Arrays.toString(posArr));
						
						
						
						//int posIndex = 0;
						for (int i=0 ; i<posArr.length ; i++) {
							insertSnpValuesPartSql.append("('" +jobid+ "', " +chrCount+ ", 0, " +i+", '" +posArr[i]+ "', '" +permissionUid+ "'), ");
							
							//if(i != posArr.length -1 ) {
							//	insertSnpValuesPartSql.append("('" +jobid+ "', " +chrCount+ ", 0, " +i+", '" +posArr[i]+ "', '" +permissionUid+ "'), ");
							//} else {
							//	insertSnpValuesPartSql.append("('" +jobid+ "', " +chrCount+ ", 0, " +i+", '" +posArr[i]+ "', '" +permissionUid+ "');");
							//}
							
						}
						//System.out.println(insertSnpColumnPartSql+insertSnpValuesPartSql);
						
					}  else if (count2 == 4) {
						System.out.println(count2);
						//System.out.println(csvLine);
						String[] posArr = csvLine.split(",");
						System.out.println(Arrays.toString(posArr));
						
						for (int i=0 ; i<posArr.length ; i++) {
							if(i != posArr.length -1 ) {
								insertSnpValuesPartSql.append("('" +jobid+ "', " +chrCount+ ", 0, " +i+", '" +posArr[i]+ "', '" +permissionUid+ "'), ");
							} else {
								insertSnpValuesPartSql.append("('" +jobid+ "', " +chrCount+ ", 0, " +i+", '" +posArr[i]+ "', '" +permissionUid+ "');");
							}
						}
						System.out.println(insertSnpColumnPartSql+insertSnpValuesPartSql);
					} else {
						System.out.println(count2);
						//System.out.println(csvLine);
						String[] posArr = csvLine.split(",");
						System.out.println(Arrays.toString(posArr));
						
						for (int i=0 ; i<posArr.length ; i++) {
							if(i != posArr.length -1 ) {
								insertSnpValuesPartSql.append("('" +jobid+ "', " +chrCount+ ", 0, " +i+", '" +posArr[i]+ "', '" +permissionUid+ "'), ");
							} else {
								insertSnpValuesPartSql.append("('" +jobid+ "', " +chrCount+ ", 0, " +i+", '" +posArr[i]+ "', '" +permissionUid+ "');");
							}
						}
						//System.out.println(insertSnpColumnPartSql+insertSnpValuesPartSql);
					}
					
				}
				csvBr.close();
				*/
			} else {
				System.out.println("=======================");
				System.out.println("no read. maybe TXT file");
				System.out.println("=======================");
			}
		}
		br.close();
		
		
		
	} catch (IOException e) {
		e.printStackTrace();
	} 
	
	
%>


<%!
	public void readCSV(String jobid, String permissionUid, String path, int lineCount, String listLine) {
		
		//юс╫ц
		if(lineCount != 1) {
			return;
		}
	
		System.out.println(jobid+" "+permissionUid+" "+lineCount);
		System.out.println(listLine);
		
		try {
			File csvFile = new File(path + lineCount++ + "_genotype_matrix.csv");
			
			
			BufferedReader csvBr = new BufferedReader(new FileReader(csvFile), 524288);
			String csvLine = csvBr.readLine();
			
			
			
			int count2 = 0;
			
			
			
			csvBr.close();
		} catch (IOException e) {
			e.printStackTrace();
		}
		
	}
%>