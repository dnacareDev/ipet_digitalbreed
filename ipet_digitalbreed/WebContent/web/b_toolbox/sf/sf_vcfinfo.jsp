<!DOCTYPE html>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<html>
 <head>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 </head>

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
 
 
 <body>


<%
	String jobid = request.getParameter("jobid");
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String db_outputPath = rootFolder+"/result/Breeder_toolbox_analyses/subset/";	
	
	System.out.println("jobid : " + jobid);
	System.out.println("rootFolder : " + rootFolder);
	System.out.println("db_outputPath : " + db_outputPath);


	FileReader fileReader = new FileReader(db_outputPath+jobid+"/"+jobid+"_vcfinfo.txt");

	BufferedReader bufferedReader = new BufferedReader(fileReader);

	StringTokenizer s = null;

	String line = "";
	ArrayList<String> str = new ArrayList<>();

	out.println("<center><table  margin-top: 5px; border='1' style='width:100%;' class='bluetop' id='userListTable' border='1' px solid #444444>");

	while( (line = bufferedReader.readLine()) != null ){ 

		 s = new StringTokenizer(line, ":", false);

		 while (s.hasMoreElements()){
			str.add(s.nextElement()+"");
		 }
	}

	out.println("<tr height='30px'><td width='20%' bgcolor='f8f8f8'><b>"+str.get(0)+"</b></td><td width='20%' bgcolor='f8f8f8'><b>"+str.get(2)+"</b></td><td width='20%' bgcolor='f8f8f8'><b>"+str.get(4)+"</b></td><td width='20%'  bgcolor='f8f8f8'><b>"+str.get(6)+"</b></td><td width='20%'  bgcolor='f8f8f8'><b>"+str.get(8)+"</b></td></tr>");
	out.println("<tr height='30px'><td width='20%' >"+str.get(1)+"</td><td width='20%' >"+str.get(3)+"</td><td width='20%' >"+str.get(5)+"</td><td width='20%' >"+str.get(7)+"</td><td width='20%' >"+str.get(9)+"</td></tr>");
	out.println("<tr height='30px'><td width='20%' bgcolor='f8f8f8'><b>"+str.get(10)+"</b></td><td width='20%' bgcolor='f8f8f8'><b>"+str.get(12)+"</b></td><td width='20%' bgcolor='f8f8f8'><b>"+str.get(14)+"</b></td><td width='20%' bgcolor='f8f8f8'><b>"+str.get(16)+"</b></td><td width='20%' bgcolor='f8f8f8'><b>"+str.get(18)+"</b></td></tr>");
	out.println("<tr height='30px'><td width='20%' >"+str.get(11)+"</td><td width='20%' >"+str.get(13)+"</td><td width='20%' >"+str.get(15)+"</td><td width='20%' >"+str.get(17)+"</td><td width='20%' >"+str.get(19)+"</td></tr>");
	out.println("</table>");

%>

