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
		height: 880px;
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
	
	#chromosomeDiv, #chromosomeDetailedDiv {
		  margin: 0px 5% auto; 
		  padding:0px; 
		  width:90%; 
		  height: 20px; 
		  display: flex; 
		  justify-content: space-around;
	}
	.chromosomeStackDiv, .chromosomeDetailedStackDiv {
		width: 1px;
		height: 18px;
		border-top: 1px solid black;
		border-bottom: 1px solid black;
		display: inline-block;
		position: relative;
	}
	.chromosomeStackDiv[data-order="0"], .chromosomeDetailedStackDiv[data-order="0"] {
		border-left: 1px solid black;
		z-index: 10;
	}
	.chromosomeStackDiv[data-position] {
		background-color: #bcbcbc;
	}
	.chromosomeStackDiv[data-selected="true"] {
		background-color: red !important;
		border: red !important;
		z-index: 99;
	}
	.chromosomeStackDiv[data-order="1999"], .chromosomeDetailedStackDiv[data-order="1999"] {
		border-right: 1px solid black;
		z-index: 10;
	}
	/*
	.popover-header {
		background-color: #b5b5b5;
	}
	.popover.bs-popover-bottom .arrow:after {
		border-bottom-color: #ababab;
	}
	*/
	
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
	//String refgenome_id = request.getParameter("refgenome_id");
	String refgenome = request.getParameter("refgenome");
	String gff = request.getParameter("gff");
	
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
											<button type="button" class="btn btn-success sideButton" onclick="expandAndCollapseSide('side1'); expandAndCollapseMain();">Loci</button>
										</div>
										<div style="position: absolute; top: 105px; right: -25px;">
											<button type="button" class="btn sideButton" style="color: #ffffff; background-color:#2da0ed;" onclick="expandAndCollapseSide('side2'); expandAndCollapseMain();">Cluster</button>
										</div>
										<!-- right side 고정버튼 -->
	                                	
	                                	<div class="row mt-2">
	                                		<div style="width:20%; min-width:200px; margin-left:10px; padding-left:13px;"> 
												<select id='Chr_select' class='select2 form-select float-left' onChange="clear_mark_all(); selectChr(this); show_SnpEff_Grid(); show_GWAS_Grid()">
												</select>
											</div>
											<div style="width:20%; min-width:200px; padding-left:14px;"> 
												<input type="text" id="positionInput" class="form-control" placeholder="Position" readonly>
											</div>
											<div style="width:56%">
												<div class="float-right">
													<button type="button" class="btn-sm btn-secondary mb-1" style="margin-top:8px; margin-left:2px;"> &gt;&gt; </button>
												</div>
												<div class="float-right">
													<button type="button" class="btn-sm btn-secondary mb-1" style="margin-top:8px;margin-left:2px;"> &gt; </button>
												</div>
												<div class="float-right">
													<button type="button" class="btn-sm btn-secondary mb-1" style="margin-top:8px;margin-left:2px;"> &lt; </button>
												</div>
												<div class="float-right">
													<button type="button" class="btn-sm btn-secondary mb-1" style="margin-top:8px;margin-left:2px;"> &lt;&lt; </button>
												</div>
											</div>
	                                	</div>
	                                	<div class="row" style="margin-top: 0px; margin-bottom:30px;">
	                                		<fieldset class="border mt-1 pt-2 pl-2 pr-2 pb-1" style="width:96%; margin-left:23px; margin-right:23px;">
	                                			<legend  class="w-auto">Reference</legend>
		                                		<div id="chromosomeDiv"></div>
	                                		</fieldset>
	                                	</div>
	                                	<div class="row">
	                                		<fieldset class="border mt-1 pt-2 pl-2 pr-2" style="width:96%; margin-left:23px; margin-right:23px; padding-bottom:130px;">
	                                			<legend  class="w-auto">Gene Model</legend>
		                                		<div id="chromosomeDetailedDiv"></div>
	                                		</fieldset>
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
		  													<div style="width:65%; margin-top:9px; padding-left:14px; "> 
																<div class="form-check" style="margin-right:0.4rem; padding-left:1.2rem; display:inline-block;">
												            		<input type="checkbox" class="form-check-input" id="high" data-impact="HIGH" onclick="SnpEff_filter();" checked />
							                                        <label class="form-check form-check-label" for="high" style="margin-left:-16px; margin-top:1px;" >HIGH</label>
												            	</div>
												            	<div class="form-check" style="margin-right:0.4rem; display:inline-block;" >
												            		<input type="checkbox" class="form-check-input" id="moderate" data-impact="MODERATE" onclick="SnpEff_filter();" checked />
							                                        <label class="form-check form-check-label" for="moderate" style="margin-left:-16px; margin-top:1px;" >MODERATE</label>
												            	</div>
												            	<div class="form-check" style="margin-right:0.4rem; display:inline-block;">
												            		<input type="checkbox" class="form-check-input" id="low" data-impact="LOW" onclick="SnpEff_filter();" checked />
							                                        <label class="form-check form-check-label" for="low" style="margin-left:-16px; margin-top:1px;" >LOW</label>
												            	</div>
												            	<div class="form-check" style="margin-right:0.4rem; display:inline-block;">
												            		<input type="checkbox" class="form-check-input" id="modifier" data-impact="MODIFIER" onclick="SnpEff_filter();" checked />
							                                        <label class="form-check form-check-label" for="modifier" style="margin-left:-16px; margin-top:1px;" >MODIFIER</label>
												            	</div>
															</div>
															<div class="float-right">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:30px;" onclick="SnpEff_mark();">표지</button>
											            	</div>
														</div>
														<!--  
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
									            		-->
									            		<!--  
									            		<div class="row mt-1" style="float:right;">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:15px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
									            		</div>
									            		-->
									            		<div class="row col-12 pl-0" style="margin-left:0px;">
															<div id='SnpEff_Grid' class="ag-theme-alpine" style="height:760px; width:100%;"></div>
														</div>
	  												</div>
	  												<!-- GWAS pill -->
	  												<div class='tab-pane pl-1' id='pill2' aria-labelledby='base-pill2'>
	  													<div class="row mt-1 justify-content-between">
		  													<div class="col-6">
																<select id='GWAS_select' class='select2 form-select float-left' onchange='GWAS_select_change(this.options[this.selectedIndex]);'>
																	<option data-jobid="-1" disabled hidden selected>Select result</option>
																</select>
															</div>
															<div class="float-right">
											            		<button type="button" class="btn btn-light float-right" style="margin-right:30px;" onclick="GWAS_mark();">표지</button>
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
	  												<!-- Marker pill -->
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
	  														<div id='Marker_Grid' class="ag-theme-alpine" style="height:745px; width:100%; padding-left:14px; padding-right: 28px;"></div>
	  													</div>
	  												</div>
	  												<!-- Selection pill -->
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
	  														<div id='SelectionList_Grid' class="ag-theme-alpine" style='height:706px; width:100%;'></div>
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
	  												<!-- UPGMA pill -->
	  												<div role='tabpanel' class='tab-pane active pl-1' id='pill5' aria-expanded='true' aria-labelledby='base-pill1'>
	  													<div class="row">
		  													<div style="width:47%; padding-left:14px;"> 
																<select id='UPGMA_select' class='select2 form-select float-left' onchange='show_UPGMA_Grid(); getUpgmaStandardList();'>
																	<option data-jobid="-1" disabled hidden selected>Select Result</option>
																</select>
															</div>
															<div style="width:48%; padding-left:14px;"> 
																<select id='Standard_select' class='select2 form-select float-left' onchange='sort_distanceMatrix_UPGMA();'>
																	<option data-jobid="-1" disabled hidden selected>Sorting Standard</option>
																</select>
															</div>
														</div>
									            		<div class="row mt-1">
									            			<div class="col-6 pr-0">
									            				<!--  
									            				<select id='Standard_select' class='select2 form-select float-left' onchange='sort_distanceMatrix_UPGMA();'>
																	<option data-jobid="-1" disabled hidden selected>Sorting Standard</option>
																</select>
																-->
									            			</div>
								            				<!-- 
								            					정렬 초기화 용도. 기본값 = false
								            					UPGMA 2개의 select 모두 변경시 data-reset="false"
								            					Reset 버튼 클릭시 data-reset="true" & 정렬이 해제된 상태로 variant browser Grid 로드
								            				-->
								            				<!--  
									            			<div class="col-6">
											            		<button type="button" id="reset_UPGMA" class="btn btn-light mb-1 float-right" data-reset="true" style="margin-right:29px;" onclick="this.dataset.reset='true'; getVariantBrowserGrid();">Reset</button>
											            	</div>
											            	-->
											            	<div class="col-3"></div>
											            	<div class="col-3 mt-1 mr-1">
											            		<div class="form-check form-check-secondary form-switch" style="display:inline;">
					                                                <input type="checkbox" class="form-check-input" id="switch_sort_UPGMA" style="height: 1.5rem; width:3em;" onclick="isSorted_by_UPGMA(this.checked);" > 
												            	</div>
											            		<label class="form-check-label " for="switch_sort_UPGMA" style="margin-left: 18px; font-size: 16px; display:inline;">Sort</label>
											            	</div>
									            		</div>
									            		<div class="row mt-1">
															<div id='UPGMA_Grid' class="ag-theme-alpine" style="height:710px; width:93%; margin-left: 15px;"></div>
														</div>
	  												</div>
	  												<!-- STRUCTURE pill -->
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
	  												<!-- Haplotype pill -->
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
	<div class="modal fade" id="geneInfoModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  		<div class="modal-dialog">
    		<div class="modal-content">
      			<div class="modal-header">
	    		    <h1 class="modal-title fs-5" id="exampleModalLabel">Gene data</h1>
   				    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
      			</div>
	      		<div class="modal-body">
	        		<div class="">
	        			<h4 class="">Primary data</h4>
	        			<div class="">
	        				<label>Name</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>Position</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>Length</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>Start</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>End</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>Strand</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>CDS</label>
	        				<p></p>
	        			</div>
	        		</div>
	        		<div class="">
	        			<h4 class="">Attributes</h4>
	        			<div class="">
	        				<label>ID</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>Description</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>RefSeq</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>UniProt</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>Pfam</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>TAIR</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>GO</label>
	        				<p></p>
	        			</div>
	        			<div class="">
	        				<label>KEGG</label>
	        				<p></p>
	        			</div>
	        		</div>
	      		</div>
	      		<div class="modal-footer">
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			        <button type="button" class="btn btn-primary">Save changes</button>
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
	const linkedJobid = "<%=linkedJobid%>";
	<%-- var refgenome_id = "<%=refgenome_id%>"; --%>
	const refgenome = "<%=refgenome%>";
	const gff = "<%=gff%>";

	
	(function() {
		console.time("IIFE")
		appendChromosomeDiv();
		appendChromosomeDetailedDiv();
		$('[data-toggle="popover"]').popover();
		console.timeEnd("IIFE")
	})();
	
	document.addEventListener('DOMContentLoaded', async function() {
		
		await addChromosomeInfo();
  		document.getElementById("Chr_select").dispatchEvent(new Event("change"));
		
		getGwasSelectList();
		getUpgmaSelectList();
		
	})
	
	// 1000등분하여 div상에 출력
	function appendChromosomeDiv() {
		
		console.time("make1000Div");
		
		const chromosomeDiv = document.getElementById('chromosomeDiv');
		
		for(let i=0 ; i<=1999 ; i++) {
			
			const child = document.createElement('div');
			child.classList.add('chromosomeStackDiv');
			child.dataset.order = i;
			child.dataset.selected = false;
			
			chromosomeDiv.append(child);
		}
		
		
		
		
		console.timeEnd("make1000Div");
	}
	
	// 각각의 chrmosomeStackDiv에 클릭이벤트 추가
	document.querySelectorAll('.chromosomeStackDiv').forEach(El => {
		El.addEventListener('click', (e) => {
			
			const clickedOrder = e.composedPath()[0].dataset.order
			let closestPositionedOrder = 2000;
			let gap = 2000;
			
			//console.log(clickedOrder);
			
			e.composedPath()[1].querySelectorAll('[data-position]').forEach( (el) => {
				
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
				//el.style.backgroundColor = "#bcbcbc";
				el.dataset.selected = "false";
			})
			
			const selectedDiv = e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`);
			selectedDiv.dataset.selected = 'true';
			//selectedDiv.style.backgroundColor = 'red';
			
			document.getElementById('positionInput').value = e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`).dataset.position.replace(/\B(?=(\d{3})+(?!\d))/g, ',');;
			
			getGeneModel(selectedDiv);
			getVariantBrowserGrid();
		})
	})
	
	
	
	// 염색체 드롭박스에 option 추가
	async function addChromosomeInfo() {
		console.time("addOption");
		await fetch(`./vb_features_chrDataList.jsp?jobid=\${linkedJobid}`)
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
			})
		console.timeEnd("addOption");
	}
	
	
	// select options 선택시 이벤트. jobid, chr값으로 position 정보 로드
	function selectChr(chrSelectElement) {
		//console.time("selectOption");
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
			//console.log("position_data : ", position_data);
			
			//console.time("position div");
			
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
			
			//console.log(position_ratio);
			//console.log(position_at_div);
			//console.log(vcf_id_at_div);
			//console.timeEnd("position div");
			
			if(row_count != 0) {
				colorPosition(position_ratio, position_at_div, vcf_id_at_div);

				//variant browser 로드
				getVariantBrowserGrid();
			} else {
				VariantBrowser_gridOptions.api.setColumnDefs([]);
				VariantBrowser_gridOptions.api.setRowData([]);
			}
			
			//console.timeEnd("selectOption");
		})
		
		
		
	}
	
	
	
	// position과 일치하는 div에 색칠 -> data-position 값 추가 & css에서 background-color 회색으로 조정
	function colorPosition(position_ratio, position_at_div, vcf_id_at_div) {
		//console.log("position_data : ", position_data);
		//console.log("position_ratio : ", position_ratio);
		//console.log("position_at_div : ", position_at_div);
		//console.time("color");
		
		for(let i=0 ; i<=1999 ; i++) {
			const stackDiv = document.querySelector(`.chromosomeStackDiv[data-order="\${i}"]`);
			stackDiv.dataset.selected = "false";
			
			//stackDiv.style.backgroundColor = '';
			delete stackDiv.dataset.position;
			delete stackDiv.dataset.vcf_id;
		}
		
		for(let i=0 ; i<position_ratio.length ; i++) {
			const stackDiv = document.querySelectorAll('#chromosomeDiv > [data-order]')[position_ratio[i]];
			stackDiv.dataset.position = position_at_div[i];
			stackDiv.dataset.vcf_id = vcf_id_at_div[i];
			//stackDiv.dataset.selected = "false";
			//stackDiv.style.backgroundColor = '#bcbcbc';
		}
		
		document.querySelectorAll('.chromosomeStackDiv[data-position]')[0].dataset.selected = "true";
		//document.querySelectorAll('.chromosomeStackDiv[data-position]')[0].style.backgroundColor = 'red';
		
		//console.timeEnd("color");
	}
	
	function appendChromosomeDetailedDiv() {
		const chromosomeDiv = document.getElementById('chromosomeDetailedDiv');
		
		for(let i=0 ; i<=1999 ; i++) {
			
			const child = document.createElement('div');
			child.classList.add('chromosomeDetailedStackDiv');
			child.dataset.order = i;
			child.dataset.selected = false;
			
			chromosomeDiv.append(child);
		}
		
		//테스트용
		const stackOrder_500 = document.querySelector(`.chromosomeDetailedStackDiv[data-order="1000"]`); 
		stackOrder_500.style.backgroundColor = "red";
		
		const childDiv = document.createElement('div');
		childDiv.dataset.geneModel_order = "500";
		childDiv.style.position = "absolute";
		childDiv.style.top = "30px";
		childDiv.style.right = "-35px";
		//childDiv.dataset.toggle = "popover";
		//childDiv.dataset.content = "Popover Area";
		/*
		childDiv.innerHTML = `<svg width="81.760757" height="11.519"
								viewBox="0 0 21.632545 3.047735" version="1.1" id="svg117"
								xmlns="http://www.w3.org/2000/svg"
								xmlns:svg="http://www.w3.org/2000/svg">
					  			<g transform="translate(-0.89341089,-1.3147886)">
							   		<path
										style="fill:#c4bd97;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.264583"
										d="m 3.0536216,1.3147886 v 3.047842 h 4.360107 v -3.047842 z"
										/>
							   		<path
										style="fill:#c4bd97;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.264583"
										d="m 9.4032916,1.3147886 v 3.047842 h 1.9895634 v -3.047842 z"
										/>
							   		<path
										style="fill:#c4bd97;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.264583"
										d="m 19.097122,1.3147886 v 3.047842 h 3.428822 v -3.047842 z"
										/>
							   		<path
										style="fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:#000000;stroke-width:0.0026457px;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
										d="M 22.356619,2.5847226 H 2.6594126 v 0.253987 H 22.356619 Z M 3.0112906,1.6534376 0.89473358,2.7117166 3.0112906,3.7699946 Z"
										/>
					  			</g>
							</svg> 
							`; 
		*/
		childDiv.innerHTML = setSVG(childDiv);
							
		//stackOrder_500.appendChild(childDiv);
		
	}
	
	async function getGeneModel(selectedDiv) {
		
		const chr = selectedOption('Chr_select').dataset.chr;
		const position = selectedDiv.dataset.position;
		
		const baseURL = window.location.href;
		const url = new URL('./vb_features_getGffData.jsp', baseURL);
		
		const map_params = new Map();
		map_params.set("jobid", linkedJobid);
		map_params.set("chr", chr);
		map_params.set("position", position);
		map_params.set("refgenome", refgenome);
		map_params.set("gff", gff);
		
		//fetch(url);
		const gene_model = await getFetchData(url, map_params);
		
		console.log("getGeneModel data : ", gene_model);
		
		
		// 이전 표식을 삭제
		document.querySelectorAll(`.chromosomeDetailedStackDiv[data-selected="true"]`).forEach((el) => {
			el.dataset.selected = "false";
			el.innerHTML = "";
		})
		
		
		// gene_model[0] : mRna | gene_model[1] : CDS
		for(let i=0 ; i<gene_model['mRNA'].length ; i++) {
			
			const mRNA_attribute = gene_model['mRNA'][i]['attribute'].split(';');
			let mRNA_id = "";
			for(let k=0 ; k<mRNA_attribute.length ; k++) {
				if(mRNA_attribute[k].includes('ID=')) {
					mRNA_id = mRNA_attribute[k].substring(3, mRNA_attribute[k].length); 
				}
			}
			
			//console.log("mRNA_id : ", mRNA_id);
			
			const selected_position = Number(document.querySelector(`.chromosomeStackDiv[data-selected='true']`).dataset.position);
			
			const mRNA_start = Number(gene_model['mRNA'][i]['start']);
			const mRNA_end = Number(gene_model['mRNA'][i]['end']);
			const mRNA_width = (mRNA_end - mRNA_start)/ 50;
			
			const mRnaDivOrder = parseInt( ((mRNA_end + mRNA_start)/2 - selected_position) / 50 ) + 1000;
			
			// 표시할 position을 선정
			const selectedGeneModelDiv = document.querySelector(`.chromosomeDetailedStackDiv[data-order="\${mRnaDivOrder}"]`);
			selectedGeneModelDiv.dataset.selected = "true";
			
			const strand = gene_model['mRNA'][i]['strand'];
			
			const svg_CDS = new Array();
			
			for(let j=0 ; j<gene_model['CDS'].length ; j++) {
				const CDS_start = Number(gene_model['CDS'][j]['start']);
				const CDS_end = Number(gene_model['CDS'][j]['end']);
				
				const CDS_attribute = gene_model['CDS'][j]['attribute'].split(';');
				//let CDS_parent = "";
				for(const attribute of CDS_attribute) {
					let CDS_parent = attribute.substring(7, attribute.length); 
					if(attribute.includes('Parent=') && CDS_parent == mRNA_id) {
						svg_CDS.push(gene_model['CDS'][j]);
						//console.log(CDS_parent);
						break;
					}
				}
				
				/*
				if(mRNA_id == CDS_parent) {
					svg_CDS.push(gene_model['CDS'][j]);
				}
				*/
				
			}
			
			
			function createSVG(mRNA_start, mRNA_end, mRNA_width, strand, svg_CDS) {
				
				console.log(mRNA_start, mRNA_end, mRNA_width, strand, svg_CDS);
				
				const xmlns = "http://www.w3.org/2000/svg";
				
				const svg = document.createElementNS(xmlns, "svg");
			    //svg.setAttribute('style', `border:1px solid black; position: absolute; top: 37px; right:\${-width/2}`);
			    svg.setAttribute('width', mRNA_width+9);
			    svg.setAttribute('height', '20');
			    //svg.setAttribute('viewBox', '0 0 21.63 3.05');
			    svg.setAttributeNS("http://www.w3.org/2000/xmlns/", "xmlns:svg", "http://www.w3.org/2000/svg");
			    svg.setAttribute('onclick', "$('#geneInfoModal').modal('show')");
			    
			    for(const cds of svg_CDS) {
			    	const cds_start_relative = (Number(cds.start) - mRNA_start) / 50;
			    	const cds_width = (Number(cds.end) - Number(cds.start)) / 50;
			    	const cds_end_relative = cds_start_relative + cds_width;
			    	
			    	const polygon_cds = document.createElementNS(xmlns, "polygon");
			    	polygon_cds.setAttribute('style', 'fill:#e2b095');
			    	polygon_cds.setAttributeNS(null, 'points', `\${cds_start_relative+4},0 \${cds_end_relative+4},0 \${cds_end_relative+4},18, \${cds_start_relative+4},18`);
				    svg.append(polygon_cds);
			    }
			    
			    
			    const line = document.createElementNS(xmlns, "line");
			    line.setAttribute('style', 'stroke:#000000;')
			    line.setAttributeNS(null, 'x1', '4');
			    line.setAttributeNS(null, 'y1', '8');
			    line.setAttributeNS(null, 'x2', `\${mRNA_width+4}`);
			    line.setAttributeNS(null, 'y2', '8');
			    
			    svg.appendChild(line);
			    
			    
			    const polygon = document.createElementNS(xmlns, "polygon");
			    polygon.setAttribute('style', 'fill:#000000');
			    if(strand == '+') {
			    	polygon.setAttributeNS(null, 'points', `\${mRNA_width+4},5 \${mRNA_width+4},11 \${mRNA_width+9},8`)
			    } else if(strand == '-') {
			    	polygon.setAttributeNS(null, 'points', '0,8 5,5 5,11')
			    }
			    
			    svg.appendChild(polygon);
			    return svg;
				
			}
			
			const svg = createSVG(mRNA_start, mRNA_end, mRNA_width, strand, svg_CDS);
			//console.log(svg);
			
			//data-bs-toggle="modal" data-bs-target="#exampleModal"
			
			const childDiv = document.createElement('div');
			childDiv.title = "Gene Info";
			childDiv.dataset.mRNA_id = mRNA_id;
			childDiv.dataset.bsToggle = "modal";
			childDiv.dataset.bsTarget = "#geneInfoModal";
			
			childDiv.dataset.toggle = mRNA_id;
			childDiv.dataset.html = "true";
			childDiv.dataset.placement = "right";
			childDiv.dataset.trigger = "hover";
			
			let popoverContent = `
									Current Position : \${selected_position}<br>
									Start : \${mRNA_start}<br>
									End : \${mRNA_end}<br>
									Strand : \${strand}<br>
									CDS : <br>
									`;
			
			for(let i=0 ; i<svg_CDS.length ; i++) {
				popoverContent += `\${i+1} : \${svg_CDS[i]['start']} - \${svg_CDS[i]['end']}<br>`
			}
			popoverContent += `Attribute : \${gene_model['mRNA'][i]['attribute']}`;
									
			childDiv.dataset.content = popoverContent;
			childDiv.style.position = 'absolute';
			childDiv.style.top = '25px';
			childDiv.style.right = (-(mRNA_width+4) / 2) + 'px';
			childDiv.appendChild(svg);
			selectedGeneModelDiv.appendChild(childDiv);
			$(`[data-toggle="\${mRNA_id}"]`).popover();
			//selectedGeneModelDiv.appendChild(svg);
			
			
			
		}
		
		
	}
	
	async function getFetchData(url, map_params) {
		
		for(const [key, value] of map_params) {
			url.searchParams.set(key, value);
		}
		
		return await fetch(url).then((response)=> response.json());
	}
	
	function selectedOption(id) {
		const selectEl = document.getElementById(id);
		return selectEl[selectEl.selectedIndex];
	}
	
	function setSVG(childDiv) {
		
		console.log(childDiv);
		
		return `<svg width="81.760757" height="11.519"
					viewBox="0 0 21.632545 3.047735" version="1.1" id="svg117"
					xmlns="http://www.w3.org/2000/svg"
					xmlns:svg="http://www.w3.org/2000/svg">
						<g transform="translate(-0.89341089,-1.3147886)">
				   		<path
							style="fill:#c4bd97;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.264583"
							d="m 3.0536216,1.3147886 v 3.047842 h 4.360107 v -3.047842 z"
							/>
				   		<path
							style="fill:#c4bd97;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.264583"
							d="m 9.4032916,1.3147886 v 3.047842 h 1.9895634 v -3.047842 z"
							/>
				   		<path
							style="fill:#c4bd97;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.264583"
							d="m 19.097122,1.3147886 v 3.047842 h 3.428822 v -3.047842 z"
							/>
				   		<path
							style="fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:#000000;stroke-width:0.0026457px;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
							d="M 22.356619,2.5847226 H 2.6594126 v 0.253987 H 22.356619 Z M 3.0112906,1.6534376 0.89473358,2.7117166 3.0112906,3.7699946 Z"
							/>
						</g>
				</svg> 
				`;
	}
	
	function getVariantBrowserGrid() {
		const position = document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.position;
		const chrSelectEl = document.getElementById('Chr_select');
		const chr = chrSelectEl.options[chrSelectEl.selectedIndex].dataset.chr;
		
		const vcf_id = document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.vcf_id;
		
		//console.log(position);
		//console.log(chr);
		//console.time("showVB");
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
    					sortable: false,
    					pinned: 'left',
    				}) 
    			} else {
    				VariantBrowser_columnDefs.push({
    					headerName: columnKeys[i].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
    					field: columnKeys[i], 
    					//headerClass: "ag-right-aligned-header",
    					width: 30,
    					sortable: true,
    					sortingOrder: ['desc', null],
    					
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
    		
    		
    		const isChecked = document.getElementById('switch_sort_UPGMA');
    		// Sort switch가 켜져있다면 ID기준으로 정렬하여 재출력
    		if(isChecked.checked) {
       			sort_vb_by_UPGMA();
       		} 
    		
    		//console.timeEnd("showVB");
    	})
    	.catch((error) => {
    		console.log(error);
    		VariantBrowser_gridOptions.api.setRowData([]);
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
			//console.log(data);
			
			SnpEff_gridOptions.api.setRowData(data);
			SnpEff_gridOptions.columnApi.autoSizeAllColumns();
			
			
		})
		.catch((error) => {
			console.log(error);
		})
		
		console.timeEnd("SnpEff_Grid");
		
	}
	
	function SnpEff_mark() {
		
		console.time("snpMark");
		
		clear_mark_snpEff();
		
		const chr_select = document.getElementById('Chr_select')
		const length = chr_select[chr_select.selectedIndex].dataset.length 
		const marked_SnpEff = SnpEff_gridOptions.api.getSelectedRows();
		
		//console.log(marked_SnpEff);
		//console.log(length);
		
		if(marked_SnpEff.length == 0) {
			return;
		}
		
		for(let i=0 ; i<marked_SnpEff.length ; i++) {
			
			const mark_pos = Number(marked_SnpEff[i].pos);
			//console.log(mark_pos);
			//console.log(parseInt(mark_pos * 1000 / length));
			
			//const mark = document.querySelector(`.chromosomeStackDiv[data-position="\${marked_SnpEff[i].pos}"]`);
			const mark = document.querySelector(`.chromosomeStackDiv[data-order="\${parseInt(mark_pos * 2000 / length)}"]`);
			//console.log(mark);
			
			const mark_data_order = mark.dataset.order;
			
			if(!document.querySelector(`[data-snpeff_order="\${mark_data_order}"]`)){
				const childDiv = document.createElement('div');
				childDiv.dataset.snpeff_order = mark_data_order;
				childDiv.style.position = "absolute";
				childDiv.style.bottom = "13px";
				childDiv.style.right = "-3px";
				childDiv.innerHTML = `<svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#0073E5;" /></svg>`;
				
				mark.appendChild(childDiv);
			}
			
			
			//mark.innerHTML = `<div data-snpEff_order=\${i} style="position: absolute; bottom: 15px; right: -3px;" ><svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#0073E5;" /></svg></div>`;
		}
		console.timeEnd("snpMark");
	}
	
	function clear_mark_snpEff() {
		// 선택되어있는 snpEff 표지를 모두 지움
		document.querySelectorAll(`[data-snpEff_order]`).forEach((El) => {
			El.remove();
		})
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
		
		
		
		/*
		const impact = SnpEff_gridOptions.api.getFilterInstance('impact');
		impact.setModel({values: ['HIGH', 'LOW']});
		impact.applyModel();
		*/
		SnpEff_gridOptions.api.setFilterModel(impactFilter);
		SnpEff_gridOptions.api.onFilterChanged();
		//SnpEff_gridOptions.api.deselectAll();
		
		// filtered-out이면 deselect
		SnpEff_gridOptions.api.forEachNode((node) => {
			if(node.displayed == false) {
				node.setSelected(false)
			} 
		})
	}
   	
	
   	function getGwasSelectList() {
   		fetch(`./vb_getSelectLists.jsp?command=GWAS&jobid=\${linkedJobid}`)
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
			
			$(`#GWAS_pill_\${model[i]}`).append(`<div class='row mt-1'><div id='GWAS_Grid_\${model[i]}' class='col-12 ag-theme-alpine' style='height:664px; padding-right:28px;' ></div></div>`); 
			
			const GWAS_gridTable = document.getElementById(`GWAS_Grid_\${model[i]}`);
			GWAS_gridOptions_model[model[i]] = Object.assign({},GWAS_gridOptions);
			
			const GWAS_Grid = new agGrid.Grid(GWAS_gridTable, GWAS_gridOptions_model[model[i]]);
			//GWAS_gridOptions_model[model[i]].api.setRowData([{}])
			//GWAS_gridOptions_model[model[i]].api.sizeColumnsToFit();
			
			// data가 출력되기 전에는 display='none' & 아이콘 출력
			GWAS_gridTable.style.display = 'none';
		}
   		
   	}
   	
   	//function show_GWAS_Grid (HTML_element) {
   	function show_GWAS_Grid() {
		
   		//console.log("onchange");
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
			GWAS_gridOptions_model[model].api.setRowData(data);
			//GWAS_gridOptions_model[model].api.sizeColumnsToFit();
			
			const GWAS_gridTable = document.getElementById(`GWAS_Grid_\${model}`);
			GWAS_gridTable.style.display = 'block';
			
			GWAS_gridOptions_model[model].columnApi.autoSizeAllColumns();
			
		})
		.catch((error) => {
			console.log(error);
		});

   	}
   	
   	function GWAS_mark() {
   		console.time("gwasMark");
		
   		clear_mark_GWAS();
		
		const chr_select = document.getElementById('Chr_select')
		const length = chr_select[chr_select.selectedIndex].dataset.length;
		
		const selected_model = document.querySelector('#GWAS_button_list .active').dataset.model;
		//console.log(selected_model);

		const GWAS_model = GWAS_gridOptions_model[selected_model]; 
		const GWAS_marked_rows = GWAS_model.api.getSelectedRows();
		
		//console.log(GWAS_marked_rows);
		//console.log(length);
		
		if(GWAS_marked_rows.length == 0) {
			return;
		}
		
		for(let i=0 ; i<GWAS_marked_rows.length ; i++) {
			
			const mark_pos = Number(GWAS_marked_rows[i]['Pos']);
			//console.log(mark_pos);
			//console.log(parseInt(mark_pos * 1000 / length));
			
			const mark = document.querySelector(`.chromosomeStackDiv[data-order="\${parseInt(mark_pos * 2000 / length)}"]`);
			//console.log(mark);
			
			const mark_data_order = mark.dataset.order;
			
			if(!document.querySelector(`[data-gwas_order="\${mark_data_order}"]`)){
				const childDiv = document.createElement('div');
				childDiv.dataset.gwas_order = mark_data_order;
				childDiv.style.position = "absolute";
				childDiv.style.bottom = "19px";
				childDiv.style.right = "-3px";
				childDiv.innerHTML = `<svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#2cb637;" /></svg>`;
				
				mark.appendChild(childDiv);
			}
			
			
			
			//mark.innerHTML = `<div data-GWAS_order=\${i} style="position: absolute; bottom: 25px; right: -3px;" ><svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#2cb637;" /></svg></div>`;
		}
		console.timeEnd("gwasMark");
   	}
   	
   	function clear_mark_GWAS() {
		//선택되어있는 표지를 모두 지움
		document.querySelectorAll(`[data-GWAS_order]`).forEach((El) => {
			El.remove();
		})
   	}
   	
   	function clear_mark_all() {
   		clear_mark_snpEff();
   		clear_mark_GWAS();
   	}
   	
   	
   	function getUpgmaSelectList() {
   		fetch(`./vb_getSelectLists.jsp?command=UPGMA&jobid=\${linkedJobid}`)
   		.then((response) => response.json())
   		.then((data) => {
   			console.log(data);
   			for(let i=0 ; i<data.length ; i++) {
  				// ${data}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
  				$("#UPGMA_select").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} > \${data[i].comment} (\${data[i].cre_dt}) </option>`);
  			}
   		});
   	}
   	
   	function show_UPGMA_Grid() {
   		const upgma_select = document.getElementById('UPGMA_select');
   		const upgma_jobid = upgma_select[upgma_select.selectedIndex].dataset.jobid;
   	
   		fetch(`./vb_features_grid_UPGMA.jsp?jobid=\${upgma_jobid}`)
   		.then((response) => response.json())
   		.then((data) => {
   			//console.log(data);
   			
   			UPGMA_gridOptions.api.setRowData(data);
   			UPGMA_gridOptions.api.sizeColumnsToFit();
   			
   			sort_vb_by_UPGMA();
   		});
   	}
   	
   	function getUpgmaStandardList() {
   		
   		
   		const upgma_select = document.getElementById('UPGMA_select');
   		const upgma_jobid = upgma_select[upgma_select.selectedIndex].dataset.jobid;
   	
   		fetch(`./vb_getSelectLists.jsp?command=UPGMA_standard&jobid=\${upgma_jobid}`)
   		.then((response) => response.json())
   		.then((data) => {
   			//console.log(data);
   			
   			const standard_select = document.getElementById('Standard_select');
   			
   			// child(=options) 제거
   			while(standard_select.firstChild) {
   				standard_select.lastChild.remove();
   			}
   			
   			// child(=options) 추가
   			for(let i=-1 ; i<data.length ; i++) {
  				//$("#Standard_select").append(`<option data-id=\${data[i].id} > \${data[i].id} </option>`);
  				
				const option = document.createElement("option");
  				if(i==-1) {
  	  				option.dataset.id = -1;
  	  				option.hidden = true;
  	  				option.disabled = true;
  	  				option.selected = true;
  	  				option.innerText = "Standard";
  				} else {
  	  				option.dataset.id = data[i]['id'];
  	  				option.innerText = data[i]['id'];
  				}
  				
  				standard_select.append(option);
  			}
   			
   			//UPGMA_gridOptions.api.setRowData(data);
   			//UPGMA_gridOptions.columnApi.autoSizeAllColumns();
   		});
   		
   	}
   	
   	function sort_distanceMatrix_UPGMA() {
   		
   		const upgma_select = document.getElementById('UPGMA_select');
   		const upgma_jobid = upgma_select[upgma_select.selectedIndex].dataset.jobid;
   		
   		const standard_select = document.getElementById('Standard_select');
   		const standard_id = standard_select[standard_select.selectedIndex].dataset.id;
   		
   		fetch(`./vb_features_sort_distanceMatrix_UPGMA.jsp?standard_id=\${standard_id}&upgma_jobid=\${upgma_jobid}`)
   		.then(() => {
   			show_UPGMA_Grid();
   			
   			sort_vb_by_UPGMA();
   		})
   	}
   	
   	function isSorted_by_UPGMA(checked) {
   		
   		const UPGMA_select = document.getElementById('UPGMA_select');
   		//const Standard_select = document.getElementById('Standard_select');
   		
   		//if(UPGMA_select[UPGMA_select.selectedIndex].dataset.jobid == '-1' || Standard_select[Standard_select.selectedIndex].dataset.jobid == '-1') {
   		if(UPGMA_select[UPGMA_select.selectedIndex].dataset.jobid == '-1' ) {
   			return;
   		}
   		
   		console.log(checked);
   		if(checked) {
   			sort_vb_by_UPGMA();
   		} else {
   			getVariantBrowserGrid();
   		}
   	}
   	
   	function sort_vb_by_UPGMA() {
   		
   		/*
   		// Reset 비활성. UPGMA Grid id값에 맞춰 vb 정렬
   		document.getElementById('reset_UPGMA').dataset.reset = "false";
   		*/
   		if(!document.getElementById('switch_sort_UPGMA').checked) {
   			return;
   		}
   		
   		console.time("sort_vb_by_UPGMA");
   		
   		let id_arr = new Array();
   		
   		UPGMA_gridOptions.api.forEachNode((node) => {
   			//console.log(node.data.id);
   			id_arr.push(node.data.id);
   		})
   		
   		console.log(id_arr);
   		
   		// 첫 row(=Reference는 무조건 고정)
   		//let updatedNodes = [VariantBrowser_gridOptions.api.getRowNode(0)];
   		let updatedNodesData = [VariantBrowser_gridOptions.api.getRowNode(0).data];
   		
   		for(let i=0 ; i<id_arr.length ; i++) {
   			VariantBrowser_gridOptions.api.forEachNode((node) => {
   				if(node.data.id == id_arr[i]) {
   					updatedNodesData.push(node.data);
   				}
   			})
   		}
   		
   		console.log(updatedNodesData);
   		
   		/*
   		VariantBrowser_gridOptions.api.applyTransaction({remove: updatedNodesData});
   		VariantBrowser_gridOptions.api.applyTransaction({add: updatedNodesData});
   		*/
   		VariantBrowser_gridOptions.api.setRowData(updatedNodesData);
   		console.timeEnd("sort_vb_by_UPGMA");
   	}
   	
   	function resetSort_UPGMA() {
   		// UPGMA Reset 버튼
   		document.getElementById('reset_UPGMA').dataset = "true";
   	}
   	
   	function resizeGrid() {
   		
				
   		setTimeout( () => {
			SnpEff_gridOptions.columnApi.autoSizeAllColumns();
			
			if(Object.keys(GWAS_gridOptions_model).length !== 0) {
				for(const GWAS_gridOptions in GWAS_gridOptions_model) {
					GWAS_gridOptions.columnApi.autoSizeAllColumns();
				}
			}
			
		}, 200)
				
   	}
   	
   	
</script>

</body>
<!-- END: Body-->

</html>