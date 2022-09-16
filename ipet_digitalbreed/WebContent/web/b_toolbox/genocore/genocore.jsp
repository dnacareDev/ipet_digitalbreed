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
    <link rel="apple-touch-icon" href="../../../css/app-assets/images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../../css/app-assets/images/ico/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/vendors.min.css">
 	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/innorix/innorix.css">    
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/tables/ag-grid/ag-grid.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/tables/ag-grid/ag-theme-alpine.css"> 
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/plugins/forms/validation/form-validation.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/forms/select/select2.min.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/themes/dark-layout.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/themes/semi-dark-layout.css">

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/core/menu/menu-types/horizontal-menu.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/dashboard-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/card-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/plugins/tour/tour.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/aggrid.css">
    <!-- END: Page CSS-->


	<style type="text/css">


	</style>
</head>
<!-- END: Head-->

<!-- BEGIN: Body-->
<style>
	body {
		font-family: 'SDSamliphopangche_Outline';
	}
	
	.select2-container--default .select2-results__option[aria-disabled=true] {
	    display: none;
	}

	table {
		width: 95%;
		margin-top: 24px;
		margin-left: 12px;
	}
	
	th, td {
		border: 1px solid #DDDDDD;
		color: black;
		text-align: center;
	}
	
	th:hover, td:hover {
	  background-color: #aad5f8;
	  color: #000000;	  
	}
	

</style>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";
	System.out.println(cropvari_sql);
	//System.out.println("UID : " + permissionUid);
%>
<%--
	GenotypeListJson genotypeListJson = new GenotypeListJson();
	String vcf_sql = "select no, uploadpath, filename,resultpath, comment, refgenome, cropid, samplecnt, variablecnt, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt  from vcfdata_info_t where creuser='"+permissionUid+"' and varietyid='" + varietyid + "' order by no desc;";
