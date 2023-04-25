<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*, java.util.stream.Stream"%> 
<%@ page import="com.google.gson.*" %>

<%
	String jobid = request.getParameter("jobid");
	String chr = request.getParameter("chr");
	int position = Integer.parseInt(request.getParameter("position"));
	String refgenome = request.getParameter("refgenome");
	//String gff = request.getParameter("gff");
	String gff = request.getParameter("gff_filename");
	
	/*
	System.out.println(jobid);
	System.out.println(chr);
	System.out.println(position);
	System.out.println(refgenome);
	System.out.println(gff);
	*/
	
	//long beforeTime = System.currentTimeMillis();
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder + "/uploads/reference_database/" +refgenome+ "/gff/";
	
	//File file = new File(path+gff+".gff");
	//BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
	
	//System.out.println("refgenome gff path : " + path);
	//System.out.println(file.exists());

	JsonObject result = new JsonObject();
	JsonArray mRnaArray = new JsonArray();
	JsonArray cdsArray = new JsonArray();
	
	//System.out.println(Paths.get(path+gff));
	
	Stream<String> lines = Files.lines(Paths.get(path+gff))
								.filter((item) -> item.contains(chr));
	
	lines.forEach(line -> {
		//System.out.println(line);
		String[] lineArr = line.split("\t");
		if( !((position - 50000) <= Integer.parseInt(lineArr[3]) && Integer.parseInt(lineArr[4]) <= (position + 50000)) ) {
			return;
		}
		
		String[] header = {"chr","annotation", "feature", "start", "end", "score", "strand", "frame", "attribute"};
		
		//System.out.println(line);
		if(lineArr[2].equals("mRNA")) {
			//System.out.println(line);
			
			JsonObject jsonObject = new JsonObject();
			for(int i=0 ; i<header.length ; i++) {
				if(i==3 || i==4){
					jsonObject.addProperty(header[i], Integer.parseInt(lineArr[i]));
				} else {
					jsonObject.addProperty(header[i], lineArr[i]);
				}
			}
			mRnaArray.add(jsonObject);
			
		} else if(lineArr[2].equals("CDS")) {
			//System.out.println(line);
			JsonObject jsonObject = new JsonObject();
			for(int i=0 ; i<header.length ; i++) {
				//jsonObject.addProperty(header[i], lineArr[i]);
				if(i==3 || i==4){
					jsonObject.addProperty(header[i], Integer.parseInt(lineArr[i]));
				}  else if (i==8) {
					jsonObject.addProperty(header[i], lineArr[i]);
				} 
			}
			cdsArray.add(jsonObject);
		}
		
	});
	
	result.add("mRNA", mRnaArray);
	result.add("CDS", cdsArray);
				
	//long afterTime = System.currentTimeMillis();
	
	out.clear();
	out.print(result);
	//System.out.println("read .gff time : " + (afterTime -  beforeTime) + "ms");
%>