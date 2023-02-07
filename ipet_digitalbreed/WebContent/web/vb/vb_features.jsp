<%@page import="java.sql.SQLException"%>
<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->
<%@ page import="com.google.gson.JsonArray, com.google.gson.JsonObject " %>
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

	#VariantBrowserCanvas {
		width: 100%;
	}
	
	.form-control::placeholder {
	  	color : #212529;
	  	font-size : 1rem;
	  	font-family: 'SDSamliphopangche_Outline';
	    transition : all 0.1s ease;
	}
	
	/************************ AG-Grid 헤더 수직 & borderline **************************/
	#VariantBrowserGrid .ag-header-cell-label .ag-header-cell-text {
	    writing-mode: vertical-lr; /* vertical text */
	}
	
	#VariantBrowserGrid .ag-header-cell, #VariantBrowserGrid .ag-header-group-cell, #VariantBrowserGrid .ag-cell {
	    border-right: 1px solid #dde2eb !important;
	}
	/************************ AG-Grid 헤더 수직  & borderline **************************/
	
	.expandAndCollapse  {
     	box-sizing: border-box;
     	padding: 10px;
     	overflow: hidden;
     	/*float: left;*/
     	align-items: center;
     	transition: width 0.2s ease, height 0.2s ease, opacity 0.2s ease;
     	/*border-left: 1px solid black;*/
	}
	.smallMain {
		width: 66.66%;
	}
	.expandMain {
		width: 100%;
	}
	
	.expand {
	    width: 33.33%;
	    transition-delay: 20ms;
	    opacity: 1;
	}
	.expandSide {
		width: 100%;
		height: 770px;
		opacity: 1;
		transition-delay: 20ms;
	}
	.small{
	    width: 0px;
	    height: 0px;
	    padding: 0px;
	    opacity: 0;
	    border: none;
	    transition-delay: 20ms;
	}
	.sideButton {
		width:80px; 
		height:30px; 
		padding: 0 10px 0 10px; 
		transform:rotate(-90deg); 
		border-radius: 0.4285rem 0.4285rem 0 0;
	}
	
	
	.chromosomeStackDiv {
		width: 0.103%;
		height: 18px;
		display: inline-block;
		
	}
	
	.ag-theme-alpine {
	    /*
	    --ag-foreground-color: rgb(126, 46, 132);
	    --ag-background-color: rgb(249, 245, 227);
	    --ag-header-foreground-color: rgb(204, 245, 172);
	    --ag-header-background-color: rgb(209, 64, 129);
	    --ag-odd-row-background-color: rgb(0, 0, 0, 0.03);
	    --ag-header-column-resize-handle-color: rgb(126, 46, 132);
	    --ag-font-size: 8px !important;
		*/
	}
	
	#VariantBrowserGrid {
		--ag-font-size: 12px !important;
		--ag-cell-horizontal-padding: 0px !important;
		--ag-widget-horizontal-spacing: 0px !important;
		--ag-widget-vertical-spacing: 0px !important;
	}
	
