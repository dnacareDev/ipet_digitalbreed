<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<html>
 <head>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>

 <style type="text/css">
    td:hover {
	  background-color: #aad5f8;
	  color: #000000;	  
	}

	table {
	  border-collapse: collapse;
	  font-size: 10pt;
	}
	.tableWrapper {
	  border-top: 3px solid #168;
		width: 400px;
		height: 300px;
		overflow: auto;
		position: relative;
	}

	.bluetop {
	  border-collapse: collapse;
	  line-height:16px;
	} 

	.bluetop th, .bluetop td {
	  border: 1px solid #ddd;
	  text-align:center;
	}


 </style>
 </head>
 
 
 <body>
<%
	String jobid = request.getParameter("jobid");

	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	
	String db_outputPath = rootFolder+"/result/Breeder_toolbox_analyses/pheno/anova/";	

	
	//FileReader fileReader = new FileReader(db_outputPath+jobid+"/ANOVA.result.csv");
	//BufferedReader bufferedReader = new BufferedReader(fileReader);
	
	FileInputStream fileInputStream = new FileInputStream(db_outputPath+jobid+"/ANOVA.result.csv");
	InputStreamReader inputStreamReader = new InputStreamReader(fileInputStream, "UTF-8");
	BufferedReader bufferedReader = new BufferedReader(inputStreamReader);
	
	//out.clear();
	out.println("<center><table margin-top: 5px; border='1' style='width:100%; border-collapse:collapse;' class='bluetop' id='userListTable' border='' px solid #444444>");
	int count = 0;
	String line = "";
	while( (line = bufferedReader.readLine()) != null ){ 

		 String[] str = line.split(",");
		 out.print("<tr height='30px'>");
		 for(int i=0 ; i<str.length ; i++) {
			 if(count ==0 ) {
				 out.print("<td bgcolor='f8f8f8'><b>"+str[i].replaceAll("\"","")+"</b></td>");
			 } else {
				 out.print("<td>"+str[i].replaceAll("\"","")+"</td>");
			 }
		 }
		 out.println("</tr>");
		 count++;
	}
	out.println("</table></center>");
	/*
	*/
	
	/*
	StringTokenizer s = null;

	String line = "";
	ArrayList<String> str = new ArrayList<>();

	out.println("<center><table  margin-top: 5px; border='1' style='width:100%;' class='bluetop' id='userListTable' border='1' px solid #444444>");

	while( (line = bufferedReader.readLine()) != null ){ 

		 s = new StringTokenizer(line, ",", false);

		 while (s.hasMoreElements()){
			str.add((s.nextElement()+"").replaceAll("\"", ""));
		 }
	}

	//System.out.println(str);
	
	
	out.println("<tr height='30px'><td width='20%' bgcolor='f8f8f8'><b>"+str.get(0)+"</b></td><td width='20%' bgcolor='f8f8f8'><b>"+str.get(1)+"</b></td><td width='20%' bgcolor='f8f8f8'><b>"+str.get(2)+"</b></td><td width='20%'  bgcolor='f8f8f8'><b>"+str.get(3)+"</b></td></tr>");
	out.println("<tr height='30px'><td width='20%' >"+str.get(4)+"</td><td width='20%' >"+str.get(5)+"</td><td width='20%' >"+str.get(6)+"</td><td width='20%' >"+str.get(7)+"</td></tr>");
	out.println("</table>");
	*/
	bufferedReader.close();
%>

