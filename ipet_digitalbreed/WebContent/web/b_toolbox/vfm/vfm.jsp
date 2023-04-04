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
    <div class="modal fade text-left" id="backdrop" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true" style="z-index:10">
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
							            		<input type="radio" class="form-check-input" id="analysisModalRadio1" name="analysisModalRadioType1" checked/>
		                                        <label class="form-check-label" for="analysisModalRadio1" style="margin-left:4px;" >Concatenate</label>
		                                        <!--  
		                                        <i class="ri-question-line" title="동일한 샘플에 대해"></i>
		                                        -->
		                                        <i class="ri-question-line" data-toggle="popover" data-trigger="hover" data-content="동일한 샘플에 대해 부분적으로(partial) 작성된 여러 개의 vcf 파일을 하나의 vcf 파일로 병합하는 기능입니다.\n입력 파일 간에는 반드시 동일한 형태의 VCF header와 sample ID 정보를 공유해야 합니다."></i>
							            	</div>
							            	<div class="form-check col-6 pl-2">
							            		<input type="radio" class="form-check-input" id="analysisModalRadio2" name="analysisModalRadioType1" />
		                                        <label class="form-check-label" for="analysisModalRadio2" style="margin-left:4px;" >Merge</label>
		                                        <i class="ri-question-line" data-toggle="popover" data-trigger="hover" data-content="동일한 변이 site에 대해 서로 다른 샘플에 대한 여러 개의 vcf 파일을 하나의 vcf 파일로 병합하는 기능입니다.\n입력 파일 간에는 반드시 동일한 형태의 VCF header와 변이 sites 정보를 공유해야 합니다."></i>
							            	</div>
					            		</div>
					            		<div class="row mt-1">
							            	<div class="form-check col-6 pl-2">
							            		<input type="checkbox" class="form-check-input" id="analysisModalCheckbox1"/>
		                                        <label class="form-check-label" for="analysisModalCheckbox1" style="margin-left:4px;" >remove duplicate sites</label>
							            	</div>
							            	<div class="form-check col-6 pl-2">
							            		<input type="checkbox" class="form-check-input" id="analysisModalCheckbox2" />
		                                        <label class="form-check-label" for="analysisModalCheckbox2" style="margin-left:4px;" >Missing to Ref genotype</label>
							            	</div>
					            		</div>
						            </div>
						        </fieldset>
						        <fieldset class="border w-100 m-1">
						        <legend class="w-auto ml-1 mr-1">Select a subset of sample</legend>
						            <div class="col-md-12 col-12">
					            		<div class="row pl-2 pr-2" style="display:flex; column-gap:10px;">
							            	Move to the right
					            		</div>
						            </div>
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
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="javascript:resetQF();">Reset</button>
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
    -->   
	<script src="../../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">

	//Statistics에서 링크를 타고 왔을때 받는 전역변수. AG-Grid 로딩직후 cell click 용도로 사용
	var linkedJobid = "<%=linkedJobid%>";

	$(function () {
		$('[data-toggle="popover"]').popover()
	})
	
   	$(document).ready(function(){
   		//vcfFileList();
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
			// ${data}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
			$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} data-refgenome_id=\${data[i].refgenome_id} > \${data[i].filename} (\${data[i].comment}) </option>`);
		}
    }
    
	// 로딩이 완료되면 로딩창 소멸
	function hideSpinner() {
		$("#iframeLoading").modal('hide');
	}
   	
	function saveToVcf(filename, jobid, refgenome, refgenome_id) { 
		if(!confirm("결과를 Genotype DB에 저장하시겠습니까?")) {
			return;
		}
		
		
	   	const variety_id = $( "#variety-select option:selected" ).val();
	   	
	   	//console.log(variety_id);
	   	//console.log(filename);
	   	//console.log(jobid);
	   	console.log("saveToVcf refgenome :", refgenome );
	   	
	   	
	   	fetch(`../../database/fileupload_ext.jsp?jobid=\${jobid}&vcf_filename=\${filename}&variety_id=\${variety_id}&refgenome=\${refgenome}&refgenome_id=\${refgenome_id}`);
	   	
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
   		resetQF();
    });    
   	
	function resetQF() {
		document.getElementById('uploadForm').reset();
		
		document.getElementById("thin").style.display = "none";
		vcfFileList();
	}
   	
    async function Execute() {
    	
	   	const variety_id = $( "#variety-select option:selected" ).val();
    	
    	const select_vcf = document.getElementById('VcfSelect');
    	const jobid_vcf = select_vcf.options[select_vcf.selectedIndex].dataset.jobid;
    	const file_name = select_vcf.options[select_vcf.selectedIndex].dataset.filename;
    	const refgenome_id = select_vcf.options[select_vcf.selectedIndex].dataset.refgenome_id;
    	
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
    		alert("VCF 파일을 선택하세요");
    		return;
    	}
    	
    	if(!snp_checked && !indel_checked) {
    		alert("Variant Type을 한 개 이상 선택해 주세요");
    		return;
    	}
    	
    	if(!minDP) {
    		alert("MinDP를 입력하세요");
    		return;
    	}
    	
    	if(!minGQ) {
    		alert("MinGQ를 입력하세요");
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
    			"variety_id": variety_id,
    			"jobid_qf": jobid_qf,
    			"file_name": file_name,
    			"refgenome_id": refgenome_id,
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
    
	$("#backdrop").on('shown.bs.modal', function() {
		vcf_gridOptions.api.sizeColumnsToFit();
	});

       
</script>

</body>
<!-- END: Body-->

</html>