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
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/bootstrap5_custom.css">
    <link rel="stylesheet" type="text/css" href="../../css/index_assets/css/icons.min.css">
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

    <jsp:include page="../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param value="gs" name="menu_active"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;Genomic Selection</h2>
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
                            <div id="myGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:435px;"></div><br>
							<button class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal" data-target="#backdrop" data-backdrop="false"><i class="feather icon-upload"></i> New Analysis</button>
                            <button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>
                        </div>
                    </div>
                    <div id="Extra_Card" class="card" style="display:none;">
                    	<div class='card-content'>
							<div class='card-body'>
								<div class='row'>
									<div class='col-12'>
										<ul id='button_list' class='nav nav-pills nav-active-bordered-pill'>
											<li class='nav-item'><a class='nav-link active' id='Cross_Validation' data-toggle='pill' href='#pill1' aria-expanded='true'>Cross Validation</a></li>
											<li class='nav-item'><a class='nav-link' id='Prediction' data-toggle='pill' href='#pill2' aria-expanded='true'>Prediction</a></li>
											<li class='nav-item'><a class='nav-link' id='Multiple_Prediction' data-toggle='pill' href='#pill3' aria-expanded='true' onclick="resizeMultiplePredictionGrid();">Multiple Prediction</a></li>
										</ul>
										<div id='content-list' class='tab-content'>
											<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
												<div class="row">
													<div class="col-2" style="max-width:12%;">
														<select id='Select-Cross_Validation' class='select2 form-select float-left' data-placeholder="Select Phenotype" onchange="showCVPlot(this[this.selectedIndex].dataset.phenotype);">
														</select>
													</div>
												</div>
												<div class="row">
													<div class="col-12 col-xl-12 style="height:445px; margin-top:25px; float:left;">
														<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='iframe-Cross_Validation' onload="$('#Loading').modal('hide')"></iframe>
													</div>
												</div>
											</div>
											<div class='tab-pane' id='pill2' aria-expanded='true' aria-labelledby='base-pill1'>
												<div class="row">
													<div class="col-2" style="max-width:12%;">
														<select id='Select-Prediction' class='select2 form-select float-left' data-placeholder="Select Phenotype" onchange="showPredictionPlot(this[this.selectedIndex].dataset.phenotype, this[this.selectedIndex].dataset.order);">
														</select>
													</div>
												</div>
												<div class="row">
													<div class="col-12 col-xl-4" style="margin-top:25px; float:left;">
														<div id="Grid-Prediction" class="ag-theme-alpine" style="display:none; margin: 0px auto; width: 98%; height:500px;"></div><br>
													</div>
													<div class="col-12 col-xl-8" style="height:445px; margin-top:25px; float:left;">
														<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='iframe-Prediction' onload="$('#Loading').modal('hide')"></iframe>
													</div>
												</div>
											</div>
											<div class='tab-pane' id='pill3' aria-expanded='true' aria-labelledby='base-pill1'>
												<!--  
												<div class="row">
													<div class="col-2" style="max-width:12%;">
														<select id='Select-Multiple_Prediction' class='select2 form-select float-left' data-placeholder="Select Phenotype" onchange="showMultiPlot();">
														</select>
													</div>
												</div>
												-->
												<div class="row">
													<div class="col-12 col-xl-8" style="height:445px; margin-top:25px; float:left;">
														<div id="Grid-Multiple_Prediction" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:430px;"></div><br>
													</div>
													<div class="col-12 col-xl-4 p-1" style="height:430px; margin-top:25px; float:left; border:2px dashed #b8c2cc; border-radius:1px;">
														<div class="col-12 d-flex justify-content-start h5" style="color: #7a7a7a; font-weight: 600;">Spyder-Plot</div>
														<iframe src = '' height='380px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='iframe-Multiple_Prediction' onload="checkJsonValid();"></iframe>
													</div>
												</div>
											</div>
										</div>
									</div>
								</div>
								<div class='hidden-parameter'>
									<!-- parameters -->
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
                    <h4 class="modal-title" id="myModalLabel5">Genomic Selection New Analysis</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadForm">
					    <div class="form-body">
					        <div class="row">
					            <div class="col-md-12 col-12">
					             	<div class="form-label-group d-flex justify-content-center">
					                	<input type="text" id="comment" class="form-control" placeholder="Comment" name="comment" style="width:93%;" autocomplete="off" required data-validation-required-message="This name field is required">						                     
					                </div>
					            </div>
					            <div class="col-md-12 col-12">
					            	<div class="form-label-group d-flex justify-content-center" >
					                    <select class="select2 form-select" id="Training_VCF" data-width="93%" data-placeholder="Select Training VCF File">
					                    </select>
					                </div>
					            </div>
					            <fieldset class="border w-100 mt-1 ml-1 mr-1 pt-1 pl-1 pr-1">
					            	<legend  class="w-auto">Phenotype Selection</legend>
						            <div class="col-12" style="display:flex;">
						            	<div class="col-6">
						            		<input class="form-check-input" type="radio" name="radio_phenotype" id="RadioPhenotype" onclick="radioSelect(false)" value="0" checked>
											<label class="form-check-label" for="RadioPhenotype" style="padding-left: 14px;"> Phenotype Database</label>
						            	</div>
						            	<div class="col-6">
						            		<input class="form-check-input" type="radio" name="radio_phenotype" id="RadioCsvFile" onclick="radioSelect(true)" value="1">
											<label class="form-check-label" for="RadioCsvFile" style="padding-left: 14px;"> New Phenotype</label>
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
										<div id="isNewFile" class="form-label-group mt-1" style="display:none">
								            <div id="PhenotypeCsvFile" class="col-md-12 col-12"  style="padding: 0; border: 1px solid #48BAE4;"></div>
							            </div>
							        </div>
							        
						        </fieldset>
						        <div class="col-12 mt-3 mb-1 d-flex justify-content-center">
				                    <select class="select2 form-select" id="Prediction_VCF" data-width="93%" data-placeholder="(Optional) Select Prediction VCF File">
				                    </select>
					            </div>
						        <fieldset class="border w-100 m-1">
						        	<legend  class="w-auto ml-1">Model</legend>
									<div class="col-12" style="display:flex;">
						            	<div class="col-3 form-check">
						            		<input class="form-check-input" type="checkbox" id="BLUP" onclick="switchCheckbox(this.id)" checked>
											<label class="form-check-label" for="BLUP" style="padding-left: 14px;"> BLUP</label>
						            	</div>
						            	<div class="col-4 form-check">
						            		<input class="form-check-input" type="checkbox" id="Bayesian" onclick="switchCheckbox(this.id)">
											<label class="form-check-label" for="Bayesian" style="padding-left: 14px;"> Bayesian</label>
						            	</div>
						            	<div class="col-7 form-check">
						            		<input class="form-check-input" type="checkbox" id="Semi-parametic" onclick="switchCheckbox(this.id)">
											<label class="form-check-label" for="Semi-parametic" style="padding-left: 14px;"> Semi-parametic</label>
						            	</div>
					            	</div>
					            	<div class="col-12 mt-1">
					            		<div id="Model_Grid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:190px;"></div>
					            	</div>
                                </fieldset>
                                <fieldset class="border w-100 m-1 pt-1">
						        <legend class="w-auto ml-1 mr-1">Options</legend>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
						            		<div class="col-4" style="margin-top:8px;">MAXNA</div>
						            		<div class="col-5" style="margin-top:8px;">
						            			<div class="row">
						            				<div class="col-1 min-range-max" onclick="document.getElementById('MAXNA_Range').value = 0; document.getElementById('MAXNA_Number').value = 0;">0</div>
							            			<div class="col-8" style="margin-right:-5px; padding-left:3px; padding-right:0px;">
								            			<input type="range" class="form-range" id="MAXNA_Range" min="0" max="1" value="1" step="0.01" oninput="document.getElementById('MAXNA_Number').value = this.value" />
							            			</div>
						            				<div class="col-1 min-range-max" onclick="document.getElementById('MAXNA_Range').value = 1; document.getElementById('MAXNA_Number').value = 1">1</div>
						            			</div>
						            		</div>
						            		<div class="col-3">
						            			<input type="text" class="form-control" id="MAXNA_Number" autocomplete="off" value="1" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value>1)this.value=1; document.getElementById('MAXNA_Range').value = this.value;" />
						            		</div>
						            	</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
						            		<div class="col-4" style="margin-top:8px;">MAF</div>
						            		<div class="col-5" style="margin-top:8px;">
						            			<div class="row">
						            				<div class="col-1 min-range-max" onclick="document.getElementById('MAF_Range').value = 0; document.getElementById('MAF_Number').value = 0;">0</div>
							            			<div class="col-8" style="margin-right:-5px; padding-left:3px; padding-right:0px;">
								            			<input type="range" class="form-range" id="MAF_Range" min="0" max="0.5" value="0.01" step="0.01" oninput="document.getElementById('MAF_Number').value = this.value" />
							            			</div>
						            				<div class="col-1 min-range-max" onclick="document.getElementById('MAF_Range').value = 0.5; document.getElementById('MAF_Number').value = 0.5">0.5</div>
						            			</div>
						            		</div>
						            		<div class="col-3">
						            			<input type="text" class="form-control" id="MAF_Number" autocomplete="off" value="0.01" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value>0.5)this.value=0.5; document.getElementById('MAF_Range').value = this.value;" />
						            		</div>
						            	</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
						            		<div class="col-4 form-check" style="margin-top:8px;">
						            			Geno.reduct
						            		</div>
						            	</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
						            		<div class="col-4 form-check" style="margin-top:8px;">
						            			<input type="checkbox" class="form-check-input" id="Checkbox-LD" 
						            				onclick="document.getElementById('LD_Range').disabled = !this.checked; 
						            						document.getElementById('LD_Number').disabled = !this.checked; 
						            						if(!this.checked){document.getElementById('LD_Range').value = 0.99; document.getElementById('LD_Number').value = 0.99;}"
						            			/>
						            			<label class="form-check-label" for="Checkbox-LD" style="padding-left: 14px;"> LD (R²)</label>
						            		</div>
						            		<div class="col-5" style="margin-top:8px;">
						            			<div class="row">
						            				<div class="col-1 min-range-max" onclick="if(document.getElementById('Checkbox-LD').checked) {document.getElementById('LD_Range').value = 0; document.getElementById('LD_Number').value = 0;}">0</div>
							            			<div class="col-8" style="margin-right:-5px; padding-left:3px; padding-right:0px;">
								            			<input type="range" class="form-range" id="LD_Range" min="0" max="1" value="0.99" step="0.01" oninput="document.getElementById('LD_Number').value = this.value" disabled/>
							            			</div>
						            				<div class="col-1 min-range-max" onclick="if(document.getElementById('Checkbox-LD').checked) {document.getElementById('LD_Range').value = 1; document.getElementById('LD_Number').value = 1;}">1</div>
						            			</div>
						            		</div>
						            		<div class="col-3">
						            			<input type="text" class="form-control" id="LD_Number" autocomplete="off" value="0.99" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value>1)this.value=1; document.getElementById('LD_Range').value = this.value;" disabled/>
						            		</div>
						            	</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
						            		<div class="col-4 form-check" style="margin-top:8px;">
						            			<input type="checkbox" class="form-check-input" id="Checkbox-ANO" 
						            				onclick="document.getElementById('ANO_Range').disabled = !this.checked; 
						            						document.getElementById('ANO_Number').disabled = !this.checked; 
						            						if(!this.checked){document.getElementById('ANO_Range').value = 0.1; document.getElementById('ANO_Number').value = 0.1;}"
						            			/>
						            			<label class="form-check-label" for="Checkbox-ANO" style="padding-left: 14px;"> ANO (pval)</label>
						            		</div>
						            		<div class="col-5" style="margin-top:8px;">
						            			<div class="row">
						            				<div class="col-1 min-range-max" onclick="if(document.getElementById('Checkbox-ANO').checked) {document.getElementById('ANO_Range').value = 0; document.getElementById('ANO_Number').value = 0;}">0</div>
							            			<div class="col-8" style="margin-right:-5px; padding-left:3px; padding-right:0px;">
								            			<input type="range" class="form-range" id="ANO_Range" min="0" max="0.5" value="0.1" step="0.01" oninput="document.getElementById('ANO_Number').value = this.value" disabled/>
							            			</div>
						            				<div class="col-1 min-range-max" onclick="if(document.getElementById('Checkbox-ANO').checked) {document.getElementById('ANO_Range').value = 0.5; document.getElementById('ANO_Number').value = 0.5;}">0.5</div>
						            			</div>
						            		</div>
						            		<div class="col-3">
						            			<input type="text" class="form-control" id="ANO_Number" autocomplete="off" value="0.1" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value>0.5)this.value=0.5; document.getElementById('ANO_Range').value = this.value;" disabled/>
						            		</div>
						            	</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
						            		<div class="col-4" style="margin-top:8px;">nFolds <i class="ri-question-line"data-toggle="popover" data-trigger="hover" data-placement="top" data-content="nFolds Popover"></i></div>
						            		<div class="col-5" style="margin-top:8px;">
						            			<div class="row">
						            				<div class="col-1 min-range-max" onclick="document.getElementById('N-Folds_Range').value = 2; document.getElementById('N-Folds_Number').value = 2;">2</div>
							            			<div class="col-8" style="margin-right:-5px; padding-left:3px; padding-right:0px;">
								            			<input type="range" class="form-range" id="N-Folds_Range" min="2" max="9" value="3" step="1" oninput="document.getElementById('N-Folds_Number').value = this.value" />
							            			</div>
						            				<div class="col-1 min-range-max" onclick="document.getElementById('N-Folds_Range').value = 9; document.getElementById('N-Folds_Number').value = 9">9</div>
						            			</div>
						            		</div>
						            		<div class="col-3">
						            			<input type="text" class="form-control" id="N-Folds_Number" autocomplete="off" value="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value>9)this.value=9; document.getElementById('N-Folds_Range').value = this.value;" />
						            		</div>
						            	</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
						            		<div class="col-4" style="margin-top:8px;">nTimes <i class="ri-question-line" data-toggle="popover" data-trigger="hover" data-placement="top" data-content="nTimes Popover"></i></div>
						            		<div class="col-5" style="margin-top:8px;">
						            			<div class="row">
						            				<div class="col-1 min-range-max" onclick="document.getElementById('N-Times_Range').value = 1; document.getElementById('N-Times_Number').value = 1;">1</div>
							            			<div class="col-8" style="margin-right:-5px; padding-left:3px; padding-right:0px;">
								            			<input type="range" class="form-range" id="N-Times_Range" min="1" max="9" value="3" step="1" oninput="document.getElementById('N-Times_Number').value = this.value" />
							            			</div>
						            				<div class="col-1 min-range-max" onclick="document.getElementById('N-Times_Range').value = 9; document.getElementById('N-Times_Number').value = 9;">9</div>
						            			</div>
						            		</div>
						            		<div class="col-3">
						            			<input type="text" class="form-control" id="N-Times_Number" autocomplete="off" value="3" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1'); if(this.value>9)this.value=9; document.getElementById('N-Times_Range').value = this.value;" />
						            		</div>
						            	</div>
						            </div>
						        </fieldset>
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
    
    
   	<div class="modal" id="Loading" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
		<div class="modal-dialog modal-dialog-centered modal-xs" role="document">
   			<center><img src='/ipet_digitalbreed/images/loading.gif'/><center>
			<div><strong>Loading GS Result...</strong></div>
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
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_gs.js"></script>
    <!--  
    <script src="../../css/app-assets/js/scripts/plotly-latest.min.js"></script>
    -->
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
   		phenotypeList();
   		
   		jQuery("#Training_VCF").select2();
   		jQuery("#Prediction_VCF").select2({
   			allowClear: true,
   		});
   		
   	});
	
	var box = new Object();
    window.onload = function() {
    	
    	// 파일전송 컨트롤 생성
	    box = innorix.create({
	    	el: '#PhenotypeCsvFile', // 컨트롤 출력 HTML 객체 ID
	        width			: 445,
	    	height          : 130,
	        maxFileCount   : 1,  
	        allowType : ["csv"],
	        charset : "utf-8",
			addDuplicateFile : false,
	        agent: false, // true = Agent 설치, false = html5 모드 사용                    
	        uploadUrl: '/ipet_digitalbreed/web/gwas_gs/gs_uploader.jsp',
	        
	    });
    	
    	

	    // 업로드 완료 이벤트
	    box.on('uploadComplete', function (p) {
	    	//box.removeAllFiles();
	    	const data = p.postData;
	    	//data['traitname_keys'] = '2,3';
	    	
	    	
	    	fetch(`./gs_samplecheck.jsp?jobid_gs=\${p.postData.jobid_gs}`)
	    	.then((response) => response.text())
	    	.then((text) => {
	    		//console.log(text);
	    		if(confirm(text+" 진행하시겠습니까?")) {
	    			
	    			fetch("./gs_insertSql.jsp", {
	       	    		method: "POST",
	       	    		headers: {
	       	    			"Content-Type": "application/json; charset='UTF-8';"
	       	    		},
	       	    		body:JSON.stringify(data),
	       	    	});
	    			
	    			fetch("./gs_analysis.jsp", {
	       	    		method: "POST",
	       	    		headers: {
	       	    			"Content-Type": "application/json"
	       	    		},
	       	    		body:JSON.stringify(data),
	       	    	});
	    			
	    			setTimeout( function () {
	    	   			refresh();
	    	   			$("#backdrop").modal("hide");
	    	   		}, 1000);
	    		}
	    	})
   	    	
        });
	    
	    //console.log("box? : ", box);
    };
	
    function showCVPlot(phenotype) {
		//console.log(phenotype);
		const jobid = document.getElementById('Extra_Card').dataset.jobid;
		const resultpath = document.getElementById('Extra_Card').dataset.resultpath;
		
		const url = `\${resultpath+jobid}/Cross-validation_box_\${phenotype}.html`;
		
		fetch(url, {method: "HEAD"})
		.then((response) => {
			if(!response.ok) {
				//HTMLNotExist("Multi");
				//$("#Multi").height(0);
				console.log("file not exist");
			} else {
				//$("#Multi").height("500px");
				$("#Loading").modal('show');
				$('iframe#iframe-Cross_Validation').attr('src', url);
			}
		})
	}
    
    function showPredictionPlot(phenotype, order) {
    	
    	$("#Loading").modal('show');
    	
    	const jobid = document.getElementById('Extra_Card').dataset.jobid;
		const resultpath = document.getElementById('Extra_Card').dataset.resultpath;
		
		document.getElementById('Grid-Prediction').style.display = 'block';
		
		const columnDefs_prediction = [
			{
				headerName: '순번',
				field: 'no',
				//checkboxSelection: true, 
				//headerCheckboxSelectionFilteredOnly: true,
				//headerCheckboxSelection: true,
				minWidth: 80,
				maxWidth: 80,
				valueGetter: inverseRowCount,
				
			},
			{
				headerName: '개체명',
				field: 'Taxa',
			},
			/*
			{
				field: phenotype,
				filter: 'agNumberColumnFilter',
			}
			*/
		];
		
		//Grid-Prediction
		fetch(`\${resultpath+jobid}/predicted.result.csv`)
		.then((response) => {
			if(!response.ok) {
				//HTMLNotExist("Multi");
				//$("#Multi").height(0);
				throw new Error('Error - ' +response.status);
			} else {
				return response.blob();
			}
		})
		.then((file) => {
			var reader = new FileReader();
		    reader.onload = function(){
		    	
		    	var fileData = reader.result;
		        var wb = XLSX.read(fileData, {type : 'binary', encoding:'UTF-8'});
		        var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
		        //console.log("rowObj : ", rowObj);
		        
		        let i=0;
		        for(const key in rowObj[0]) {
		        	if(i == Number(order) + 1) {
			        	columnDefs_prediction.push({headerName:phenotype, field: key, filter: 'agNumberColumnFilter',})
		        	}
		        	i++;
		        }
		        
		        
				gridOptions_prediction.api.setColumnDefs(columnDefs_prediction);
		        gridOptions_prediction.api.setRowData(rowObj);
		        gridOptions_prediction.api.sizeColumnsToFit();
		        //gridOptions_prediction.columnApi.autoSizeAllColumns();
		    };
		    reader.readAsBinaryString(file);
		});
		
		
		const url = `\${resultpath+jobid}/Predict_GEBV_bar_\${phenotype}.html`;
		
		fetch(url, {method: "HEAD"})
		.then((response) => {
			if(!response.ok) {
				//HTMLNotExist("Multi");
				//$("#Multi").height(0);
				$("#Loading").modal('hide');
				throw new Error('Error - ' +response.status);
			} else {
				//$("#Multi").height("500px");
				$('iframe#iframe-Prediction').attr('src', url);
				$("#Loading").modal('hide');
			}
		})
    }
	
    function showMultiPredictionPlot(phenotype_arr) {
    	
    	const jobid = document.getElementById('Extra_Card').dataset.jobid;
		const resultpath = document.getElementById('Extra_Card').dataset.resultpath;
		
		//const url = `\${resultpath+jobid}/spyder.html`;
		
		
		const columnDefs_prediction = [
			{
				headerName: '순번',
				field: 'no',
				checkboxSelection: true, 
				headerCheckboxSelectionFilteredOnly: true,
				headerCheckboxSelection: false,
				minWidth: 120,
				maxWidth: 120,
				valueGetter: inverseRowCount,
				
			},
			{
				headerName: '개체명',
				field: 'Taxa',
			},
		];
		
		
		
		
		fetch(`\${resultpath+jobid}/predicted.result.csv`)
		.then((response) => {
			if(!response.ok) {
				throw new Error('Error - ' +response.status);
			} else {
				return response.blob();
			}
		})
		.then((file) => {
			var reader = new FileReader();
		    reader.onload = function(){
		    	
		    	var fileData = reader.result;
		        var wb = XLSX.read(fileData, {type : 'binary'});
		        var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
		        //console.log("rowObj : ", rowObj);
				
		        const phenotype_fields = new Array();
		        for(key in rowObj[0]) {
		        	if(key == "Taxa") {
		        		continue;
		        	}
		        	phenotype_fields.push(key);
		        }
		        
		        for(let i=0 ; i<phenotype_arr.length ; i++) {
					//columnDefs_prediction.push({field: phenotype_arr[i], filter:'agNumberColumnFilter', })
					columnDefs_prediction.push({headerName: phenotype_arr[i], field: phenotype_fields[i], filter:'agNumberColumnFilter', })
				}
		        
		        
		        
		        gridOptions_multiplePrediction.api.setColumnDefs(columnDefs_prediction);
		        gridOptions_multiplePrediction.api.setRowData(rowObj);
		        //gridOptions_prediction.columnApi.autoSizeAllColumns();
		    };
		    reader.readAsBinaryString(file);
		});
    }
    
    async function resizeMultiplePredictionGrid() {
    	
    	await sleep(100);
    	
   		gridOptions_multiplePrediction.columnApi.autoSizeAllColumns();
       	
       	const grid_width = document.getElementById('Grid-Multiple_Prediction').clientWidth;
       	const columns = gridOptions_multiplePrediction.columnApi.getColumnState();
       	let columns_width = 0;
       	for(let i=0 ; i<columns.length ; i++) {
       		columns_width += columns[i]['width'];
       	}
       	
       	if(grid_width>columns_width) {
       		gridOptions_multiplePrediction.api.sizeColumnsToFit();
       	}
    	
    	
    }
    
   	function vcfFileList() {
   		
   		$.ajax({
   			url: "/ipet_digitalbreed/web/database/genotype_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(),
   			method: 'POST',
   			success: function(data) {
	  			console.log("vcf file list : ", data);
	  			// data.selectFiles = vcfdata_info_t PK
	  			
	  			$("#Training_VCF").empty();
	  	    	$("#Training_VCF").append(`<option data-jobid="-1" data-filename="null"></option>`);
	  	    	for(let i=0 ; i<data.length ; i++) {
	  	    		$("#Training_VCF").append(`<option data-vcfdata_no=\${data[i].selectfiles} data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} data-refgenome_id=\${data[i].refgenome_id} > \${data[i].filename} (\${data[i].comment}) </option>`);
	  			}
	  	    	
	  	    	$("#Prediction_VCF").empty();
	  	    	$("#Prediction_VCF").append(`<option data-jobid="-1" data-filename="null"></option>`);
	  	    	for(let i=0 ; i<data.length ; i++) {
	  	    		$("#Prediction_VCF").append(`<option data-vcfdata_no=\${data[i].selectfiles} data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} data-refgenome_id=\${data[i].refgenome_id} > \${data[i].filename} (\${data[i].comment}) </option>`);
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
			}
		});
   	}
	
	function modelCheckList() {
		gridOptions_model.api.forEachNode((node) => {
  			if(node.data.group == 'BLUP') {
  				node.setSelected(true);
  			} else {
  				node.setSelected(false);
  			}
  		})
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
   	
	function switchCheckbox(id) {
		const isChecked = document.getElementById(id).checked;
		
		gridOptions_model.api.forEachNode((node) => {
			if(node.data.group == id) {
				node.setSelected(isChecked);
			} 
		})
	}
   	
   	function flatpickr() {
   		const dateSelector = document.querySelectorAll(".flatpickr-range");
   		
   		dateSelector.flatpickr({
   			mode: "range",
   			dateFormat: "Y-m-d",
   			conjunction: " ~ "
   		});
   	}
   	
   	function resetFlatpickr() {
   		
   		const cre_date = document.getElementById('cre_date');
   		cre_date.flatpickr({
   			mode: "range",
   			dateFormat: "Y-m-d",
   			conjunction: " ~ "
   		}).clear();
   		
   		const inv_date = document.getElementById('inv_date');
   		inv_date.flatpickr({
   			mode: "range",
   			dateFormat: "Y-m-d",
   			conjunction: " ~ "
   		}).clear();
   	}
   	
   	async function execute() {
   		
	   	//comment
		if(!document.getElementById("comment").value) {
			alert("Comment를 입력해 주세요.");
			return;
		}
   		
   		//VCF파일 목록 선택 안했으면 return
   		if($("#Training_VCF :selected").data('jobid') == '-1') {
   			alert("Training VCF파일을 선택하세요.");
   			return;
   		} 
   		
	   	// model options Ag-Grid
		if(!gridOptions_model.api.getSelectedRows().length) {
			alert("Model을 한 개 이상 선택해 주세요");
			return;
		}
   		
   		
   		const jobid_gs = await fetch('../getJobid.jsp')
	   							.then((response) => response.text())
	   							.then((data) => data);
   		
   		
		// permissionUid 삭제 (jsp session에서 받음)
		const varietySelectEl = document.getElementById('variety-select');
		const variety_id = varietySelectEl.options[varietySelectEl.selectedIndex].value;

		const comment = document.getElementById('comment').value;
		
		const Training_VCF = document.getElementById('Training_VCF');
		const jobid_training_vcf = Training_VCF.options[Training_VCF.selectedIndex].dataset.jobid;
		const filename_training_vcf = Training_VCF.options[Training_VCF.selectedIndex].dataset.filename
		
		const Prediction_VCF = document.getElementById('Prediction_VCF');
		const jobid_prediction_vcf = Prediction_VCF.options[Prediction_VCF.selectedIndex].dataset.jobid;
		const filename_prediction_vcf = Prediction_VCF.options[Prediction_VCF.selectedIndex].dataset.filename
		
    	const selectedTrait = gridOptionsTraitName.api.getSelectedRows();
    	let traitname = "";
		let traitname_keys = "";
		for (var i = 0; i < selectedTrait.length; i++) {
			traitname += selectedTrait[i].traitname;
			traitname_keys += (selectedTrait[i].traitname_key + 2).toString();
			if(i != selectedTrait.length -1) {
				traitname_keys += ",";
				traitname += ",";
			}
		}
		
		const cre_date = document.getElementById('cre_date').value;
		const inv_date = document.getElementById('inv_date').value;
		
		const model_selected = gridOptions_model.api.getSelectedRows()
		let model_keys = "";
		for(let i=0 ; i<model_selected.length ; i++) {
			//model_arr.push(model_selected[i].data.model);
			model_keys += model_selected[i].model;
			if(i != model_selected.length -1) {
				model_keys += ",";
			}
		}
		
		const MAXNA = document.getElementById('MAXNA_Number').value;
		const MAF = document.getElementById('MAF_Number').value;
		const LD_checked = document.getElementById('Checkbox-LD').checked;
		const LD = document.getElementById('LD_Number').value;
		const ANO_checked = document.getElementById('Checkbox-ANO').checked;
		const ANO = document.getElementById('ANO_Number').value;
		const nFolds = document.getElementById('N-Folds_Number').value;
		const nTimes = document.getElementById('N-Times_Number').value;
	    	
	    	
    	const data = {
    			"variety_id": variety_id,
    			"comment": comment,
    			"jobid_gs": jobid_gs,
    			"jobid_training_vcf": jobid_training_vcf,
    			"filename_training_vcf": filename_training_vcf,
    			"radio_phenotype": document.querySelector('input[name="radio_phenotype"]:checked').value,						// Phenotype Database
    			"traitname": traitname,
    			"traitname_keys": traitname_keys,
    			"jobid_prediction_vcf": jobid_prediction_vcf,
    			"filename_prediction_vcf": filename_prediction_vcf,
    			"model_keys": model_keys,
    			"cre_date": cre_date,
    			"inv_date": inv_date,
    			"MAXNA": MAXNA,
    			"MAF": MAF,
    			"LD_checked": LD_checked,
    			"LD": LD,
    			"ANO_checked": ANO_checked,
    			"ANO": ANO,
    			"nFolds": nFolds,
    			"nTimes": nTimes,
    	}
   		
   		
   		//select Phenotype Database
   		if(document.querySelector('input[name="radio_phenotype"]:checked').value == '0') {
   			
   			// phenotype options AG-Grid
   			if(!gridOptionsTraitName.api.getSelectedRows().length) {
   				alert("phenotype을 한 개 이상 선택해 주세요");
   				return;
   			}
   	    	
   			//debugger;
   	    	
   			
   			
   			const text =  await fetch(`./gs_check.jsp`, {
					   				method: "POST",
					   	    		headers: {
					   	    			"Content-Type": "application/json"
					   	    		},
					   	    		body:JSON.stringify(data),
					   			})
						    	.then((response) => response.text())
						    	.then((text) => text)
   			
			if(confirm(text+" 진행하시겠습니까?")) {
	   	    	fetch("./gs_insertSql.jsp", {
	   	    		method: "POST",
	   	    		headers: {
	   	    			"Content-Type": "application/json"
	   	    		},
	   	    		body:JSON.stringify(data),
	   	    	});
	   	    	
	   	    	fetch("./gs_analysis.jsp", {
	   	    		method: "POST",
	   	    		headers: {
	   	    			"Content-Type": "application/json"
	   	    		},
	   	    		body:JSON.stringify(data),
	   	    	});
	   	    	
	   	    	
				setTimeout( function () {
		   			refresh();
		   			$("#backdrop").modal("hide");
		   		}, 1000);
			}     
   			
   		// select New Phenotype File	
   		} else {
   			//console.log(box.fileList.files.length);
   			if(!box.fileList.files.length) {
   				alert("파일을 아래 영역에 넣어주세요.");
   				return;
   			}
   			
   			
			// 파일 업로드 영역
	        box.setPostData(data);
	        box.upload();
	   		
   		}
    }
   	
   	function checkJsonValid() {
   		
   		if(!document.getElementById('iframe-Multiple_Prediction').contentWindow.document.querySelector(`script[type="application/json"]`)) {
   			return;
   		}
   		
   		const str = document.getElementById('iframe-Multiple_Prediction').contentWindow.document.querySelector(`script[type="application/json"]`).innerHTML;
   		
   		function IsJsonString(str) {
   			try {
   		    	var json = JSON.parse(str);
   		    	return (typeof json === 'object');
   			} catch (e) {
   		    	return false;
   		    }
   		}
   		
   		if(IsJsonString(str)) {
	   		$('#Loading').modal('hide');
   		} else {
   			// setInterval
   			const interval_id = setInterval(myCallback, 500);
   			
   			function myCallback() {
   				const interval_str = document.getElementById('iframe-Multiple_Prediction').contentWindow.document.querySelector(`script[type="application/json"]`).innerHTML;
   				if(isJsonString(interval_str)) {
   					$('iframe#iframe-Multiple_Prediction').attr('src', url);
   					clearInterval(interval_id);
   				}
   			}
   		}
   		
   	}
    
   	
   	$('#backdrop').on('hidden.bs.modal', function (e) {
   		resetForm();
    });
   	
   	function resetForm() {
   		document.getElementById('uploadForm').reset();
   		document.getElementById('LD_Number').disabled = true;
   		document.getElementById('LD_Range').disabled = true;
   		document.getElementById('ANO_Number').disabled = true;
   		document.getElementById('ANO_Range').disabled = true;
   		
   		vcfFileList();
    	phenotypeList();
    	modelCheckList();
    	resetFlatpickr();
   	}
   	
   	function sleep(ms) {
   		return new Promise((r) => setTimeout(r, ms));
   	}
       
</script>

</body>
<!-- END: Body-->

</html>