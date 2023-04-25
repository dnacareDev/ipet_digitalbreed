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
    <link rel="stylesheet" type="text/css" href="../../../css/index_assets/css/icons.min.css">
    <!-- END: Page CSS-->

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
	
	String linkedJobid = request.getParameter("linkedJobid");
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">

    <jsp:include page="../../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="vfm"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;VCF File Merge</h2>
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
                                </div>
                                  
                            </div>
                            <div id="myGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:435px;"></div><br>
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
											<li class='nav-item'><a class='nav-link active' id='qf_1' data-toggle='pill' href='#pill1' aria-expanded='true'>Filtering Info </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_2' data-toggle='pill' href='#pill2' aria-expanded='false'>Variant </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_3' data-toggle='pill' href='#pill3' aria-expanded='false'>DP </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_4' data-toggle='pill' href='#pill4' aria-expanded='false'>Missing </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_5' data-toggle='pill' href='#pill5' aria-expanded='false'>Density Plot </a></li>
										</ul>
										<div class='tab-content'>
											<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill1_frame' onload='hideSpinner(); gridOptions.api.sizeColumnsToFit();'></iframe>
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
												<iframe src = '' height='650px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill5_frame' onload='hideSpinner()'></iframe>
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
    <div class="modal fade text-left" id="backdrop" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true" >
        <div class="modal-dialog  modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">Merge New analysis</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadForm">
					    <div class="form-body">
					        <div class="row">
					            <fieldset class="border w-100 ml-1 mr-1 p-1">
						        <legend class="w-auto">Options</legend>
						            <div class="col-12">
					            		<div class="row">
							            	<div class="form-check col-6 pl-2">
							            		<input type="radio" class="form-check-input" id="analysisModalRadio1" name="analysisModalRadioType1" value="concatenate" onclick="document.getElementById('concatenateOptionDiv').style.display='flex'; document.getElementById('mergeOptionDiv').style.display='none'; deselectAllCheckbox()" checked/>
		                                        <label class="form-check-label" for="analysisModalRadio1" style="margin-left:4px;" >Concatenate</label>
		                                        <!--  
		                                        <i class="ri-question-line" title="동일한 샘플에 대해"></i>
		                                        -->
		                                        <i class="ri-question-line" data-toggle="popover" data-trigger="hover" data-container="#backdrop" data-content="동일한 샘플에 대해 부분적으로(partial) 작성된 여러 개의 vcf 파일을 하나의 vcf 파일로 병합하는 기능입니다.<br><br>입력 파일 간에는 반드시 동일한 형태의 VCF header와 sample ID 정보를 공유해야 합니다." data-html="true"></i>
							            	</div>
							            	<div class="form-check col-6 pl-2">
							            		<input type="radio" class="form-check-input" id="analysisModalRadio2" name="analysisModalRadioType1" value="merge" onclick="document.getElementById('concatenateOptionDiv').style.display='none'; document.getElementById('mergeOptionDiv').style.display='flex'; deselectAllCheckbox" />
		                                        <label class="form-check-label" for="analysisModalRadio2" style="margin-left:4px;" >Merge</label>
		                                        <i class="ri-question-line" data-toggle="popover" data-trigger="hover" data-container="#backdrop" data-content="동일한 변이 site에 대해 서로 다른 샘플에 대한 여러 개의 vcf 파일을 하나의 vcf 파일로 병합하는 기능입니다.<br><br>입력 파일 간에는 반드시 동일한 형태의 VCF header와 변이 sites 정보를 공유해야 합니다." data-html="true"></i>
							            	</div>
					            		</div>
					            		<div id="concatenateOptionDiv" class="row mt-1">
							            	<div class="form-check col-6 pl-2">
							            		<input type="checkbox" class="form-check-input" id="modalCheckbox1" name="removeDuplicateSites" />
		                                        <label class="form-check-label" for="modalCheckbox1" style="margin-left:4px;" >Remove duplicate sites</label>
							            	</div>
							            	<div class="form-check col-6 pl-2">
							            		<input type="checkbox" class="form-check-input" id="modalCheckbox2" name="sortPositions" />
		                                        <label class="form-check-label" for="modalCheckbox2" style="margin-left:4px;" >Sort positions</label>
							            	</div>
					            		</div>
					            		<div id="mergeOptionDiv" class="row mt-1" style="display:none;">
							            	<div class="form-check col-6 pl-2">
							            		<input type="checkbox" class="form-check-input" id="modalCheckbox3" name="AllowDuplicateSamples" />
		                                        <label class="form-check-label" for="modalCheckbox3" style="margin-left:4px;" >Allow duplicate samples</label>
							            	</div>
							            	<div class="form-check col-6 pl-2">
							            		<input type="checkbox" class="form-check-input" id="modalCheckbox4" name="missingToRefGenotype" />
		                                        <label class="form-check-label" for="modalCheckbox4" style="margin-left:4px;" >Missing to Ref genotype</label>
							            	</div>
					            		</div>
						            </div>
						        </fieldset>
						        <fieldset class="border w-100 m-1">
						        <legend class="w-auto ml-1 mr-1">Select VCF File</legend>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
					            			<div class="col-12">
												<div id="VcfGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:220px;"></div>
											</div>
					            		</div>
						            </div>
						        </fieldset>
					            <div class="col-12">
					                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="Execute();">Run</button>
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="javascript:resetForm();">Reset</button>
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
    <script src="../../../css/app-assets/js/scripts/forms/select/form-select2_B_toolbox.js"></script>
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
    <script src="../../../css/app-assets/js/scripts/ag-grid/ag-grid_vfm.js"></script>
    <!--  
    <script src="../../../css/app-assets/js/scripts/plotly-latest.min.js"></script>
	<script src="../../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    -->   
    <!-- END: Page JS-->

