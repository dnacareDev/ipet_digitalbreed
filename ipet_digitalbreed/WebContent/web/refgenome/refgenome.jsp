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
	
	<!--  
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/jquery-ui/jquery-ui.min.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/jquery-ui/jquery-ui.structure.min.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/jquery-ui/jquery-ui.theme.min.css">
    -->
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

.select2-container--default .select2-results__option[aria-disabled=true] {
    display: none;
}

.irx-file-inner-wrapper {
	height: 30px !important;
}

.innorix_basic div.irx_filetree, .irx_container {
	border : none !important;
}

.custom-file-input:lang(en) .custom-file-label::after {
    content: '파일 첨부' !important;
}

</style>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";
	//System.out.println(cropvari_sql);
	//System.out.println("UID : " + permissionUid);
	
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">
    <jsp:include page="../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="refDB"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;Reference Database</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../../mainboard.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">Reference Database
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
                                                <select class="select2-bg form-control" id="variety-select-grid" onchange="javascript:refresh();" data-bgcolor="success" data-bgcolor-variation="lighten-3" data-text-color="white">                                                   
                                                    <%
	                                                	try{
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
	                                                	}
                                                    %>       
                                                     </select>                                          
                                            </div>
                                            <div class="ag-btns d-flex flex-wrap">                                            
                                                <input type="text" class="ag-grid-filter form-control w-50 mr-1 mb-1 mb-sm-0 " id="filter-text-box" placeholder="Search...." />
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                  
                            </div>
                            <div id="myGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:320px;"></div><br>
							<button class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal" data-target="#backdrop" data-backdrop="false"><i class="feather icon-upload"></i> Upload</button>
                            <button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>
                        </div>
                    </div>
                    <div id="vcf_status" class="card"></div>
                </section>
                <!-- Basic example section end -->
            </div>
        </div>
    </div>
    
	<!-- Modal start-->
    <div class="modal fade text-left" id="backdrop" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">Reference Upload</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadForm" enctype="multipart/form-data" method="post">
					    <div class="form-body">
					        <div class="row">
					        	<fieldset class="border w-100 m-1">
						        	<legend  class="w-auto ml-1">Reference Info</legend>
					             	<div class="form-label-group col-12">
					             		<div class="row">
						             		<div class="col-4" style="margin-top:10px; padding-left: 25px;">
												작목
											</div>
											<div class="col-8">
							                	<select class=" form-control select2"  id="variety-select" name="variety_id" onchange="javascript:refresh();">                                                   
                                                    <%
	                                                	try{
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
										</div>
										<div class="row mt-1">
											<div class="col-4" style="margin-top:10px; padding-left: 25px;">
												참조유전체
											</div>
											<div class="col-8">
							                	<input type="text" id="refgenomeParam" class="form-control" name="refgenomeParam" autocomplete="off" required data-validation-required-message="This name field is required">						                     
											</div>
										</div>
										<div class="row mt-1">
											<div class="col-4" style="margin-top:10px; padding-left: 25px;">
												GFF
											</div>
											<div class="col-8">
							                	<input type="text" id="gffParam" class="form-control" name="gffParam" autocomplete="off" required data-validation-required-message="This name field is required">						                     
											</div>
										</div>
										<div class="row mt-1">
											<div class="col-4" style="margin-top:10px; padding-left: 25px;">
												출처
											</div>
											<div class="col-8">
							                	<input type="text" id="authorParam" class="form-control" name="authorParam" autocomplete="off" required data-validation-required-message="This name field is required">						                     
											</div>
										</div>
					                </div>
						        </fieldset>
						        <fieldset class="border w-100 m-1">
						        	<legend class="w-auto ml-1">Data Upload</legend>
									
									<div class="form-label-group input-group col-12">
										<div class="col-4" style="margin-top:5px;">
											Reference
										</div>
										<div class="custom-file col-7">
										    <input type="file" class="custom-file-input" id="fasta" name="fasta">
										    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
										</div>
										<div class="col-1 btn-sm btn-light" style="width:80%; margin-left:5px; padding-left:5px; float:right; ">
											<a href="/ipet_digitalbreed/uploads/reference_database/EXAMPLE/EXP.fasta" download><div class="feather icon-download" style="font-size:20px; margin-left: 3px;"></div></a> 
										</div>
						            </div>
						            <div class="form-label-group input-group col-12">
										<div class="col-4" style="margin-top:5px;">
											GFF
										</div>
										<div class="custom-file col-8">
										    <input type="file" class="custom-file-input" id="gff" name="gff">
										    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
										</div>
										<div class="col-1 btn-sm btn-light" style="width:80%; margin-left:5px; padding-left:5px; float:right; ">
											<a href="/ipet_digitalbreed/uploads/reference_database/EXAMPLE/EXP.gff" download><div class="feather icon-download" style="font-size:20px; margin-left: 3px;"></div></a>
										</div>
						            </div>
						            <div class="form-label-group input-group col-12">
										<div class="col-4" style="margin-top:5px;">
											Gene sequence
										</div>
										<div class="custom-file col-8">
										    <input type="file" class="custom-file-input" id="gene" name="gene">
										    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
										</div>
										<div class="col-1 btn-sm btn-light" style="width:80%; margin-left:5px; padding-left:5px; float:right; ">
											<a href="/ipet_digitalbreed/uploads/reference_database/EXAMPLE/EXP.gene.fasta" download><div class="feather icon-download" style="font-size:20px; margin-left: 3px;"></div></a>
										</div>
						            </div>
						            <div class="form-label-group input-group col-12">
										<div class="col-4" style="margin-top:5px;">
											CDS sequence
										</div>
										<div class="custom-file col-8">
										    <input type="file" class="custom-file-input" id="cds" name="cds">
										    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
										</div>
										<div class="col-1 btn-sm btn-light" style="width:80%; margin-left:5px; padding-left:5px; float:right; ">
											<a href="/ipet_digitalbreed/uploads/reference_database/EXAMPLE/EXP.cds.fasta" download><div class="feather icon-download" style="font-size:20px; margin-left: 3px;"></div></a>
										</div>
						            </div>
						            <div class="form-label-group input-group col-12">
										<div class="col-4" style="margin-top:5px;">
											Protein sequence
										</div>
										<div class="custom-file col-8">
										    <input type="file" class="custom-file-input" id="protein" name="protein">
										    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
										</div>
										<div class="col-1 btn-sm btn-light" style="width:80%; margin-left:5px; padding-left:5px; float:right; ">
											<a href="/ipet_digitalbreed/uploads/reference_database/EXAMPLE/EXP.pep.fasta" download><div class="feather icon-download" style="font-size:20px; margin-left: 3px;"></div></a>
										</div>
						            </div>
						            <div class="form-label-group input-group col-12">
										<div class="col-4" style="margin-top:5px;">
											Annotaion
										</div>
										<div class="custom-file col-8">
										    <input type="file" class="custom-file-input" id="annotation" name="annotation">
										    <label class="custom-file-label" for="inputGroupFile01">Choose file</label>
										</div>
										<div class="col-1 btn-sm btn-light" style="width:80%; margin-left:5px; padding-left:5px; float:right; ">
											<a href="/ipet_digitalbreed/uploads/reference_database/EXAMPLE/EXP.annotation.txt" download><div class="feather icon-download" style="font-size:20px; margin-left: 3px;"></div></a>
										</div>
						            </div>
						        </fieldset>
					            <div class="col-12">
					                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="FileUpload();">Upload</button>
					                <!--  
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="resetPCA();">Reset</button>
					                -->
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
			<div><strong>Loading PCA Result...</strong></div>
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
    <script src="../../css/app-assets/js/scripts/forms/select/form-select2_B_toolbox.js"></script>
    <!--  
    <script src="../../css/app-assets/vendors/js/jquery-ui/jquery-ui.min.js"></script>
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
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_refgenome.js"></script>
	<script src="../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">

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
			// ${data}}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
			$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} > \${data[i].filename} (\${data[i].comment}) </option>`);
		}
    }
   	
   	$('#backdrop').on('hidden.bs.modal', function (e) {
   		resetForm();
    });    
   	
    function resetForm() {
    	document.getElementById('uploadForm').reset();
    	document.getElementById('variety-select').selectedIndex = 0;
    	document.getElementById('variety-select').dispatchEvent(new Event("change"));
    	document.querySelectorAll('label.custom-file-label').forEach( (node) => {
    		node.innerText='Choose file';
    	})
    }
   	
    function FileUpload() {
    	
    	//const variety_id = $("#variety-select :selected").val();
    	const crop_name = $("#variety-select :selected").text();
    	//debugger;
    	
    	const refgenomeParam = document.getElementById('refgenomeParam').value;
    	const gffParam = document.getElementById('gffParam').value;
    	
    	let flagDuplicated = false;
    	gridOptions.api.forEachNode((rowNode, index) => {
    		//console.log(rowNode.rowIndex);
    		console.log(rowNode.data.reference);
    		if(refgenomeParam == rowNode.data.reference && gffParam == rowNode.data.gff ) {
    			flagDuplicated = true;
    			return;		// forEachNode break;
    		}
    	})
    	
    	if(flagDuplicated) {
    		alert("해당 참조유전체가 이미 등록된 상태입니다.");
    		return;
    	}
    	
    	const form = document.getElementById('uploadForm');
    	/*
    	const objs = document.createElement('input'); // 값이 들어있는 녀석의 형식
		objs.setAttribute('type', 'hidden'); // 값이 들어있는 녀석의 type
		objs.setAttribute('name', 'variety_id'); // 객체이름
		objs.setAttribute('value', variety_id); //객체값
		form.appendChild(objs);
    	*/
    	const formData = new FormData(form);
    	formData.append('cropParam', crop_name);
    	
    	
    	for(let key of formData.keys()) {				// key목록을 읽은다음 그에 해당하는 get(key)=value 값을 함께 나열
    		console.log(key, ":", formData.get(key));
    	}
    	
    	
    	console.log("not returned");
    	
    	//debugger;
    	
    	fetch('./refgenome_fileUpload.jsp', {
    		method:'POST',
    		body: formData,
    	})
    	.then((response) => response.ok)
    	.then((ok) => {
    		console.log(ok);
    		
    		//if(ok != 0)	return;
    		
    		refresh();
    		$("#backdrop").modal("hide");
    	});
    	
    	/*
    	$.ajax({
    		url: "./refgenome_fileUpload.jsp",
    		type: "POST",
    		data: formData,
    		//data: queryString,
    		enctype:"multipart/form-data",
    		processData: false,
    		contentType: false,
    		cache: false,
    		success: function(result) {
    			console.log("success");
    		}
    	})
    	*/
    	
    	
    	
    }
    


       
</script>

</body>
<!-- END: Body-->

</html>