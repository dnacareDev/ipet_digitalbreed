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
					                	<input type="text" id="comment" class="form-control" placeholder="Comment" name="comment" style="width:444px;" autocomplete="off" required data-validation-required-message="This name field is required">						                     
					                </div>
					            </div>
					            <div class="col-md-12 col-12 ml-1">
					            	<div class="form-label-group" >
					                    <select class="select2 form-select" id="VcfSelect" style="width: 444px;">
					                    </select>
					                </div>
					            </div>
					            <div class="col-md-12 col-12 ml-1" style="margin-bottom:4px;">
					            	<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="radio_phenotype" id="inlineRadio1" onclick="radioSelect(false)" value="0" checked>
										<label class="form-check-label" for="inlineRadio1"> Phenotype Database</label>
									</div>
									<div class="form-check form-check-inline">
										<input class="form-check-input" type="radio" name="radio_phenotype" id="inlineRadio2" onclick="radioSelect(true)" value="1">
										<label class="form-check-label" for="inlineRadio2"> New Phenotype</label>
									</div>
									<!--  
					            	<input type="radio" name="radio_phenotype" onclick="radioSelect(false)" value="0"" checked ><span> Phenotype DB</span><br>
					            	<input type="radio" name="radio_phenotype" onclick="radioSelect(true)" value="1" ><span> 신규 등록</span>
					            	-->
					            </div>
					            <div class="col-md-12 col-12 ml-1">
						            <div id="isPhenotype" class="form-label-group" >
						            	<!--  
						            	<input type="radio" name="radio_phenotype" onclick="radioSelect(false)" value="0" checked><span> Phenotype DB</span><br>
						            	-->
					                    <select class="select2 form-select max-length" id="PhenotypeSelect" style="width: 444px;" multiple>
					                    </select>
						                <br>
						                <br>
                                    	<input type="text" id="cre_date" class="form-control flatpickr-range" style="background-color:white; width:444px;" name="cre_date" placeholder=" (Optional) 등록일자" />
                                    	<br>
                                    	<input type="text" id="inv_date" class="form-control flatpickr-range" style="background-color:white; width:444px;" name="inv_date" placeholder=" (Optional) 조사일자" />
                                    	<br>
						            </div>
						        </div>
						        <div class="col-md-12 col-12 ml-1">
									<div id="isNewFile" class="form-label-group" style="display:none">
							            <!--  
							            <input type="radio" name="radio_phenotype" onclick="radioSelect(true)" value="1" ><span> 신규 등록</span>
							            -->
							            <input type="file" id="Csvfile" style="display:none">
					                	<br>
						            </div>
						        </div>
						        <div class="col-md-12 col-12 ml-1">
									<div class="form-label-group">
							            <h6>Model</h6>
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
						        </div>
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
    <script src="../../css/app-assets/vendors/js/vendors.min.js"></script>
    <!--  
    <script src="../../css/app-assets/vendors/js/vendors_v2.min.js"></script>
    -->
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
   		$(".select2-container--default:gt(0)").width("444px");
   	});
	
   	function vcfFileList() {
   		
   		$.ajax({
   			url: "/ipet_digitalbreed/web/database/genotype_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(),
   			method: 'POST',
   			success: function(data) {
	  			//console.log("vcf file list : ", data);
	  			
	  			$("#VcfSelect").empty();
	  	    	$("#VcfSelect").append(`<option disabled hidden selected>Select VCF File</option>`);
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
		console.log(flag);
		if(flag) {
			$("#isNewFile").css('display','block');
			$("#Csvfile").css('display','inline');
			$("#isPhenotype").css('display','none');
		} else {
			$("#isNewFile").css('display','none');
			$("#Csvfile").css('display','none');
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
   		
   		const permissionUid = "<%=permissionUid%>";
   		const variety_id = $( "#variety-select option:selected" ).val();
    	const jobid_vcf = $('#VcfSelect :selected').data('jobid');
    	const filename_vcf = $('#VcfSelect :selected').data('filename');
    	
    	//const traitname = $("#PhenotypeSelect :selected").data('traitname');
    	//const traitname_seq = $("#PhenotypeSelect :selected").data('traitname_key');
    	
    	
    	
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
    	//formData.append('traitname', traitname);
    	//formData.append('traitname_seq', traitname_seq);
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
    						refresh();
    			   			$("#backdrop").modal("hide");
    					}
    					
    				})
    			} else {
    				//$("#backdrop").modal("hide");
    			}
    			
    			//refresh();
	   			//$("#backdrop").modal("hide");
    		}
    		
    	})
    	
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