<script type="text/javascript">

	//Statistics에서 링크를 타고 왔을때 받는 전역변수. AG-Grid 로딩직후 cell click 용도로 사용
	var linkedJobid = "<%=linkedJobid%>";

	$(function () {
   		$('[data-toggle="popover"]').popover()
	});
	
   	$(document).ready(function(){
   		
   	});

   	function vcfFileList() {
   		$.ajax(
   			{
 	   			url: "../../../web/database/genotype_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(),
 	   			method: 'POST',
 	   			success: function(data) {
 		  			console.log("vcf file list : ", data);
 		  			
 		  			//makeOptions(data);
 	   			}
   	  	});
   	}
   	
    function makeOptions(data) {
    	$("#VcfSelect").empty();
    	
    	$("#VcfSelect").append(`<option data-jobid="-1" disabled hidden selected>Select VCF File</option>`);
    	for(let i=0 ; i<data.length ; i++) {
			// ${data}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
			$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} data-refgenome_id=\${data[i].refgenome_id} > \${data[i].filename} (\${data[i].comment}) </option>`);
		}
    }
    
	// 로딩이 완료되면 로딩창 소멸
	function hideSpinner() {
		$("#iframeLoading").modal('hide');
	}
   	
	function saveToVcf(filename, jobid, refgenome, refgenome_id, annotation_filename) { 
		if(!confirm("결과를 Genotype DB에 저장하시겠습니까?")) {
			return;
		}
		
		
	   	const variety_id = $( "#variety-select option:selected" ).val();
	   	
	   	//console.log(variety_id);
	   	//console.log(filename);
	   	//console.log(jobid);
	   	console.log("saveToVcf refgenome :", refgenome );
	   	
	   	
	   	fetch(`./vfm_fileupload_ext.jsp?jobid=\${jobid}&vcf_filename=\${filename}&variety_id=\${variety_id}&refgenome=\${refgenome}&refgenome_id=\${refgenome_id}&annotation_filename=\${annotation_filename}`);
	   	
	   	$("#iframeLoading").modal('show');
	   	
	   	//시간이 조금 지나면 Rscript 작동 여부에 관계없이 새로고침
   		setTimeout( function () {
	   			refresh();
	   			hideSpinner();
	   			$("#backdrop").modal("hide");
   			}
   		, 2000);
	}
	
	function moveToVcf(jobid) {
		console.log(jobid);
		
		let form = document.createElement('form'); // 폼객체 생성
		let objs;
		objs = document.createElement('input'); // 값이 들어있는 녀석의 형식
		objs.setAttribute('type', 'hidden'); // 값이 들어있는 녀석의 type
		objs.setAttribute('name', 'linkedJobid'); // 객체이름
		objs.setAttribute('value', jobid); //객체값
		form.appendChild(objs);
		form.setAttribute('method', 'post'); //get,post 가능
		form.setAttribute('action', "../../database/genotype.jsp"); //보내는 url
		form.target = "VCF";
		document.body.appendChild(form);
		form.submit();
	}
	
   	$('#backdrop').on('hidden.bs.modal', function (e) {
   		resetForm();
    });    
   	
	function resetForm() {
		//document.getElementById('uploadForm').reset();
		document.querySelectorAll(`#uploadForm .form-check input[type="checkbox"]`).forEach((node) => {
			node.checked = false;
		});
		document.getElementById('analysisModalRadio1').click();
		
		vcf_gridOptions.api.forEachNode((node) => {
			node.setSelected(false);
		});
		
		//vcfFileList();
	}
	
	function deselectAllCheckbox() {
		document.querySelectorAll(`#uploadForm .form-check input[type="checkbox"]`).forEach((node) => {
			node.checked = false;
		});
	}
   	
    async function Execute() {
    	
    	
	   	const variety_id = $( "#variety-select option:selected" ).val();
    	
   		const jobid_vfm = await fetch('../../getJobid.jsp').then((response)=>response.text());
    	
    	const form = document.getElementById('uploadForm');
    	const formData = new FormData(form);
    	
    	const selected_vcf = vcf_gridOptions.api.getSelectedRows();
    	
    	if( document.getElementById('analysisModalRadio1').checked && (!document.getElementById('modalCheckbox1').checked && !document.getElementById('modalCheckbox2').checked) ) {
    		return alert("Remove doplicate sites 또는 Sort positions 중 하나 이상을 체크하셔야 합니다.")
    	}
    	
    	if( document.getElementById('analysisModalRadio2').checked && (!document.getElementById('modalCheckbox3').checked && !document.getElementById('modalCheckbox4').checked) ) {
    		return alert("Allow duplicate samples 또는 Missing to Ref genotype 중 하나 이상을 체크하셔야 합니다.")
    	}
    	
    		
    	if(selected_vcf.length != 2) {
    		return alert("vcf파일을 2개 선택해주세요.");
    	}
    	
    	
    	let refgenome_id = 0;
    	if(selected_vcf[0].refgenome_id != selected_vcf[1].refgenome_id) {
    		if(!confirm("각 VCF가 서로 다른 참조유전체를 가지고 있습니다.\n이대로 진행할 경우 참조유전체 정보가 사라집니다.\n계속하시겠습니까?")) {
    			return;
    		}
    	} else {
	    	refgenome_id = selected_vcf[0].refgenome_id;
    	}
    	
    	
    	formData.append('variety_id', variety_id);
    	formData.append('jobid_vfm', jobid_vfm);
    	formData.append('vcf_1', selected_vcf[0]['jobid']+","+selected_vcf[0]['filename']);
    	formData.append('vcf_2', selected_vcf[1]['jobid']+","+selected_vcf[1]['filename']);
    	formData.append('refgenome_id', refgenome_id);

    	const params = new URLSearchParams(formData);
    	
    	/*
    	for(const key of formData.keys()) {
   			console.log(key, ":", formData.get(key));
   		}
    	*/
    	
   		fetch(`./vfm_insertSql.jsp`, {
    		method: "POST",
   			headers: {
   				"Content-Type": "application/x-www-form-urlencoded",
   			},
   			body: params
    	});
    	
    	fetch(`./vfm_analysis.jsp`, {
   			method: "POST",
   			headers: {
   				"Content-Type": "application/x-www-form-urlencoded",
   			},
   			body: params
   		});
    	
   		
    	//시간이 조금 지나면 Rscript 작동 여부에 관계없이 새로고침
   		setTimeout( function () {
   			refresh();
   			$("#backdrop").modal("hide");
   			}
   		, 1000);
    	
    }
    
	$("#backdrop").on('shown.bs.modal', function() {
		vcf_gridOptions.api.sizeColumnsToFit();
	});

       
</script>

</body>
<!-- END: Body-->

</html>