</style>
<%
	//IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	//ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	//String permissionUid = session.getAttribute("permissionUid")+"";
	//String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";
	//System.out.println(cropvari_sql);
	//System.out.println("UID : " + permissionUid);
	
	String linkedJobid = request.getParameter("jobid");
	
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">
	
	<%-- 
    <jsp:include page="../../css/topmenu.jsp" flush="true"/>
	
	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="vb"/>
	</jsp:include>
	--%>

    <!-- BEGIN: Content-->
    <div class="app-content content" style="padding-top: 0px;">
        <div class="content-overlay"></div>
        <div class="content-wrapper">
            <div class="content-body">
                <!-- Basic example section start -->
                <section id="basic-examples">
                    <div class="card">
                        <div class="card-content">
                            <div class="card-body pt-0 pb-0">
                                <div class="row justify-content-between">
	                                <div id="main" class="expandAndCollapse expandMain" style="position: relative;">
	                                	
	                                	<!-- right side 고정버튼 -->
	                                	<div style="position: absolute; top: 25px; right: -25px;">
											<button type="button" class="btn btn-success sideButton" onclick="expandAndCollapseSide('side1'); expandAndCollapseMain();">Mapping</button>
										</div>
										<div style="position: absolute; top: 105px; right: -25px;">
											<button type="button" class="btn btn-danger sideButton" onclick="expandAndCollapseSide('side2'); expandAndCollapseMain();">Sorting</button>
										</div>
										<!-- right side 고정버튼 -->
	                                	
	                                	<div class="row">
	                                		<div style="width:20%; min-width:200px; margin-top:1.5rem; margin-left:10px; padding-left:13px;"> 
												<select id='Chr_select' class='select2 form-select float-left' onChange="selectChr(this); show_SnpEff_Grid(); show_GWAS_Grid()">
													<!--  
													<option data-chr="-1" disabled hidden selected>Select Chromosome</option>
													-->
												</select>
											</div>
											<div style="width:20%; min-width:200px; margin-top:1.5rem; padding-left:14px;"> 
												<input type="text" id="positionInput" class="form-control" placeholder="Select Position" oninput="inputNumberRange(this);">
											</div>
	                                	</div>
	                                	<!--  
	                                	<div class="row mt-1">
	                                		<div id="chromosomeCanvasArea" class="col-12" style="padding:0px 1%;">
		                                		<canvas id="chromosomeCanvas" height="200px"></canvas>
	                                		</div>
	                                	</div>
	                                	<div class="row mt-1">
	                                		<div id="geneModelCanvasArea" class="col-12" style="padding:0px 1%;">
		                                		<canvas id="geneModelCanvas" height="200px"></canvas>
	                                		</div>
	                                	</div>
	                                	-->
	                                	<div class="row" style="margin-top: 50px; margin-bottom:30px;">
	                                		<div id="chromosomeDiv"  style="margin: 0px 10% auto; padding:0px; width:80%; height: 20px; border: 1px solid black; display: flex; justify-content: space-around;">
	                                		</div>
	                                	</div>
	                                	<div class="row" style="margin-bottom:150px;">
	                                		<div id="chromosomeDiv2"  style="margin: 0px 10% auto; padding:0px; width:80%; height: 20px; border: 1px solid black;">
	                                		</div>
	                                	</div>
	                                	<div class="row">
				                            <div id="VariantBrowserGrid" class="ag-theme-alpine" style="margin: 13px 23px; width: 96%; height:420px;"></div><br>
	                                	</div>
	                                </div>
	                                <div id="sideRow" class="expandAndCollapse small" style="border-left: 1px solid black;">
		                                <div class="row">
		                                	<div id="side1"  class="expandAndCollapse small">
			                                	<ul id='button_list' class='nav nav-pills nav-active-bordered-pill pl-1 pr-1'>
		                             				<li class='nav-item col-3' style="padding:0px;"><a class='nav-link active text-center' id='result_1_1' data-toggle='pill' href='#pill1' onclick="resizeGrid();" aria-expanded='true'>SnpEff</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_2' data-toggle='pill' href='#pill2' onclick="resizeGrid();" aria-expanded='false'>GWAS</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_3' data-toggle='pill' href='#pill3' onclick="resizeGrid();" aria-expanded='false'>Marker</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_4' data-toggle='pill' href='#pill4' onclick="resizeGrid();" aria-expanded='false'>Selection</a></li>
												</ul>
												<div class='tab-content'>
	  												<div role='tabpanel' class='tab-pane active pl-1' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
	  													<div class="row justify-content-between">
		  													<div style="width:50%; padding-left:14px; display:hidden;"> 
		  													<!--  
																<select id='SnpEff_select' class='select2 form-select float-left'>
																	<option data-chr="-1" disabled hidden selected>Select Chromosome</option>
																</select>
															-->
															</div>
															<div class="float-right">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:30px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
														</div>
														<div class="row mt-2" style="padding-left: 6px;">
											            	<div class="form-check" style="margin-right:1vw;">
											            		<input type="checkbox" class="form-check-input" id="high" data-impact="HIGH" onclick="SnpEff_filter();" checked />
						                                        <label class="form-check form-check-label" for="high" style="margin-left:-16px; margin-top:1px;" >HIGH</label>
											            	</div>
											            	<div class="form-check" style="margin-right:1vw;">
											            		<input type="checkbox" class="form-check-input" id="moderate" data-impact="MODERATE" onclick="SnpEff_filter();" checked />
						                                        <label class="form-check form-check-label" for="moderate" style="margin-left:-16px; margin-top:1px;" >MODERATE</label>
											            	</div>
											            	<div class="form-check" style="margin-right:1vw;">
											            		<input type="checkbox" class="form-check-input" id="low" data-impact="LOW" onclick="SnpEff_filter();" checked />
						                                        <label class="form-check form-check-label" for="low" style="margin-left:-16px; margin-top:1px;" >LOW</label>
											            	</div>
											            	<div class="form-check">
											            		<input type="checkbox" class="form-check-input" id="modifier" data-impact="MODIFIER" onclick="SnpEff_filter();" checked />
						                                        <label class="form-check form-check-label" for="modifier" style="margin-left:-16px; margin-top:1px;" >MODIFIER</label>
											            	</div>
									            		</div>
									            		<!--  
									            		<div class="row mt-1" style="float:right;">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:15px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
									            		</div>
									            		-->
									            		<div class="row col-12 mt-1 pl-0" style="margin-left:0px;">
															<div id='SnpEff_Grid' class="ag-theme-alpine" style="height:600px; width:100%;"></div>
														</div>
	  												</div>
	  												<!-- GWAS pill -->
	  												<div class='tab-pane pl-1' id='pill2' aria-labelledby='base-pill2'>
	  													<div class="row mt-1 justify-content-between">
		  													<div class="col-6">
																<select id='GWAS_select' class='select2 form-select float-left' onchange='GWAS_select_change(this.options[this.selectedIndex]);'>
																	<option data-chr="-1" disabled hidden selected>Select result</option>
																</select>
															</div>
															<div class="float-right">
											            		<button type="button" class="btn btn-light float-right" style="margin-right:30px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
														</div>
														<!--  
									            		<div class="row mt-1">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light float-right" style="margin-right:29px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
									            		</div>
									            		-->
														<div class="row mt-1">
															<div class="col-12">
																<ul id='GWAS_button_list' class='nav nav-pills nav-active-bordered-pill'>
																	<!--  
																	<li class='nav-item'><a class='nav-link active' id='GWAS_1' data-toggle='pill' href='#GWAS_pill1' aria-expanded='true'>GLM(test)</a></li>
																	-->
																</ul>
																<div class="row mt-1">
																	<div id="GWAS_content_list" class='tab-content col-12'>
		  															</div>
																</div>
															</div>
														</div>
	  												</div>
	  												<div class='tab-pane pl-1' id='pill3' aria-labelledby='base-pill3'>
	  													<div class="row mt-1 justify-content-between">
	  														<div class="col-6"> 
																<select id='Marker_select' class='select2 form-select float-left'>
																	<option data-chr="-1" disabled hidden selected>Select result</option>
																</select>
															</div>
									            			<div class="float-right">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:30px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
	  													</div>
	  													
									            		<div class="row mt-1">
	  														<div id='Marker_Grid' class="ag-theme-alpine" style="height:642px; width:100%; padding-left:14px; padding-right: 28px;"></div>
	  													</div>
	  												</div>
	  												<div class='tab-pane pl-1' id='pill4' aria-labelledby='base-pill4'>
	  													<div style="width:50%;"> 
															<select id='SelectionList_select' class='select2 form-select float-left'>
																<option data-chr="-1" disabled hidden selected>Select result</option>
															</select>
														</div>
														<div class="row mt-1" style="float:right;">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light mb-1" style="margin-left:13px; margin-right:15px;" onclick="filter_SnpEff();">Flanking sequence</button>
											            		<button type="button" class="btn btn-light mb-1" style="margin-left:13px; margin-right:15px;" onclick="alert('전송되었습니다.');">Primer Design</button>
											            		<button type="button" class="btn btn-light mb-1" style="margin-left:13px; margin-right:15px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
									            		</div>
									            		<div class="row col-12 mt-1 pr-0">
	  														<div id='SelectionList_Grid' class="ag-theme-alpine" style='height:604px; width:100%;'></div>
	  													</div>
	  												</div>
	  											</div>
		                                	</div>
		                                </div>
		                                <div class="row">
		                                	<div id="side2" class="expandAndCollapse small">
			                                	<ul id='button_list' class='nav nav-pills nav-active-bordered-pill pl-1 pr-1'>
		                             				<li class='nav-item col-3' style="padding:0px;"><a class='nav-link active text-center' id='result_1_1' data-toggle='pill' href='#pill5' onclick="resizeGrid();" aria-expanded='true'>UPGMA</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_2' data-toggle='pill' href='#pill6' onclick="resizeGrid();" aria-expanded='false'>STRUCTURE</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_3' data-toggle='pill' href='#pill7' onclick="resizeGrid();" aria-expanded='false'>Haplotype</a></li>
												</ul>
												<div class='tab-content'>
	  												<div role='tabpanel' class='tab-pane active pl-1' id='pill5' aria-expanded='true' aria-labelledby='base-pill1'>
	  													<div class="row">
		  													<div style="width:50%; padding-left:14px;"> 
																<select id='UPGMA_select' class='select2 form-select float-left'>
																	<option data-chr="-1" disabled hidden selected>Select Result</option>
																</select>
															</div>
														</div>
									            		<div class="row mt-1">
									            			<div class="col-6 pr-0">
									            				<select id='Standard_select' class='select2 form-select float-left'>
																	<option data-chr="-1" disabled hidden selected>Standard</option>
																</select>
									            			</div>
									            			<div class="col-6">
											            		<button type="button" class="btn btn-light mb-1 float-right" style="margin-right:29px;" onclick="filter_SnpEff();">정렬</button>
											            	</div>
									            		</div>
									            		<div class="row">
															<div id='UPGMA_Grid' class="ag-theme-alpine" style="height:604px; width:93%; margin-left: 15px;"></div>
														</div>
	  												</div>
	  												<div class='tab-pane pl-1' id='pill6' aria-labelledby='base-pill2'>
	  													<div class="row justify-content-between"> 
															<div class="col-6">
																<select id='STRUCTURE_select' class='select2 form-select float-left'>
																	<option data-chr="-1" disabled hidden selected>Select result</option>
																</select>
															</div>
															<div class="float-right">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:29px;" onclick="filter_SnpEff();">정렬</button>
											            	</div>
														</div>
														<!--  
														<div class="row mt-1" style="float:right;">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:29px;" onclick="filter_SnpEff();">정렬</button>
											            	</div>
									            		</div>
									            		-->
									            		<div class="row mt-1">
	  														<div id='STRUCTURE_Grid' class="ag-theme-alpine" style="height:642px; width:93%; margin-left: 15px;"></div>
	  													</div>
	  												</div>
	  												<div class='tab-pane pl-1' id='pill7' aria-labelledby='base-pill3'>
	  													<div class="row" style="width:50%; padding-left:14px;"> 
															<button type="button" class="btn btn-light" style="margin-right:29px;" onclick="filter_SnpEff();">Haplotype Analysis</button>
														</div>
														<div class="row mt-1" >
									            			<div class="col-6 pr-0">
									            				<select id='Haplotype_select' class='select2 form-select float-left'>
																	<option data-chr="-1" disabled hidden selected>Select result</option>
																</select>
									            			</div>
									            			<div class="col-6">
											            		<button type="button" class="btn btn-light mb-1 float-right" style="margin-right:29px;" onclick="filter_SnpEff();">정렬</button>
											            	</div>
									            		</div>
									            		<div class="row">
	  														<div id='Haplotype_Grid' class="ag-theme-alpine" style="height:604px; width:93%; margin-left: 15px;"></div>
	  													</div>
	  												</div>
	  											</div>
		                                	</div>
		                                </div>
                                	</div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div id="vcf_status" class="card"></div>
                </section>
                <!-- // Basic example section end -->
            </div>
        </div>
    </div>
    
    
    
	<!-- Modal start-->
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
    <script src="../../css/app-assets/vendors/js/innorix/innorix.js"></script>
    -->
    <script src="../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../css/app-assets/js/scripts/forms/select/form-select2_vb_features.js"></script>
    <script src="../../css/app-assets/js/scripts/sheetjs/xlsx.full.min.js"></script>
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
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_vb_features.js"></script>
    <!--  
    <script src="../../css/app-assets/js/scripts/plotly-latest.min.js"></script>
    -->   
	<script src="../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">       

	//Statistics에서 링크를 타고 왔을때 받는 전역변수. AG-Grid 로딩직후 cell click 용도로 사용
	var linkedJobid = "<%=linkedJobid%>";

	
	//addChromosomeInfo();
	
	document.addEventListener('DOMContentLoaded', function() {
		//const canvas = getCanvasInfo();
		
		
		
		//drawCanvas();

		appendChromosomeDiv();
		
		getGwasList();
		
	})
	
	// 1000등분하여 div상에 출력
	function appendChromosomeDiv() {
		
		console.time("make1000Div");
		
		const chromosomeDiv = document.getElementById('chromosomeDiv');
		//chromosomeDiv.innerHTML = "";
		
		for(let i=0 ; i<=1999 ; i++) {
			
			const child = document.createElement('div');
			child.classList.add('chromosomeStackDiv');
			child.dataset.order = i;
			child.dataset.selected = false;
			//child.style.width = '0.1003%';
			//child.style.height = '19px';
			//child.style.display = 'inline-block';
			
			chromosomeDiv.append(child);
		}
		
		
		document.querySelectorAll('.chromosomeStackDiv').forEach(El => {
			El.addEventListener('click', (e) => {
				//console.log(e.composedPath()[0].dataset.order);
				//console.log(document.querySelector('.chromosomeStackDiv[data-order="0"]').offsetLeft);
				//console.log(document.querySelector('.chromosomeStackDiv[data-order="998"]').offsetLeft);
				
				const clickedOrder = e.composedPath()[0].dataset.order
				let closestPositionedOrder = 2000;
				let gap = 2000;
				
				console.log(clickedOrder);
				
				
				
				e.composedPath()[1].querySelectorAll('[data-position]').forEach( (el) => {
					
					//el.style.backgroundColor = "#808000";
					
					
					//console.log("each el : ", el.dataset.order)
					
					const order = el.dataset.order;
					
					if(Math.abs( Number(order) - Number(clickedOrder) ) < gap ) {
						//console.log("closer");
						gap = Math.abs( Number(order) - Number(clickedOrder) );
						//console.log( "gap : ", gap);
						closestPositionedOrder = Number(order);
						//console.log("closest : ", closestPositionedOrder);
					} 
				})
				
				
				e.composedPath()[1].querySelectorAll('[data-selected="true"]').forEach( (el) => {
					el.style.backgroundColor = "#808000";
					el.dataset.selected = "false";
				})
				
				
				e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`).dataset.selected = 'true';
				e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`).style.backgroundColor = 'red';
				document.getElementById('positionInput').value = e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`).dataset.position;
				
				getVariantBrowserGrid();
			})
		})
		console.timeEnd("make1000Div");
	}
	
	// 염색체 드롭박스에 option 추가
	async function addChromosomeInfo() {
		console.time("addOption");
		const firstChr = await fetch(`./vb_features_chrDataList.jsp?jobid=\${linkedJobid}`)
							.then((response) => response.json())
							.then((data) => {
								//console.log(data);
								
								const chrSelectEl = document.getElementById("Chr_select");
								for(let i=0 ; i<data.length ; i++) {
									const option = document.createElement("option");
									option.dataset.chr = data[i]['chr'];
									option.dataset.vcfId_at_firstRow = data[i]['vcfId_at_firstRow'];
									option.dataset.row_count = data[i]['row_count'];
									option.dataset.length = data[i]['length'];
									option.innerText = data[i]['chr'];
									chrSelectEl.append(option);
								}
								
								return chrSelectEl.options[0].dataset.chr
								
							})
		console.timeEnd("addOption");
		return firstChr;
	}
	
	// select options 선택시 이벤트. jobid, chr값으로 position 정보 로드
	function selectChr(chrSelectElement) {
		console.time("selectOption");
		//console.log(chrSelectElement);
		const vcf_id = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.vcfId_at_firstRow;
		const row_count = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.row_count;
		const chr = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.chr;
		const length = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.length;
		
		//console.log(vcf_id);
		//console.log(row_count);
		//console.log(chr);
		
		
		fetch(`./vb_features_positionListFromChr.jsp?vcf_id=\${vcf_id}&row_count=\${row_count}&chr=\${chr}&jobid=\${linkedJobid}`)
		.then((response) => response.json())
		.then((position_data) => {
			console.log("position_data : ", position_data);
			
			console.time("position div");
			
			let position_ratio = [];
			let position_at_div = [];
			let vcf_id_at_div = [];
			
			for(let i=0 ; i<position_data.length ; i++) {
				const position = parseInt(position_data[i]['position'] * 2000 / length );
				if(!position_ratio.includes(position)) {
					position_ratio.push(position);
					position_at_div.push(position_data[i]['position']);
					vcf_id_at_div.push(position_data[i]['vcf_id']);
				} /* else {
					position_at_div[position_at_div.length - 1] = position_at_div[position_at_div.length - 1] +","+  position_data[i]['position'];
				} // 모든 position 정보를 하나의 div [data-position]에 저장. 다른 부분의 코드를 보강해야 정상작동 */
			}
			
			console.log(position_ratio);
			console.log(position_at_div);
			console.log(vcf_id_at_div);
			console.timeEnd("position div");
			
			colorPosition(position_ratio, position_at_div, vcf_id_at_div);
			
			//variant browser 로드
			getVariantBrowserGrid();
			console.timeEnd("selectOption");
		})
		
		
		
	}
	
	
	
	// position과 일치하는 div에 색칠
	function colorPosition(position_ratio, position_at_div, vcf_id_at_div) {
		//console.log("position_data : ", position_data);
		//console.log("position_ratio : ", position_ratio);
		//console.log("position_at_div : ", position_at_div);
		console.time("color");
		
		for(let i=0 ; i<=1999 ; i++) {
			const stackDiv = document.querySelector(`.chromosomeStackDiv[data-order="\${i}"]`);
			stackDiv.dataset.selected = "false";
			stackDiv.style.backgroundColor = '';
			delete stackDiv.dataset.position;
			delete stackDiv.dataset.vcf_id;
		}
		
		for(let i=0 ; i<position_ratio.length ; i++) {
			const stackDiv = document.querySelectorAll('#chromosomeDiv > [data-order]')[position_ratio[i]];
			stackDiv.dataset.position = position_at_div[i];
			stackDiv.dataset.vcf_id = vcf_id_at_div[i];
			stackDiv.dataset.selected = "false";
			stackDiv.style.backgroundColor = '#808000';
		}
		
		document.querySelectorAll('.chromosomeStackDiv[data-position]')[0].dataset.selected = "true";
		document.querySelectorAll('.chromosomeStackDiv[data-position]')[0].style.backgroundColor = 'red';
		
		console.timeEnd("color");
	}
	
	function getVariantBrowserGrid() {
		const position = document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.position;
		const chrSelectEl = document.getElementById('Chr_select');
		const chr = chrSelectEl.options[chrSelectEl.selectedIndex].dataset.chr;
		
		const vcf_id = document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.vcf_id;
		
		//console.log(position);
		//console.log(chr);
		console.time("showVB");
		fetch(`./vb_features_getBrowserData.jsp?chr=\${chr}&position=\${position}&jobid=\${linkedJobid}&vcf_id=\${vcf_id}`)
    	.then((response) => response.json())
    	.then((data) => {
    		//console.log("chr=1, position=3374674로 설정")
    		//console.log(data);
    		
    		let columnKeys = new Array('id')
    		
    		for(const key in data[0]) {
    			if(key == 'id')	continue;
    			columnKeys.push(key);
    		}
    		//console.log(columnKeys);
    		
    		VariantBrowser_columnDefs = [];
    		for(let i=0 ; i<columnKeys.length ; i++) {
    			if(columnKeys[i] == 'id') {
    				VariantBrowser_columnDefs.push({
    					field: columnKeys[i], 
    					width: 120,
    					sorting: false,
    				}) 
    			} else {
    				VariantBrowser_columnDefs.push({
    					headerName: columnKeys[i].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
    					field: columnKeys[i], 
    					//headerClass: "ag-right-aligned-header",
    					width: 30,
    					sorting: true,
    					sortingOrder: ['desc'],
    					
    		            comparator: (valueA, valueB, nodeA, nodeB, isDescending) => {
    		                
    		            	switch(valueA) {
    		            		case base_order[0]:
    		            			valueA = 4;
    		            			break;
    		            		case base_order[1]:
    		            			valueA = 3;
    		            			break;
    		            		case base_order[2]:
    		            			valueA = 2;
    		            			break;
    		            		case base_order[3]:
    		            			valueA = 1;
    		            			break;
    		            		default:
    		            			valueA = 0;
    		            	}
    		            	
    		            	switch(valueB) {
			            		case base_order[0]:
			            			valueB = 4;
			            			break;
			            		case base_order[1]:
			            			valueB = 3;
			            			break;
			            		case base_order[2]:
			            			valueB = 2;
			            			break;
			            		case base_order[3]:
			            			valueB = 1;
			            			break;
			            		default:
    		            			valueB = 0;
			            	}
    		            	
    		            	if(base_switch) {
    		            		base_switch = false;
   		            			const spliced = base_order.shift();
    		            		base_order.push(spliced);
    		            		setTimeout(() => {
	    		            		base_switch = true;
    		            		}, 200);
    		            	}
    		            	
    		            	if (valueA == valueB) return 0;
    		                return (valueA > valueB) ? 1 : -1;
    		            },
    		            
    					tooltipField: columnKeys[i], 
    					tooltipComponent: CustomTooltip, 
    					cellStyle: cellStyle,
    				}) 
    			}
    		}
    		
    		
    		const VariantBrowser_gridTable = document.getElementById("VariantBrowserGrid");
    		if(!VariantBrowser_gridTable.innerHTML) {
	    		const VariantBrowser_Grid = new agGrid.Grid(VariantBrowser_gridTable, VariantBrowser_gridOptions);
    		}

    		VariantBrowser_gridOptions.api.setColumnDefs(VariantBrowser_columnDefs);
    		VariantBrowser_gridOptions.api.setRowData(data);
    		
    		//'Position' 컬럼을 검색 => 해당 컬럼은 수평처리
    		Array.prototype.slice.call(document.querySelectorAll('#VariantBrowserGrid .ag-header-cell-label .ag-header-cell-text'))
    		.filter((el) => el.textContent === 'Id')[0].style.writingMode = 'horizontal-tb';
    		
    		console.timeEnd("showVB");
    	})
	}
	var base_order = ['A','T','G','C'];
	var base_switch = true;
   	
	function expandAndCollapseMain() {
		
		const main = document.getElementById('main');
		const side = document.getElementById('sideRow');
		
		const side1 = document.getElementById('side1');
		const side2 = document.getElementById('side2');
		
		if ( side1.classList.contains('small') && side2.classList.contains('small') ) {
			main.classList.replace('smallMain', 'expandMain');
			side.classList.replace('expand', 'small');
			
		} else if( !(side1.classList.contains('small') && side2.classList.contains('small')) && main.classList.contains('expandMain') ) {
			
			main.classList.replace('expandMain', 'smallMain');
			side.classList.replace('small', 'expand');
		} else {
			return;
		}
	}
	
	function expandAndCollapseSide(text) {
		
		const side1 = document.getElementById('side1');
		const side2 = document.getElementById('side2');
		

		if(text == 'side1') {
			
			side2.classList.replace('expandSide', 'small');
			if(side1.classList.contains('expandSide')) {
				side1.classList.replace('expandSide', 'small');
			} else {
				side1.classList.replace('small', 'expandSide');
			}
			
		} else if(text == 'side2') {
			
			if(side2.classList.contains('expandSide')) {
				side2.classList.replace('expandSide', 'small');
			} else {
				side2.classList.replace('small', 'expandSide');
			}
			side1.classList.replace('expandSide', 'small');
			
		}
		
		resizeGrid();
		
	}
	
	function show_SnpEff_Grid() {
		//const resultpath = '/ipet_digitalbreed/result/database/genotype_statistics/';
		
		console.time("SnpEff_Grid");
		
		const chr_select = document.getElementById('Chr_select');
   		const chr = chr_select.options[chr_select.selectedIndex].dataset.chr;
		
		fetch(`./vb_features_grid_SnpEff.jsp?jobid=\${linkedJobid}&chr=\${chr}`)
		.then((response) => response.json())
		.then((data) => {
			//console.log(data.split("\n"));
			/*
			const header_arr = ['Chr','Pos','Impact','Effect Classic','GeneID','Description'];
			const body = data.split('\n');
			*/
			//console.log(data);
			SnpEff_gridOptions.api.setRowData(data);
			SnpEff_gridOptions.columnApi.autoSizeAllColumns();
			
			
		})
		
		console.timeEnd("SnpEff_Grid");
		
	}
	
	function SnpEff_filter() {
		
		const impact = document.querySelectorAll("[data-impact]:checked");
		
		const impact_filter_values = new Array();
		for(let i=0 ; i<impact.length ; i++) {
			impact_filter_values.push(impact[i].dataset.impact);
		}
		
		
		console.log(impact_filter_values);
		
		const impactFilter = {
				impact: {
					type: 'set',
					//values: ['HIGH','LOW']
					values: impact_filter_values
				},
		}
		
		SnpEff_gridOptions.api.setFilterModel(impactFilter);
		/*
		if(impact_filter_values.length == 0) {
			SnpEff_gridOptions.api.setFilterModel(null);
		} else {
			SnpEff_gridOptions.api.setFilterModel(impactFilter);
		}
		*/
		
		
		/*
		const impact = SnpEff_gridOptions.api.getFilterInstance('impact');
		impact.setModel({values: ['HIGH', 'LOW']});
		impact.applyModel();
		*/
		SnpEff_gridOptions.api.onFilterChanged();
		
		
		
	}
   	
	
   	function getGwasList() {
   		fetch(`./vb_getLists.jsp?command=GWAS&jobid=\${linkedJobid}`)
   		.then((response) => response.json())
   		.then((data) => {
   			console.log(data);
   			for(let i=0 ; i<data.length ; i++) {
  				// ${data}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
  				$("#GWAS_select").append(`<option data-jobid=\${data[i].jobid} data-phenotype=\${data[i].phenotype_name} data-model=\${data[i].model} data-filename=\${data[i].filename} > \${data[i].comment} (\${data[i].cre_dt}) </option>`);
  			}
   		});
   	}
   	
   	const GWAS_gridOptions_model = {};
   	
   	// GWAS탭의 드롭박스 change시 발생 이벤트
   	function GWAS_select_change(HTML_element) {
   		//console.log(HTML_element);
   		
   		const jobid = HTML_element.dataset.jobid;
   		
   		
   		// model list 나열
   		const model = HTML_element.dataset.model.split("|");
   		$("#GWAS_button_list").empty();
   		$("#GWAS_content_list").empty();
   		for(let i=0 ; i<model.length ; i++) {
			$("#GWAS_button_list").append(`<li class="nav-item"><a class="nav-link" id="GWAS_\${model[i]}" data-toggle="pill" href="#GWAS_pill_\${model[i]}" aria-expanded="true" data-phenotype="-1" data-model=\${model[i]} >\${model[i]}</a></li>`);
			$("#GWAS_content_list").append(`<div role='tabpanel' class='tab-pane' id='GWAS_pill_\${model[i]}' aria-expanded='true' aria-labelledby='base-pill1'>\${model[i]}</div>`)
			
			
			if(i==0) {
				document.getElementById(`GWAS_\${model[i]}`).classList.add('active');
				document.getElementById(`GWAS_pill_\${model[i]}`).classList.add('active');
			}
			
			const element = document.getElementById(`GWAS_pill_\${model[i]}`);
			element.innerHTML = `<select id="GWAS_select_\${model[i]}" data-model="\${model[i]}" data-jobid="\${jobid}" onchange="show_GWAS_Grid()"></select>`
			
			
			const phenotype = HTML_element.dataset.phenotype.split("|");
			$(`#GWAS_select_\${model[i]}`).append('<option data-phenotype="-1" disabled hidden selected>Select Phenotype</option>')
			for(let j=0 ; j<phenotype.length ; j++) {
				$(`#GWAS_select_\${model[i]}`).append(`<option data-phenotype=\${phenotype[j]} > \${phenotype[j]} </option>`);
			}
			jQuery(`#GWAS_select_\${model[i]}`).select2({width: '35%'});
			
			$(`#GWAS_pill_\${model[i]}`).append(`<div class='row mt-1'><div id='GWAS_Grid_\${model[i]}' class='col-12 ag-theme-alpine' style='height:561px; padding-right:28px;' ></div></div>`); 
			
			const GWAS_gridTable = document.getElementById(`GWAS_Grid_\${model[i]}`);
			GWAS_gridOptions_model[`\${model[i]}`] = Object.assign({},GWAS_gridOptions);
			
			const GWAS_Grid = new agGrid.Grid(GWAS_gridTable, GWAS_gridOptions_model[`\${model[i]}`]);
			GWAS_gridOptions_model[`\${model[i]}`].api.sizeColumnsToFit();
			
		}
   		
   	}
   	
   	//function show_GWAS_Grid (HTML_element) {
   	function show_GWAS_Grid () {
		
   		console.log("onchange");
   		/*
   		console.log(HTML_element);
		
		const model = HTML_element.dataset.model;
		const phenotype = HTML_element.options[HTML_element.selectedIndex].dataset.phenotype;
   		const jobid = HTML_element.dataset.jobid;
		*/
		const model = document.querySelector('#GWAS_button_list .nav-link.active')?.dataset?.model;
		const select_phenotype = document.getElementById(`GWAS_select_\${model}`);
		const phenotype = select_phenotype?.options[select_phenotype.selectedIndex]?.dataset?.phenotype;
		const jobid = select_phenotype?.dataset?.jobid;
		
		//console.log(model);
		//console.log(phenotype);
		//console.log(jobid);
   		
		if(!model || !phenotype || !jobid) {
			//console.log("gwas 영역 생성안됨");
			return;
		}
		
		const chr_select = document.getElementById('Chr_select');
   		const chr = chr_select.options[chr_select.selectedIndex].dataset.chr;
   		
		//console.log(model);
		//console.log(phenotype);
		//console.log(jobid);
		 
		fetch(`./vb_features_grid_Gwas.jsp?chr=\${chr}&jobid=\${jobid}&model=\${model}&phenotype=\${phenotype}`)
		.then((response) => response.json())
		.then((data) => {
			console.log(data);
			GWAS_gridOptions_model[`\${model}`].api.setRowData(data);
		});

   	}
   	
   	function resizeGrid() {
   		setTimeout( () => {
			SnpEff_gridOptions.columnApi.autoSizeAllColumns();
			
			if(Object.keys(GWAS_gridOptions_model).length !== 0) {
				GWAS_gridOptions_model.forEach((El) => {
					El.columnApi.autoSizeAllColumns();
				})
			}
			
		}, 200)
   	}
   	
   	function inputNumberRange(HTML_element) {
   		//console.log(HTML_element);
   		HTML_element.value = HTML_element.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
   	}
   	
</script>

</body>
<!-- END: Body-->

</html>