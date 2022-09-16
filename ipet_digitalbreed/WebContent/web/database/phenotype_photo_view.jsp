<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    

<script src="../../css/app-assets/vendors/js/jquery.bpopup.min.js"></script>
<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/innorix/innorix.css">    

<style>
	body {
		font-family: 'SDSamliphopangche_Outline';
	}
	
	.Pstyle {
	   opacity : 0;
	   display : none;
	   position : relative;
	   width : 300px;
	   border : 5px solid #fff;
	   padding : 20px;
	   background-color : #fff;
	}
	.b-close {
	   position : absolute;
	   right : 5px;
	   top : 5px;
	   padding : 0px; /* padding : 5px; */
	   display : inline-block;
	   cursor : pointer;
	}
</style>


<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String no = request.getParameter("no");		
	String sql = "SELECT photogps, photodate, filename, cre_dt, comment, no FROM sampledata_img_t where sampleno='"+no+"' order by no desc";
	
	String path = "../../uploads/database/phenotype_img/"+no+"/";
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);		
%>
    <script src="../../css/app-assets/vendors/js/innorix/innorix.js"></script>	
		
	<script type="text/javascript">

			function view_photo(filename){
				$("#photo_zone").attr("src", filename);			
				$('#photo_zone').width('100%');       
			    $('#photo_zone').height('100%');
				$('#photo_ori_view').modal({ show: true });			
			}
			
			function view_uploader(){
				 //$("#popup_uploader").bPopup(); 
				 $('#popup_uploader').modal({ show: true });			
			}
	
			function mapOpen(photogps){
				var popHeight = 310;                                      // 띄울 팝업창 높이   
				var popWidth = 600;                                       // 띄울 팝업창 너비
				var winHeight = document.body.clientHeight;	  // 현재창의 높이
				var winWidth = document.body.clientWidth;	  // 현재창의 너비
				var winX = window.screenLeft;	                          // 현재창의 x좌표
				var winY = window.screenTop;	                          // 현재창의 y좌표
				var popX = winX + (winWidth - popWidth)/2;
				var popY = winY + (winHeight - popHeight)/2;
				window.open("./map.jsp?imggps="+photogps, "pop",  "top="+popY+", left="+popX+",width="+popWidth+",height="+popHeight+", scrollbars=yes,resizable=yes");
			}
	</script>
	

<!-- photo original view Modal start-->

	    <div class="modal fade text-left" id="photo_ori_view" tabindex="-1" role="dialog" aria-labelledby="myModalLabel4" aria-hidden="true">
	        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-lg" role="document">
	            <div class="modal-content">
	                <div class="modal-header bg-primary white">
	                    <h4 class="modal-title" id="myModalLabel4">Photo Viewer</h4>
	                   
	                    <button type="button" class="close" aria-label="Close" onclick="$('#photo_ori_view').modal('hide');">
	                        <span aria-hidden="true">&times;</span>
	                    </button>
	                </div>
	                <div id="photo_div" class="modal-body">
	                	<img id="photo_zone">
	                </div>
	            </div>
	        </div>
         </div>         
	<!-- Modal end-->
	
		
