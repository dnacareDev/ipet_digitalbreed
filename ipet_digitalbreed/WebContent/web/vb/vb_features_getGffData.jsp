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
	String gff = request.getParameter("gff");
	
	
	System.out.println(jobid);
	System.out.println(chr);
	System.out.println(position);
	System.out.println(refgenome);
	System.out.println(gff);
	
	
	long beforeTime = System.currentTimeMillis();
	
	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder + "/uploads/reference_database/" +refgenome+ "/gff/";
	
	File file = new File(path+gff+".gff");
	
	System.out.println(path);
	//System.out.println(file.exists());

	/*
	BufferedReader br = new BufferedReader(new InputStreamReader(new FileInputStream(file)));
	
	JsonArray result = new JsonArray();
	JsonArray mRnaArray = new JsonArray();
	JsonArray cdsArray = new JsonArray();
	
	String line;
	while((line = br.readLine()) != null) {
		
		List<String> lineArr = Arrays.asList(line.split("\t"));
		
		String chrInGff = lineArr.get(0);
		int start = Integer.parseInt(lineArr.get(3));
		int end = Integer.parseInt(lineArr.get(4));
		
		if(chr.equals(chrInGff) && (position - 50000) <= start && end <= (position + 50000)) {
			System.out.println(lineArr);
		}
		
	}
	br.close();
	*/
	
	Stream<String> lines = Files.lines(Paths.get(path+gff+".gff"))
								.filter((item)-> item.contains(chr) || (position - 50000) <= Integer.parseInt(item.split("\t")[3]) || Integer.parseInt(item.split("\t")[4]) <= (position + 50000) );
								//.filter(t->t.contains(chr));
	
	lines.forEach(line -> {
		System.out.println(line);
	})
				
	/*
	lines.forEach(line -> {
        //System.out.println(line);
        List<String> lineArr = Arrays.asList(line.split("\t"));
        int start = Integer.parseInt(lineArr.get(3));
		int end = Integer.parseInt(lineArr.get(4));
        if((position - 50000) <= start && end <= (position + 50000)) {
        	System.out.println(lineArr);
        }
    });
	*/
	
	long afterTime = System.currentTimeMillis();
	
	System.out.println("time : " + (afterTime -  beforeTime) + "ms");
	
	//out.clear();
%>