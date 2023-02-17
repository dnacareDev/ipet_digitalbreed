<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%
	String permissionUid = session.getAttribute("permissionUid")+"";


	String rootFolder = request.getSession().getServletContext().getRealPath("/");
	String path = rootFolder+"uploads/reference_database/";

	//System.out.println(path);
	
	String command = request.getParameter("command");
	String file_name = request.getParameter("file_name");
	String refgenome = request.getParameter("refgenome");
	
	
	out.clear();
	String sequence = "";
	switch(command) {
		case "gene":
			sequence = geneSequence(path, file_name, refgenome);
			break;
		case "cds":
			sequence = cdsSequence(path, file_name, refgenome);
			break;
		case "protein":
			sequence = proteinSequence(path, file_name, refgenome);
			break;
	}
	
	out.print(sequence);
%>

<%!
	public String geneSequence(String path, String file_name, String refgenome) {

		//System.out.println("gene file name : " + file_name);
	
		//System.out.println(path+refgenome+"/split/gene/"+file_name+".fasta");
		File file = new File(path+refgenome+"/split/gene/"+file_name+".fasta");
		
		String sequence = "";
		try {
			BufferedReader br = new BufferedReader(new FileReader(file));
			
			String line = br.readLine();
			while(true) {
				sequence += line;
				if((line=br.readLine()) == null) {
					break;
				} else {
					sequence += "\n";
				}
			}
			br.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		} 
		//System.out.println(sequence);
		return sequence;
	}
%>

<%!
	public String cdsSequence(String path, String file_name, String refgenome) {
		
		//System.out.println(path+refgenome+"/split/cds/"+file_name+".fasta");
		File file = new File(path+refgenome+"/split/cds/"+file_name+".fasta");
		
		String sequence = "";
		try {
			BufferedReader br = new BufferedReader(new FileReader(file));
			
			String line = br.readLine();
			while(true) {
				sequence += line;
				if((line=br.readLine()) == null) {
					break;
				} else {
					sequence += "\n";
				}
			}
			br.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		} 
		return sequence;
	}
%>

<%!
	public String proteinSequence(String path, String file_name, String refgenome) {

		//System.out.println(path+refgenome+"/split/pep/"+file_name+".fasta");
		File file = new File(path+refgenome+"/split/pep/"+file_name+".fasta");
		
		String sequence = "";
		try {
			BufferedReader br = new BufferedReader(new FileReader(file));
			
			String line = br.readLine();
			while(true) {
				sequence += line;
				if((line=br.readLine()) == null) {
					break;
				} else {
					sequence += "\n";
				}
			}
			br.close();
			
		} catch (IOException e) {
			e.printStackTrace();
		} 
		return sequence;
	}
%>