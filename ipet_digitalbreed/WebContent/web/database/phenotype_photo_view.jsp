<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="com.innorix.transfer.InnorixUpload" %>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<style>
body {
	font-family: 'SDSamliphopangche_Outline';
}
</style>

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String permissionUid = session.getAttribute("permissionUid")+"";

	String no = request.getParameter("no");		

	String sql = "SELECT photogps, photodate, filename, cre_dt, imgseq  FROM sampledata_img_t where sampleno='"+no+"'";
	
	String path = "../../uploads/database/phenotype_img/"+no+"/";

	System.out.println(sql);
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);
	
%>

	<script type="text/javascript">
			function winOpen(){
				var popHeight = 292;                                      // 띄울 팝업창 높이   
				var popWidth = 580;                                       // 띄울 팝업창 너비
				var winHeight = document.body.clientHeight;	  // 현재창의 높이
				var winWidth = document.body.clientWidth;	  // 현재창의 너비
				var winX = window.screenLeft;	                          // 현재창의 x좌표
				var winY = window.screenTop;	                          // 현재창의 y좌표
				var popX = winX + (winWidth - popWidth)/2;
				var popY = winY + (winHeight - popHeight)/2;
				window.open("./innorix/exam/html5Upload.jsp?no=<%=no%>", "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
			}

			function mapOpen(photosseq){
				var popHeight = 310;                                      // 띄울 팝업창 높이   
				var popWidth = 600;                                       // 띄울 팝업창 너비
				var winHeight = document.body.clientHeight;	  // 현재창의 높이
				var winWidth = document.body.clientWidth;	  // 현재창의 너비
				var winX = window.screenLeft;	                          // 현재창의 x좌표
				var winY = window.screenTop;	                          // 현재창의 y좌표
				var popX = winX + (winWidth - popWidth)/2;
				var popY = winY + (winHeight - popHeight)/2;
				window.open("./map.jsp?no=<%=no%>", "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
			}
	</script>
	
	<center>
	<table border="0" width="100%" height="400">
	
	<%
	String filename="";
	int count=0;
	int count_old=0;
	while (ipetdigitalconndb.rs.next()) { 
		filename=path+ipetdigitalconndb.rs.getString(3);
		System.out.println("filename : " + path+filename);
	
	if(count==0){
		count_old=0;
		out.println("<tr>");
	}
	%>
		<td align="left">
			<table border="1" width="100%" height="200" align="left" cellspacing=1 cellpadding=1 style='border-width:1; border-color:#DCDCDC;' >
			<tr>
			  <td align="center">
			   <input type="checkbox" name="">
			  </td>
			</tr>
			<tr>
			  <td align="center">
			   <font size=2><img src="<%=filename%>"  width="200" height="150"></font><br>
			   <a href="javascript:mapOpen(<%=ipetdigitalconndb.rs.getString(5)%>);"><b><font color="red"> 
			  <%
			   if(!ipetdigitalconndb.rs.getString(1).equals("nothing")){
					out.println("(View GPS Info)");
				}
			  %>		  
			  </font></b></a>
			  </td>
			</tr>
			<tr>
			  <td align="left">
			  <b>photo date</b> : <%=ipetdigitalconndb.rs.getString(2)%> <br> <b>upload date</b> : <%=ipetdigitalconndb.rs.getString(4)%>
			  </td>
			</tr>
			</table>
		</td>
	<%
	if(count==4){
		out.println("</tr>");
		count=0;
		count_old=2;
	}
	if(count_old!=2){
		count++;
	}
	}
	%>
	</td>
	</tr>
	
	<tr>
		<td colspan="5">
		&nbsp;
		</td>
	</tr>	 
	</table>
	
	<br>	
	<div align="right">
	<table border="0">	
	<tr>
		<td colspan="3" align="right">		  
			<button class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal"  data-backdrop="false"  data-target="#backdrop_photo"><i class="feather icon-upload"></i> Upload</button>
			<button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>
		</td>
	</tr>
	</table>
	</div>
			
	<script>    
            var box = new Object();
            window.onload = function() {
                // 파일전송 컨트롤 생성
                box = innorix.create({
                    el: '#fileControl_photo', // 컨트롤 출력 HTML 객체 ID
                    height          : 130,
                    maxFileCount   : 1,  
                    allowType : ["vcf"],
					addDuplicateFile : false,
                    agent: false, // true = Agent 설치, false = html5 모드 사용                    
                    uploadUrl: './fileuploader.jsp' // 업로드 URL
                });

                // 업로드 완료 이벤트
                box.on('uploadComplete', function (p) {
             	    
                    /*var f = p.files;
                    var r = "Upload complete\n\n";
                    for (var i = 0; i < f.length; i++ ) {
                        r += f[i].clientFileName + " " + f[i].fileSize + "\n";
                    }
                    alert(r);*/
					//window.close();
					//self.opener.location.reload(); 
					document.getElementById('uploadvcfform').reset();
	        		box.removeAllFiles();
					backdrop.style.display = "none";					
					refresh();
                });
            };
            function FileUpload() {
	            var postObj = new Object();
	            postObj.no = <%=no%>;
	            box.setPostData(postObj);
	            box.upload();
            }            
         
	</script>
        		


	
	
	
