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
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/tables/ag-grid/ag-grid.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/tables/ag-grid/ag-theme-alpine.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/css/plugins/forms/validation/form-validation.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/forms/select/select2.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/pickers/flatpickr/flatpickr.min.css"> 
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/bootstrap.css">
	<!--  
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/bootstrap5.min.css">
    -->
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

.select2-container--default .select2-results__option[aria-disabled=true] {
    display: none;
}

.irx-file-inner-wrapper {
	height: 30px !important;
}

.select2-search--inline {
    display: contents; /*this will make the container disappear, making the child the one who sets the width of the element*/
}

.select2-search__field:placeholder-shown {
    width: 100% !important; /*makes the placeholder to be 100% of the width while there are no options selected*/
}
/*로딩 아이콘 회전 시도*/
/*
@keyframes rotate {
  from {
    -webkit-transform: rotate(0deg);
    -o-transform: rotate(0deg);
    transform: rotate(0deg);
  }
  to {
    -webkit-transform: rotate(360deg);
    -o-transform: rotate(360deg);
    transform: rotate(360deg);
  }
}

.feather.icon-loader {
animation-name: rotate;
animation-duration: 2s;
animation-timing-function: linear;
animation-delay: 0s;
animation-iteration-count: infinite;
animation-direction: normal;
animation-fill-mode: none;
animation-play-state: running;
}
*/

