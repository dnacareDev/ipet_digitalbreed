<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->
<%@ page import="ipet_digitalbreed.*"%>    

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Vuexy admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities.">
    <meta name="keywords" content="digital breeding ipet dnacare">
    <meta name="author" content="DNACARE">
    <title>Digital Breeding System- DNACARE</title>
    <link rel="apple-touch-icon" href="../../css/app-assets/images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../css/app-assets/images/ico/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/vendors.min.css">
 	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/innorix/innorix.css">    
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/tables/ag-grid/ag-grid.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/tables/ag-grid/ag-theme-alpine.css"> 
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/css/plugins/forms/validation/form-validation.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/forms/select/select2.min.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/themes/dark-layout.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/themes/semi-dark-layout.css">

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/core/menu/menu-types/horizontal-menu.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/pages/dashboard-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/pages/card-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/plugins/tour/tour.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/pages/aggrid.css">
    <!-- END: Page CSS-->

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->
<style>
body {
	font-family: 'SDSamliphopangche_Outline';
}

.irx-file-inner-wrapper {
   height: 30px !important;
}

.innorix_basic div.irx_filetree, .irx_container {
	border : none !important;
}

/********************* 헤더 수직 **************************/
#pill2_frame .ag-header-cell-label .ag-header-cell-text {
    writing-mode: vertical-lr; /* vertical text */
}
/********************* 헤더 수직 **************************/

#pill2_frame .ag-header-cell, #pill2_frame .ag-header-group-cell, #pill2_frame .ag-cell {
    border-right: 1px solid #dde2eb !important;
}