<!-- upload Modal start-->

	    <div class="modal fade text-left" id="popup_uploader" tabindex="-1" role="dialog" aria-labelledby="myModalLabel4" aria-hidden="true">
	        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
	            <div class="modal-content">
	                <div class="modal-header bg-primary white">
	                    <h4 class="modal-title" id="myModalLabel4">Photo Files Upload</h4>
	                   
	                    <button type="button" class="close" aria-label="Close" onclick="$('#popup_uploader').modal('hide');">
	                        <span aria-hidden="true">&times;</span>
	                    </button>
	                </div>
	                <div class="modal-body">
						<form class="form" id="uploadphotoform">
						     <div class="form-body">
						         <div class="row">
						             <br><div class="col-md-12 col-12">
						                 <br><div class="form-label-group">
						                     <textarea class="form-control" id="upload_comment" rows="3" placeholder="Comment"></textarea>						                     
						                     <label for="first-name-column">Comment</label>
						                 </div>
						             </div>						            			             
						             <div class="col-md-12 col-12">
										<div id="fileControl_photo" class="col-md-12 col-12"  style="border: 1px solid #48BAE4;"></div><br>
						             </div>	
						             <div class="col-12">
						                 <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="FileUpload();">Upload</button>
						                 <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;">Reset</button>
						             </div>						             
						         </div>
						     </div>
						</form>
	                </div>
	            </div>
	        </div>
         </div>         
	<!-- Modal end-->
	
 
	<center>
	<table border="0"  width="90%">	
	<tr>
		<td style="float:left;">		  
			<input type="button" class="btn btn-warning mr-1 mb-1" style="margin-left: 20px;float: left;" onclick="javascript:view_uploader(<%=no%>);" value="Upload">
		</td>
		<td style="float:right;">		  
			<button class="btn btn-success mr-1 mb-1"  style="float: right;" onclick="getAllData()"><i class="feather icon-save"></i> Save</button>
			<button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>
		</td>
	</tr>
	</table>
	</div>
	<div id="photo_list">
	<table border="0" width="90%" height="400">
	
	<%
	String filename="";
	String imgno="";
	String photogps="";
	String comment="";
	int count=0;
	int count_old=0;
	while (ipetdigitalconndb.rs.next()) { 
		filename=path+ipetdigitalconndb.rs.getString(3);
		imgno=ipetdigitalconndb.rs.getString(6);
		comment=ipetdigitalconndb.rs.getString(5);
		photogps=ipetdigitalconndb.rs.getString(1);
		System.out.println("filename : " + path+filename);
	
	if(count==0){
		count_old=0;
		out.println("<tr align='right'>");
	}
	%>
		<td align="left">
			<table border="1" width="100%" height="200" align="left" cellspacing=1 cellpadding=1 style='border-width:1; border-color:#DCDCDC;' >
			<tr>
			  <td align="center">
			   <input type="checkbox" name="no" value="<%=imgno%>">
			  </td>
			</tr>
			<tr>
			  <td align="center">
			   <font size=2><img src="<%=filename%>"  width="200" height="150"></font><br>
			   <font size=4>
			   <a href="javascript:view_photo('<%=filename%>');"><i class='feather icon-zoom-in'></i></a>
			   <a href="javascript:mapOpen('<%=photogps%>');">
			  <%
			   if(!photogps.equals("nothing")){
					out.println("<i class='feather icon-map'></i>");
				}
			  %>		  
			  </a>
			  </font>
			  </td>
			</tr>
			<tr>
			  <td align="center">
			  <b>photo date</b> : <%=ipetdigitalconndb.rs.getString(2)%> <br> <b>upload date</b> : <%=ipetdigitalconndb.rs.getString(4)%>
			  </td>
			</tr>
			
			<tr>
			  <td align="center">
			   <textarea name="comment" rows="" cols="30" placeholder="Comment"><%=comment%></textarea>
			  </td>
			</tr>
			
			
			</table>
		</td>
	<%
	if(count==5){
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
	</center>
	</div>
	
    <script>    
            	var box = new Object();
                // 파일전송 컨트롤 생성
                box = innorix.create({
                    el: '#fileControl_photo', // 컨트롤 출력 HTML 객체 ID
                    height          : 130,
					addDuplicateFile : false,
                    agent: false, // true = Agent 설치, false = html5 모드 사용                    
                    uploadUrl: './photouploader.jsp' // 업로드 URL
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
					document.getElementById('uploadphotoform').reset();
	        		box.removeAllFiles();
					//backdrop.style.display = "none";					
					$('#popup_uploader').modal('hide');

					$.ajax({
						 url:"./phenotype_photo_view.jsp",
						 type:"POST",
					     data:{'no': <%=no%>},
						 success: function(result) {	
							 console.log(result);
						 	$("#photo_list").html(result);		
							$('#backdrop').modal({ show: true });	
						 }
					});						             	   	 	
					
                });
            function FileUpload() {
	            var postObj = new Object();
	            postObj.comment = document.getElementById("upload_comment").value;      
	            postObj.varietyid = $( "#variety-select option:selected" ).val();
	            postObj.no = <%=no%>;
	            box.setPostData(postObj);
	            box.upload();
            }            
         
	</script>    		
	
	
	
	
