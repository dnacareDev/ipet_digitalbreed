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
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/bootstrap5_custom.css">
    <!-- END: Page CSS-->


	<style type="text/css">


	</style>
</head>
<!-- END: Head-->

<!-- BEGIN: Body-->
<style>
	html {
		scroll-behavior: smooth;
	}
	
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
	//System.out.println(cropvari_sql);
	//System.out.println("UID : " + permissionUid);
	
	String linkedJobid = request.getParameter("linkedJobid");
%>
<%--
	GenotypeListJson genotypeListJson = new GenotypeListJson();
	String vcf_sql = "select no, uploadpath, filename,resultpath, comment, refgenome, cropid, samplecnt, variablecnt, jobid, DATE_FORMAT(cre_dt, '%Y-%m-%d') AS cre_dt  from vcfdata_info_t where creuser='"+permissionUid+"' and varietyid='" + varietyid + "' order by no desc;";
--%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">

	<jsp:include page="../../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../../css/menu.jsp" flush="true">
		<jsp:param value="structure" name="menu_active"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;STRUCTURE</h2>
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
                            </div>
                            <div id="myGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:435px;"></div><br>
							<button class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal" data-target="#backdrop" data-backdrop="false"><i class="feather icon-upload"></i> New Analysis</button>
                            <button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>  
                        </div>
                    </div>
                    <div id="vcf_status" class="card" style="display:none;">
                    	<div class='card-content'>
   							<div class='card-body'>
   								<div class='row'>
   									<div class='col-12'>
   										<ul class='nav nav-pills nav-active-bordered-pill'>
   											<li class='nav-item'><a class='nav-link active' id='DeltaK' data-toggle='pill' href='#pill1' aria-expanded='true' onclick="window.scrollTo(0, document.body.scrollHeight);">DeltaK</a></li>
   											<li class='nav-item'><a class='nav-link' id='Sturcture_Result' data-toggle='pill' href='#pill2' aria-expanded='true' onclick="window.scrollTo(0, document.body.scrollHeight);">STURCTURE result</a></li>
   										</ul>
   										<div class='tab-content'>
   											<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
   												<div class="row">
	   												<div class="col-12">
	   													<select id="Select_Delta_K" class="select2 form-select" data-placeholder="Select K" data-width="150px" onchange="selectMergePlot(this.options[this.selectedIndex].dataset.number)">
	   														<option></option>
	   													</select>
	   												</div>
	   											</div>
   												<div class="row mt-1">
	   												<div class="col-12">
		   												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill1_frame' onload='$("#iframeLoading").modal("hide"); gridOptions.api.sizeColumnsToFit();'></iframe>
	   												</div>
   												</div>
   											</div>
   											<div class='tab-pane' id='pill2' aria-expanded='true' aria-labelledby='base-pill1'>
   												<div class="row">
	   												<div class="col-12">
	   													<select id="Select_Structure_result" class="select2 form-select" data-placeholder="Select Plot" data-width="150px" onchange="selectPlot(this.options[this.selectedIndex].dataset.file_name)">
	   														<option></option>
	   													</select>
	   												</div>
	   											</div>
   												<div class="row mt-1">
	   												<div class="col-12">
		   												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill2_frame' onload='$("#iframeLoading").modal("hide"); gridOptions.api.sizeColumnsToFit();'></iframe>
	   												</div>
   												</div>
   											</div>
   										</div>
   									</div>
   								</div>
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
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">Annotation New Analysis</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadForm">
					    <div class="form-body">
					        <div class="row">
					            <div class="col-md-12 col-12">
					             	<div class="form-label-group">
					                	<input type="text" id="comment" class="form-control" placeholder="Comment" name="comment" autocomplete="off" required data-validation-required-message="This name field is required">						                     
					             		<label for="first-name-column">Comment</label>
					                </div>
					            </div>
					            <div class="col-md-12 col-12">
					            	<div class="form-label-group" >
					                    <select class="select2 form-select" id="VcfSelect" name="VcfSelect">
					                    </select>
					                </div>
					            </div>
					            <div class="col-12 mt-1 mb-1">
					            	<div class="row">
										<div class="col-4" style="margin-top:8px;">Interation </div>
                                        <div class="col-5" style="margin-top:8px;">
                                        	<div class="row">
                                        		<div class="col-1 min-range-max" onclick="document.getElementById('iteration-range').value = 1; document.getElementById('iteration-number').value = 1;">1</div>
                                        		<div class="col-8" style="margin-right:-3px; padding-left:3px; padding-right:0px;">
		                                        	<input type="range" class="form-range" id="iteration-range" min="1" max="10" value="5" step="1" oninput="document.getElementById('iteration-number').value = this.value" />
                                        		</div>
                                        		<div class="col-1 min-range-max" onclick="document.getElementById('iteration-range').value = 10; document.getElementById('iteration-number').value = 10;"> 10</div>
                                        	</div>
                                        </div>
                                        <div class="col-3">
					            			<input type="text" class="form-control" id="iteration-number" name="iteration-number" autocomplete="off" value="5" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value<1)this.value=1; if(this.value>10)this.value=10; document.getElementById('iteration-range').value = this.value;" />
					            		</div>
                                    </div>
					            </div>
					            <div class="col-md-12 col-12 mt-1 mb-1">
					            	<div class="row">
										<div class="col-4" style="margin-top:2%">Number of K</div>
										<div class="col-8">
											<input type="number" class="form-control" id="Number_of_K" name="Number_of_K" value="" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');" />
										</div>
									</div>
					            </div>
					            <div class="col-md-12 col-12 mt-1 mb-1">
					            	<div class="row">
										<div class="col-4">Burn-IN<br>(Max 100,000)</div>
										<div class="col-8">
											<input type="number" class="form-control" id="Burn_IN" name="Burn_IN" max="100000" value="10000" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value<1)this.value=1; if(this.value>100000)this.value=100000;" />
										</div>
									</div>
					            </div>
					            <div class="col-md-12 col-12 mt-1 mb-1">
					            	<div class="row">
										<div class="col-4">MCMC<br>(Max 1,000,000)</div>
										<div class="col-8">
											<input type="number" class="form-control" id="MCMC" name="MCMC" max="1000000" value="20000" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value<1)this.value=1; if(this.value>1000000)this.value=1000000;" />
										</div>
									</div>
					            </div>
					            <div class="col-12">
					                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="execute();">Run</button>
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="resetForm();">Reset</button>
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
			<div><strong>Loading Result...</strong></div>
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
    <script src="../../../css/app-assets/js/scripts/sheetjs/xlsx.full.min.js"></script>
    <script src="../../../css/app-assets/js/scripts/forms/select/form-select2_B_toolbox.js"></script>    
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
    <script src="../../../css/app-assets/js/scripts/ag-grid/ag-grid_structure.js"></script>
    <script src="../../../css/app-assets/js/scripts/plotly-latest.min.js"></script>   
	<script src="../../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">   

	//Statistics에서 링크를 타고 왔을때 받는 전역변수. AG-Grid 로딩직후 cell click 용도로 사용
	var linkedJobid = "<%=linkedJobid%>";

   	$(document).ready(function(){
   		vcfFileList();
   	});
   	
   	function vcfFileList() {
   		
   		/*
   		fetch("../../../web/vb/vb_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(), {
   			method: "POST",
   		})
   		.then((res) => res.json())
   		.then((data) => {
   			console.log("vcf file list : ", data);
	 			
 			makeOptions(data);
   		})
   		*/
   		
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
   		
   		$("#VcfSelect").append(`<option data-jobid="-1" disabled hidden selected></option>`);
    	for(let i=0 ; i<data.length ; i++) {
			// ${data}}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
			$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-refgenome_id=\${data[i].refgenome_id} data-refgenome=\${data[i].refgenome} data-annotation_filename=\${data[i].annotation_filename} > \${data[i].filename} (\${data[i].comment}) </option>`);
		}
    }
    
    function selectMergePlot(number_of_k) {
    	//console.log(number_of_k);
    	
    	const jobid = document.getElementById('vcf_status').dataset.jobid;
    	const resultpath = document.getElementById('vcf_status').dataset.resultpath;
    	
    	$("#iframeLoading").modal("show");
    	
    	$('#pill1_frame').attr('src', `\${resultpath+"/"+jobid+"/merge_plot/"+number_of_k+".html"}`);
    }
    
    function selectPlot(file_name) {
    	const jobid = document.getElementById('vcf_status').dataset.jobid;
    	const resultpath = document.getElementById('vcf_status').dataset.resultpath;
    	
    	$("#iframeLoading").modal("show");
    	
    	$('#pill2_frame').attr('src', `\${resultpath+"/"+jobid+"/plot/"+file_name+".html"}`);
    }
    
    function resetForm() {
   		document.getElementById('uploadForm').reset();
    	vcfFileList();
    }
   	
   	$('#backdrop').on('hidden.bs.modal', function (e) {
   		resetForm();
    });    
   	
    async function execute() {
	   	
		const varietyid = $( "#variety-select option:selected" ).val();

		let comment = $('#comment').val();
   		
   		const jobid_structure = await fetch('../../getJobid.jsp').then((response) => response.text());
   		
    	const form = document.getElementById('uploadForm');
    	const formData = new FormData(form);
    	
   		const vcfSelect = document.getElementById('VcfSelect');
   		const jobid_vcf = vcfSelect.options[vcfSelect.selectedIndex].dataset.jobid;
   		const filename = vcfSelect.options[vcfSelect.selectedIndex].dataset.filename;
   		const refgenome_id = vcfSelect.options[vcfSelect.selectedIndex].dataset.refgenome_id;
   		const refgenome = vcfSelect.options[vcfSelect.selectedIndex].dataset.refgenome;
   		const annotation_filename = vcfSelect.options[vcfSelect.selectedIndex].dataset.annotation_filename;
   		
   		formData.append("varietyid", varietyid);
   		formData.append("jobid_structure", jobid_structure);
   		formData.append("jobid_vcf", jobid_vcf);
   		formData.append("filename", filename);
    	formData.append("refgenome_id", refgenome_id);
    	formData.append("refgenome", refgenome);
    	formData.append("annotation_filename", annotation_filename);
    	
   		/*
   		for(const key of formData.keys()) {
   			console.log(key, ":", formData.get(key));
   		}
   		*/
   		/*
   		console.log("comment : ", comment);
   		console.log("varietyid : ", varietyid);
   		console.log("jobid : ", jobid);
   		console.log("filename : ", filename);
   		console.log("uploadpath : ", uploadpath);
   		*/
   		
   		if(!comment) {
   			return alert("comment를 입력하세요.");
   		}
   		
    	if(Number(jobid_vcf) == -1) {
    		return alert("VCF 파일을 선택하세요.");
    	}
    	
    	if(!document.getElementById('Number_of_K').value) {
    		return alert("K값을 입력하세요.");
    	}
    	
   		
    	
    	fetch(`./structure_insertSql.jsp`, {
    		method: "POST",
   			headers: {
   				"Content-Type": "application/x-www-form-urlencoded",
   			},
   			body: new URLSearchParams(formData)
    	});
    	
    	
   		fetch(`./structure_analysis.jsp`, {
   			method: "POST",
   			headers: {
   				"Content-Type": "application/x-www-form-urlencoded",
   			},
   			body: new URLSearchParams(formData)
   		})
   		
   		
   		setTimeout( function () {
   			refresh();
   			$("#backdrop").modal("hide");
   		}, 1000);
   		
    }
    
       

       
</script>

</body>
<!-- END: Body-->

</html>