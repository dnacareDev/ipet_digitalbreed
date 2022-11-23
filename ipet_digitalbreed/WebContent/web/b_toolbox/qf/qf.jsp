<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->
<%@ page import="java.io.*"%>
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
    <!--  
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/nouislider.min.css">
	-->
    <!--  
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/vendors.min.css">
    -->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/tables/ag-grid/ag-grid.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/tables/ag-grid/ag-theme-alpine.css"> 
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/plugins/forms/validation/form-validation.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/forms/select/select2.min.css">
	
	<!--  
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/jquery-ui/jquery-ui.min.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/jquery-ui/jquery-ui.structure.min.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/jquery-ui/jquery-ui.theme.min.css">
    -->
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
    <!--  
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/plugins/extensions/ext-component-sliders.css">
    -->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/aggrid.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/bootstrap5_custom.css">
    <!-- END: Page CSS-->

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

/* placeholder float-right */
::-webkit-input-placeholder { 
	text-align:right; 
}

.min-range-max {
	color: gray;
	cursor: pointer;
}

</style>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";
	//System.out.println(cropvari_sql);
	//System.out.println("UID : " + permissionUid);
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">

    <jsp:include page="../../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="qf"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;Quality Filter</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../../mainboard.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item">Breeder's toolbox
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
                                    <div class="col-12">
                                    	<i class='feather icon-database'></i>
                                    	<% 
	                                    	String  drive;
	                                    	double  totalSize, freeSize, useSize;        
	
	                                    	File[] roots = File.listRoots();
	                                    	totalSize = roots[0].getTotalSpace() / Math.pow(1024, 3);
	                                    	useSize = roots[0].getUsableSpace() / Math.pow(1024, 3);
	                                    	freeSize = totalSize - useSize;
	
	                                    	out.println(String.format("%.2f",freeSize) + " GB Remained");
                                    	%>
                                    </div>
                                </div>
                                  
                            </div>
                            <div id="myGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:320px;"></div><br>
							<button class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal" data-target="#backdrop" data-backdrop="false"><i class="feather icon-upload"></i> New Analysis</button>
                            <button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>
                        </div>
                    </div>
                    <div id="vcf_status" class="card" style="display:none">
                    	<div class='card-content'>
							<div class='card-body'>
								<div class='row'>
									<div class='col-12'>
										<ul class='nav nav-pills nav-active-bordered-pill'>
											<li class='nav-item'><a class='nav-link active' id='qf_1' data-toggle='pill' href='#pill1' aria-expanded='true'>VCF Info </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_2' data-toggle='pill' href='#pill2' aria-expanded='false'>Variant </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_3' data-toggle='pill' href='#pill3' aria-expanded='false'>DP </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_4' data-toggle='pill' href='#pill4' aria-expanded='false'>Missing </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_5' data-toggle='pill' href='#pill5' aria-expanded='false'>CM Plot </a></li>
										</ul>
										<div class='tab-content'>
											<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill1_frame' onload='hideSpinner()'></iframe>
											</div>
											<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill2_frame' onload='hideSpinner()'></iframe>
											</div>
											<div class='tab-pane' id='pill3' aria-labelledby='base-pill3'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill3_frame' onload='hideSpinner()'></iframe>
											</div>
											<div class='tab-pane' id='pill4' aria-labelledby='base-pill4'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill4_frame' onload='hideSpinner()'></iframe>
											</div>
											<div class='tab-pane' id='pill5' aria-labelledby='base-pill4'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill5_frame' onload='hideSpinner()'></iframe>
											</div>
										</div>
									</div>
								</div>
								<input type='hidden' id='jobid'>
								<input type='hidden' id='resultpath'>
							</div>
						</div>
                    </div>
                </section>
                <!-- // Basic example section end -->
            </div>
        </div>
    </div>
    
	<!-- Modal start-->
    <div class="modal fade text-left" id="backdrop" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
        <div class="modal-dialog  modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">Quality Filter</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadForm">
					    <div class="form-body">
					        <div class="row">
					            <fieldset class="border w-100 m-1 pt-1">
						        <legend class="w-auto ml-1 mr-1">Quality Filter</legend>
						            <div class="col-md-12 col-12">
						            	<div class="form-label-group" >
						                    <select class="select2 form-select" id="VcfSelect">
						                    </select>
						                </div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
					            		<div class="row">
							            	<div class="col-4">Variant Type</div>
							            	<div class="form-check col-3">
							            		<input type="checkbox" class="form-check-input" id="variant_snp" />
		                                        <label class="form-check form-check-label" for="variant_snp" style="margin-left:-16px;" >SNP</label>
							            	</div>
							            	<div class="form-check col-3">
							            		<input type="checkbox" class="form-check-input" id="variant_indel" />
		                                        <label class="form-check-label" for="variant_indel" style="margin-left:6px;" >INDEL</label>
							            	</div>
					            		</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
							            	<div class="col-4">Allelic Type</div>
							            	<div class="form-check col-3">
							            		<input type="checkbox" class="form-check-input" id="allelic_bi" />
		                                        <label class="form-check-label" for="allelic_bi" style="margin-left:6px;">Bi-allelic</label>
							            	</div>
					            		</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
						            		<div class="col-4" style="margin-top:8px;">Missing (%)</div>
						            		<div class="col-5" style="margin-top:8px;">
						            			<div class="row">
						            				<div class="col-1 min-range-max" onclick="document.getElementById('missing-range').value = 0; document.getElementById('missing-number').value = 0;">0</div>
							            			<div class="col-8" style="margin-right:-5px; padding-left:3px; padding-right:0px;">
								            			<input type="range" class="form-range" id="missing-range" min="0" max="100" value="50" step="1" oninput="document.getElementById('missing-number').value = this.value" />
							            			</div>
						            				<div class="col-1 min-range-max" onclick="document.getElementById('missing-range').value = 100; document.getElementById('missing-number').value = 100">100</div>
						            			</div>
						            		</div>
						            		<div class="col-3">
						            			<input type="text" class="form-control" id="missing-number" autocomplete="off" value="50" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value>100)this.value=100; document.getElementById('missing-range').value = this.value;" />
						            		</div>
						            	</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
											<div class="col-4" style="margin-top:8px;">MAF (%)</div>
	                                        <div class="col-5" style="margin-top:8px;">
	                                        	<div class="row">
	                                        		<div class="col-1 min-range-max" onclick="document.getElementById('maf-range').value = 0; document.getElementById('maf-number').value = 0;">0</div>
	                                        		<div class="col-8" style="margin-right:-3px; padding-left:3px; padding-right:0px;">
			                                        	<input type="range" class="form-range" id="maf-range" min="0" max="50" value="25" step="1" oninput="document.getElementById('maf-number').value = this.value" />
	                                        		</div>
	                                        		<div class="col-1 min-range-max" onclick="document.getElementById('maf-range').value = 50; document.getElementById('maf-number').value = 50;"> 50</div>
	                                        	</div>
	                                        </div>
	                                        <div class="col-3">
						            			<input type="text" class="form-control" id="maf-number" autocomplete="off" value="25" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value>50)this.value=50; document.getElementById('maf-range').value = this.value;" />
						            		</div>
	                                    </div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
											<div class="col-4" style="margin-top:2%">MinDP</div>
											<div class="col-8">
												<input type="text" class="form-control" id="minDP" autocomplete="off" />
											</div>
										</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
											<div class="col-4" style="margin-top:2%">MinGQ</div>
											<div class="col-8">
												<input type="text" class="form-control" id="minGQ" autocomplete="off" />
											</div>
										</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
											<div class="col-4" style="margin-top:5px;">Thin</div>
											<div class="form-check col-3">
							            		<input type="checkbox" class="form-check-input" id="useThin" style="margin-top:9px; margin-left:-11px;" onclick="if(this.checked){document.getElementById('thin').style.display = 'block'}else{document.getElementById('thin').style.display ='none'; document.getElementById('thin').value='';}" checked/>
		                                        <label for="useThin"  style="margin-top:9px; margin-left:12px;">사용</label>
							            	</div>
											<div class="col-5">
												<input class="form-control" type="text" id="thin" placeholder="(unit : bp)" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');">
											</div>
										</div>
						            </div>
						            <!--  
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row mb-1">
							            	<div class="col-4" style="margin-top:5px;">CMPlot</div>
							            	<div class="form-check col-3">
							            		<input type="checkbox" class="form-check-input" id="CMPlot_use" style="margin-top:9px; margin-left:-11px;" value="CMPlot_without_condition" checked/>
		                                        <label for="CMPlot_use"  style="margin-top:9px; margin-left:12px;">사용</label>
							            	</div>
							            	<div class="col-5">
							            		<input class="form-control" type="text" id="CMPlot" name="variant_type" placeholder="(unit : mb)">
							            	</div>
					            		</div>
						            </div>
						            -->
						        </fieldset>
					            <div class="col-12">
					                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="Execute();">Run</button>
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;">Reset</button>
					            </div>
					        </div>
					    </div>
					</form>
                </div>
            </div>
        </div>
    </div>
    
   	<div class="modal" id="iframeLoading" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
		<div class="modal-dialog modal-dialog-centered modal-xs" role="document">
   			<center><img src='/ipet_digitalbreed/images/loading.gif'/><center>
			<div><strong>Loading...</strong></div>
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
    <!--  
    <script src="../../../css/app-assets/vendors/js/jquery-ui/jquery-ui.min.js"></script>
    -->
        
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
    <script src="../../../css/app-assets/js/scripts/ag-grid/ag-grid_qf.js"></script>
    <!--  
    <script src="../../../css/app-assets/js/scripts/plotly-latest.min.js"></script>
    -->   
	<script src="../../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">

   	$(document).ready(function(){
   		vcfFileList();
   		//$(".select2.select2-container.select2-container--default").eq(1).width("444px");
   	});

   	function vcfFileList() {
   		$.ajax(
   			{
 	   			//url: "./pca_non_population.jsp",
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
    	
    	$("#VcfSelect").append(`<option data-jobid="-1" disabled hidden selected>Select VCF File</option>`);
    	for(let i=0 ; i<data.length ; i++) {
			// ${data}}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
			$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} > \${data[i].filename} (\${data[i].comment}) </option>`);
		}
    }
    
	// 로딩이 완료되면 로딩창 소멸
	function hideSpinner() {
		$("#iframeLoading").modal('hide');
	}
   	
	function saveToVcf(filename, jobid) { 
		if(!confirm("결과를 Gynotype DB에 저장하시겠습니까?")) {
			return;
		}
		
		
	   	const variety_id = $( "#variety-select option:selected" ).val();
	   	
	   	//console.log(variety_id);
	   	//console.log(filename);
	   	//console.log(jobid);
	   	
	   	
	   	fetch(`../../database/fileupload_ext.jsp?jobid=\${jobid}&vcf_filename=\${filename}&varietyid=${variety_id}`);
	   	
	   	/*
		$.ajax({
			url: "./qf_saveToVcf.jsp",
			method: "POST",
			data: {
				"variety_id": variety_id,
				"filename": filename,
				"jobid": jobid,
			},
			success: function(result) {
				
			}
		})
		*/
	}
	
   	$('#backdrop').on('hidden.bs.modal', function (e) {

   		// 모달창 닫으면 초기화
    	document.getElementById('uploadPcaForm').reset();
    	vcfFileList();
    	box.removeAllFiles();
    });    
   	
    async function Execute() {
    	
	   	const variety_id = $( "#variety-select option:selected" ).val();
    	
    	const select_vcf = document.getElementById('VcfSelect');
    	const jobid_vcf = select_vcf.options[select_vcf.selectedIndex].dataset.jobid;
    	const file_name = select_vcf.options[select_vcf.selectedIndex].dataset.filename;
    	
    	const jobid_qf = await fetch('../../getJobid.jsp')
    					.then((response) => response.text());
    	
    	const snp_checked = document.getElementById('variant_snp').checked;
    	const indel_checked = document.getElementById('variant_indel').checked;
    	const allelic_bi_checked = document.getElementById('allelic_bi').checked;
    	const missing = document.getElementById('missing-number').value;
    	const maf = document.getElementById('maf-number').value;
    	const minDP = document.getElementById('minDP').value;
    	const minGQ = document.getElementById('minGQ').value;
    	//thin input이 빈칸이면 false로 판단(사용 체크해제해도 값을 비우므로 false)
    	let thin = document.getElementById('thin').value;
    	
    	if(jobid_vcf == -1) {
    		alert("vcf파일을 선택하세요");
    		return;
    	}
    	
    	if(!snp_checked && !indel_checked) {
    		alert("Variant Type을 적어도 하나 선택하세요.");
    		return;
    	}
    	
    	if(!minDP) {
    		alert("MinDP를 입력하세요.");
    		return;
    	}
    	
    	if(!minGQ) {
    		alert("MinGQ를 입력하세요.");
    		return;
    	}
    	
    	// thin이 빈값이면 0으로 간주
    	if(!thin) {
    		thin = 0;
    	}
 
    	// snp체크 = 1, indel체크 = 2, 둘다체크 = 0
    	let variant_type;
    	if(snp_checked && indel_checked) {
    		variant_type = 0;
    	} else if(snp_checked && !indel_checked) {
    		variant_type = 1;
    	} else if(!snp_checked && indel_checked) {
    		variant_type = 2;
    	}
    	
    	// Bi-allelic체크 = 1, 체크x = 0
    	let allelic_type;
    	if(allelic_bi_checked) {
    		allelic_type = 1;
    	} else {
    		allelic_type = 0;
    	}
    	
    	/*
    	const data = {
    			"jobid_vcf": jobid_vcf, "jobid_qf": jobid_qf, "variant_type": variant_type, "file_name":file_name,
    			"allelic_type": allelic_type, "missing": missing, "maf": maf,
    			"minDP": minDP, "minGQ": minGQ, "thin": thin
    	}
    	console.log(data);
    	*/
    	
    	
    	$.ajax({
    		url: './qf_analysis.jsp',
    		method: 'POST',
    		data: {
    			"jobid_vcf": jobid_vcf, "jobid_qf": jobid_qf, "variant_type": variant_type, "file_name":file_name,
    			"allelic_type": allelic_type, "missing": missing, "maf": maf,
    			"minDP": minDP, "minGQ": minGQ, "thin": thin
    		},
    		success: function(result) {
    			console.log("success");
    		}
    	})
    	
    	
    	$.ajax({
    		url: './qf_insertSql.jsp',
    		method: 'POST',
    		data: {
    			"permissionUid": permissionUid,
    			"variety_id": variety_id,
    			"jobid_qf": jobid_qf,
    			"file_name": file_name
    		},
    		sucess: function(result) {
    		}
    	})
    	
    	//시간이 조금 지나면 Rscript 작동 여부에 관계없이 새로고침
   		setTimeout( function () {
   			refresh();
   			$("#backdrop").modal("hide");
   			}
   		, 1000);
    	
    }
    
       

       
</script>

</body>
<!-- END: Body-->

</html>