--%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">

    <!-- BEGIN: Header-->
    <nav class="header-navbar navbar-expand-lg navbar navbar-with-menu navbar-fixed navbar-shadow navbar-brand-center">
        <div class="navbar-wrapper">
            <div class="navbar-container content">
                <div class="navbar-collapse" id="navbar-mobile">
                    <div class="mr-auto float-left bookmark-wrapper d-flex align-items-center">
                        <ul class="nav navbar-nav">
                            <li class="nav-item mobile-menu d-xl-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ficon feather icon-menu"></i></a></li>
                        </ul>
			            <ul class="nav navbar-nav flex-row">
			                <li class="nav-item"><a class="navbar-brand" href="../../mainboard.jsp">
									<img src="../../../images/logo.png"><font size="4px"  color="#4c8aa9"><b>&nbsp;Digital Breeding</b></font>           
			                    </a></li>
			            </ul>
                    </div>
                    <ul class="nav navbar-nav float-right">
                        <li class="dropdown dropdown-user nav-item"><a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
                                <div class="user-nav d-sm-flex d-none"><span class="user-name text-bold-600">DNACARE(master)</span><span class="user-status">Available</span></div><span><img class="round" src="../../../css/app-assets/images/portrait/small/avatar-s-11.jpg" alt="avatar" height="40" width="40"></span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right"><a class="dropdown-item" href="page-user-profile.html"><i class="feather icon-user"></i> Edit Profile</a><a class="dropdown-item" href="app-email.html"><i class="feather icon-mail"></i> My Inbox</a><a class="dropdown-item" href="app-todo.html"><i class="feather icon-check-square"></i> Task</a><a class="dropdown-item" href="app-chat.html"><i class="feather icon-message-square"></i> Chats</a>
                                <div class="dropdown-divider"></div><a class="dropdown-item" href="auth-login.html"><i class="feather icon-power"></i> Logout</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

		<jsp:include page="../../../css/menu.jsp?menu_active=genocore" flush="true"/>

    <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
            <div class="content-header row">
                <div class="content-header-left col-md-9 col-12 mb-2">
                    <div class="row breadcrumbs-top">
                        <div class="col-12">
                            <h2 class="content-header-title float-left mb-0">&nbsp;Genocore</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../../mainboard.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">Breeder's toolbox
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
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                
                                <div id="myGrid" class="ag-theme-alpine" style="width: 100%;height:320px;"></div><br>
								<button class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal" data-target="#backdrop" data-backdrop="false">New Analysis</button>
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
    
    
	<!-- Modal start-->
    <div class="modal fade text-left" id="backdrop" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">Genocore New Analysis</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadGenocoreForm">
					    <div class="form-body">
					        <div class="row">
					            <br>
					            <div class="col-md-12 col-12">
					                <br>
					             	<div class="form-label-group">
					                	<input type="text" id="comment" class="form-control" placeholder="Comment" name="comment" autocomplete="off" required data-validation-required-message="This name field is required">						                     
					             		<label for="first-name-column">Comment</label>
					                </div>
					            </div>
					            <div class="col-md-12 col-12">
					            	<div class="form-label-group" >
					                    <select class="select2 form-select" id="VcfSelect">
 
					                    	<!--  
					                    	<option value="-1" selected disabled>목록 선택</option>
					                    	<option value="1">Alaska</option>
					                    	<option value="2">22</option>
					                    	<option value="3">33</option>
					                    	-->
					                    </select>
					                </div>
					            </div>
					            <div class="col-12">
					                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="excute();">실행</button>
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;">초기화</button>
					            </div>
					        </div>
					    </div>
					</form>
                </div>
            </div>
        </div>
    </div>                      
	<!-- Modal end-->
                        
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
    <script src="../../../css/app-assets/vendors/js/vendors.min.js"></script>
    <script src="../../../css/app-assets/vendors/js/innorix/innorix.js"></script>
    <script src="../../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../../css/app-assets/js/scripts/forms/select/form-select2.js"></script>    
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
	<script src="../../../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../../../css/app-assets/js/core/app-menu.js"></script>
    <script src="../../../css/app-assets/js/core/app.js"></script>
    <script src="../../../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="../../../css/app-assets/js/scripts/ag-grid/ag-grid_genocore.js"></script>
    <script src="../../../css/app-assets/js/scripts/plotly-latest.min.js"></script>   
	<script src="../../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">                  
   	$(document).ready(function(){
   		vcfFileList();
   	});
   	
   	function vcfFileList() {
   		$.ajax(
 	   	{
 	   		url: "../../../web/database/genotype_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(),
 	   		method: 'POST',
 	   		success: function(data) {
	 			console.log("vcf file list : ", data);
	 		   	 			
	 			makeOptions(data);
 	   	   	}
   	   	});
   	}
   	
   	function makeOptions(data) {
   		$("#VcfSelect").empty();
   		
   		$("#VcfSelect").append(`<option disabled hidden selected>Select VCF File</option>`);
    	for(let i=0 ; i<data.length ; i++) {
			// ${data}}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
			$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} > \${data[i].filename} (\${data[i].comment}) </option>`);
		}
    }
   
   	$('input[type=radio][name=radio_population]').change(function() {
   		if (this.value == 'invalid') {
   			$("#fileControl").hide();
   		} else {
   			$("#fileControl").show();
   		}
   	});
   	
   	$('#backdrop').on('hidden.bs.modal', function (e) {
    	
   		console.log("ba")
   		
   		document.getElementById('uploadGenocoreForm').reset();
    	vcfFileList();
    	
    	//box.removeAllFiles();
    });    
   	
    function excute() {
    	console.log("invalid");	  
	   	
    	let comment = $('#comment').val();
   		let varietyid = $( "#variety-select option:selected" ).val();
   		let jobid = $('#VcfSelect').find(':selected').data('jobid');
   		let filename = $('#VcfSelect').find(':selected').data('filename');
   		let uploadpath = $('#VcfSelect').find(':selected').data('uploadpath');
   		
   		console.log("comment : ", comment);
   		console.log("varietyid : ", varietyid);
   		console.log("jobid : ", jobid);
   		console.log("filename : ", filename);
   		console.log("uploadpath : ", uploadpath);
   		
   		$.ajax({
   				url: "./genocore_analysis.jsp",
   				method: 'POST',
   				data: {
   					"comment" : comment, 
   					"varietyid" : varietyid, 
   					"jobid" : jobid, 
   					"filename" : filename
   					},
   				success: function(result) {
  					console.log("genocore_analysis.jsp");
   				}
  		});
    }
    

       

       
</script>

</body>
<!-- END: Body-->

</html>