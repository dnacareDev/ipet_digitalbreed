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
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/bootstrap5_custom.css">
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

	.irx-file-inner-wrapper {
	height: 30px !important;
	}
	
	.innorix_basic div.irx_filetree, .irx_container {
		border : none !important;
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

/*
	#RestrictionEnzymeGrid {
		--ag-cell-horizontal-padding: 5px !important;
		--ag-widget-horizontal-spacing: 5px !important;
		--ag-widget-vertical-spacing: 0px !important;
	}	
*/
</style>

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">


    <jsp:include page="../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="pd"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;Primer design</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../index.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">Primer design
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
	                                                	try {
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
	                                                	} catch(Exception e){
	                                                		System.out.println(e);
	                                                	} finally { 
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
                </section>
                <!-- // Basic example section end -->
            </div>
        </div>
    </div>
    
    
	<!-- Modal start-->
    <div class="modal fade text-left" id="backdrop" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">Primer design</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadForm">
					    <div class="form-body">
					        <div class="row p-1">
				            	<div class="col-12" style="display:flex; column-gap:5%;">
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="KASP" name='modalCategory1' onclick="onClickMarkerCategory(this.id);" checked/>
                                        <label class="form-check form-check-label" for="KASP" style="padding-top:1px; padding-left:15px;"  >KASP</label>
					            	</div>
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="CAPs" name='modalCategory1'  onclick="onClickMarkerCategory(this.id);" />
                                        <label class="form-check form-check-label" for="CAPs" style="padding-top:1px; padding-left:15px;" >CAPs</label>
					            	</div>
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="INDEL" name='modalCategory1'  onclick="onClickMarkerCategory(this.id);" disabled/>
                                        <label class="form-check form-check-label" for="INDEL" style="padding-top:1px; padding-left:15px;">INDEL</label>
					            	</div>
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="HRM" name='modalCategory1'  onclick="onClickMarkerCategory(this.id);" disabled/>
                                        <label class="form-check form-check-label" for="HRM" style="padding-top:1px; padding-left:15px;">HRM</label>
					            	</div>
				            	</div>
				            </div>
				            <div class="row p-1">
				             	<div class="col-md-12 col-12">
					             	<div class="form-label-group">
					                	<input type="text" id="comment" class="form-control" placeholder="Comment" autocomplete="off" required data-validation-required-message="This name field is required">						                     
					             		<label for="first-name-column">Comment</label>
					                </div>
					            </div>
					            <div class="col-md-12 col-12">
					             	<div class="form-label-group">
					                	<input type="text" id="Marker_Name" class="form-control" placeholder="Marker Name" autocomplete="off" required data-validation-required-message="This name field is required">						                     
					             		<label for="first-name-column">Marker Name</label>
					                </div>
					            </div>
					            <div class="col-12 mb-1" style="display:flex; column-gap:5%;">
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="Genomic_DB"  name='modalCategory2' onclick="onClickMethodCategory(this.id);" checked/>
                                        <label class="form-check form-check-label" for="Genomic_DB" style="padding-top:1px; padding-left:15px;" >Genomic DB</label>
					            	</div>
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="Direct_Input"  name='modalCategory2' onclick="onClickMethodCategory(this.id);" />
                                        <label class="form-check form-check-label" for="Direct_Input" style="padding-top:1px; padding-left:15px;" >Direct input</label>
					            	</div>
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="File_Upload"  name='modalCategory2'  onclick="onClickMethodCategory(this.id);" />
                                        <label class="form-check form-check-label" for="File_Upload" style="padding-top:1px; padding-left:15px;" >File upload</label>
					            	</div>
				            	</div>
				            	<div id="VCF_Select_Div" class="col-12" style="display:block;">
				            		<div class="form-label-group">
					                    <select id="VcfSelect" class="select2 form-select" data-placeholder="Select VCF File" data-width="100%" >
					                    </select>
				                    </div>
					            </div>
					            <div id="Reference_Select_Div" class="col-12" style="display:none;">
					            	<div class="form-label-group">
						            	<select id="ReferenceSelect" class="select2 form-select" data-placeholder="Select Reference" data-width="100%" >
					                    </select>
				                    </div>
					            </div>
					            <div id="Sequence_Div" class="col-12" style="display:none;">
					            	<div class="form-label-group">
					            		<textarea id="Sequence" class="form-control" rows="3" placeholder="Sequence를 입력해주세요 &#13;&#10Ex) ATACATATGATAAA[T]CCCGGGGTATGG"></textarea>
					            	</div>
					            </div>
					            <div id="Innorix_Div" class="col-md-12 col-12" style="display:none;">
									<div style="display:flex; justify-content:space-between;">
							            <h6>Sequence</h6>
							            <button type="button" class="btn btn-info btn-sm" ><a href="/ipet_digitalbreed/uploads/pca_population.xlsx" download="pca_population.xlsx" style="color:white;" ><i class='feather icon-download'></i>예시파일받기</a> </button>
							            <!--  
							            <h6 style="margin-left:13px; font-weight:bold;">Population &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-info btn-sm" ><a href="/ipet_digitalbreed/uploads/pca_population.xlsx" download="pca_population.xlsx" style="color:white;" ><i class='feather icon-download'></i>예시파일받기</a> </button></h6>
							            -->
						            </div>
									<div id="fileControl" class="col-md-12 col-12 mt-1"  style="padding: 0; border: 1px solid #48BAE4;"></div>
						        </div>
					        </div>
					        <div class="row pb-1 pl-1 pr-1">
					        	<fieldset class="border w-100 m-1 pt-1">
						        	<legend class="w-auto ml-1 mr-1">Option</legend>
							        <div id="RestrictionEnzymeGrid_Div" class="col-12 mb-1" style="display:none;">
							        	<div id="RestrictionEnzymeGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:320px;"></div><br>
							        </div>
							        <div class="col-12 mb-1" style="display:flex;">
						            	<div class="col-4">
						            	</div>
						            	<div class="col-4" style="text-align:center;">
						            		Min
						            	</div>
						            	<div class="col-4" style="text-align:center;">
						            		Max
						            	</div>
					            	</div>
							        <div class="col-12 mb-1" style="display:flex;">
						            	<div class="col-4">
						            		Primer length
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="Length_Min" value="18" />
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="Length_Max" value="22" />
						            	</div>
					            	</div>
					            	<div class="col-12 mb-1" style="display:flex;">
						            	<div class="col-4">
						            		Primer GCcontent
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="GCcontent_Min" value="40" />
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="GCcontent_Max" value="55" />
						            	</div>
					            	</div>
					            	<div class="col-12 mb-1" style="display:flex;">
						            	<div class="col-4">
						            		Primer TM
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="TM_Min" value="55" />
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="TM_Max" value="65" />
						            	</div>
					            	</div>
				            		<div class="col-12 mb-1" style="display:flex;">
						            	<div class="col-4">
						            		Product size
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="Size_Min" value="60" />
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="Size_Max" value="100" />
						            	</div>
					            	</div>
						        </fieldset>
					        </div>
					        <div class="row p-1">
					            <div class="col-12">
					                <button type="button" class="btn btn-success mb-1" style="float: right;" onclick="fileUpload();">Run</button>
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="reset();">Reset</button>
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
			<div><strong>Loading PD Result...</strong></div>
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
    <script src="../../css/app-assets/vendors/js/innorix/innorix.js"></script>
    <script src="../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../css/app-assets/js/scripts/forms/select/form-select2.js"></script>
    <!-- 
    <script src="../../css/app-assets/js/scripts/sheetjs/xlsx.full.min.js"></script>
    -->    
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
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_pd.js"></script>
    <!--  
    <script src="../../css/app-assets/js/scripts/plotly-latest.min.js"></script>
    -->   
	<script src="../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">       
       
</script>

</body>
<!-- END: Body-->
<script type="text/javascript">
	$(document).ready(function(){ 
		vcfFileList();
		referenceGenomeList();
	});
	 

	function vcfFileList() {
		
		$.ajax(
			{
	   			//url: "/ipet_digitalbreed/web/database/genotype_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(),
	   			url: "/ipet_digitalbreed/web/vb/vb_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(),
	   			method: 'POST',
	   			success: function(data) {
	   				console.log("vcf file list : ", JSON.parse(data));
		  			
		  			makeOptions(JSON.parse(data));
	   			}
	  	});
	}
		
	function makeOptions(data) {
		$("#VcfSelect").empty();
		
		//$("#VcfSelect").append(`<option data-jobid="-1" disabled hidden selected>Select VCF File</option>`);
		$("#VcfSelect").append(`<option data-jobid="-1" data-filename="-" data-refgenome_id="-1" data-refgenome="-" data-fasta_filename="-" disabled hidden selected></option>`);
		for(let i=0 ; i<data.length ; i++) {
			$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-refgenome_id=\${data[i].refgenome_id} data-refgenome=\${data[i].refgenome} data-fasta_filename=\${data[i].fasta_filename} > \${data[i].filename} (\${data[i].comment}) </option>`);
		}
	}
	
	async function referenceGenomeList() {
		
		const url_string = '../refgenome/refgenome_json.jsp';
		const map_params = new Map();
		map_params.set("varietyid", $( "#variety-select option:selected" ).val());
		
		const data = await getFetchData(url_string, map_params);
		console.log("refgeome list : ", data);
		
		$("#ReferenceSelect").empty();
		$("#ReferenceSelect").append(`<option data-refgenome_id="-1" data-refgenome="-"></option>`);
		for(let i=0 ; i<data.length ; i++) {
			$("#ReferenceSelect").append(`<option data-refgenome_id=\${data[i].refgenome_id} data-refgenome=\${data[i].refgenome} data-fasta_filename=\${data[i].fasta_filename} > \${data[i].refgenome} (\${data[i].gff}) </option>`);
		}
	}
	
	function onClickMarkerCategory(id) {
		document.getElementById('RestrictionEnzymeGrid_Div').style.display = id=='CAPs' ? 'block' : 'none';
		
		enzyme_gridOptions.columnApi.autoSizeAllColumns();
	}
	
	function onClickMethodCategory(id) {
		console.log(id);
		vcfFileList(); 
		referenceGenomeList(); 
		box.removeAllFiles();
		
		
		document.getElementById('VCF_Select_Div').style.display = id=='Genomic_DB' ? 'block' : 'none';
		document.getElementById('Reference_Select_Div').style.display = id=='Genomic_DB' ? 'none' : 'block';
		
		document.getElementById('Sequence_Div').style.display = id=='Direct_Input' ? 'block' : 'none';
		document.getElementById('Sequence').value = id=='Direct_Input' ? document.getElementById('Sequence').value : '';
		
		document.getElementById('Innorix_Div').style.display = id=='File_Upload' ? 'block' : 'none';
		
	}
		
	$('#backdrop').on('hidden.bs.modal', function (e) {
		reset();
	});    
		
	function reset() {
		document.getElementById('uploadForm').reset();
		vcfFileList();
		referenceGenomeList();
		box.removeAllFiles();
	}
		
	var box = new Object();
	window.onload = function() {
		
		//const jobid_pca = $("#jobid_pca").val();
		//console.log("innorix jobid_pca : ", jobid_pca);
		
		// 파일전송 컨트롤 생성
	    box = innorix.create({
	    	el: '#fileControl', // 컨트롤 출력 HTML 객체 ID
	        width			: "100%",
	    	height          : 130,
	        maxFileCount   : 1,  
	        allowType : ["vcf"],
			addDuplicateFile : false,
	        agent: false, // true = Agent 설치, false = html5 모드 사용                    
	        uploadUrl: './pd_fileupload.jsp'
	        //uploadUrl: './pca_fileuploader.jsp?jobid_pca='+jobid_pca,
	    });
		
		
	
	    // 업로드 완료 이벤트
	    box.on('uploadComplete', function (p) {
			
	    	//console.log(p);
	    	//p.postData['vcf_filename'] = p.files[0]['clientFileName'];
	    	p.postData['filename'] = 'primer_test.vcf';
	    	
	    	fetch(`./pd_analysis.jsp`, {
				method: "POST",
				headers: {
					"Content-type": "application/json",
				},
				body: JSON.stringify(p.postData),
			})
	    	
			/*
	    	//시간이 조금 지나면 Rscript 작동 여부에 관계없이 새로고침
	   		setTimeout( function () {
	   			refresh();
	   			$("#backdrop").modal("hide");
	   		}, 1000);
			*/
	    });
	};
	
	async function fileUpload() {
		
		const varietyid = document.querySelector(`#variety-select option:checked`).value;

		const marker_category = document.querySelector(`input[name='modalCategory1']:checked`).id;
		const comment = document.getElementById('comment').value;
		const marker_name = document.getElementById('Marker_Name').value;
		const upload_method = document.querySelector(`input[name='modalCategory2']:checked`).id;
		const jobid_vcf = document.querySelector(`#VcfSelect option:checked`).dataset.jobid;
		const filename = document.querySelector(`#VcfSelect option:checked`).dataset.filename;
		const refgenome_id = upload_method == 'Genomic_DB' ? document.querySelector(`#VcfSelect option:checked`).dataset.refgenome_id : document.querySelector(`#ReferenceSelect option:checked`).dataset.refgenome_id;
		const refgenome = upload_method == 'Genomic_DB' ? document.querySelector(`#VcfSelect option:checked`).dataset.refgenome : document.querySelector(`#ReferenceSelect option:checked`).dataset.refgenome;
		const fasta_filename = upload_method == 'Genomic_DB' ? document.querySelector(`#VcfSelect option:checked`).dataset.fasta_filename : document.querySelector(`#ReferenceSelect option:checked`).dataset.fasta_filename;
		const sequence = document.getElementById('Sequence').value;
		const Length_Min = document.getElementById('Length_Min').value;
		const Length_Max = document.getElementById('Length_Max').value;
		const GCcontent_Min = document.getElementById('GCcontent_Min').value;
		const GCcontent_Max = document.getElementById('GCcontent_Max').value;
		const TM_Min = document.getElementById('TM_Min').value;
		const TM_Max = document.getElementById('TM_Max').value;
		const Size_Min = document.getElementById('Size_Min').value;
		const Size_Max = document.getElementById('Size_Max').value;
		const jobid_pd = await fetch("../getJobid.jsp")
							.then((response) => response.text())
		
		const data = {
			'varietyid': varietyid,
			'marker_category': marker_category,
			'comment': comment,
			'marker_name': marker_name,
			'upload_method': upload_method,
			'jobid_vcf': jobid_vcf,
			'filename': filename,
			'refgenome_id': refgenome_id,
			'refgenome': refgenome,
			'fasta_filename': fasta_filename,
			'sequence': sequence,
			'Length_Min': Length_Min,
			'Length_Max': Length_Max,
			'GCcontent_Min': GCcontent_Min,
			'GCcontent_Max': GCcontent_Max,
			'TM_Min': TM_Min,
			'TM_Max': TM_Max,
			'Size_Min': Size_Min,
			'Size_Max': Size_Max,
			'jobid_pd': jobid_pd,
		};
		
		// Genomic DB : 선택한 vcf의 reference를 사용
		/*
		if(upload_method == 'Genomic_DB') {
			data['refgenome_id'] = document.querySelector(`#VcfSelect option:checked`).dataset.refgenome_id;
			data['refgenome'] = document.querySelector(`#VcfSelect option:checked`).dataset.refgenome;
			data['fasta_filename'] = document.querySelector(`#VcfSelect option:checked`).dataset.fasta_filename;
		}
		*/
		
		fetch(`./pd_insertSql.jsp`, {
			method: "POST",
			headers: {
				"Content-type": "application/json",
			},
			/*
			body: JSON.stringify({
				'varietyid': varietyid,
				'vcf_filename': vcf_filename,
				'comment': comment,
				'marker_category': marker_category,
				'jobid_pd': jobid_pd,
			}),
			*/
			body: JSON.stringify(data),
		})
		
		if(upload_method == 'File_Upload') {
			
			box.setPostData(data);
			box.upload();
		} else {
			
			fetch(`./pd_analysis.jsp`, {
				method: "POST",
				headers: {
					"Content-type": "application/json",
				},
				body: JSON.stringify(data),
			})
			
			/*
			setTimeout( function () {
	   			refresh();
	   			$("#backdrop").modal("hide");
	   			}
	   		, 1000);
			*/
		}
		
					
		
		
		/*					
		console.log("jobid_pca : ", jobid_pca);
		//$("#jobid_pca").val(jobid_pca);
		const filename = $('#VcfSelect').find(':selected').data('filename');
		// jobid_vcf: 선택한 vcf파일(=select VCF Files 목록)의 고유한 id 
		// jobid_pca: pca신규분석으로 생성된 데이터(=grid 각각의 row)가 가진 고유한 id (pca_fileuploader.jsp의 get parameter로 직접 붙어있음)
		
		
		if(Number(jobid_vcf) == -1) {
			alert("VCF 파일을 선택하세요");
			return;
		}
		*/
		
	}
	
	/*
	$("#backdrop").on("shown.bs.modal", function(e) {
		enzyme_gridOptions.columnApi.autoSizeAllColumns();
	});
	*/
	
	async function getFetchData(url_string, map_params) {
		
		const baseURL = window.location.href;
		const url = new URL(url_string, baseURL);
		
		if(map_params.size !== 0) {
			for(const [key, value] of map_params) {
				url.searchParams.set(key, value);
			}
		}
		
		return await fetch(url).then((response)=> response.json()).catch((error) => console.log("non-json response fetch"));
	}
	
</script>
</html>