</style>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";
	//System.out.println(cropvari_sql);
	//System.out.println("UID : " + permissionUid);
	
	//RunAnalysisTools runAnalysisTools = new RunAnalysisTools();
	//String jobid_gwas = runAnalysisTools.getCurrentDateTime();
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
                                    <li class="breadcrumb-item"><a href="../../mainboard.jsp">Home</a>
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
                            <div id="myGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:320px;"></div><br>
							<button class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal" data-target="#backdrop" data-backdrop="false"><i class="feather icon-upload"></i> New Analysis</button>
                            <button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>
                        </div>
                    </div>
                    <div id="gwas_status" class="card"></div>
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
												<button type="button" id="exampleButton" style="float: right; display:none;" class="btn btn-info btn-sm" ><a href="/ipet_digitalbreed/uploads/phenotype.csv" download="pca_population.xlsx" style="color:white;" ><i class='feather icon-download'></i>예시파일받기</a> </button>	 
											</div>
										</div>
						            </div>
						            <div>
							            <div id="isPhenotype" class="form-label-group" >
						                    <select class="select2 form-select max-length" id="PhenotypeSelect" style="width: 97%;" multiple>
						                    </select>
							                <br>
							                <br>
	                                    	<input type="text" id="cre_date" class="form-control flatpickr-range" style="display:inline; background-color:white; width:49%;" name="cre_date" placeholder=" (Optional) 등록일자" />
	                                    	<input type="text" id="inv_date" class="form-control flatpickr-range" style="display:inline; background-color:white; width:49%;" name="inv_date" placeholder=" (Optional) 조사일자" />
							            </div>
							        </div>
							        <div>
										<div id="isNewFile" class="form-label-group" style="display:none">
								            <div id="PhenotypeCsvFile" class="col-md-12 col-12"  style="border: 1px solid #48BAE4;"></div>
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
	                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox1" name="modelGroup" value="GLM" />
	                                            <label class="form-check-label" for="inlineCheckbox1">GLM (General Linear Model)</label>
	                                        </div>
	                                        <div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox2" name="modelGroup" value="MLM" />
	                                            <label class="form-check-label" for="inlineCheckbox2">MLM(Mixed Linear Model)</label>
	                                        </div>
	                                        
	                                    </div>
	                                    <div class="demo-inline-spacing">
	                                    	<div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox3" name="modelGroup" value="CMLM" />
	                                            <label class="form-check-label" for="inlineCheckbox3">CMLM(Compression MLM)</label>
	                                        </div>
	                                    	<div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox4" name="modelGroup" value="FarmCPU"  style="margin-left:9px;" />
	                                            <label class="form-check-label" for="inlineCheckbox4">FarmCPU</label>
	                                        </div>
	                                    </div>
	                                    <div class="demo-inline-spacing">
	                                    	<div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox5" name="modelGroup" value="SUPER" />
	                                            <label class="form-check-label" for="inlineCheckbox5">SUPER</label>
	                                        </div>
	                                        <div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox6" name="modelGroup" value="BLINK" style="margin-left:121px;" />
	                                            <label class="form-check-label" for="inlineCheckbox6">BLINK</label>
	                                        </div>
	                                    </div>
	                                    <div class="demo-inline-spacing">
	                                        <div class="form-check form-check-inline">
	                                            <input class="form-check-input" type="checkbox" id="inlineCheckbox7" name="modelGroup" value="MLMM" />
	                                            <label class="form-check-label" for="inlineCheckbox7">MLMM</label>
	                                        </div>
	                                    </div>
						            </div>
                                </fieldset>
					            <div class="col-12">
					                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="execute();">Run</button>
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
    <script src="../../css/app-assets/js/scripts/forms/select/form-select2.js"></script>
    <script src="../../css/app-assets/vendors/js/pickers/flatpickr/flatpickr.min.js"></script>
    <script src="../../css/app-assets/js/scripts/sheetjs/xlsx.full.min.js"></script>  
    <!--  
    <script src="../../css/app-assets/core/libraries/bootstrap.min.js"></script>
    -->  
	<!--  
	<script src="../../css/app-assets/vendors/js/jquery-ui/jquery-ui.min.js"></script>
	-->
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
    <script src="../../css/app-assets/js/scripts/loadingoverlay/loadingoverlay.js"></script>
	<script src="../../css/app-assets/js/scripts/loadingoverlay/loadingoverlay.min.js"></script>
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_gwas.js"></script>
    <script src="../../css/app-assets/js/scripts/plotly-latest.min.js"></script>
	<script src="../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">    

	$(document).ready(function(){
   		
		flatpickr();   		

   		vcfFileList();
   		phenotypeList();
   		//$(".select2-container--default:gt(0)").width("444px");
   		$(".select2-container--default:eq(1)").width("93%");
   		$(".select2-container--default:eq(2)").width("99%");
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
	    	const jobid_gwas = $("#jobid_gwas").val();
	    	console.log("jobid_gwas : ", jobid_gwas);
	    	
	    	$.ajax({
	    		url: "./gwas_samplecheck.jsp",
	    		method: "POST",
	    		data: {"jobid_gwas": jobid_gwas},
	    		success: function(data) {
					console.log("없는 표현형 : ", data);
   	    			
   	    			let data_arr = data.split(",");
   	    			data_arr.pop();
   	    	    	
   	    			
   	    			
   	    			$.ajax({
   	    				url: "./gwas_phenotypeFromCsv.jsp",
   	    				method: "POST",
   	    				data: {"jobid_gwas": jobid_gwas},
   	    				success: function(phenotype) {
   	    					//console.log("phenotype_input : ", phenotype_input);
   	    					console.log("phenotype : ", phenotype);
   	    					$("#phenotype_input").val(phenotype);
   	    					//const phenotype_input = $("#phenotype_input").val();
   	    					
   	    					if(confirm(data_arr.length+"개의 표현형이 없습니다. 그래도 진행하시겠습니까?")) {
   	    	    	    		
   	    	    	    		const permissionUid = "<%=permissionUid%>";
   	    	   	    	   		const variety_id = $( "#variety-select option:selected" ).val();
   	    	   	    	    	const jobid_vcf = $('#VcfSelect :selected').data('jobid');
   	    	   	    	    	const filename_vcf = $('#VcfSelect :selected').data('filename');
   	    	   	    	    	
   	    	   	    	    	
   	    	   	    	    	let traitname_arr = new Array();
   	    	   	    	    	let traitname_key_arr = new Array();
   	    	   	    	    	
   	    	   	    	    	const phenotype = $("#phenotype_input").val();
   	    	   	    	    	
   	    	   	    	    	for(let i=0 ; i<phenotype.length ; i++) {
   	    	   	    	    		traitname_arr.push( $(this).data('traitname'));
   	 	   	    	    			traitname_key_arr.push( $(this).data('traitname_key'));
   	    	   	    	    	}
   	    	   	    	    	
   	    	   	    	    	
   	    	   	    	    	/*
   	    	   	    	    	$("#PhenotypeSelect :selected").each(function(index) {
   	    	   	    	    		traitname_arr.push( $(this).data('traitname'));
   	    	   	    	    		traitname_key_arr.push( $(this).data('traitname_key'));
   	    	   	    	    	})
   	    	   	    	    	*/
   	    	   	    	    	
   	    	   	    	    	//console.log(traitname_arr);
   	    	   	    	    	//console.log(traitname_key_arr);
   	    	    	    		
   	    	   	    	    	let formData = new FormData($("#uploadGwasForm")[0]);
   	    	   	   	    	
   	    			   	    	formData.append('permissionUid', permissionUid);
   	    			   	    	formData.append('variety_id', variety_id);
   	    			   	    	formData.append('jobid_gwas', jobid_gwas);
   	    			   	  		formData.append('jobid_vcf', jobid_vcf);
   	    			   	    	formData.append('filename_vcf', filename_vcf);
   	    			   	    	formData.append('traitname_arr', traitname_arr);
   	    			   	    	formData.append('traitname_key_arr', traitname_key_arr);
   	    			   	    	formData.append('phenotype', phenotype);
   	    			   	    	
   	    			   	  		let queryString = new URLSearchParams(formData).toString();
   	    	    	    		
   	    	    				$.ajax(
   	    	    				{
   	    	    					url: "./gwas_analysis.jsp",
   	    	    					method: "POST",
   	    	    					data: queryString,
   	    	    					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
   	    	    					success: function(result) {
   	    	    						
   	    	    					}
   	    	    					
   	    	    				})
   	    	    				
   	    	    				setTimeout( function () {
   	    	    		   			refresh();
   	    	    		   			$("#backdrop").modal("hide");
   	    	    		   		}, 1000);
   	    	    			} 
   	    				}
   	    			})
	    		}
	    	})
			
			/*
	    	//시간이 조금 지나면 Rscript 작동 여부에 관계없이 새로고침
	   		setTimeout( function () {
	   			//backdrop.style.display = "none";
	   			refresh();
	   			$("#backdrop").modal("hide");
	   			}
	   		, 1000);
			*/
        });
	    
	    //console.log("box? : ", box);
    };
	
	
   	function vcfFileList() {
   		
   		$.ajax({
   			url: "/ipet_digitalbreed/web/database/genotype_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(),
   			method: 'POST',
   			success: function(data) {
	  			//console.log("vcf file list : ", data);
	  			
	  			$("#VcfSelect").empty();
	  	    	$("#VcfSelect").append(`<option data-jobid="-1" disabled hidden selected>Select VCF File</option>`);
	  	    	for(let i=0 ; i<data.length ; i++) {
	  				// ${data}}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
	  				$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} > \${data[i].filename} (\${data[i].comment}) </option>`);
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
	   	    	console.log("phenotype traitname : ", result);
	   	    	//$("#PhenotypeSelect").append(`<option disabled hidden selected>(Required)Select Phenotype</option>`);
	   	    	for(let i=0 ; i<result.length ; i++) {
	   	    		$("#PhenotypeSelect").append(`<option data-traitname_key=\${i} data-traitname=\${result[i]} > \${result[i]} </option>`);
	   	    	}
			}
		});
   	}
   	
	//radio 선택에 따라 파일창 노출여부 결정
	function radioSelect(flag) {
		//console.log(flag);
		if(flag) {
			$("#isNewFile").css('display','block');
			$("#exampleButton").css('display','block');
			$("#isPhenotype").css('display','none');
		} else {
			$("#isNewFile").css('display','none');
			$("#exampleButton").css('display','none');
			$("#isPhenotype").css('display','block');
		}
	}
   	
   	function flatpickr() {
   		let dateSelector = document.querySelectorAll(".flatpickr-range");
   		
   		dateSelector.flatpickr({
   			mode: "range",
   			dateFormat: "Y-m-d",
   			conjunction: " ~ "
   		});
   	}
   	
   	function execute() {
   		
   		//VCF파일 목록 선택 안했으면 return
   		if($("#VcfSelect :selected").data('jobid') == '-1') {
   			alert("VCF파일을 선택하세요.");
   			return;
   		} 
   		
   		//select Phenotype Database
   		if(document.querySelector('input[name="radio_phenotype"]:checked').value == '0') {
   			
   			// phenotype option
   			if($("#PhenotypeSelect :selected").length == 0) {
   	   			alert("Phenotype을 선택하세요.");
   	   			return;
   	   		}
   			
   			//modelGroup
   			if(document.querySelectorAll('input[name="modelGroup"]:checked').length == 0) {
   				alert("Model을 최소 1개 선택하세요.")
   				return;
   			}
   			
   			 
   			const permissionUid = "<%=permissionUid%>";
   	   		const variety_id = $( "#variety-select option:selected" ).val();
   	    	const jobid_vcf = $('#VcfSelect :selected').data('jobid');
   	    	const filename_vcf = $('#VcfSelect :selected').data('filename');
   	    	
   	    	
   	    	let traitname_arr = new Array();
   	    	let traitname_key_arr = new Array();
   	    	
   	    	$("#PhenotypeSelect :selected").each(function(index) {
   	    		traitname_arr.push( $(this).data('traitname'));
   	    		traitname_key_arr.push( $(this).data('traitname_key'));
   	    	})
   	    	
   	    	//console.log(traitname_arr);
   	    	//console.log(traitname_key_arr);
   	    	
   	    	
   	    	let formData = new FormData($("#uploadGwasForm")[0]);
   	    	
   	    	formData.append('permissionUid', permissionUid);
   	    	formData.append('variety_id', variety_id);
   	    	formData.append('jobid_vcf', jobid_vcf);
   	    	formData.append('filename_vcf', filename_vcf);
   	    	formData.append('traitname_arr', traitname_arr);
   	    	formData.append('traitname_key_arr', traitname_key_arr);
   	    	
   	    	let queryString = new URLSearchParams(formData).toString();
   			
   	    	console.log(queryString);
   	    	
   	    	$.ajax(
   	    	{
   	    		url: "./gwas_check.jsp",
   	    		method: "POST",
   	    		data: queryString,
   	    		contentType : "application/x-www-form-urlencoded; charset=UTF-8",
   	    		//dataType:"json",
   	    		success: function(data) {
   	    			
   	    			//$("#backdrop").modal("hide");
   	    			
   	    			
   	    			console.log("없는 표현형 : ", data);
   	    			
   	    			let data_arr = data.split(",");
   	    			
   	    			const jobid_gwas = data_arr.pop();
   	    			console.log("jobid_gwas : ", jobid_gwas);
   	    			formData.append('jobid_gwas', jobid_gwas);
   	    			let queryString2 = new URLSearchParams(formData).toString();
   	    			
   	    			console.log(data_arr);
   	    			
   	    			if(confirm(data_arr.length+"개의 표현형이 없습니다. 그래도 진행하시겠습니까?")) {
   	    				$.ajax(
   	    				{
   	    					url: "./gwas_analysis.jsp",
   	    					method: "POST",
   	    					data: queryString2,
   	    					contentType : "application/x-www-form-urlencoded; charset=UTF-8",
   	    					success: function(result) {
   	    						
   	    					}
   	    					
   	    				})
   	    				
   	    				setTimeout( function () {
   	    		   			refresh();
   	    		   			$("#backdrop").modal("hide");
   	    		   		}, 1000);
   	    			} 
   	    			
   	    		}
   	    		
   	    	})
   			
   			
   			
   		// select New Phenotype File	
   		} else {
   			console.log(box.fileList.files.length);
   			if(!box.fileList.files.length) {
   				alert("파일을 아래 영역에 넣어주세요.");
   				return;
   			}
   			
   			//modelGroup
   			if(document.querySelectorAll('input[name="modelGroup"]:checked').length == 0) {
   				alert("Model을 최소 1개 선택하세요.")
   				return;
   			}
   			
   			const permissionUid = "<%=permissionUid%>";
   	   		const varietyid = $( "#variety-select option:selected" ).val();
   	    	const jobid_vcf = $('#VcfSelect :selected').data('jobid');
   	    	const filename = $('#VcfSelect :selected').data('filename');
   			
   	    	let model_arr = [];
   			document.querySelectorAll('input[name="modelGroup"]:checked').forEach(function(item) {
   				model_arr.push(item.value);
   			})
   			
   			
   			
   			fetch("./gwas_getJobId.jsp")
   			.then((response) => response.text())
   			.then((jobid_gwas) => {
   				$("#jobid_gwas").val(jobid_gwas);
					
   				// 파일 업로드 영역
		    	var postObj = new Object();
		   		postObj.permissionUid = permissionUid;
		    	postObj.comment = $("#comment").val();	       
		        postObj.varietyid = varietyid;
		        postObj.jobid_vcf = jobid_vcf;
		        postObj.filename = filename;
		        postObj.model_arr = model_arr;
		        postObj.jobid_gwas_ = jobid_gwas;
		        box.setPostData(postObj);
		        box.upload();
   			});
   			
   		}
   		
   		
   		
    	
    }
   	
   	
   	function printCSV(text) {
   		console.log("iframe param(text) : ", text);
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

   		// 모달창 닫으면 초기화
    	// document.getElementById('uploadGwasForm').reset();
    	vcfFileList();
    	phenotypeList();
    });
       
</script>

</body>
<!-- END: Body-->

</html>