</style>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";

	String linkedJobid = request.getParameter("linkedJobid");
	
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">

	<jsp:include page="../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="genotype"/>
	</jsp:include>

    <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
            <div class="content-header row">
                <div class="content-header-left col-md-9 col-12 mb-2">
                    <div class="row breadcrumbs-top">
                        <div class="col-12">
                            <h2 class="content-header-title float-left mb-0">&nbsp;Genotype Database</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../mainboard.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">Database
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            	<div class="content-body">
                <!-- Basic example section start -->
                <section id="basic-examples">
                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="ag-grid-btns d-flex justify-content-between flex-wrap mb-1">
                                            <div class="dropdown sort-dropdown mb-1 mb-sm-0">                                                
                                                <select class="select2-bg form-control" id="variety-select" onchange="javascript:refresh();" data-bgcolor="success" data-bgcolor-variation="lighten-3" data-text-color="white">                                                   
                                                    <%
	                                                	try{
	                                                		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	                                                		int selected_cnt=0;
	                                                		String selected_flag=null;
	
	                                                		ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(cropvari_sql);
	                                                		while (ipetdigitalconndb.rs.next()) { 	
	                                                			if(selected_cnt==0) {selected_flag = "selected";};   
	                                                			out.println("<option value='"+ipetdigitalconndb.rs.getString("varietyid")+"' "+ selected_flag +">"+ipetdigitalconndb.rs.getString("cropname")+"("+ipetdigitalconndb.rs.getString("varietyname")+")"+"</option>");
	                                                			selected_cnt++;
	                                                			selected_flag="";
	                                                		}
	                                                	}catch(Exception e){
	                                                		System.out.println(e);
	                                                	}finally { 
	                                                		ipetdigitalconndb.stmt.close();
	                                                		ipetdigitalconndb.rs.close();
	                                                		ipetdigitalconndb.conn.close();
	                                                	}
                                                    %>       
                                                     </select>                                          
                                            </div>           
                                            <div class="ag-btns d-flex flex-wrap">                                            
                                                <input type="text" class="ag-grid-filter form-control w-50 mr-1 mb-1 mb-sm-0" id="filter-text-box" placeholder="Search...." />
                                               <!-- <div class="btn-export">
                                                    <button class="btn btn-primary mr-1 mb-1">
                                                        Export as CSV
                                                    </button>-->
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>								                              
                              	<div id="myGrid" class="ag-theme-alpine" style="margin: 0 auto;width: 98%;height:320px;" ></div><br>
                              	<!--  
                                <button class="btn btn-warning mr-1 mb-1" style="margin-left: 20px;" onclick="addRow()"><i class="feather icon-corner-up-left"></i> Tool Box</button>
                                -->
                                <button class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal"  data-backdrop="false"  data-target="#backdrop"><i class="feather icon-upload"></i> Upload</button>
								<button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>  	
                            </div>
                        </div>
                    </div>                    
                    <div id="vcf_status" class="card"></div>
                </section>
                <!-- // Basic example section end -->

            </div>
        </div>
    </div>
                            
    <!-- END: Content-->
    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

    <!-- BEGIN: Footer-->
    <footer class="footer footer-static footer-light navbar-shadow">
        <p class="clearfix blue-grey lighten-2 mb-0"><span class="float-md-left d-block d-md-inline-block mt-25">COPYRIGHT &copy; 2022<a class="text-bold-800 grey darken-2" href="http://www.dnacare.co.kr" target="_blank">DNACARE Co., LTD</a>All rights Reserved</span>
            <button class="btn btn-primary btn-icon scroll-top" type="button"><i class="feather icon-arrow-up"></i></button>
        </p>
    </footer>
    <!-- END: Footer-->


    <!-- BEGIN: Vendor JS-->
    <script src="../../css/app-assets/vendors/js/vendors.min.js"></script>
    <script src="../../css/app-assets/vendors/js/innorix/innorix.js"></script>
    <script src="../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../css/app-assets/js/scripts/forms/select/form-select2.js"></script>
    <script src="../../css/app-assets/js/scripts/sheetjs/xlsx.full.min.js"></script>    
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
	<script src="../../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../../css/app-assets/js/core/app-menu.js"></script>
    <script src="../../css/app-assets/js/core/app.js"></script>
    <script src="../../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_genotype.js"></script>
    <script src="../../css/app-assets/js/scripts/plotly-latest.min.js"></script>   
	<script src="../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<!-- Modal start-->

	    <div class="modal fade text-left" id="backdrop" tabindex="-1" role="dialog" aria-labelledby="myModalLabel4" aria-hidden="true">
	        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
	            <div class="modal-content">
	                <div class="modal-header bg-warning white">
	                    <h4 class="modal-title" id="myModalLabel4">VCF File Upload</h4>
	                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
	                        <span aria-hidden="true">&times;</span>
	                    </button>
	                </div>
	                <div class="modal-body">
						<form class="form" id="uploadvcfform">
						     <div class="form-body">
						         <div class="row">
						             <br><div class="col-md-12 col-12">
						                 <br><div class="form-label-group">
						                     <input type="text" id="comment" class="form-control" placeholder="Comment" name="comment" required data-validation-required-message="This name field is required">						                     
						                     <label for="first-name-column">Comment</label>
						                 </div>
						             </div>
						             <!-- 
						             <div class="col-md-6 col-12">
						                 <div class="form-label-group">
						                     <input type="text" id="maf" class="form-control" placeholder="Maf" name="maf">
						                     <label for="city-column">Maf</label>
						                 </div>
						             </div>
						             <div class="col-md-6 col-12">
						                 <div class="form-label-group">
						                     <input type="text" id="mindp" class="form-control" name="mindp" placeholder="minDP">
						                     <label for="country-floating">minDP</label>
						                 </div>
						             </div>
						             <div class="col-md-6 col-12">
						                 <div class="form-label-group">
						                     <input type="text" id="mingq" class="form-control" name="mingq" placeholder=minGQ>
						                     <label for="company-column">minGQ</label>
						                 </div>
						             </div>
						             <div class="col-md-6 col-12">
						                 <div class="form-label-group">
						                     <input type="email" id="missing" class="form-control" name="missing" placeholder="Missing">
						                     <label for="email-id-column">Missing</label>
						                 </div>
						             </div>		
						             -->				             
						             <div class="col-md-12 col-12">
										<div id="fileControl" class="col-md-12 col-12"  style="padding: 0; border: 1px solid #48BAE4;"></div><br>
						             </div>	
						             <div class="col-12">
						                 <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="FileUpload();">Upload</button>
						                 <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="box.removeAllFiles();">Reset</button>
						             </div>						             
						         </div>
						     </div>
						</form>
	                </div>
	                <!-- 
		                <div class="modal-footer">
		                    <button type="button" class="btn btn-primary" data-dismiss="modal">Accept</button>
		                </div>
	                 -->
	            </div>
	        </div>
                          
	<!-- Modal end-->
	
        <script>
        
        // Quality Filter에서 링크를 타고 왔을때 받는 parameter(jobid)를 .js파일에 넘겨주기 위한 전역변수. 
        // "null"인 경우를 구분해야함
        var linkedJobid = "<%=linkedJobid%>";
        
        var box = new Object();
        window.onload = function() {
            // 파일전송 컨트롤 생성
            box = innorix.create({
                el: '#fileControl', // 컨트롤 출력 HTML 객체 ID
                height          : 130,
                maxFileCount   : 1,  
                allowExtension: ["vcf", "gvcf"],
				addDuplicateFile : false,
                agent: false, // true = Agent 설치, false = html5 모드 사용                    
                uploadUrl: './fileuploader.jsp' // 업로드 URL
            });

			box.on("addFileError", function(p) {
                alert("하나의 VCF 파일만 업로드 할 수 있습니다")
            }),

            // 업로드 완료 이벤트
            box.on('uploadComplete', function (p) {

				document.getElementById('uploadvcfform').reset();
			    box.removeAllFiles();
				$('#backdrop').modal('hide');
				jQuery('#vcf_status').html('');
				$('html').scrollTop(0);
				refresh();
				
				
				
				//VCFViewer 작업
				//서버의 csv파일을 json형태로 변경
				makeJson(p.postData.jobid)
				
            });
        };
        
        async function FileUpload() {
        	if(document.getElementById("comment").value==''){
        		alert("Comment must be entered.");   
        		document.getElementById("comment").focus();
        	    return false;  
        	}
        	
        	/* 
        	const jobid = await fetch('../getJobid.jsp')
        				.then((response) => response.text())
        				.then((data) => data);
        	*/
        	
        	const jobid = "20221214133523"			// csv 1.4GB
        	//const jobid = "20221214112940";			// csv 500MB
        	//const jobid = "20221130123347";		// csv 250MB
        	//const jobid = "20221130134541";		// csv 1.8MB
        	//const jobid = "20221212151125";		// csv 150MB
        	//console.log("await jobid : ", jobid);
        	
			var postObj = new Object();
			postObj.comment = document.getElementById("comment").value;      
			postObj.varietyid = $( "#variety-select option:selected" ).val();
			postObj.jobid = jobid;
			box.setPostData(postObj);
			box.upload();
        }   
        
        function makeJson(jobid) {
        	fetch(`./genotype_after_upload_process.jsp?jobid=\${jobid}`)
        }
        
            
		$('#backdrop').on('hidden.bs.modal', function (e) {
			document.getElementById('uploadvcfform').reset();
			box.removeAllFiles();
		});            
        </script>
</body>
<!-- END: Body-->

</html>