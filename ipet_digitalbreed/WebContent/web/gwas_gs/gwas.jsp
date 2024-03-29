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
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/vendors.min.css">
 	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/innorix/innorix.css">    
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/tables/ag-grid/ag-grid.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/tables/ag-grid/ag-theme-alpine.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/css/plugins/forms/validation/form-validation.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/forms/select/select2.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/pickers/flatpickr/flatpickr.min.css"> 
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
    <!--  
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/bootstrap5_custom.css">
    -->
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

.irx-file-inner-wrapper {
	height: 30px !important;
}

.innorix_basic div.irx_filetree, .irx_container {
	border : none !important;
}

.select2-container--default .select2-results__option[aria-disabled=true] {
    display: none;
}

.select2-search--inline {
    display: contents; /*this will make the container disappear, making the child the one who sets the width of the element*/
}

.select2-search__field:placeholder-shown {
    width: 100% !important; /*makes the placeholder to be 100% of the width while there are no options selected*/
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

    <jsp:include page="../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param value="gwas" name="menu_active"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;GWAS</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../index.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">GWAS/GS
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
                    <div id="gwas_status" class="card" style="display:none;">
                    	<div class='card-content'>
							<div class='card-body'>
								<div class='row'>
									<div class='col-12'>
										<ul id='button_list' class='nav nav-pills nav-active-bordered-pill'>
										</ul>
										<div id='content-list' class='tab-content'>
										</div>
									</div>
								</div>
								<div class='hidden-parameter'>
									<!-- parameters -->
									<input type='hidden' id='model_name'>
									<input type='hidden' id='resultpath'>
									<input type='hidden' id='jobid_param'>
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
        <!--  
        <div class="modal-dialog modal-dialog-centered modal-xl" style="max-width : 1140px; margin: 0 auto;" role="document">
        -->
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">GWAS New Analysis</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadGwasForm">
					    <div class="form-body">
					        <div class="row">
					            <div class="col-md-12 col-12 ml-1">
					                <br>
					             	<div class="form-label-group">
					                	<input type="text" id="comment" class="form-control" placeholder="Comment" name="comment" style="width:93%;" autocomplete="off" required data-validation-required-message="This name field is required">						                     
					                </div>
					            </div>
					            <div class="col-md-12 col-12 ml-1">
					            	<div class="form-label-group" >
					                    <select class="select2 form-select" id="VcfSelect" style="width:50%;">
					                    </select>
					                </div>
					            </div>
					            <fieldset class="border w-100 mt-1 ml-1 mr-1 pt-1 pl-1 pr-1">
					            	<legend  class="w-auto">Phenotype Selection</legend>
						            <div style="margin-bottom:4px;">
						            	<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="radio_phenotype" id="RadioPhenotype" onclick="radioSelect(false)" value="0" checked>
											<label class="form-check-label" for="RadioPhenotype"> Phenotype Database</label>
										</div>
										<div class="form-check form-check-inline">
											<input class="form-check-input" type="radio" name="radio_phenotype" id="RadioCsvFile" onclick="radioSelect(true)" value="1">
											<label class="form-check-label" for="RadioCsvFile"> New Phenotype</label>
										</div>
										<div class="form-check form-check-inline" style="margin-top:5px; margin-left:45px;">
											<div>
												<button type="button" id="exampleButton" style="float: right; display:none;" class="btn btn-info btn-sm" ><a href="/ipet_digitalbreed/uploads/phenotype.csv" download="phenotype.csv" style="color:white;" ><i class='feather icon-download'></i>예시파일받기</a> </button>	 
											</div>
										</div>
						            </div>
						            <div>
							            <div id="isPhenotype" class="form-label-group mt-1" >
						                    <div id="phenotypeSelectGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:190px;"></div><br>
							                <!--
							                <div id="phenotypeResultGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:120px;"></div><br>
							                -->
	                                    	<input type="text" id="cre_date" class="form-control flatpickr-range" style="display:inline; background-color:white; width:49%;" name="cre_date" placeholder=" (Optional) 등록일자" />
	                                    	<input type="text" id="inv_date" class="form-control flatpickr-range" style="display:inline; background-color:white; width:49%;" name="inv_date" placeholder=" (Optional) 조사일자" />
							            </div>
							        </div>
							        <div>
										<div id="isNewFile" class="form-label-group" style="display:none">
								            <div id="PhenotypeCsvFile" class="col-md-12 col-12"  style="padding: 0; border: 1px solid #48BAE4;"></div>
											<br>
						                	<!--  
						                	<div style="float: left; margin-top:5px;">
												<button type="button" style="float: left;" class="btn btn-danger btn-sm" ><a href="/ipet_digitalbreed/uploads/phenotype.csv" download="pca_population.xlsx" style="color:white;" ><i class='feather icon-download'></i>예시파일받기</a> </button>	 
											</div>
											-->
							            </div>
							        </div>
						        </fieldset>
						        <fieldset class="border w-100 m-1 pl-1">
						        	<legend  class="w-auto">Model</legend>
									<div class="form-label-group">
							            <div class="demo-inline-spacing">
	                                        <div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="GLM" name="modelGroup" value="GLM" />
	                                            <label class="form-check-label" for="GLM">GLM (General Linear Model)</label>
	                                        </div>
	                                        <div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="MLM" name="modelGroup" value="MLM" />
	                                            <label class="form-check-label" for="MLM">MLM(Mixed Linear Model)</label>
	                                        </div>
	                                    </div>
	                                    <div class="demo-inline-spacing">
	                                    	<div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="CMLM" name="modelGroup" value="CMLM" />
	                                            <label class="form-check-label" for="CMLM">CMLM(Compression MLM)</label>
	                                        </div>
	                                    	<div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="FarmCPU" name="modelGroup" value="FarmCPU"  style="margin-left:9px;" />
	                                            <label class="form-check-label" for="FarmCPU">FarmCPU</label>
	                                        </div>
	                                    </div>
	                                    <div class="demo-inline-spacing">
	                                    	<div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="SUPER" name="modelGroup" value="SUPER" />
	                                            <label class="form-check-label" for="SUPER">SUPER</label>
	                                        </div>
	                                        <div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="BLINK" name="modelGroup" value="BLINK" style="margin-left:121px;" />
	                                            <label class="form-check-label" for="BLINK">BLINK</label>
	                                        </div>
	                                    </div>
	                                    <div class="demo-inline-spacing">
	                                        <div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="MLMM" name="modelGroup" value="MLMM" />
	                                            <label class="form-check-label" for="MLMM">MLMM</label>
	                                        </div>
	                                    </div>
						            </div>
                                </fieldset>
					            <div class="col-12">
					                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="execute();">Run</button>
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="resetGWAS();">Reset</button>
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
			<div><strong>Loading GWAS Result...</strong></div>
	  	</div>
	</div>
	<!-- Modal end-->
                        
    <!-- END: Content-->
    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>
    <input type="hidden" id="jobid_gwas">
    <input type="hidden" id="phenotype_input">

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
    <script src="../../css/app-assets/js/scripts/forms/select/form-select2_gwas.js"></script>
    <script src="../../css/app-assets/vendors/js/pickers/flatpickr/flatpickr.min.js"></script>
    <script src="../../css/app-assets/js/scripts/sheetjs/xlsx.full.min.js"></script>  
    <!-- END Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
    <!--  
    <script src="../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-enterprise.js"></script>
    -->
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../../css/app-assets/js/core/app-menu.js"></script>
    <script src="../../css/app-assets/js/core/app.js"></script>
    <script src="../../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_gwas.js"></script>
    <script src="../../css/app-assets/js/scripts/plotly-latest.min.js"></script>
	<script src="../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>  
    <!--  
    <script src="../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    -->
    <!-- END: Page JS-->

<script type="text/javascript">    

	//Statistics에서 링크를 타고 왔을때 받는 전역변수. AG-Grid 로딩직후 cell click 용도로 사용
	var linkedJobid = "<%=linkedJobid%>";

	$(document).ready(function(){
   		
		flatpickr();   		

   		vcfFileList();
   		//phenotypeList();
   		
   		//$(".select2-container--default:gt(0)").width("444px");
   		//$(".select2-container--default:eq(1)").width("93%");
   		//$(".select2-container--default:eq(2)").width("99%");
   	});
	
	var box = new Object();
    window.onload = function() {
    	
    	// 파일전송 컨트롤 생성
	    box = innorix.create({
	    	el: '#PhenotypeCsvFile', // 컨트롤 출력 HTML 객체 ID
	        width			: 445,
	    	height          : 130,
	        maxFileCount   : 1,  
	        //allowType : ["vcf"],
	        allowType : ["csv"],
	        charset : "utf-8",
			addDuplicateFile : false,
	        agent: false, // true = Agent 설치, false = html5 모드 사용                    
	        uploadUrl: '/ipet_digitalbreed/web/gwas_gs/gwas_file_check.jsp',
	    });
    	
    	

	    // 업로드 완료 이벤트
	    box.on('uploadComplete', function (p) {
			//document.getElementById('uploadGwasForm').reset();
	    	box.removeAllFiles();
	    	//const jobid_gwas = $("#jobid_gwas").val();
	    	const jobid_gwas = p.postData.jobid_gwas;
	    	console.log("jobid_gwas : ", jobid_gwas);
	    	
	    	let data_arr;
	    	$.ajax({
	    		url: "./gwas_samplecheck.jsp",
	    		method: "POST",
	    		data: {"jobid_gwas": jobid_gwas},
	    		async: false,
	    		success: function(data) {
					console.log("없는 표현형 : ", data);
   	    			
   	    			//let data_arr = data.split(",");
   	    			//data_arr.pop();
   	    			let data_arr = data.substring(0, data.length - 1).split(",");
   	    			
   	    			$.ajax({
   	    				url: "./gwas_phenotypeFromCsv.jsp",
   	    				method: "POST",
   	    				data: {"jobid_gwas": jobid_gwas},
   	    				success: function(result_phenotype) {
   	    					
   	    					console.log("result_phenotype : ", result_phenotype);
   	    					
   	    					if(data_arr.length == 0 ) {
   	    	    				alert("분석이 시작됩니다. 잠시만 기다려주세요.");
   	    	    			} else {
   	    	    				if(!confirm(data_arr.length+"개의 표현형이 없습니다. 그래도 진행하시겠습니까?"))	return; 
   	    	    			}
   	    					
    	   	    	    	
    	   	    	    	
    	   	    	  		// permissionUid 삭제 (jsp session에서 받음)
    	   	    			const varietySelectEl = document.getElementById('variety-select');
    	   	    			const variety_id = varietySelectEl.options[varietySelectEl.selectedIndex].value;

    	   	    			const comment = document.getElementById('comment').value;
    	   	    			
    	   	    			const VcfSelectEl = document.getElementById('VcfSelect');
    	   	    			const jobid_vcf = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.jobid;
    	   	    			const filename_vcf = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.filename
    	   	    			// 2023-01-10 | 파라미터에 refgenome 추가
    	   	 				const refgenome = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.refgenome;
    	   	    			const refgenome_id = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.refgenome_id;
    	   	    			// 2023-02-03 | vcfdata_no 추가
    	   	    			const vcfdata_no = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.vcfdata_no;
    	   	    					
    	   	    	    	
	    	   	 			
    	   	    	    	const model_arr = ['GLM', 'MLM', 'CMLM', 'FarmCPU', 'SUPER', 'BLINK', 'MLMM'];
	    	   	 	   		//체크하지 않은 model은 배열에서 탈락
	    	   	 			for(let i=0 ; i<model_arr.length ; i++) {
	    	   	 				const modelCheckbox = document.getElementById(model_arr[i]);
	    	   	 				if(!modelCheckbox.checked) {
	    	   	 					model_arr.splice(i,1);
	    	   	 					i--;
	    	   	 				}
	    	   	 			}
    	   	    	    	
    	   	    	    	
    	   	    	    	const phenotype = result_phenotype;
    	   	    	    	
    	   	    	    	
    	   	    	    	const data = {
   	   	    	    			"variety_id": variety_id,
   	   	    	    			"comment": comment,
   	   	    	    			"jobid_gwas": jobid_gwas,
   	   	    	    			"jobid_vcf": jobid_vcf,
   	   	    	    			"refgenome": refgenome,						// analysis.jsp에서 사용
   	   	    	    			"refgenome_id": refgenome_id,
   	   	    	    			"vcfdata_no": vcfdata_no,
   	   	    	    			"radio_phenotype": 1,						// New Phenotype
   	   	    	    			"filename_vcf": filename_vcf,
   	   	    	    			"model_arr": model_arr,
   	   	    	    			"phenotype": phenotype,
    	   	    	    	}
    	   	    	    	
    	   	    	    	$.ajax({
    	    					url: "./gwas_analysis.jsp",
    	    					method: "POST",
    	    					data: data,
    	    				})
    	    				
    	    				setTimeout( function () {
    	    		   			refresh();
    	    		   			$("#backdrop").modal("hide");
    	    		   		}, 1000);
    	   	    	    	
   	    				}
   	 	    		});	
	    		}
	    	});
   	    	
        });
	    
	    //console.log("box? : ", box);
    };
	
	async function showPlotAndGrid(phenotype) {

		//document.getElementById('cutOffDiv').style.display = 'flex';
		
		const model = document.querySelector(`.nav-link.active`).textContent;
		const jobid_param = $('#jobid_param').val();
		//showPlot(phenotype);
		
		//document.getElementById(`cutOffDiv_\${model}`).style.display = 'flex';
		
		const params = new URLSearchParams({
			"phenotype": phenotype,
			"model": model,
			"jobid": jobid_param,
		});
		
		showPlot(phenotype);
		
		let cutOffValue = await fetch('./gwas_getCutOffValue.jsp', {
								method: "POST",
								headers: {
					   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
					   			},
					   			body: params,
							})
							.then((response) => response.text())
		
		
		cutOffValue = parseInt(cutOffValue) == Number(cutOffValue) ? parseInt(cutOffValue) : Number(cutOffValue);  
		
		//console.log(cutOffValue);
		
		
		if(cutOffValue == -1) {
			document.getElementById(`cutOffValue_\${model}`).value = "";
			showGrid(phenotype, cutOffValue, phenotype);
		} else {
			document.getElementById(`cutOffValue_\${model}`).value = cutOffValue;
			gapitCutOff(model, cutOffValue, phenotype);
		}
	}
	
	function validCheckCutOff(model, cutOff, phenotype) {
		if(Number(phenotype) == -1) {
    		return false;
    	}
    	
    	if(cutOff == 0 && !confirm("cut off값에 0 또는 아무것도 입력하지 않았습니다.\n이 경우 모든 데이터가 출력됩니다.\n계속 하시겠습니까?") ) {
    		return false;
    	}
    	
    	return true;
	}
	
	function updateCutOff(model, cutOffValue, phenotype) {
		//const selectEl = document.getElementById(`\${model}_phenotype`);
    	//const phenotype = selectEl.options[selectEl.selectedIndex].value;
    	
    	const params = new URLSearchParams({
			"phenotype": phenotype,
			"model": model,
			"jobid": $('#jobid_param').val(),
			"cutOffValue": cutOffValue,
		});
    	
    	fetch('./gwas_updateCutOffValue.jsp', {
			method: "POST",
			headers: {
   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
   			},
   			body: params,
		})
	}
    
    function gapitCutOff(model, cutOff, phenotype) {
    	console.log(model, cutOff, phenotype);
    	//const selectEl = document.getElementById(`\${model}_phenotype`);
    	//const phenotype = selectEl.options[selectEl.selectedIndex].value;
    	//console.log(phenotype);
    	showGrid(phenotype, cutOff);
    }
	
   	function vcfFileList() {
   		
   		$.ajax({
   			url: "/ipet_digitalbreed/web/database/genotype_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(),
   			method: 'POST',
   			success: function(data) {
	  			console.log("vcf file list : ", data);
	  			// data.selectFiles = vcfdata_info_t PK
	  			
	  			$("#VcfSelect").empty();
	  	    	$("#VcfSelect").append(`<option data-jobid="-1" disabled hidden selected>Select VCF File</option>`);
	  	    	for(let i=0 ; i<data.length ; i++) {
	  				// ${data}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
	  				//$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} data-refgenome_id=\${data[i].refgenome_id} > \${data[i].filename} (\${data[i].comment}) </option>`);
	  	    		$("#VcfSelect").append(`<option data-vcfdata_no=\${data[i].selectfiles} data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} data-refgenome_id=\${data[i].refgenome_id} > \${data[i].filename} (\${data[i].comment}) </option>`);
	  			}
   			}
   	  	});
   	}
   	
   	
	function phenotypeList() {
   		
		const variety_id = $( "#variety-select option:selected" ).val();
		
		//console.log("variety_id : ", variety_id);
		
		$.ajax({
			url : "./gwas_traitname.jsp",
			type : "post",
			async: false,
			data : {"varietyid" : variety_id},
			dataType : "json",
			success : function(result){
				gridOptionsTraitName.api.setRowData(result);
				/*
	   	    	for(let i=0 ; i<result.length ; i++) {
	   	    		$("#PhenotypeSelect").append(`<option data-traitname_key=\${i} data-traitname=\${result[i]} > \${result[i]} </option>`);
	   	    	}
				*/
			}
		});
   	}
   	
	//radio 선택에 따라 파일창 노출여부 결정  | true: New Phenotype , false: Phenotype Database
	function radioSelect(flag) {
		//console.log(flag);
		if(flag) {
			$("#isNewFile").css('display','block');
			$("#exampleButton").css('display','block');
			$("#isPhenotype").css('display','none');
			
			// New Phenotype 선택시 특성 체크박스 해제
			gridOptionsTraitName.api.deselectAll();
		} else {
			$("#isNewFile").css('display','none');
			$("#exampleButton").css('display','none');
			$("#isPhenotype").css('display','block');
			
			// Phenotype Database 선택시 innorix 파일목록 해제
			box.removeAllFiles();
		}
	}
   	
   	
   	function flatpickr() {
   		//let dateSelector = document.querySelectorAll(".flatpickr-range");
   		dateSelector = document.querySelectorAll(".flatpickr-range");
   		
   		
   		
   		dateSelector.flatpickr({
   			mode: "range",
   			dateFormat: "Y-m-d",
   			conjunction: " ~ "
   		});
   	}
   	
   	function resetFlatpickr() {
   		
   		let dateSelector = document.querySelectorAll(".flatpickr-day");
   		
   		//범위선택시 추가된 class를 삭제하여 css 제거 - 서버에는 input text값이 올라가므로 css만 신경쓰면 된다.
   		console.log(document.querySelectorAll('.flatpickr-day').forEach(el => {
   			//console.log(el);
   			//console.log(el.classList.contains('inRange'));
   			el.classList.remove('selected', 'startRange', 'endRange', 'inRange');
   		}));
   	}
   	
   	async function execute() {
   		
	   	//comment
		if(!document.getElementById("comment").value) {
			alert("Comment를 입력해 주세요.");
			return;
		}
   		
   		//VCF파일 목록 선택 안했으면 return
   		if($("#VcfSelect :selected").data('jobid') == '-1') {
   			alert("VCF파일을 선택하세요.");
   			return;
   		} 
   		
   		const jobid_gwas = await fetch('../getJobid.jsp')
	   							.then((response) => response.text())
	   							.then((data) => data);
   		
   		//select Phenotype Database
   		if(document.querySelector('input[name="radio_phenotype"]:checked').value == '0') {
   			
   			// phenotype options AG-Grid
   			if(!gridOptionsTraitName.api.getSelectedRows().length) {
   				alert("Phenotype을 한 개 이상 선택해 주세요");
   				return;
   			}
   			
   			
   			//modelGroup
   			if(document.querySelectorAll('input[name="modelGroup"]:checked').length == 0) {
   				alert("Model을  한 개 이상 선택해 주세요")
   				return;
   			}
   			
   			// permissionUid 삭제 (jsp session에서 받음)
   			const varietySelectEl = document.getElementById('variety-select');
   			const variety_id = varietySelectEl.options[varietySelectEl.selectedIndex].value;

   			const comment = document.getElementById('comment').value;
   			
   			const VcfSelectEl = document.getElementById('VcfSelect');
   			const jobid_vcf = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.jobid;
   			const filename_vcf = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.filename
   			// 2023-01-10 | 파라미터에 refgenome 추가
			const refgenome = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.refgenome;
   			// 2023-02-03 | vcfdata_no, regenome_id 추가
   			const vcfdata_no = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.vcfdata_no;
   			const refgenome_id = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.refgenome_id;
   					
   	    	
   	    	const selectedTrait = gridOptionsTraitName.api.getSelectedRows();
   	    	//console.log("selectedData : ", selectedData);
   	    	let traitname_arr = new Array();
   	    	let traitname_key_arr = new Array();
			  
			for (var i = 0; i < selectedTrait.length; i++) {
				traitname_arr.push(selectedTrait[i].traitname);
				traitname_key_arr.push(selectedTrait[i].traitname_key);
			}
   	    	
			
			const cre_date = document.getElementById('cre_date').value;
			//if(!cre_date) {
			//	cre_date = "-"
			//}
			const inv_date = document.getElementById('inv_date').value;
			//if(!inv_date) {
			//	inv_date = "-"
			//}
			
			const model_arr = ['GLM', 'MLM', 'CMLM', 'FarmCPU', 'SUPER', 'BLINK', 'MLMM'];

			//체크하지 않은 model은 배열에서 탈락
			for(let i=0 ; i<model_arr.length ; i++) {
				const modelCheckbox = document.getElementById(model_arr[i]);
				if(!modelCheckbox.checked) {
					model_arr.splice(i,1);
					i--;
				}
			}
			//console.log(modelArr);
			
			
   	    	
   	    	//console.log(traitname_arr);
   	    	//console.log(traitname_key_arr);
   	    	
   	    	const data = {
   	    			"variety_id": variety_id,
   	    			"comment": comment,
   	    			"jobid_gwas": jobid_gwas,
   	    			"jobid_vcf": jobid_vcf,
   	    			"refgenome": refgenome,						// analysis.jsp에서 사용
   	    			"refgenome_id": refgenome_id,
   	    			"vcfdata_no": vcfdata_no,
   	    			"radio_phenotype": 0,						// Phenotype Database
   	    			"filename_vcf": filename_vcf,
   	    			"traitname_arr": traitname_arr,
   	    			"traitname_key_arr": traitname_key_arr,
   	    			"model_arr": model_arr,
   	    			"cre_date": cre_date,
   	    			"inv_date": inv_date,
   	    	}
   	    	
   	    	
   	    	const check_data = await $.ajax({
							   	    		url: "./gwas_check.jsp",
							   	    		method: "POST",
							   	    		data: data,
							   	    		async: false,
							   	    	})
							  
   	    	
			const check_data_arr = check_data.substring(0, check_data.length - 1).split(",");
							   	    	
   	    	console.log(check_data_arr);
   	    	
   	    	if(check_data_arr.length == 0 ) {
   				alert("분석이 시작됩니다. 잠시만 기다려주세요.");
   			} else {
   				if(!confirm(check_data_arr.length+"개의 표현형이 없습니다. 그래도 진행하시겠습니까?"))	return; 
   			}
   	    	
   	    	
   	    	$.ajax({
				url: "./gwas_analysis.jsp",
				method: "POST",
				data: data,
				
			})
			
			setTimeout( function () {
	   			refresh();
	   			$("#backdrop").modal("hide");
	   		}, 1000);
   	    	
   			
   			
   		// select New Phenotype File	
   		} else {
   			//console.log(box.fileList.files.length);
   			if(!box.fileList.files.length) {
   				alert("파일을 아래 영역에 넣어주세요.");
   				return;
   			}
   			
   			//modelGroup
   			if(document.querySelectorAll('input[name="modelGroup"]:checked').length == 0) {
   				alert("Model을  한 개 이상 선택해 주세요.")
   				return;
   			}
   			
   			
   			const VcfSelectEl = document.getElementById('VcfSelect');
   			const jobid_vcf = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.jobid;
   			const filename_vcf = VcfSelectEl.options[VcfSelectEl.selectedIndex].dataset.filename;
   			
   			
   			
			// 파일 업로드 영역
	    	var postObj = new Object();
	    	//postObj.comment = comment;       
	        //postObj.variety_id = variety_id;
	        postObj.jobid_vcf = jobid_vcf;
	        postObj.filename_vcf = filename_vcf;
	        //postObj.model_arr = model_arr;
	        postObj.jobid_gwas = jobid_gwas;
	        box.setPostData(postObj);
	        box.upload();
	   		
   		}
    }
   	
   	function printCSV(text) {
   		//console.log("iframe param(text) : ", text);
   		let SNP_key = text.split("<br>").shift();
   		SNP_key = SNP_key.replace(/ /gi,"");
   		const SNP_value = SNP_key.split(":").pop();
   		console.log(SNP_value);
   		
   		if(!SNP_value){
   			return;
   		}
   		
   		const model_name = $('#model_name').val();
   		
   		gridOptions2.api.forEachNode((rowNode, index) => {
   			if(SNP_value == rowNode.data.SNP) {
   				//console.log(rowNode);
	   		    //console.log('node ' + rowNode.data.SNP + ' is in the grid');
	   		    //console.log(rowNode.rowIndex);
	   		 	gridOptions2.api.ensureIndexVisible(Number(rowNode.rowIndex), 'middle');
	   		 	rowNode.setSelected(true);
	   		 	//gridOptions2.api.getRowStyle(param)
   			}
   		});
   		
   	}
    
   	
   	$('#backdrop').on('hidden.bs.modal', function (e) {
   		resetGWAS();
    });
   	
   	function resetGWAS() {
   		document.getElementById('uploadGwasForm').reset();
   		
   		// 모달창 닫으면 초기화
    	// document.getElementById('uploadGwasForm').reset();
   		vcfFileList();
    	phenotypeList();
    	resetFlatpickr();
   	}
       
</script>

</body>
<!-- END: Body-->

</html>