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
    
    <link rel="stylesheet" type="text/css" href="../../css/index_assets/css/icons.min.css">
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
	/*
	#VariantBrowserGrid .ag-header-cell-label .ag-header-cell-text {
	    writing-mode: vertical-lr;
	}
	*/
	
	.grid-header-red {
		color: red;
		/*animation: blink 1s 5;*/
		/*
		animation-name: blink;
		animation-duration: 1s;
		animation-iteration-count: 5;
		*/
	}
	
	@-webkit-keyframes blink {
  		0%, 49% {
    		/*background-color: #eedac2;*/
    		color: red;
  		}
	  	50%, 100% {
	    	/*background-color: #e50000;*/
	    	color: black;
		}
		
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
		justify-content: space-between;
	}
	
	.chromosomeStackDiv, .chromosomeDetailedStackDiv {
		width: 1px;
		height: 18px;
		border-top: 1px solid black;
		border-bottom: 1px solid black;
		display: inline-block;
		position: relative;
	}
	.chromosomeStackDiv[data-position], .chromosomeDetailedStackDiv[data-position] {
		background-color: #bcbcbc;
	}
	.chromosomeStackDiv[data-order="0"], .chromosomeDetailedStackDiv[data-order="0"],
	.chromosomeStackDiv[data-order="1999"], .chromosomeDetailedStackDiv[data-order="1999"] {
		background-color: black;
		z-index: 2;
	}
	.chromosomeStackDiv[data-selected="true"],
	.chromosomeDetailedStackDiv[data-order="1000"] {
		 background-color: red !important;
		z-index: 3;
	}
	
	/*
	@media(max-width: 762px) {
		.verticalLtrMedia762 {
			transform: rotate(0.25turn);
			transform-origin: 24%;
			top: 15px;
		}
	}
	*/
	
	
	#chromosomeScaleBarDiv {
		margin: 3px 5% auto;
		padding: 0px; 
		width: 90%; 
		height: 10px; 
		display: flex; 
		justify-content: space-between;
		
	}
	
	.chromosomeScaleBarStackDiv {
		width: 1px;
		height: 5px;
		/*border-bottom: 1px solid black;*/
		display: inline-block;
	}
	
	.chromosomeScaleBarStackDiv[data-order="0"], .chromosomeScaleBarStackDiv[data-order="99"], .chromosomeScaleBarStackDiv[data-order="199"], .chromosomeScaleBarStackDiv[data-order="299"],
	.chromosomeScaleBarStackDiv[data-order="399"], .chromosomeScaleBarStackDiv[data-order="499"], .chromosomeScaleBarStackDiv[data-order="599"], .chromosomeScaleBarStackDiv[data-order="699"],
	.chromosomeScaleBarStackDiv[data-order="799"], .chromosomeScaleBarStackDiv[data-order="899"], .chromosomeScaleBarStackDiv[data-order="999"], .chromosomeScaleBarStackDiv[data-order="1099"],
	.chromosomeScaleBarStackDiv[data-order="1199"], .chromosomeScaleBarStackDiv[data-order="1299"], .chromosomeScaleBarStackDiv[data-order="1399"], .chromosomeScaleBarStackDiv[data-order="1499"], 
	.chromosomeScaleBarStackDiv[data-order="1599"], .chromosomeScaleBarStackDiv[data-order="1699"], .chromosomeScaleBarStackDiv[data-order="1799"], .chromosomeScaleBarStackDiv[data-order="1899"],
	.chromosomeScaleBarStackDiv[data-order="1999"] {
		position: relative;
		background-color: #bcbcbc;
	}
	
	#VariantBrowserGrid {
		--ag-font-size: 12px !important;
		--ag-cell-horizontal-padding: 0px !important;
		--ag-widget-horizontal-spacing: 0px !important;
		--ag-widget-vertical-spacing: 0px !important;
	}
	
	input::placeholder {
		color: #ccc;
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
	String filename = request.getParameter("filename");
	String fasta_filename = request.getParameter("fasta_filename");
	String gff_filename = request.getParameter("gff_filename");
	String cds_filename = request.getParameter("cds_filename");
	String protein_filename = request.getParameter("protein_filename");
	String annotation_filename = request.getParameter("annotation_filename");
	String varietyid = request.getParameter("varietyid");
	
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">
	
	<%-- 
    <jsp:include page="../../css/topmenu.jsp" flush="true"/>
	
	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="vb"/>
	</jsp:include>
	--%>
	<!-- Header -->
    <nav class="header-navbar navbar-expand-lg navbar navbar-with-menu navbar-fixed navbar-shadow navbar-brand-center">
        <div class="navbar-wrapper">
            <div class="navbar-container content">
                <div class="navbar-collapse" id="navbar-mobile">
                    <div class="mr-auto float-left bookmark-wrapper d-flex align-items-center">
                    	<div style="width:20%; min-width:200px; margin-left:10px; padding-left:13px; font-family: 'SDSamliphopangche_Outline'"> 
							<select id='Chr_select' class='select2 form-select float-left'  onChange="clear_mark_all(); selectChr(this); show_SnpEff_Grid(); show_GWAS_Grid(); ">
							</select>
						</div>
						<div style="width:20%; min-width:250px; padding-left:14px;"> 
							<input type="text" id="positionInput" class="form-control" style="width:180px; display:inline; font-family: 'SDSamliphopangche_Outline';" placeholder="Position" autocomplete="off" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1').replace(/\B(?=(\d{3})+(?!\d))/g, ',');" onkeyup="if(event.keyCode==13){this.blur();}" onblur="changeInputValue(Number(this.value.replaceAll(',','')));">
							<span style="margin-left:3px;">bp</span>
						</div>
                    </div>
					<div class="btn-group" role="group" aria-label="Basic example">
						<button type="button" id="beforeOrder" class="btn btn-sm" style="margin:8px 0; color:white; background-color:#23cac4; font-size:15px;" data-toggle="popover" data-trigger="hover" data-placement="bottom" data-content="Display 기준 왼쪽 변이로 이동합니다." onclick="previousOrder(this.dataset.vcf_id, this.dataset.order);">
							<i class="bx bx-rewind"></i>
						</button>
						<button type="button" id="beforeId" class="btn btn-sm" style="margin:8px 0; color:white; background-color:#23cac4; font-size:15px;" data-toggle="popover" data-trigger="hover" data-placement="bottom" data-content="Position 기준 왼쪽 변이로 이동합니다." onclick="previousPosition(this.dataset.index, this.dataset.vcf_id, this.dataset.position, this.dataset.order);">
							<i class="bx bx-skip-previous"></i>
						</button>
						<button type="button" id="currentId" style="display:none;"></button>
						<button type="button" id="afterId" class="btn btn-sm" style="margin:8px 0; color:white; background-color:#23cac4; font-size:15px;" data-toggle="popover" data-trigger="hover" data-placement="bottom" data-content="Position 기준 오른쪽 변이로 이동합니다." onclick="nextPosition(this.dataset.index, this.dataset.vcf_id, this.dataset.position, this.dataset.order);">
							<i class="bx bx-skip-next"></i>
						</button>
						<button type="button" id="afterOrder" class="btn btn-sm" style="margin:8px 15px 8px 0; border-radius:0 5px 5px 0; color:white; background-color:#23cac4; font-size:15px;" data-toggle="popover" data-trigger="hover" data-placement="bottom" data-content="Display 기준 오른쪽 변이로 이동합니다." onclick="nextOrder(this.dataset.vcf_id, this.dataset.order);"> 
							<i class="bx bx-fast-forward"></i> 
						</button>
						<button type="button" id="loci" class="btn btn-outline-success" style="width:145px; margin:8px 0 8px 0; border-radius:0;" onclick="expandAndCollapseSide('side1'); expandAndCollapseMain(); resizeGrid();">Loci Info</button>
						<button type="button" id="cluster" class="btn" style="width:145px; margin:8px 0 8px -1px; color: #2da0ed; background-color:#ffffff; border:1px solid #2da0ed; border-radius:0;" onclick="expandAndCollapseSide('side2'); expandAndCollapseMain(); resizeGrid();">Cluster Info</button>
					</div>
                </div>
            </div>
        </div>
    </nav>
	
    <!-- BEGIN: Content-->
    <div class="app-content content" style="padding-top: 30px;">
        <div class="content-overlay"></div>
        <div class="content-wrapper" style="position:relative;">
        	<!--  
        	<div style="position: absolute; top: 50px; right: -25px;">
				<button type="button" class="btn btn-success sideButton" onclick="expandAndCollapseSide('side1'); expandAndCollapseMain(); resizeGrid();">Loci</button>
			</div>
			<div style="position: absolute; top: 130px; right: -25px;">
				<button type="button" class="btn sideButton" style="color: #ffffff; background-color:#2da0ed;" onclick="expandAndCollapseSide('side2'); expandAndCollapseMain(); resizeGrid();">Cluster</button>
			</div>
			-->
            <div class="content-body">
                <!-- Basic example section start -->
                <section id="basic-examples">
                    <div class="card mb-0">
                        <div class="card-content">
                            <div class="card-body pt-0 pb-0">
                                <div class="row justify-content-between">
	                                <div id="main" class="expandAndCollapse expandMain" style="position: relative;">
	                                	<!-- right side 고정버튼 -->
	                                	<!--  
	                                	<div style="position: absolute; top: 25px; right: -25px;">
											<button type="button" class="btn btn-success sideButton" onclick="expandAndCollapseSide('side1'); expandAndCollapseMain(); resizeGrid();">Loci</button>
										</div>
										<div style="position: absolute; top: 105px; right: -25px;">
											<button type="button" class="btn sideButton" style="color: #ffffff; background-color:#2da0ed;" onclick="expandAndCollapseSide('side2'); expandAndCollapseMain(); resizeGrid();">Cluster</button>
										</div>
										-->
	                                	<div class="row" style="margin-top: 0px; margin-bottom:0px;">
	                                		<fieldset class="border pt-2 pl-2 pr-2 pb-1 pb-3" style="width:96%; margin-left:23px; margin-right:23px;">
	                                			<legend  class="w-auto">Reference : <%=refgenome %></legend>
		                                		<div id="chromosomeDiv"></div>
		                                		<div id="chromosomeScaleBarDiv">
		                                		</div>
	                                		</fieldset>
	                                	</div>
	                                	<div class="row">
	                                		<fieldset class="border mt-1 mb-2 pt-2 pl-2 pr-2" style="width:96%; margin-left:23px; margin-right:23px; padding-bottom:85px;">
	                                			<legend  class="w-auto">Gene Model</legend>
		                                		<div id="chromosomeDetailedDiv"></div>
	                                		</fieldset>
	                                	</div>
	                                	<div class="row" style="position:relative;">
	                                		<div style="position:absolute; bottom:-14px; margin: 0px 23px; width: 96%;">
	                                			<svg id="connection" width="100%" height="35" xmlns:svg="http://www.w3.org/2000/svg"></svg>
	                                		</div>
	                                	</div>
	                                	<div class="row">
				                            <div id="VariantBrowserGrid" class="ag-theme-alpine" style="margin: 13px 23px; width: 96%; height:415px;"></div><br>
	                                	</div>
	                                </div>
	                                <div id="sideRow" class="expandAndCollapse small" style="border-left: 1px solid #E9E9E9;">
		                                <div class="row">
		                                	<div id="side1" class="expandAndCollapse small">
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
											            		<button type="button" class="btn btn-outline-warning mb-1" style="margin-right:5px;" onclick="clear_mark_snpEff();">Reset</button>
											            	</div>
															<div class="float-right">
											            		<button type="button" class="btn btn-outline-success mb-1" style="margin-right:30px;" onclick="SnpEff_mark();">표지</button>
											            	</div>
														</div>
									            		<div class="row col-12 pl-0" style="margin-left:0px;">
															<div id='SnpEff_Grid' class="ag-theme-alpine" style="height:760px; width:100%; display:none;"></div>
														</div>
														<div id="SnpEff_Not_Exist" class="row col-12 pl-0" style="height:500px; margin-left:0px; display:none; justify-content:center; align-content:center; font-size: 25px;">
															연관된 SNP 정보를 찾을 수 없습니다.
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
															<div class="col-6 pr-0">
																<div class="float-right">
												            		<button type="button" class="btn btn-outline-success float-right" style="margin-right:30px;" onclick="GWAS_mark();">표지</button>
												            	</div>
																<div class="float-right">
												            		<button type="button" class="btn btn-outline-warning mb-1" style="margin-right:7px;" onclick="clear_mark_GWAS();">Reset</button>
												            	</div>
											            	</div>
														</div>
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
														<div id="nonSelectGWAS" class="row mt-1" style="display:block;">
															<!--  
															<div class="col-12" style="display: flex; flex-direction: column; align-items: center;">
																<i class="ri-file-search-line" style=" font-size: 355px;"></i>
																<p style="margin-top:-25px; font-size: 30px;">Please select a result</p>
															</div>
															-->
															<div class="col-12" style="height:500px; display: flex; align-items: center; justify-content: center;">
																<p style="margin-top:80px; font-size: 30px;">Please select a result</p>
															</div>
														</div>
														<div id="status404" class="row mt-1" style="display:none;">
															<div class="col-12" style="margin-top:70px; display: flex; flex-direction: column; align-items: center;">
																<!--  
																<svg xmlns="http://www.w3.org/2000/svg" width="280" height="280" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
																	<path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
																	<line x1="12" y1="9" x2="12" y2="13"></line>
																	<line x1="12" y1="17" x2="12.01" y2="17"></line>
																</svg>
																-->
																<p style="margin-top:170px; font-size: 25px;">표현형과의 유사성을 찾을 수 없습니다.</p>
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
											            		<button type="button" class="btn btn-outline-success mb-1" style="margin-right:30px;" onclick="marker_mark();">표지</button>
											            	</div>
	  													</div>
	  													
									            		<div class="row mt-1">
	  														<div id='Marker_Grid' class="ag-theme-alpine" style="height:745px; width:100%; padding-left:14px; padding-right: 28px;"></div>
	  													</div>
	  												</div>
	  												<!-- Selection pill -->
	  												<div class='tab-pane pl-1' id='pill4' aria-labelledby='base-pill4'>
														<div class="row mt-1">
									            			<div class="col-12">
									            				<!--  
											            		<button type="button" class="btn btn-light mb-1" style="margin-left:13px; margin-right:15px;" onclick="flanking_sequence();">Flanking sequence</button>
											            		-->
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:5px; float:left; background-color:#7367F0 !important; color:#FFFFFF;" onclick=" if(SelectionList_gridOptions.api.getSelectedNodes().length != 1) {return alert('position을 하나만 선택해주세요.')} $('#flankingSequenceModal').modal();">Sequence</button>
											            		<button type="button" class="btn btn-light mb-1" style="margin-left:5px; margin-right:auto; float:left; background-color:#7367F0 !important; color:#FFFFFF;" onclick=" if(SelectionList_gridOptions.api.getSelectedRows().length == 0) {return alert('position을 1개 이상 선택해주세요.');} $('#Primer_Design').modal()">Primer Design</button>
											            		<button type="button" class="btn btn-outline-success mb-1" style="margin-left:5px; margin-right:15px; float:right;" onclick="selection_mark();">표지</button>
											            		<button type="button" class="btn btn-outline-warning mb-1" style="margin-left:13px; margin-right:5px; float:right;" onclick="clear_mark_all();">Reset</button>
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
  		<div class="modal-dialog modal-dialog-scrollable modal-lg">
    		<div class="modal-content">
      			<div class="modal-header bg-warning white">
	    		    <h4 class="modal-title fs-5" id="exampleModalLabel">Gene data</h4>
   				    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
      			</div>
	      		<div class="modal-body">
	        		<div>
	        			<h4 class="mb-1">Primary data</h4>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">Name</label>
	        				<p id="pd_name" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">Position</label>
	        				<p id="pd_position" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">Length</label>
	        				<p id="pd_length" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">Start</label>
	        				<p id="pd_start" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">End</label>
	        				<p id="pd_end" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">Strand</label>
	        				<p id="pd_strand" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">CDS</label>
	        				<p id="pd_cds" style="margin-left:1px;"></p>
	        			</div>
	        		</div>
	        		<div>
	        			<h4 class="mb-1">Attributes</h4>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">ID</label>
	        				<p id="attributes_id" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">Parent</label>
	        				<p id="attributes_parent" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">Description</label>
	        				<p id="attributes_description" style="margin-left:1px;"></p>
	        			</div>
	        			<div class="">
	        				<label class="h5 pl-0" style="margin-bottom:3px;">RefSeq</label>
	        				<p id="attributes_refSeq" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">UniProt</label>
	        				<p id="attributes_uniProt" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">Pfam</label>
	        				<p id="attributes_pfam" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">TAIR</label>
	        				<p id="attributes_tair" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">GO</label>
	        				<p id="attributes_go" style="margin-left:1px;"></p>
	        			</div>
	        			<div>
	        				<label class="h5 pl-0" style="margin-bottom:3px;">KEGG</label>
	        				<p id="attributes_kegg" style="margin-left:1px;"></p>
	        			</div>
	        		</div>
	        		<div class="form-group">
					    <label for="gene_sequence" class="h5 pl-0">Gene sequence</label>
					    <span style="color:#7367F0; text-decoration:underline; cursor: pointer;" onclick="copyToClipboard('gene_sequence')"> Copy</span>
					    <textarea class="form-control" id="gene_sequence" rows="3" data-label_text="Gene sequence"></textarea>
					</div>
	        		<div class="form-group">
					    <label for="cds_sequence" class="h5 pl-0">CDS sequence</label>
					    <span style="color:#7367F0; text-decoration:underline; cursor: pointer;" onclick="copyToClipboard('cds_sequence')"> Copy</span>
					    <textarea class="form-control" id="cds_sequence" rows="3" data-label_text="CDS sequence"></textarea>
					</div>
	        		<div class="form-group">
					    <label for="protein_sequence" class="h5 pl-0">Protein sequence</label>
					    <span style="color:#7367F0; text-decoration:underline; cursor: pointer;" onclick="copyToClipboard('protein_sequence')"> Copy</span>
					    <textarea class="form-control" id="protein_sequence" rows="3" data-label_text="Protein sequence"></textarea>
					</div>
	      		</div>
	    	</div>
	  	</div>
	</div>
	
	
	<div class="modal fade" id="flankingSequenceModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered modal-sm">
    		<div class="modal-content">
      			<div class="modal-header bg-warning white">
	    		    <h4 class="modal-title fs-5">Window Size</h4>
   				    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
      			</div>
	      		<div class="modal-body">
	        		<div class="row">
		        		<div class="col-5" style="margin:15px 0 15px auto;">
						    <input class="form-control" id="flankingSequence" style="font-size:14px;" oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1').replace(/\B(?=(\d{3})+(?!\d))/g, ',');" autocomplete="off" />
						</div>
						<div class="col-2 pl-0" style="margin:0 auto 0 0; font-size:14px; display: flex; align-items: center">
						    bp
						</div>
	        		</div>
	      		</div>
	      		<div class="modal-footer">
	      			<button type="button" class="btn btn-success" onclick="flanking_sequence();" >Extraction</button>
	      			<!--  
			        <button type="button" class="btn btn-secondary" data-bs-dismiss="modal">Close</button>
			        -->
	      		</div>
	    	</div>
	  	</div>
	</div>
	
	<div class="modal fade" id="flankingSequenceSizeModal" tabindex="-1" aria-labelledby="exampleModalLabel" aria-hidden="true">
  		<div class="modal-dialog modal-dialog-centered modal-lg">
    		<div class="modal-content">
    			<div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">Sequence</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
	      		<div class="modal-body">
	        		<div class="col-12" style="margin:15px auto;">
					    <!--    
					    <textarea rows="20" class="form-control" style="font-size:14px;" readonly></textarea>
					    -->
					    <div class="form-control" id="sequenceSize" style="height: 200px; font-size:14px; word-break:break-all; overflow: scroll;" readonly></div>
					</div>
	      		</div>
	      		<div class="modal-footer">
	      			<button type="button" class="btn btn-outline-dark" onclick="copyToClipboard('sequenceSize')" >Copy to Clipboard</button>
	      			<button type="button" id="sequenceDownload" class="btn btn-success" onclick="downloadFlankingSequenceCSV(this.dataset.jobid)" >Download</button>
	      		</div>
	    	</div>
	  	</div>
	</div>
	
	<div class="modal fade text-left" id="Primer_Design" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true" data-backdrop="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">Primer Design New Analysis</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadForm">
					    <div class="form-body">
					        <div class="row p-1">
				            	<div class="col-12" style="display:flex; column-gap:12%;">
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="KASP" name='Category' value="KASP" onclick="onClickMarkerCategory(this.id); " checked/>
                                        <label class="form-check form-check-label" for="KASP" style="padding-top:1px; padding-left:15px;"  >KASP [200bp]</label>
					            	</div>
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="CAPs" name='Category' value="CAPs" onclick="onClickMarkerCategory(this.id);" />
                                        <label class="form-check form-check-label" for="CAPs" style="padding-top:1px; padding-left:15px;" >CAPs [500bp]</label>
					            	</div>
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="INDEL" name='Category' value="INDEL" onclick="onClickMarkerCategory(this.id);" disabled/>
                                        <label class="form-check form-check-label" for="INDEL" style="padding-top:1px; padding-left:15px;">INDEL</label>
					            	</div>
					            	<div class="col-2">
					            		<input type="radio" class="form-check-input" id="HRM" name='Category' value="HRM" onclick="onClickMarkerCategory(this.id);" disabled/>
                                        <label class="form-check form-check-label" for="HRM" style="padding-top:1px; padding-left:15px;">HRM</label>
					            	</div>
				            	</div>
				            </div>
				            <div class="row p-1">
				             	<div class="col-md-12 col-12">
					             	<div class="form-label-group">
					                	<input type="text" id="comment" name="comment" class="form-control" placeholder="Comment" autocomplete="off" required data-validation-required-message="This name field is required">						                     
					             		<label for="first-name-column"></label>
					                </div>
					            </div>
					        </div>
					        <div class="row pb-1 pl-1 pr-1">
					        	<fieldset class="border w-100 m-1 pt-1">
						        	<legend class="w-auto ml-1 mr-1">Option</legend>
							        <div id="Enzyme_Grid" class="ag-theme-alpine ml-1 mr-1" style="display:none;; margin: 0px auto; height:320px;"></div><br>
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
						            		<input type="text" class="form-control" id="Length_Min" name="Length_Min" value="18" />
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="Length_Max" name="Length_Max" value="22" />
						            	</div>
					            	</div>
					            	<div class="col-12 mb-1" style="display:flex;">
						            	<div class="col-4">
						            		Primer GCcontent
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="GCcontent_Min" name="GCcontent_Min" value="40" />
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="GCcontent_Max" name="GCcontent_Max" value="55" />
						            	</div>
					            	</div>
					            	<div class="col-12 mb-1" style="display:flex;">
						            	<div class="col-4">
						            		Primer TM
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="TM_Min" name="TM_Min" value="55" />
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="TM_Max" name="TM_Max" value="65" />
						            	</div>
					            	</div>
				            		<div class="col-12 mb-1" style="display:flex;">
						            	<div class="col-4">
						            		Product size
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="Size_Min" name="Size_Min" value="60" />
						            	</div>
						            	<div class="col-4">
						            		<input type="text" class="form-control" id="Size_Max" name="Size_Max" value="100" />
						            	</div>
					            	</div>
						        </fieldset>
					        </div>
					        <div class="row p-1">
					            <div class="col-12">
					                <button type="button" class="btn btn-success mb-1" style="float: right;" onclick="primerDesign();">Run</button>
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="resetForm();">Reset</button>
					            </div>
					        </div>
					    </div>
					</form>
                </div>
            </div>
        </div>
    </div>
	
	<div class="modal" id="loading" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
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
    <!--  
    <script src="../../css/app-assets/js/core/app.js"></script>
    <script src="../../css/app-assets/js/scripts/components.js"></script>
    -->
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
	const filename = "<%=filename%>";
	const fasta_filename = "<%=fasta_filename%>";
	const gff_filename = "<%=gff_filename%>";
	const cds_filename = "<%=cds_filename%>";
	const protein_filename = "<%=protein_filename%>";
	const annotation_filename = "<%=annotation_filename%>";
	const varietyid = "<%=varietyid%>";
	
	
	const chr_orders_map = new Map();
	const gene_model_position_map = new Map();
	
	(function() {
		console.time("IIFE")
		appendChromosomeDiv();
		appendChromosomeScaleBarDiv();
		appendChromosomeDetailedDiv();
		$('[data-toggle="popover"]').popover();
		console.timeEnd("IIFE")
	})();
	
	function copyToClipboard(id) {
		
		
		if(id == 'sequenceSize') {
			const textarea = document.createElement("textarea");
			textarea.textContent = document.querySelector(`#\${id}`).innerText;
			document.body.appendChild(textarea);
			textarea.focus();
			textarea.select();
			document.execCommand('copy');
			document.body.removeChild(textarea);
		} else {
			document.querySelector(`#\${id}`).select(); 
			document.execCommand('copy');
		}
		
		
		
		const label_text = document.getElementById(`\${id}`).dataset.label_text;
		
		if(label_text === undefined || label_text === null) {
			alert('sequence copied!')
		} else {
			alert(`\${label_text} copied!`);
		}
	}
	
	document.addEventListener('DOMContentLoaded', async function() {
		
  		await Promise.all([addChromosomeInfo(), show_Selection_Grid()]);
		document.getElementById("Chr_select").dispatchEvent(new Event("change"));
		
		getGwasSelectList();
		getUpgmaSelectList();
		//getStructureSelectList();
		
		
	})
	
	// 1000등분하여 div상에 출력
	function appendChromosomeDiv() {
		
		console.time("make2000Div");
		
		const chromosomeDiv = document.getElementById('chromosomeDiv');
		
		for(let i=0 ; i<=1999 ; i++) {
			
			const child = document.createElement('div');
			child.classList.add('chromosomeStackDiv');
			child.dataset.order = i;
			child.dataset.selected = false;
			
			chromosomeDiv.append(child);
		}
		
		
		console.timeEnd("make2000Div");
	}
	
	// 각각의 chrmosomeStackDiv에 클릭이벤트 추가
	document.querySelectorAll('.chromosomeStackDiv').forEach(El => {
		El.addEventListener('click', (e) => {
			
			if(e.composedPath()[0].classList[0] != 'chromosomeStackDiv') {
				return;
			}
			
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
				el.dataset.selected = "false";
			})
			
			const selectedDiv = e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`);
			selectedDiv.dataset.selected = 'true';
			
			document.getElementById('positionInput').value = e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`).dataset.position.replace(/\B(?=(\d{3})+(?!\d))/g, ',');;
			
			// 버튼 클릭시 이동값을 dataset에 저장
			setPositionMoveControl();
			
			const position = selectedDiv.dataset.position;
			//getGeneModel(selectedDiv);
			colorGeneModelPosition(Number(position));
			getGeneModel(position);
			getVariantBrowserGrid();
		})
	})
	
	function appendChromosomeScaleBarDiv() {
		const chromosomeDiv = document.getElementById('chromosomeScaleBarDiv');
		
		for(let i=0 ; i<=1999 ; i++) {
			
			const child = document.createElement('div');
			child.classList.add('chromosomeScaleBarStackDiv');
			child.dataset.order = i;
			//child.dataset.selected = false;
			
			chromosomeDiv.append(child);
		}
		
		
		// 0, 1999 번째 stackDiv에 숫자 출력
		//const nodes = document.querySelectorAll('.chromosomeStackDiv');
		const nodes = document.querySelectorAll('.chromosomeScaleBarStackDiv');
		
		function create_SVG_specificOrderStackDiv(order_id, left, width) {
			const childDiv = document.createElement('div');
			//childDiv.classList.add("verticalLtrMedia762");
			childDiv.style.position = "absolute";
			childDiv.style.top = "3px";
			childDiv.style.left = "-49px";
			//childDiv.style.height = "80px";
			
			const xmlns = "http://www.w3.org/2000/svg";
			const svg = document.createElementNS(xmlns, "svg");
			svg.setAttribute('id', order_id);
			svg.setAttribute('width', width);
		    svg.setAttribute('height', '20');
		    svg.setAttributeNS("http://www.w3.org/2000/xmlns/", "xmlns:svg", "http://www.w3.org/2000/svg");
			
		    const svg_text = document.createElementNS(xmlns, "text");
		    svg_text.setAttributeNS(null, 'fill', '#000000');
		    svg_text.setAttributeNS(null, 'font-size', '0.8rem');
		    //svg_text.setAttributeNS(null, 'x', '5');
		    svg_text.setAttributeNS(null, 'x', '50%');
		    svg_text.setAttributeNS(null, 'y', '50%');
		    svg_text.setAttributeNS(null, 'dominant-baseline', 'middle');
		    svg_text.setAttributeNS(null, 'text-anchor', 'middle');

		    const text_node = document.createTextNode('0');
		    
		    svg_text.appendChild(text_node);
		    svg.appendChild(svg_text);
		    childDiv.appendChild(svg);
		    
		    return childDiv;
		}
		
		
		for(let i=0 ; i<=10 ; i++) {
			const childDiv = create_SVG_specificOrderStackDiv(`scaleBarDiv_\${i}`, '-15', '100');
			
			if(i==0) {
				nodes[0].appendChild(childDiv);
			} else {
				nodes[(i*200)-1].appendChild(childDiv);
			}
		}
		
	}
	
	
	// 염색체 드롭박스에 option 추가
	async function addChromosomeInfo() {
		console.time("addOption");
		await fetch(`./vb_features_chrDataList.jsp?jobid=\${linkedJobid}`)
			.then((response) => response.json())
			.then((data) => {
				console.log(data);
				
				// chr 목록 정렬
				data.sort((a,b) => a.chr>b.chr ? 1 : (a.chr<b.chr ? -1 : 0));
				
				const chrSelectEl = document.getElementById("Chr_select");
				for(let i=0 ; i<data.length ; i++) {
					const option = document.createElement("option");
					option.dataset.chr = data[i]['chr'];
					option.dataset.vcfId_at_firstRow = data[i]['vcfId_at_firstRow'];
					option.dataset.row_count = data[i]['row_count'];
					option.dataset.length = data[i]['length'];
					option.innerText = data[i]['chr'];
					chrSelectEl.append(option);
					
					chr_orders_map.set(data[i]['chr'], new Array());
				}
			})
		console.timeEnd("addOption");
	}
	
	
	// select options 선택시 이벤트. jobid, chr값으로 position 정보 로드
	function selectChr(chrSelectElement) {
		console.time("select_chr");
		//console.log(chrSelectElement);
		const vcf_id = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.vcfId_at_firstRow;
		const row_count = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.row_count;
		const chr = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.chr;
		const length = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.length;
		
		//console.log(vcf_id);
		//console.log(row_count);
		//console.log(chr);
		
		// #chromosomeLastStackDiv에 length값 입력
		const thousands_separator = (number) => number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		
		
		for(let i=1 ; i<=10 ; i++) {
			const division_length = parseInt(Number(length) * i / 10)
			//document.getElementById(`scaleBarDiv_\${i}`).children[0].textContent = thousands_separator(division_length);
			document.getElementById(`scaleBarDiv_\${i}`).children[0].textContent = parseInt(division_length / 1000000 ) + 'Mbp'
			/*
			for(let j=0, left=0; j<thousands_separator(length).length ; j++) {
				left = isNaN(thousands_separator(division_length)[j]) ? left-2 : left-4; 
				if(j==length.toString().length -1) {
					document.querySelector(`.chromosomeScaleBarStackDiv[data-order="\${(i*400)-1}"]>div`).style.left = left + "px";
				}
			}
			*/
		}
		
		
		fetch(`./vb_features_positionListFromChr.jsp?vcf_id=\${vcf_id}&row_count=\${row_count}&chr=\${chr}&jobid=\${linkedJobid}`)
		.then((response) => response.json())
		.then((position_data) => {
			//console.log("position_data : ", position_data);
			
			let chr_flag = true;
			if(chr_orders_map.get(chr).length != 0) {
				chr_flag = false;
			}
			
			let position_ratio = [];
			let position_at_div = [];
			let vcf_id_at_div = [];
			
			//console.time("set_position_memory");
			for(let i=0 ; i<position_data.length ; i++) {
				const position = parseInt(position_data[i]['position'] * 2000 / length );
				if(!position_ratio.includes(position)) {
					position_ratio.push(position);
					position_at_div.push(position_data[i]['position']);
					vcf_id_at_div.push(position_data[i]['vcf_id']);
				} 
				
				if(chr_flag) {
					chr_orders_map.get(chr).push({
						'index': i,
						'vcf_id': Number(position_data[i]['vcf_id']),
						'order': position, 
						'position':Number(position_data[i]['position'])
					});
				}
			}
				//console.timeEnd("set_position_memory");
			
			if(row_count != 0) {
				colorPosition(position_ratio, position_at_div, vcf_id_at_div);

				document.querySelector('[data-selected="true"]').dispatchEvent(new Event("click"));
				
			} else {
				VariantBrowser_gridOptions.api.setColumnDefs([]);
				VariantBrowser_gridOptions.api.setRowData([]);
			}
			
			console.timeEnd("select_chr");
		})
		
		
		
	}
	
	function changeInputValue(value) {
		console.log(value);
		
		const chr = selectedOption('Chr_select').dataset.chr;
		const length = Number(selectedOption('Chr_select').dataset.length);
		
		if( !(0 < value && value < length) ) {
			return alert('염색체의 범위 내의 값을 입력해 주세요.');
		}
		
		const chr_orders_arr = chr_orders_map.get(chr);
		const below_index = chr_orders_arr.findLast((item) => item.position<=value)?.index;
		const above_index = chr_orders_arr.find((item) => value<=item.position)?.index;
		
		let index = 0;
		
		if(above_index === undefined) {
			index = below_index;
		} else if(below_index === undefined) {
			index = above_index;
		} else {
			const below_gap = value - chr_orders_arr[below_index].position;
			const above_gap = chr_orders_arr[above_index].position - value;
			index = below_gap <= above_gap ? chr_orders_arr[below_index].index : chr_orders_arr[above_index].index; 
		}
		
		document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.selected = "false";
		
		document.querySelector(`.chromosomeStackDiv[data-order="\${chr_orders_arr[index].order}"]`).dataset.selected = "true";
		getVariantBrowserGrid(chr_orders_arr[index].vcf_id, chr_orders_arr[index].position);
		colorGeneModelPosition(chr_orders_arr[index].position)
		getGeneModel(chr_orders_arr[index].position);
		
		document.getElementById('positionInput').value = thousands_separator(chr_orders_arr[index].position);
		
		const currentId = document.getElementById('currentId');
		currentId.dataset.index = index;
		currentId.dataset.vcf_id = chr_orders_arr[index].vcf_id;
		currentId.dataset.position = chr_orders_arr[index].position;
		currentId.dataset.order = chr_orders_arr[index].order;
		
		
		const before_index = index == 0 ? -1 : index - 1;
		const after_index = index == chr_orders_arr.length-1 ? -1 : index + 1;
		
		
		const chromosomeStackDiv_nodes = document.querySelectorAll('.chromosomeStackDiv[data-vcf_id]');
		
		const beforeOrder_index = chr_orders_arr.findLast(el => el.order < chr_orders_arr[index].order)?.index;
		const beforeOrder_vcf_id = chr_orders_arr.findLast(el => el.order < chr_orders_arr[index].order)?.vcf_id;
		const beforeOrder_order = chr_orders_arr.findLast(el => el.order < chr_orders_arr[index].order)?.order;
		const afterOrder_index = chr_orders_arr.find(el => el.order > chr_orders_arr[index].order)?.index
		const afterOrder_vcf_id = chr_orders_arr.find(el => el.order > chr_orders_arr[index].order)?.vcf_id;
		const afterOrder_order = chr_orders_arr.find(el => el.order > chr_orders_arr[index].order)?.order; 
		
		//debugger;
		
		const beforeId = document.getElementById('beforeId');
		const afterId = document.getElementById('afterId');
		const beforeOrder = document.getElementById('beforeOrder');
		const afterOrder = document.getElementById('afterOrder');
		
		beforeId.dataset.index = before_index;
		beforeId.dataset.vcf_id = chr_orders_arr[before_index] ? chr_orders_arr[before_index]['vcf_id'] : -1;
		beforeId.dataset.position = chr_orders_arr[before_index] ? chr_orders_arr[before_index]['position'] : -1;
		beforeId.dataset.order = chr_orders_arr[before_index] ? chr_orders_arr[before_index]['order'] : -1;
		
		afterId.dataset.index = after_index;
		afterId.dataset.vcf_id = chr_orders_arr[after_index] ? chr_orders_arr[after_index]['vcf_id'] : -1;
		afterId.dataset.position = chr_orders_arr[after_index] ? chr_orders_arr[after_index]['position'] : -1;
		afterId.dataset.order = chr_orders_arr[after_index] ? chr_orders_arr[after_index]['order'] : -1;
		
		beforeOrder.dataset.index = beforeOrder_order===undefined ? -1 : beforeOrder_index;
		beforeOrder.dataset.vcf_id = beforeOrder_order===undefined ? -1 : beforeOrder_vcf_id;
		beforeOrder.dataset.order = beforeOrder_order===undefined ? -1 : beforeOrder_order;
		
		afterOrder.dataset.index = afterOrder_order===undefined ? -1 : afterOrder_index;
		afterOrder.dataset.vcf_id = afterOrder_order===undefined ? -1 : afterOrder_vcf_id;
		afterOrder.dataset.order = afterOrder_order===undefined ? -1 : afterOrder_order;
		
	}
	
	function setPositionMoveControl() {

		const chr = selectedOption('Chr_select').dataset.chr;
		const chr_orders_arr = chr_orders_map.get(chr);
		
		const first_vcf_id = chr_orders_arr[0]['vcf_id'];
		const last_vcf_id = chr_orders_arr[chr_orders_arr.length - 1]['vcf_id'];
		
		const selected_vcf_id = Number(document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.vcf_id);
		const selected_order = Number(document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.order);
		
		
		
		let selected_index = -1; 
		
		for(let i=0 ; i<chr_orders_arr.length ; i++) {
			if(chr_orders_arr[i]['vcf_id'] == selected_vcf_id) {
				selected_index = i;
			}
		}
		
		//debugger;
		const currentId = document.getElementById('currentId');
		currentId.dataset.index = selected_index;
		currentId.dataset.vcf_id = selected_vcf_id;
		currentId.dataset.position = chr_orders_arr[selected_index]['position'];
		currentId.dataset.order = selected_order;
		
		
		const before_index = selected_index == 0 ? -1 : selected_index - 1;
		const after_index = selected_index == chr_orders_arr.length-1 ? -1 : selected_index + 1;
		
		
		const chromosomeStackDiv_nodes = document.querySelectorAll('.chromosomeStackDiv[data-vcf_id]');
		//const before_order = Array.from(chromosomeStackDiv_nodes).findLast(el => Number(el.dataset.order) < selected_order)?.dataset?.order;
		//const after_order = Array.from(chromosomeStackDiv_nodes).find(el => Number(el.dataset.order) > selected_order)?.dataset?.order;
		
		const beforeOrder_index = chr_orders_arr.findLast(el => el.order < selected_order)?.index;
		const beforeOrder_vcf_id = chr_orders_arr.findLast(el => el.order < selected_order)?.vcf_id;
		const beforeOrder_order = chr_orders_arr.findLast(el => el.order < selected_order)?.order;
		const afterOrder_index = chr_orders_arr.find(el => el.order > selected_order)?.index
		const afterOrder_vcf_id = chr_orders_arr.find(el => el.order > selected_order)?.vcf_id;
		const afterOrder_order = chr_orders_arr.find(el => el.order > selected_order)?.order; 
		
		//debugger;
		
		const beforeId = document.getElementById('beforeId');
		const afterId = document.getElementById('afterId');
		//const currentId = document.getElementById('currentId');
		const beforeOrder = document.getElementById('beforeOrder');
		const afterOrder = document.getElementById('afterOrder');
		
		beforeId.dataset.index = before_index;
		beforeId.dataset.vcf_id = chr_orders_arr[before_index] ? chr_orders_arr[before_index]['vcf_id'] : -1;
		beforeId.dataset.position = chr_orders_arr[before_index] ? chr_orders_arr[before_index]['position'] : -1;
		beforeId.dataset.order = chr_orders_arr[before_index] ? chr_orders_arr[before_index]['order'] : -1;
		
		afterId.dataset.index = after_index;
		afterId.dataset.vcf_id = chr_orders_arr[after_index] ? chr_orders_arr[after_index]['vcf_id'] : -1;
		afterId.dataset.position = chr_orders_arr[after_index] ? chr_orders_arr[after_index]['position'] : -1;
		afterId.dataset.order = chr_orders_arr[after_index] ? chr_orders_arr[after_index]['order'] : -1;
		
		beforeOrder.dataset.index = beforeOrder_order===undefined ? -1 : beforeOrder_index;
		beforeOrder.dataset.vcf_id = beforeOrder_order===undefined ? -1 : beforeOrder_vcf_id;
		beforeOrder.dataset.order = beforeOrder_order===undefined ? -1 : beforeOrder_order;
		
		afterOrder.dataset.index = afterOrder_order===undefined ? -1 : afterOrder_index;
		afterOrder.dataset.vcf_id = afterOrder_order===undefined ? -1 : afterOrder_vcf_id;
		afterOrder.dataset.order = afterOrder_order===undefined ? -1 : afterOrder_order;
		
		
	}
	
	function previousOrder(vcf_id, order) {
		console.log("prev order");
		
		if(Number(order) == -1) {
			return alert("더이상 이동할 수 없습니다.");
		}
		
		document.querySelector(`.chromosomeStackDiv[data-selected="true"]`).dataset.selected = "false";
		document.querySelector(`.chromosomeStackDiv[data-order="\${order}"]`).dataset.selected = "true";
		document.querySelector('[data-selected="true"]').dispatchEvent(new Event("click"));
		
	}
	
	function previousPosition(index, vcf_id, position, order) {
		
		if(Number(vcf_id) == -1 || Number(position) == 1) {
			return alert("더이상 이동할 수 없습니다.");
		}
		
		
		changeInputValue(position);
	}
	
	function nextPosition(index, vcf_id, position, order) {
		
		if(Number(vcf_id) == -1 || Number(position) == 1) {
			return alert("더이상 이동할 수 없습니다.");
		}
		
		changeInputValue(position);
	}
	
	function nextOrder(vcf_id, order) {
		console.log("next order");
		
		if(Number(order) == -1) {
			return alert("더이상 이동할 수 없습니다.");
		}
		
		document.querySelector(`.chromosomeStackDiv[data-selected="true"]`).dataset.selected = "false";
		document.querySelector(`.chromosomeStackDiv[data-order="\${order}"]`).dataset.selected = "true";
		document.querySelector('[data-selected="true"]').dispatchEvent(new Event("click"));
	}
	
	
	// position과 일치하는 div에 색칠 -> data-position 값 추가 & css에서 background-color 회색으로 조정
	function colorPosition(position_ratio, position_at_div, vcf_id_at_div) {
		//console.time("color");
		
		for(let i=0 ; i<=1999 ; i++) {
			const stackDiv = document.querySelector(`.chromosomeStackDiv[data-order="\${i}"]`);
			stackDiv.dataset.selected = "false";
			
			delete stackDiv.dataset.position;
			delete stackDiv.dataset.vcf_id;
		}
		
		for(let i=0 ; i<position_ratio.length ; i++) {
			const stackDiv = document.querySelectorAll('#chromosomeDiv > [data-order]')[position_ratio[i]];
			stackDiv.dataset.position = position_at_div[i];
			stackDiv.dataset.vcf_id = vcf_id_at_div[i];
		}
		
		document.querySelectorAll('.chromosomeStackDiv[data-position]')[0].dataset.selected = "true";
		
		//console.timeEnd("color");
	}
	
	function appendChromosomeDetailedDiv() {
		const chromosomeDiv = document.getElementById('chromosomeDetailedDiv');
		
		//for(let i=0 ; i<=1999 ; i++) {
		for(let i=-1 ; i<=2000 ; i++) {
			
			const child = document.createElement('div');
			child.classList.add('chromosomeDetailedStackDiv');
			child.dataset.order = i;
			child.dataset.selected = false;
			
			chromosomeDiv.append(child);
		}
	}
	
	function colorGeneModelPosition(position) {
		const chr = selectedOption('Chr_select').dataset.chr;
		const chr_orders_arr = chr_orders_map.get(chr);
		
		// range : position-50k ~ position+50k => 100k
		
		const gene_model_position_arr = chr_orders_arr.filter((item) => position-50000 < item.position && item.position<position+50000 );
		const gene_model_order_arr = new Array();
		
		for(let i=0 ; i<gene_model_position_arr.length ; i++) {
			const selected_order = parseInt(((gene_model_position_arr[i].position - position) / 50) + 1000);
			//console.log("order_arr : ", selected_order );
			gene_model_order_arr.push(selected_order)
			//console.log("index_arr : ", gene_model_position_arr[i].index);
		}
		
		document.querySelectorAll(`.chromosomeDetailedStackDiv[data-position]`).forEach((node) => {
			delete node.dataset.position;
			node.innerHTML = "";
		});
		
		
		for(let i=0 ; i<gene_model_order_arr.length ; i++) {
			document.querySelector(`.chromosomeDetailedStackDiv[data-order="\${gene_model_order_arr[i]}"]`).dataset.position = gene_model_position_arr[i].position;
			
			const color = gene_model_order_arr[i]==1000 ? 'red' : '#bcbcbc';
			
			
			document.querySelector(`.chromosomeDetailedStackDiv[data-order="\${gene_model_order_arr[i]}"]`).innerHTML = `
				<div style="position:absolute; top:17px;">
					<svg width="1" height="89" xmlns:svg="http://www.w3.org/2000/svg">
						<polygon style="fill:\${color}" fill-opacity="0.4" points="0,0 1,0 1,89 0,89"></polygon>
					</svg>
				</div>
				`;
			
				
		}
		
		
		// data-order=-1, 2000에 포지션 입력
		const leftside = (position-50000)<0 ? 0 : position-50000;
		document.querySelector(`.chromosomeDetailedStackDiv[data-order="-1"]`).innerHTML = `
			<div style="position:absolute; left:-50px; bottom:15px;">
				<svg width="100" height="20" xmlns:svg="http://www.w3.org/2000/svg">
				<text fill="#000000" font-size="0.8rem" x="50%" y="50%" text-anchor="middle" dominant-baseline="middle">\${thousands_separator(leftside)}</text>
				</svg>
			</div>
			`;
		
		const rightside = (position+50000) > Number($("#Chr_select :selected").attr('data-length')) ? Number($("#Chr_select :selected").attr('data-length')) : position+50000;
		document.querySelector(`.chromosomeDetailedStackDiv[data-order="2000"]`).innerHTML = `
			<div style="position:absolute; left:-50px; bottom:15px;">
				<svg width="100" height="20" xmlns:svg="http://www.w3.org/2000/svg">
				<text fill="#000000" font-size="0.8rem" x="50%" y="50%" text-anchor="middle" dominant-baseline="middle">\${thousands_separator(rightside)}</text>
				</svg>
			</div>
			`
			
		//debugger;
	}
	
	// 각각의 chrmosomeStackDiv에 클릭이벤트 추가
	document.querySelectorAll('.chromosomeDetailedStackDiv').forEach(El => {
		El.addEventListener('click', (e) => {
			
			if(e.composedPath()[0].classList[0] != 'chromosomeDetailedStackDiv') {
				return;
			}
			
			const clickedOrder = e.composedPath()[0].dataset.order
			let closestPositionedOrder = 2000;
			let gap = 2000;
			
			//console.log(clickedOrder);
			
			e.composedPath()[1].querySelectorAll('[data-position]').forEach( (el) => {
				const order = el.dataset.order;
				if(Math.abs( Number(order) - Number(clickedOrder) ) < gap ) {
					gap = Math.abs( Number(order) - Number(clickedOrder) );
					closestPositionedOrder = Number(order);
				} 
			})
			
			const selectedDiv = e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`);
			selectedDiv.dataset.selected = 'true';
			
			
			const input_value = Number(e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`).dataset.position);
			
			//document.getElementById('positionInput').value = e.composedPath()[1].querySelector(`[data-order='\${closestPositionedOrder}']`).dataset.position.replace(/\B(?=(\d{3})+(?!\d))/g, ',');
			
			changeInputValue(input_value);
			
			/*
			// 버튼 클릭시 이동값을 dataset에 저장
			setPositionMoveControl();
			
			const position = selectedDiv.dataset.position;
			//getGeneModel(selectedDiv);
			colorGeneModelPosition(Number(position));
			getGeneModel(position);
			getVariantBrowserGrid();
			*/
		})
	})
	
	//async function getGeneModel(selectedDiv) {
	async function getGeneModel(position) {
		
		const chr = selectedOption('Chr_select').dataset.chr;
		//const position = selectedDiv.dataset.position;
		
		const url_string = './vb_features_getGffData.jsp'
		
		const map_params = new Map();
		map_params.set("jobid", linkedJobid);
		map_params.set("chr", chr);
		map_params.set("position", position);
		map_params.set("refgenome", refgenome);
		//map_params.set("gff", gff);
		map_params.set("gff_filename", gff_filename);
		
		
		//fetch(url);
		const gene_model = await getFetchData(url_string, map_params);
		
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
			
			const selected_position = position;
			
			const mRNA_start = Number(gene_model['mRNA'][i]['start']);
			const mRNA_end = Number(gene_model['mRNA'][i]['end']);
			
			const mRNA_start_div_order = parseInt(( mRNA_start - selected_position) / 50 ) + 1000;
			
			
			// end-start 로는 픽셀이 제대로 맞지 않음. -> start, end position에 해당하는  각 divOrder x좌표의 차이를 width값으로 한다.
			//const mRNA_width = (mRNA_end - mRNA_start)/ 50;
			
			
			const getDivPosition = (position, selected_position) => {
				const div_order = parseInt(( position - selected_position) / 50 ) + 1000;
				const div_position = document.querySelector(`.chromosomeStackDiv[data-order="\${div_order}"]`).getBoundingClientRect().x;
				return div_position;
			}
			
			const mRNA_start_div_position = getDivPosition(mRNA_start, selected_position);
			const mRNA_end_div_position = getDivPosition(mRNA_end, selected_position);
			const mRNA_width = mRNA_end_div_position - mRNA_start_div_position;
			
			// 표시할 position을 선정
			const selectedGeneModelDiv = document.querySelector(`.chromosomeDetailedStackDiv[data-order="\${mRNA_start_div_order}"]`);
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
			}
			
			const row_SVG = (i) => i%4<=1 ? i%4 : 4-(i%4);
			
			//console.log(row_SVG(i));
			
			const svg = createSVG(mRNA_attribute, mRNA_start, mRNA_end, mRNA_width, strand, svg_CDS, getDivPosition, selected_position);
			//console.log(svg);
			
			const childDiv = document.createElement('div');
			childDiv.dataset.id = mRNA_id;
			
			childDiv.dataset.toggle = mRNA_id;
			childDiv.dataset.html = "true";
			childDiv.dataset.placement = "right";
			childDiv.dataset.trigger = "hover";
			
			let popoverContent = `
									Current Position : \${thousands_separator(selected_position)}<br>
									Start : \${thousands_separator(mRNA_start)}<br>
									End : \${thousands_separator(mRNA_end)}<br>
									Strand : \${strand}<br>
									CDS : <br>
									`;
			for(let i=0 ; i<svg_CDS.length ; i++) {
				popoverContent += `\${i+1} : \${thousands_separator(svg_CDS[i]['start'])} - \${thousands_separator(svg_CDS[i]['end'])}<br>`
			}
									
			childDiv.dataset.content = popoverContent;
			childDiv.style.position = 'absolute';
			//childDiv.style.top = '25px';
			childDiv.style.top = (row_SVG(i)*25+25) + 'px';
			//childDiv.style.top = `\${row_SVG*10+25}px`;
			//childDiv.style.right = (-(mRNA_width+4) / 2) + 'px';
			childDiv.appendChild(svg);
			selectedGeneModelDiv.appendChild(childDiv);
			$(`[data-toggle="\${mRNA_id}"]`).popover();
		}
	}
	
	function createSVG(mRNA_attribute, mRNA_start, mRNA_end, mRNA_width, strand, svg_CDS, getDivPosition, selected_position) {
		
		//console.log(mRNA_start, mRNA_end, mRNA_width, strand, svg_CDS, getDivPosition, selected_position);
		
		const xmlns = "http://www.w3.org/2000/svg";
		
		const svg = document.createElementNS(xmlns, "svg");
	    svg.setAttribute('width', mRNA_width+9);
	    svg.setAttribute('height', '20');
	    //svg.setAttribute('viewBox', `0 0 \${mRNA_width+8} 16`);
	    svg.setAttributeNS("http://www.w3.org/2000/xmlns/", "xmlns:svg", "http://www.w3.org/2000/svg");
	    svg.setAttribute('onclick', "show_geneInfoModal();");
	    
	    
	    for(const cds of svg_CDS) {
	    	/*
	    	const cds_start_relative = (Number(cds.start) - mRNA_start) / 50;
	    	const cds_width = (Number(cds.end) - Number(cds.start)) / 50;
	    	const cds_end_relative = cds_start_relative + cds_width;
	    	*/
	    	
	    	const cds_start_relative = getDivPosition(Number(cds.start), selected_position) - getDivPosition(mRNA_start, selected_position);
	    	const cds_end_relative = getDivPosition(Number(cds.end), selected_position) - getDivPosition(mRNA_start, selected_position);
	    	const cds_width = cds_end_relative - cds_start_relative;
	    	
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
	    
	    svg.addEventListener('mouseenter', function(event) {
	    	//console.log(event);
	    	modifyGeneInfoModal(mRNA_attribute, mRNA_start, mRNA_end, mRNA_width, strand, svg_CDS)
	    });
	    
	    return svg;
		
	}
	
	function show_geneInfoModal() {
		$('#geneInfoModal').modal('show');
		
		const mRNA_id = document.getElementById('attributes_id').innerText;
		const mRNA_parent = document.getElementById('attributes_parent').innerText;
		
		setTimeout(() => {
			fetch(`./vb_features_getSequence.jsp?command=gene&file_name=\${mRNA_parent}&refgenome=\${refgenome}`)
			//fetch(`./vb_features_getSequence.jsp?command=gene&file_name=\${mRNA_id}&refgenome=\${refgenome}`)
			.then((response) => response.text())
			.then((data) => {
				/*
				*/
				console.log(data.replaceAll("\r\n",""));
				document.getElementById('gene_sequence').value = data.replaceAll("\r\n","");
				
				/*
				const str = data.replaceAll("\r\n","");
				const sequence = str.split("\n")[1];
				
				let sequence_lines = ""
				for(let i=0 ; i < sequence.length ; i+=60) {
					sequence_lines += sequence.slice(i,i+60);
					if(i != sequence.length/60) {
						sequence_lines += "\n";
					}
				}
				
				document.getElementById('gene_sequence').value = str.split("\n")[0] +"\n"+ sequence_lines;
				*/
				
			})
			
			fetch(`./vb_features_getSequence.jsp?command=cds&file_name=\${mRNA_id}&refgenome=\${refgenome}`)
			.then((response) => response.text())
			.then((data) => {
				document.getElementById('cds_sequence').value = data.replaceAll("\r\n","");
			});
			
			//fetch(`./vb_features_getSequence.jsp?command=protein&file_name=\${mRNA_parent}&refgenome=\${refgenome}`)
			fetch(`./vb_features_getSequence.jsp?command=protein&file_name=\${mRNA_id}&refgenome=\${refgenome}`)
			.then((response) => response.text())
			.then((data) => {
				document.getElementById('protein_sequence').value = data.replaceAll("\r\n","");
			});
			
			
		},50);
		
		
	}
	
	async function modifyGeneInfoModal(mRNA_attribute, mRNA_start, mRNA_end, mRNA_width, strand, svg_CDS) {
		
		const search_attribute = (text) => {
			for(let i=0 ; i<mRNA_attribute.length ; i++) {
				if(mRNA_attribute[i].includes(text)) {
					return mRNA_attribute[i].substring(text.length+1, mRNA_attribute[i].length);
				}
			}
			return "-";
		}
		
		
		
		const thousands_separator = (number) => number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
		
		//document.getElementById('pd_name').innerText() = ""
		//document.getElementById('pd_name').innerText = mRNA_id();
		document.getElementById('pd_name').innerText = search_attribute('ID');
		document.getElementById('pd_position').innerText = thousands_separator(mRNA_start) +" - " + thousands_separator(mRNA_end);
		document.getElementById('pd_length').innerText = thousands_separator(mRNA_end - mRNA_start)
		document.getElementById('pd_start').innerText = thousands_separator(mRNA_start)
		document.getElementById('pd_end').innerText = thousands_separator(mRNA_end);
		document.getElementById('pd_strand').innerText = strand;
		
		let CDS_contents = ""
		
		for(let i=0 ; i<svg_CDS.length ; i++) {
			CDS_contents += `\${i+1} : \${thousands_separator(svg_CDS[i]['start'])} - \${thousands_separator(svg_CDS[i]['end'])}<br>`
		}
		document.getElementById('pd_cds').innerHTML = CDS_contents;
		
		document.getElementById('attributes_id').innerText = search_attribute('ID');
		document.getElementById('attributes_parent').innerText = search_attribute('Parent');
		
		
		const url_string = './vb_features_getAnnotationData.jsp'
			
		const map_params = new Map();
		//map_params.set("mRNA_id", search_attribute('ID'));
		map_params.set("mRNA_id", document.getElementById('pd_name').innerText);
		map_params.set("refgenome", refgenome);
		map_params.set("annotation_filename", annotation_filename);
		
		const description = await getFetchData(url_string, map_params);
		const attributes = description['attributes'];
		
		//debugger;
		
		const search_description = (text) => {
			for(let i=0 ; i<attributes.length ; i++) {
				if(attributes[i].includes(text)) {
					return attributes[i].substring(text.length+1, attributes[i].length);
				}
			}
			return "-";
		}
		
		
		document.getElementById('attributes_description').innerText = search_description('Description');
		
		const RefSeq = search_description('RefSeq').split(",");
		const Uniprot = search_description('Uniprot').split(",");
		const Pfam = search_description('Pfam').split(",");
		const TAIR = search_description('TAIR').split(",");
		const GO = search_description('GO').split(",");
		const KEGG = search_description('KEGG').split(",");
		
		/*
		document.getElementById('attributes_description').innerText = search_attribute('Description');
		
		const RefSeq = search_attribute('RefSeq').split(",");
		const Uniprot = search_attribute('Uniprot').split(",");
		const Pfam = search_attribute('Pfam').split(",");
		const TAIR = search_attribute('TAIR').split(",");
		const GO = search_attribute('GO').split(",");
		const KEGG = search_attribute('KEGG').split(",");
		*/
		
		const attributes_refSeq = document.getElementById('attributes_refSeq');
		const attributes_uniProt = document.getElementById('attributes_uniProt');
		const attributes_pfam = document.getElementById('attributes_pfam');
		const attributes_tair = document.getElementById('attributes_tair');
		const attributes_go = document.getElementById('attributes_go');
		const attributes_kegg = document.getElementById('attributes_kegg');
		
		attributes_refSeq.innerHTML = "";
		attributes_uniProt.innerHTML = "";
		attributes_pfam.innerHTML = "";
		attributes_tair.innerHTML = "";
		attributes_go.innerHTML = "";
		attributes_kegg.innerHTML = "";
		
		for(let i=0 ; i<RefSeq.length ; i++){
			attributes_refSeq.innerHTML += `<a href="https://www.ncbi.nlm.nih.gov/gene/?term=\${RefSeq[i]}" target="_blank">\${RefSeq[i]}</a>`;
		}
		
		for(let i=0 ; i<Uniprot.length ; i++){
			attributes_uniProt.innerHTML += `<a href="https://www.uniprot.org/uniprotkb/\${Uniprot[i]}/entry" target="_blank">\${Uniprot[i]}</a>`;
		}
		
		for(let i=0 ; i<Pfam.length ; i++){
			attributes_pfam.innerHTML += `<a href="https://www.ebi.ac.uk/interpro/entry/pfam/\${Pfam[i]}/" target="_blank">\${Pfam[i]}</a>`;
		}
		
		for(let i=0 ; i<TAIR.length ; i++){
			attributes_tair.innerHTML += `<a href="https://www.arabidopsis.org/servlets/TairObject?type=locus&name=\${TAIR[i].split('.')[0]}" target="_blank">\${TAIR}</a>`
		}
		
		for(let i=0 ; i<GO.length ; i++){
			if(i == GO.length - 1){
				attributes_go.innerHTML += `<a href="http://amigo.geneontology.org/amigo/term/\${GO[i]}" target="_blank">\${GO[i]}</a>`;
			} else {
				attributes_go.innerHTML += `<a href="http://amigo.geneontology.org/amigo/term/\${GO[i]}" target="_blank">\${GO[i]}, </a>`;
			}
		}
		
		for(let i=0 ; i<KEGG.length ; i++){
			if(i == KEGG.length - 1){
				attributes_kegg.innerHTML += `<a href="https://www.genome.jp/dbget-bin/www_bget?pathway+\${KEGG[i]}" target="_blank">\${KEGG[i]}</a>`;
			} else {
				attributes_kegg.innerHTML += `<a href="https://www.genome.jp/dbget-bin/www_bget?pathway+\${KEGG[i]}" target="_blank">\${KEGG[i]}, </a>`;
			}
		}
		
	}
	
	//function drawLineBetweenGeneModelAndBrowser(position) {
	function drawLineBetweenGeneModelAndBrowser() {
		
		/*
		const selected_stack_div_arr = new Array();
		document.querySelectorAll('.chromosomeDetailedStackDiv[data-position]').forEach((node) => {
			//selected_stack_div_arr.push(node.dataset.position);
			selected_stack_div_arr.push({
				'position': node.dataset.position,
				'div_bottom': node.getBoundingClientRect().bottom,
				'div_left': node.getBoundingClientRect().left,
			});
		})
		
		for(let i=0 ; i<selected_stack_div_arr.length ; i++) {
			const node = document.querySelector(`#VariantBrowserGrid [col-id="\${selected_stack_div_arr[i]['position']}"]`);
			selected_stack_div_arr[i]['column_top'] = node.getBoundingClientRect().top;
			selected_stack_div_arr[i]['column_center'] = (node.getBoundingClientRect().left + node.getBoundingClientRect().right) / 2 ;
		}
		*/
		
		const position = Number(document.getElementById('positionInput').value.replaceAll(",",""));
		
		const chr = selectedOption('Chr_select').dataset.chr;
		const chr_orders_arr = chr_orders_map.get(chr);
		
		const gene_model_position_arr = chr_orders_arr.filter((item) => position-50000 < item.position && item.position<position+50000 );
		const gene_model_order_arr = new Array();
		
		for(let i=0 ; i<gene_model_position_arr.length ; i++) {
			const selected_order = parseInt(((gene_model_position_arr[i].position - position) / 50) + 1000);
			gene_model_order_arr.push(selected_order)
		}
		
		const svg = document.getElementById('connection');
		svg.innerHTML = '';
		const svg_x = svg.getBoundingClientRect().x;
		for(let i=0 ; i<gene_model_position_arr.length ; i++) {
			//const col_rect = document.querySelector(`#VariantBrowserGrid div.ag-header-cell.ag-header-cell-sortable[col-id="\${gene_model_position_arr[i]['position']}"]`).getBoundingClientRect();
			const col_rect = document.querySelector(`#VariantBrowserGrid div.ag-header-cell.ag-header-cell-sortable[col-id="\${gene_model_position_arr[i]['position']}"]`)?.getBoundingClientRect();
			
			if(col_rect === undefined || col_rect === null) {
				continue;
			}
			
			const start_x = (col_rect.left + col_rect.right) / 2;   
       		const end_x = document.querySelector(`.chromosomeDetailedStackDiv[data-order="\${gene_model_order_arr[i]}"]`).getBoundingClientRect().x;
       		
       		const xmlns = "http://www.w3.org/2000/svg";
       		const polyline = document.createElementNS(xmlns, "polyline");
       		//polygon.setAttribute('style', 'fill:#0073E5;')
       		polyline.setAttributeNS(null, 'stroke-width', 1);
       		polyline.setAttributeNS(null, 'fill', 'none');
       		polyline.setAttributeNS(null, 'shape-rendering', 'crispEdges');
       		if(gene_model_position_arr[i]['position'] == Number(document.querySelector(`#VariantBrowserGrid div.ag-header-cell.ag-header-cell-sortable.grid-header-red`).getAttribute('col-id'))) {
       			polyline.setAttributeNS(null, 'stroke', 'red');
       		} else {
       			polyline.setAttributeNS(null, 'stroke', '#bcbcbc');
       		}
       		polyline.setAttributeNS(null, 'points', `\${start_x - svg_x},34 \${end_x - svg_x},0`);
       	    svg.appendChild(polyline);
		}
		
		
		/*
		const svg = document.getElementById('connection');
		svg.innerHTML = '';
		const svg_x = svg.getBoundingClientRect().x;
		for(let i=0 ; i<selected_stack_div_arr.length ; i++) {
			const start_x = selected_stack_div_arr[i]['column_center'];
       		const end_x = selected_stack_div_arr[i]['div_left'];
       		
       		const xmlns = "http://www.w3.org/2000/svg";
       		const polyline = document.createElementNS(xmlns, "polyline");
       		//polygon.setAttribute('style', 'fill:#0073E5;')
       		polyline.setAttributeNS(null, 'stroke-width', 1);
       		polyline.setAttributeNS(null, 'fill', 'none');
       		polyline.setAttributeNS(null, 'shape-rendering', 'crispEdges');
       		if(selected_stack_div_arr[i].position == Number(document.querySelector(`#VariantBrowserGrid div.ag-header-cell.ag-header-cell-sortable.grid-header-red`).getAttribute('col-id'))) {
       			polyline.setAttributeNS(null, 'stroke', 'red');
       		} else {
       			polyline.setAttributeNS(null, 'stroke', '#bcbcbc');
       		}
       		polyline.setAttributeNS(null, 'points', `\${start_x - svg_x},34 \${end_x - svg_x},0`);
       	    svg.appendChild(polyline);
		}
		*/
		
		//debugger;
		
	}
	
	function getVariantBrowserGrid(
			vcf_id = document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.vcf_id, 
			position = document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.position) {
		
		console.time("Variant_Browser");
		
		//const vcf_id = document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.vcf_id;
		//const position = document.querySelector('.chromosomeStackDiv[data-selected="true"]').dataset.position;
		const chrSelectEl = document.getElementById('Chr_select');
		const chr = chrSelectEl.options[chrSelectEl.selectedIndex].dataset.chr;
		
		
		//console.log(position);
		//console.log(chr);
		fetch(`./vb_features_getBrowserData.jsp?chr=\${chr}&position=\${position}&jobid=\${linkedJobid}&vcf_id=\${vcf_id}`)
    	.then((response) => response.json())
    	.then((data) => {
    		//console.log("chr=1, position=3374674로 설정")
    		console.log(data);
    		
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
    					rowDrag: true,
    					pinned: 'left',
    				}) 
    			} else {
    				const column = {
   						headerName: columnKeys[i].toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
       					field: columnKeys[i], 
       					//headerClass: "ag-right-aligned-header",
       					width: 30,
       					sortable: true,
       					sortingOrder: ['desc', null],
       					
       		            comparator: (valueA, valueB, nodeA, nodeB, isDescending) => {
       		                
       		            	const sort_map = new Map();
       		            	sort_map.set('A', ['A','T','G','C'])
       		            	sort_map.set('T', ['T','G','C','A'])
       		            	sort_map.set('G', ['G','C','A','T'])
       		            	sort_map.set('C', ['C','A','T','G'])
       		            	
       		            	switch(valueA) {
       		            		case sort_map.get(base_sort_order)[0]: valueA = 4; break;
       		            		case sort_map.get(base_sort_order)[1]: valueA = 3; break;
       		            		case sort_map.get(base_sort_order)[2]: valueA = 2; break;
       		            		case sort_map.get(base_sort_order)[3]: valueA = 1; break;
       		            		default: valueA = 0;
       		            	}
       		            	
       		            	switch(valueB) {
   			            		case sort_map.get(base_sort_order)[0]: valueB = 4; break;
   			            		case sort_map.get(base_sort_order)[1]: valueB = 3; break;
   			            		case sort_map.get(base_sort_order)[2]: valueB = 2; break;
   			            		case sort_map.get(base_sort_order)[3]: valueB = 1; break;
   			            		default: valueB = 0;
   			            	}
       		            	
       		            	if (valueA == valueB) {
       		            		return 0;
       		            	} else {
       		            		return (valueA > valueB) ? 1 : -1
       		            	}
       		            },
       		            
       					tooltipField: columnKeys[i], 
       					tooltipComponent: CustomTooltip, 
       					cellStyle: cellStyle,	
    				}
    				
    				if(columnKeys[i] == position) {
    					column['headerClass'] = "grid-header-red";
    				}
    				
    				VariantBrowser_columnDefs.push(column);
    				
    			}
    		}
    		
    		
    		const VariantBrowser_gridTable = document.getElementById("VariantBrowserGrid");
    		if(!VariantBrowser_gridTable.innerHTML) {
	    		const VariantBrowser_Grid = new agGrid.Grid(VariantBrowser_gridTable, VariantBrowser_gridOptions);
    		}

    		VariantBrowser_gridOptions.api.setColumnDefs(VariantBrowser_columnDefs);
    		VariantBrowser_gridOptions.api.setRowData(data);
    		
    		
    		
    		//'Position' 컬럼을 검색 => 해당 컬럼은 수평처리
    		//Array.prototype.slice.call(document.querySelectorAll('#VariantBrowserGrid .ag-header-cell-label .ag-header-cell-text'))
    		//.filter((el) => el.textContent === 'Id')[0].style.writingMode = 'horizontal-tb';
    		
    		// headerComponent 설정 시 'Id'컬럼 수평처리
    		Array.prototype.slice.call(document.querySelectorAll('#VariantBrowserGrid .customHeaderLabel'))
    		.filter((el) => el.textContent === 'Id')[0].style.writingMode = 'horizontal-tb';
    		
    		const isChecked = document.getElementById('switch_sort_UPGMA');
    		// Sort switch가 켜져있다면 ID기준으로 정렬하여 재출력
    		if(isChecked.checked) {
       			sort_vb_by_UPGMA();
       		} 
    		
    		console.timeEnd("Variant_Browser");
    		
    		
   			
   			
   			// model과 browser 사이에 선 긋기
       		//drawLineBetweenGeneModelAndBrowser(position);
   			drawLineBetweenGeneModelAndBrowser();
       		
       		
       		/*
   			const svg = document.querySelector('.chromosomeDetailedStackDiv[data-order="1000"] svg');
       		const selected_column_div = document.querySelector(`#VariantBrowserGrid [col-id="\${Number(position)}"]`)
       		const start_x = svg.getBoundingClientRect().x
       		const start_y = svg.getBoundingClientRect().y
       		const end_x = selected_column_div.getBoundingClientRect().x;
       		const end_y = selected_column_div.getBoundingClientRect().y;
       		
       		const xmlns = "http://www.w3.org/2000/svg";
       		const polygon = document.createElementNS(xmlns, "polygon");
       		polygon.setAttribute('style', 'fill:#0073E5;')
       		polygon.setAttributeNS(null, 'points', '0,0 1,0 30,30 25,30');
       	    svg.appendChild(polygon);
       		*/
    		
    		
    	})
    	.catch((error) => {
    		console.log(error);
    		VariantBrowser_gridOptions.api.setRowData([]);
    	})
	}
	var base_sort_order = '';
   	
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

		const loci = document.getElementById('loci');
		const cluster = document.getElementById('cluster');
		
		if(text == 'side1') {
			
			side2.classList.replace('expandSide', 'small');
			cluster.style.color = '#2da0ed';
			cluster.style.backgroundColor = '#FFFFFF';
			
			if(side1.classList.contains('expandSide')) {
				side1.classList.replace('expandSide', 'small');
				loci.classList.replace('btn-success','btn-outline-success')
			} else {
				side1.classList.replace('small', 'expandSide');
				loci.classList.replace('btn-outline-success','btn-success')
			}
			
		} else if(text == 'side2') {
			
			if(side2.classList.contains('expandSide')) {
				side2.classList.replace('expandSide', 'small');
				cluster.style.color = '#2da0ed';
				cluster.style.backgroundColor = '#FFFFFF';
			} else {
				side2.classList.replace('small', 'expandSide');
				cluster.style.color = '#FFFFFF';
				cluster.style.backgroundColor = '#2da0ed';
			}
			side1.classList.replace('expandSide', 'small');
			side1.classList.replace('expandSide', 'small');
			loci.classList.replace('btn-success','btn-outline-success')
			
		}
		
		resizeGrid();
		
	}
	
	function clear_mark_all() {
   		clear_mark_snpEff();
   		clear_mark_GWAS();
   	}
	
	function show_SnpEff_Grid() {
		
		console.time("SnpEff_Grid");
		
		const chr_select = document.getElementById('Chr_select');
   		const chr = chr_select.options[chr_select.selectedIndex].dataset.chr;
		
		fetch(`./vb_features_grid_SnpEff.jsp?jobid=\${linkedJobid}&chr=\${chr}`)
		.then((response) => response.json())
		.then((data) => {
			//console.log("SnpEff data : ", data);
			
			if(!data) {
				document.getElementById('SnpEff_Grid').style.display = 'none';
				document.getElementById('SnpEff_Not_Exist').style.display = 'flex';
			} else {
				
				document.getElementById('SnpEff_Grid').style.display = 'block';
				document.getElementById('SnpEff_Not_Exist').style.display = 'none';
			}
			
			SnpEff_gridOptions.api.setRowData(data);
			SnpEff_gridOptions.columnApi.autoSizeAllColumns();
			
			SelectionList_gridOptions.api.forEachNode((selection_node) => {
				const selection_row_id = selection_node.id;
				const snpEff_node = SnpEff_gridOptions.api.getRowNode(selection_row_id);
				
				//console.log("snpEff_node : " , snpEff_node);
				if(snpEff_node) {
					const selection_snpEff_flag = selection_node.data.snpeff
					snpEff_node.setDataValue('selection', selection_snpEff_flag);
				}
			})
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
			
			const mark = document.querySelector(`.chromosomeStackDiv[data-order="\${parseInt(mark_pos * 2000 / length)}"]`);
			//console.log(mark);
			
			const mark_data_order = mark.dataset.order;
			
			if(!document.querySelector(`[data-snpeff_order="\${mark_data_order}"]`)){
				const childDiv = document.createElement('div');
				childDiv.dataset.snpeff_order = mark_data_order;
				childDiv.dataset.toggle="popover";
				childDiv.dataset.placement = "top";
				childDiv.dataset.trigger = "hover";
				//childDiv.dataset.content = mark_pos;
				childDiv.dataset.content = thousands_separator(mark_pos);
				childDiv.style.position = "absolute";
				childDiv.style.bottom = "13px";
				childDiv.style.right = "-3px";
				childDiv.innerHTML = `<svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#0073E5;" ></svg>`;
				childDiv.addEventListener("click", (e) => {
					changeInputValue(mark_pos);
				})
				
				mark.appendChild(childDiv);
				
			}
			
			
			//mark.innerHTML = `<div data-snpEff_order=\${i} style="position: absolute; bottom: 15px; right: -3px;" ><svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#0073E5;" /></svg></div>`;
		}
		$('[data-toggle="popover"]').popover();
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
		
		
		
		SnpEff_gridOptions.api.setFilterModel(impactFilter);
		SnpEff_gridOptions.api.onFilterChanged();
		
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
   		
   		//변경시 please select result 숨김
   		document.getElementById("nonSelectGWAS").style.display="none";
   		
   		const jobid = HTML_element.dataset.jobid;
   		
   		
   		// model list 나열
   		const model = HTML_element.dataset.model.split("|");
   		$("#GWAS_button_list").empty();
   		$("#GWAS_content_list").empty();
   		for(let i=0 ; i<model.length ; i++) {
			$("#GWAS_button_list").append(`<li class="nav-item"><a class="nav-link" id="GWAS_\${model[i]}" data-toggle="pill" href="#GWAS_pill_\${model[i]}" aria-expanded="true" data-phenotype="-1" data-model=\${model[i]} onclick="resizeGrid();" >\${model[i]}</a></li>`);
			//$("#GWAS_content_list").append(`<div role='tabpanel' class='tab-pane' id='GWAS_pill_\${model[i]}' aria-expanded='true' aria-labelledby='base-pill1'>\${model[i]}</div>`)
			$("#GWAS_content_list").append(`<div role='tabpanel' class='tab-pane' id='GWAS_pill_\${model[i]}' aria-expanded='true' aria-labelledby='base-pill1'></div>`)
			
			
			if(i==0) {
				document.getElementById(`GWAS_\${model[i]}`).classList.add('active');
				document.getElementById(`GWAS_pill_\${model[i]}`).classList.add('active');
			}
			
			const element = document.getElementById(`GWAS_pill_\${model[i]}`);
			//element.innerHTML = `<select id="GWAS_select_\${model[i]}" data-model="\${model[i]}" data-jobid="\${jobid}" onchange="show_GWAS_Grid()"></select>`
			element.insertAdjacentHTML('beforeend',`
					<div class="row">
						<div class="col-4">
							<select id="GWAS_select_\${model[i]}" data-model="\${model[i]}" data-jobid="\${jobid}" onchange="show_GWAS_Grid()"></select>
						</div>
						<div id="cutOffDiv_\${model[i]}" class="col-8" style="display:none; justify-content:end;">
							<div class="col-8">
								<input type="text" id='cutOffValue_${model_arr[i]}' class='form-control' placeholder='cut off value (-log10(P))' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\\..*)\\./g, '$1'); if(this.value<0)this.value=0;" >
							</div>
							<div class="col-4">
								<button class="btn btn-primary" style="width:100%;" data-model="${model[i]}" onclick="const selectEl = document.getElementById('${model_arr[i]}_phenotype'); 
																									const phenotype = selectEl.options[selectEl.selectedIndex].value; 
																									const cutOffValue = Number(document.getElementById('cutOffValue_${model_arr[i]}').value); 
																									if(validCheckCutOff(this.dataset.model, cutOffValue, phenotype)) {
																										updateCutOff(this.dataset.model, cutOffValue, phenotype);
																										show_GWAS_Grid(phenotype, cutOffValue);
																									} ">cutoff</button>
							</div>
						</div>
					</div>
					`);
					/*
					*/
			
			
			const phenotype = HTML_element.dataset.phenotype.split("|");
			$(`#GWAS_select_\${model[i]}`).append('<option data-phenotype="-1" disabled hidden selected>Select Phenotype</option>')
			for(let j=0 ; j<phenotype.length ; j++) {
				$(`#GWAS_select_\${model[i]}`).append(`<option data-phenotype=\${phenotype[j]} > \${phenotype[j]} </option>`);
			}
			//jQuery(`#GWAS_select_\${model[i]}`).select2({width: '35%'});
			jQuery(`#GWAS_select_\${model[i]}`).select2({width: '100%'});
			
			$(`#GWAS_pill_\${model[i]}`).append(`<div class='row mt-1'><div id='GWAS_Grid_\${model[i]}' class='col-12 ag-theme-alpine' style='height:664px; padding-right:28px;' ></div></div>`); 
			
			const GWAS_gridTable = document.getElementById(`GWAS_Grid_\${model[i]}`);
			GWAS_gridOptions_model[model[i]] = Object.assign({},GWAS_gridOptions);
			
			const GWAS_Grid = new agGrid.Grid(GWAS_gridTable, GWAS_gridOptions_model[model[i]]);
			GWAS_gridOptions_model[model[i]].api.setRowData([]);
			GWAS_gridOptions_model[model[i]].columnApi.autoSizeAllColumns();
			
			// data가 출력되기 전에는 display='none' & 아이콘 출력
			//GWAS_gridTable.style.display = 'none';
		}
   		
   	}
   	
   	//function show_GWAS_Grid (HTML_element) {
   	function show_GWAS_Grid() {
		
		const model = document.querySelector('#GWAS_button_list .nav-link.active')?.dataset?.model;
		const select_phenotype = document.getElementById(`GWAS_select_\${model}`);
		const phenotype = select_phenotype?.options[select_phenotype.selectedIndex]?.dataset?.phenotype;
		const jobid = select_phenotype?.dataset?.jobid;
		
   		
		if(!model || !phenotype || !jobid) {
			console.log("gwas 영역 생성안됨");
			return;
		}
		
		const chr_select = document.getElementById('Chr_select');
   		const chr = chr_select.options[chr_select.selectedIndex].dataset.chr;
   		
		//console.log(model);
		//console.log(phenotype);
		//console.log(jobid);
		
		const GWAS_gridTable = document.getElementById(`GWAS_Grid_\${model}`);
		
		/*
		fetch(`/ipet_digitalbreed/result/gwas/\${jobid}/GAPIT.Association.GWAS_Results.\${model}.\${phenotype}.csv`, {method: "HEAD"})
		.then((response) => response.ok)
		.then((ok) => {
			if(!ok) {
				
				GWAS_gridTable.style.display = 'none';
				document.getElementById('status404').style.display = 'block';
				
			} else {
				fetch(`./vb_features_grid_Gwas.jsp?chr=\${chr}&jobid=\${jobid}&model=\${model}&phenotype=\${phenotype}`)
				.then((response) => response.json())
				.then((data) => {
					//console.log(data);
					GWAS_gridOptions_model[model].api.setRowData(data);
					
					GWAS_gridTable.style.display = 'block';
					document.getElementById('status404').style.display = 'none';
					
					GWAS_gridOptions_model[model].columnApi.autoSizeAllColumns();
					
					
					
					SelectionList_gridOptions.api.forEachNode((selection_node) => {
						const selection_row_id = selection_node.id;
						const GWAS_node = GWAS_gridOptions_model[model].api.getRowNode(selection_row_id);
						
						//console.log("snpEff_node : " , snpEff_node);
						if(GWAS_node) {
							const selection_gwas_flag = selection_node.data.gwas
							GWAS_node.setDataValue('selection', selection_gwas_flag);
						}
					})
				})
			}
		})
		*/

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
			
			const mark_pos = Number(GWAS_marked_rows[i]['pos']);
			//console.log(mark_pos);
			//console.log(parseInt(mark_pos * 1000 / length));
			
			const mark = document.querySelector(`.chromosomeStackDiv[data-order="\${parseInt(mark_pos * 2000 / length)}"]`);
			//console.log(mark);
			
			const mark_data_order = mark.dataset.order;
			
			if(!document.querySelector(`[data-gwas_order="\${mark_data_order}"]`)){
				const childDiv = document.createElement('div');
				childDiv.dataset.gwas_order = mark_data_order;
				childDiv.dataset.toggle="popover";
				childDiv.dataset.placement = "top";
				childDiv.dataset.trigger = "hover";
				childDiv.dataset.content = thousands_separator(mark_pos);
				childDiv.style.position = "absolute";
				childDiv.style.bottom = "19px";
				childDiv.style.right = "-3px";
				childDiv.innerHTML = `<svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#2cb637;" /></svg>`;
				childDiv.addEventListener("click", (e) => {
					changeInputValue(mark_pos);
				});
				
				mark.appendChild(childDiv);
			}
			
			
			
			//mark.innerHTML = `<div data-GWAS_order=\${i} style="position: absolute; bottom: 25px; right: -3px;" ><svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#2cb637;" /></svg></div>`;
		}
		$('[data-toggle="popover"]').popover();
		console.timeEnd("gwasMark");
   	}
   	
   	function clear_mark_GWAS() {
		//선택되어있는 표지를 모두 지움
		document.querySelectorAll(`[data-GWAS_order]`).forEach((El) => {
			El.remove();
		})
   	}
   	
   	
   	
   	async function flanking_sequence() {
   		
   		const sequence = SelectionList_gridOptions.api.getSelectedNodes();
   		
   		if(sequence.length != 1) {
   			return alert("position을 하나만 선택해주세요.")
   		}
   		
   		$("#loading").modal('show');
   		
   		const chr = sequence[0].data.chr;
   		const position = sequence[0].data.pos;
   		const flanking_sequence_jobid = await fetch('../getJobid.jsp').then((response)=>response.text());
   		const flanking_sequence_size = document.getElementById('flankingSequence').value.replace(",","");
   		
		const url_string = './vb_features_flanking_sequence.jsp';
		const map_params = new Map([
			['chr', chr],
			['position', position],
			['flanking_sequence_jobid', flanking_sequence_jobid],
			['flanking_sequence_size', flanking_sequence_size],
			['vcf_jobid', linkedJobid],
			['refgenome', refgenome],
			['filename', filename],
			['fasta_filename', fasta_filename],
		]);
		
		//debugger;
		$('#flankingSequenceModal').modal('hide'); 
		document.getElementById('sequenceSize').innerHTML = "";
		$('#flankingSequenceSizeModal').modal('show');
		const data = await getFetchTextData(url_string, map_params);
		//console.log(data);
		
		const data_arr = data.split(',');
		
		document.getElementById('sequenceSize').innerHTML = data.includes("null") ? `>\${data_arr[0]}<br>${data_arr[2]}` : `>\${data_arr[0]}<br>\${data_arr[2].replaceAll(/\[([^)]+)\]/g,'<span style="color:red;">[$1]</span>')}`; 
		
		/*
		if(data.includes("null")) {
			document.getElementById('sequenceSize').innerHTML = `>\${data_arr[0]}<br>${data_arr[2]}`; 
		} else {
			document.getElementById('sequenceSize').innerHTML = `>\${data_arr[0]}<br>\${data_arr[2].replaceAll(/\[([^)]+)\]/g,'<span style="color:red;">[$1]</span>')}`;
		}
		*/
		
		$("#loading").modal('hide');
		
		$('#sequenceDownload').attr('data-jobid', flanking_sequence_jobid);
		
   	}
   	
   	function downloadFlankingSequenceCSV(jobid) {
   		//console.log(jobid);
   		
   		const anchorElement = document.createElement('a');
   	  	document.body.appendChild(anchorElement);
   	  	anchorElement.download = 'flanking_sequence.csv'; // a tag에 download 속성을 줘서 클릭할 때 다운로드가 일어날 수 있도록 하기
   	  	anchorElement.href = `/ipet_digitalbreed/result/variants_browser/flanking/\${jobid}/\${jobid}_for_flnking.csv`; // href에 url 달아주기
   	  	anchorElement.click(); 
   	  	document.body.removeChild(anchorElement); 
   	}
   	
   	async function show_Selection_Grid() {
		//console.log("selection grid");   
		
		const url_string = './vb_features_grid_Selection.jsp';
		
		const map_params = new Map();
		//map_params.set("chr", selectedOption("Chr_select").dataset.chr);
		map_params.set("jobid", linkedJobid);
		
		const data = await getFetchData(url_string,map_params);
		
		console.log("selection : ", data);
		SelectionList_gridOptions.api.setRowData(data);
   	}
   	
   	function selection_mark() {
   		
   		clear_mark_all();
   		
   		const chr = selectedOption("Chr_select").dataset.chr;
   		const length = selectedOption("Chr_select").dataset.length; 
   		
   		//const selected_nodes = SelectionList_gridOptions.api.getSelectedNodes();
   		const selection_marked_SnpEff = SelectionList_gridOptions.api.getSelectedRows().filter((node) => (node.chr == chr) && (node.snpeff == true));
   		const selection_marked_GWAS = SelectionList_gridOptions.api.getSelectedRows().filter((node) => (node.chr == chr) && (node.gwas == true));
   		const selection_marked_marker = SelectionList_gridOptions.api.getSelectedRows().filter((node) => (node.chr == chr) && (node.marker_candidate == true));
   		
   		
   		for(node of selection_marked_SnpEff) {
   			const mark_pos = Number(node.pos);
   			const mark = document.querySelector(`.chromosomeStackDiv[data-order="\${parseInt(mark_pos * 2000 / length)}"]`);
   			const mark_data_order = mark.dataset.order;
   			
   			
   			if(!document.querySelector(`[data-snpeff_order="\${mark_data_order}"]`)){
	   			const childDiv = document.createElement('div');
				childDiv.dataset.snpeff_order = mark_data_order;
				childDiv.dataset.toggle="popover";
				childDiv.dataset.placement = "top";
				childDiv.dataset.trigger = "hover";
				childDiv.dataset.content = thousands_separator(mark_pos);
				childDiv.style.position = "absolute";
				childDiv.style.bottom = "13px";
				childDiv.style.right = "-3px";
				childDiv.innerHTML = `<svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#0073E5;" /></svg>`;
				childDiv.addEventListener("click", (e) => {
					changeInputValue(mark_pos);
				});
				
				mark.appendChild(childDiv);
   			}
   		}
   		
   		for(node of selection_marked_GWAS) {
   			const mark_pos = Number(node.pos);
			const mark = document.querySelector(`.chromosomeStackDiv[data-order="\${parseInt(mark_pos * 2000 / length)}"]`);
			const mark_data_order = mark.dataset.order;
			
			if(!document.querySelector(`[data-gwas_order="\${mark_data_order}"]`)){
				const childDiv = document.createElement('div');
				childDiv.dataset.gwas_order = mark_data_order;
				childDiv.dataset.toggle="popover";
				childDiv.dataset.placement = "top";
				childDiv.dataset.trigger = "hover";
				childDiv.dataset.content = thousands_separator(mark_pos);
				childDiv.style.position = "absolute";
				childDiv.style.bottom = "19px";
				childDiv.style.right = "-3px";
				childDiv.innerHTML = `<svg height="5" width="6"><polygon points="3,5 6,0 0,0" style="fill:#2cb637;" /></svg>`;
				childDiv.addEventListener("click", (e) => {
					changeInputValue(mark_pos);
				});
				
				mark.appendChild(childDiv);
			}
   		}
   		
   		$('[data-toggle="popover"]').popover();
   	}
   	
   	function onClickMarkerCategory(id) {
		document.getElementById('Enzyme_Grid').style.display = id=='CAPs' ? 'block' : 'none';
		
		if(id != 'CAPs') {
			enzyme_gridOptions.api.deselectAll();
		}
		
		enzyme_gridOptions.columnApi.autoSizeAllColumns();
	}
   	
   	function getUpgmaSelectList() {
   		fetch(`./vb_getSelectLists.jsp?command=UPGMA&jobid=\${linkedJobid}`)
   		.then((response) => response.json())
   		.then((data) => {
   			console.log(data);
   			for(let i=0 ; i<data.length ; i++) {
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
   		
   		VariantBrowser_gridOptions.api.setRowData(updatedNodesData);
   		console.timeEnd("sort_vb_by_UPGMA");
   	}
   	
   	function resetSort_UPGMA() {
   		// UPGMA Reset 버튼
   		document.getElementById('reset_UPGMA').dataset = "true";
   	}
   	
   	function getStructureSelectList() {
   		console.log("sturcture");
   		// structure new analysis 시 vcf_data no값이 안 넘어감. select option값에 넣어주는 것부터 시작해야 함.
   	}
   	
   	async function primerDesign() {
   		
   		if(!document.getElementById('comment').value) {
   			return alert('comment를 입력해주세요.');
   		}
   		
   		const form = document.getElementById('uploadForm');
   		const formData = new FormData(form);
   		
   		
   		const jobid_pd = await fetch('../getJobid.jsp').then((response)=>response.text());
   		const chr_info = new Array();
   		SelectionList_gridOptions.api.forEachNode((node) => {
   			chr_info.push({
   				'chr': node.data.chr,
   				'pos': node.data.pos,
   			})
   		});
   		
   		const enzymes = enzyme_gridOptions.api.getSelectedRows();

   		formData.append('jobid_vcf', linkedJobid);
   		formData.append('filename_vcf', filename);
   		formData.append('refgenome', refgenome);
   		formData.append('fasta_filename', fasta_filename);
   		formData.append('jobid_pd', jobid_pd);
   		formData.append('chr_info', JSON.stringify(chr_info));
   		formData.append('enzymes', JSON.stringify(enzymes));
   		formData.append('varietyid', varietyid);

   		const params = new URLSearchParams(formData);
   		/*
   		for(const key of formData.keys()) {
   			console.log(key, ":", formData.get(key));
   		}
   		*/
   		
   		
   		fetch(`./vb_features_insertSql_PrimerDesign.jsp`, {
   			method: "POST",
   			headers: {
   				"Content-Type": "application/x-www-form-urlencoded",
   			},
   			body: params
   		})
   		.then(response => {
   			if(!response.ok) {
   				throw new Error('error');
   			}
   		})
   		
   		
   		fetch(`./vb_features_primerDesign.jsp`, {
   			method: "POST",
   			headers: {
   				"Content-Type": "application/x-www-form-urlencoded",
   			},
   			body: params
   		})
   		.then(response => {
   			if(!response.ok) {
   				throw new Error('error');
   			}
   		})
   		
   		setTimeout( function () {
   			$("#Primer_Design").modal("hide");
   			alert("분석이 실행되었습니다. primer design에서 결과를 확인해주세요.");
   		}, 1000);
   		
   	}
   	
   	function resizeGrid() {
   		
   		setTimeout( () => {
			
   			const position = Number(document.getElementById('currentId').dataset.position);
			getGeneModel(position);
   			
			
   			SnpEff_gridOptions.columnApi.autoSizeAllColumns(true);
			
			if(Object.keys(GWAS_gridOptions_model).length !== 0) {
				for(const GWAS_gridOptions in GWAS_gridOptions_model) {
					GWAS_gridOptions_model[GWAS_gridOptions].columnApi.autoSizeAllColumns();
				}
			}
			
			SelectionList_gridOptions.columnApi.autoSizeAllColumns(false);
			
		}, 100)
   	}
   	
   	function resetForm() {
   		document.getElementById('Enzyme_Grid').style.display = 'none';
   		document.getElementById('uploadForm').reset();
   		enzyme_gridOptions.api.deselectAll();
   	}
   	
   	$("#flankingSequenceModal").on('hidden.bs.modal', function(e) {
   		document.getElementById('flankingSequence').value = "";
   	});
   	
   	$("#Primer_Design").on("shown.bs.modal", function(e) {
		enzyme_gridOptions.columnApi.autoSizeAllColumns();
	});
   	
   	$("#Primer_Design").on("hidden.bs.modal", function(e) {
   		resetForm();
	});
   	
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
	
	async function getFetchTextData(url_string, map_params) {
		
		const baseURL = window.location.href;
		const url = new URL(url_string, baseURL);
		
		if(map_params.size !== 0) {
			for(const [key, value] of map_params) {
				url.searchParams.set(key, value);
			}
		}
		
		return await fetch(url).then((response)=> response.text()).catch((error) => console.log("non-text response fetch"));
	}
	
	function selectedOption(id) {
		const selectEl = document.getElementById(id);
		return selectEl[selectEl.selectedIndex];
	}
	
	const thousands_separator = (number) => number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
	
	window.onresize = resizeGrid;
		
</script>

</body>
<!-- END: Body-->

</html>