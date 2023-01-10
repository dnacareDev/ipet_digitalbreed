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
	
	#VariantBrowserCanvas {
		width: 100%;
	}
	
	.form-control::placeholder {
	  	color : #212529;
	  	font-size : 1rem;
	  	font-family: 'SDSamliphopangche_Outline';
	  	-webkit-transition : all 0.2s ease;
	    transition : all 0.2s ease;
	}

</style>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";
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
            <!--  
            <div class="content-header row">
                <div class="content-header-left col-md-9 col-12 mb-2">
                    <div class="row breadcrumbs-top">
                        <div class="col-12">
                            <h2 class="content-header-title float-left mb-0">&nbsp;Variants browser</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../index.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">Variants browser
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
            -->
            <div class="content-body">
                <!-- Basic example section start -->
                <section id="basic-examples">
                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
	                                <div class="col-xl-8">
	                                	<div class="row">
	                                		<div style="width:20%; min-width:200px; padding-left:13px;"> 
												<select id='Chr_select' class='select2 form-select float-left'>
													<option data-chr="-1" disabled hidden selected>Select Chromosome</option>
												</select>
											</div>
											<div style="width:20%; min-width:200px; padding-left:14px;"> 
												<input type="text" id="comment" class="form-control" placeholder="Select Position" oninput="inputNumberRange(this);">
											</div>
	                                	</div>
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
	                                	<div class="row">
				                            <div id="VariantBrowserGrid" class="ag-theme-alpine" style="margin: 13px auto; width: 98%; height:420px;"></div><br>
	                                	</div>
	                                </div>
	                                <div class="col-xl-4">
		                                <div class="row">
		                                	<div class="col-12">
			                                	<ul id='button_list' class='nav nav-pills nav-active-bordered-pill'>
		                             				<li class='nav-item col-3' style="padding:0px;"><a class='nav-link active text-center' id='result_1_1' data-toggle='pill' href='#pill1' aria-expanded='true'>SnpEff</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_2' data-toggle='pill' href='#pill2' aria-expanded='false'>GWAS</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_3' data-toggle='pill' href='#pill3' aria-expanded='false'>Marker</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_4' data-toggle='pill' href='#pill4' aria-expanded='false'>Selection</a></li>
												</ul>
												<div class='tab-content'>
	  												<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
	  													<div class="row">
		  													<div style="width:50%; padding-left:14px;"> 
																<select id='SnpEff_select' class='select2 form-select float-left'>
																	<option data-chr="-1" disabled hidden selected>Select Chromosome</option>
																</select>
															</div>
														</div>
														<div class="row mt-2" style="padding-left: 6px;">
											            	<div class="form-check" style="margin-right:1vw;">
											            		<input type="checkbox" class="form-check-input" id="high" />
						                                        <label class="form-check form-check-label" for="high" style="margin-left:-16px; margin-top:1px;" >HIGH</label>
											            	</div>
											            	<div class="form-check" style="margin-right:1vw;">
											            		<input type="checkbox" class="form-check-input" id="moderate" />
						                                        <label class="form-check form-check-label" for="moderate" style="margin-left:-16px; margin-top:1px;" >MODERATE</label>
											            	</div>
											            	<div class="form-check" style="margin-right:1vw;">
											            		<input type="checkbox" class="form-check-input" id="low" />
						                                        <label class="form-check form-check-label" for="low" style="margin-left:-16px; margin-top:1px;" >LOW</label>
											            	</div>
											            	<div class="form-check">
											            		<input type="checkbox" class="form-check-input" id="modifier" />
						                                        <label class="form-check form-check-label" for="modifier" style="margin-left:-16px; margin-top:1px;" >MODIFIER</label>
											            	</div>
									            		</div>
									            		<div class="row mt-1" style="float:right;">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:29px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
									            		</div>
									            		<div class="row col-12 mt-1">
															<div id='SnpEff_Grid' class="ag-theme-alpine" style="height:245px; width:100%;"></div>
														</div>
	  												</div>
	  												<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
	  													<div style="width:50%;"> 
															<select id='GWAS_select' class='select2 form-select float-left'>
																<option data-chr="-1" disabled hidden selected>Select result</option>
															</select>
														</div>
														<div class="row mt-1" style="float:right;">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:29px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
									            		</div>
									            		<div class="row col-12 mt-1">
	  														<div id='GWAS_Grid' class="ag-theme-alpine" style="height:245px; width:100%;"></div>
	  													</div>
	  												</div>
	  												<div class='tab-pane' id='pill3' aria-labelledby='base-pill3'>
	  													<div style="width:50%;"> 
															<select id='Marker_select' class='select2 form-select float-left'>
																<option data-chr="-1" disabled hidden selected>Select result</option>
															</select>
														</div>
														<div class="row mt-1" style="float:right;">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:29px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
									            		</div>
									            		<div class="row col-12 mt-1">
	  														<div id='Marker_Grid' class="ag-theme-alpine" style="height:245px; width:100%;"></div>
	  													</div>
	  												</div>
	  												<div class='tab-pane' id='pill4' aria-labelledby='base-pill4'>
	  													<div style="width:50%;"> 
															<select id='SelectionList_select' class='select2 form-select float-left'>
																<option data-chr="-1" disabled hidden selected>Select result</option>
															</select>
														</div>
														<div class="row mt-1" style="float:right;">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light mb-1" style="margin-left:13px; margin-right:16px;" onclick="filter_SnpEff();">Flanking sequence</button>
											            		<button type="button" class="btn btn-light mb-1" style="margin-left:13px; margin-right:16px;" onclick="alert('전송되었습니다.');">Primer Design</button>
											            		<button type="button" class="btn btn-light mb-1" style="margin-left:13px; margin-right:29px;" onclick="filter_SnpEff();">표지</button>
											            	</div>
									            		</div>
									            		<div class="row col-12 mt-1">
	  														<div id='SelectionList_Grid' class="ag-theme-alpine" style='height:245px; width:100%;'></div>
	  													</div>
	  												</div>
	  											</div>
		                                	</div>
		                                </div>
		                                <div class="row mt-2">
		                                	<div class="col-12">
			                                	<ul id='button_list' class='nav nav-pills nav-active-bordered-pill'>
		                             				<li class='nav-item col-3' style="padding:0px;"><a class='nav-link active text-center' id='result_1_1' data-toggle='pill' href='#pill5' aria-expanded='true'>UPGMA</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_2' data-toggle='pill' href='#pill6' aria-expanded='false'>STRUCTURE</a></li>
					   								<li class='nav-item col-3' style="padding:0px;"><a class='nav-link text-center' id='result_1_3' data-toggle='pill' href='#pill7' aria-expanded='false'>Haplotype</a></li>
												</ul>
												<div class='tab-content'>
	  												<div role='tabpanel' class='tab-pane active' id='pill5' aria-expanded='true' aria-labelledby='base-pill1'>
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
									            		<div class="row col-12 mt-1">
															<div id='UPGMA_Grid' class="ag-theme-alpine" style="height:260px; width:100%;"></div>
														</div>
	  												</div>
	  												<div class='tab-pane' id='pill6' aria-labelledby='base-pill2'>
	  													<div style="width:50%;"> 
															<select id='STRUCTURE_select' class='select2 form-select float-left'>
																<option data-chr="-1" disabled hidden selected>Select result</option>
															</select>
														</div>
														<div class="row mt-1" style="float:right;">
									            			<div class="col-12">
											            		<button type="button" class="btn btn-light mb-1" style="margin-right:29px;" onclick="filter_SnpEff();">정렬</button>
											            	</div>
									            		</div>
									            		<div class="row col-12 mt-1">
	  														<div id='STRUCTURE_Grid' class="ag-theme-alpine" style="height:260px; width:100%;"></div>
	  													</div>
	  												</div>
	  												<div class='tab-pane' id='pill7' aria-labelledby='base-pill3'>
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
									            		<div class="row col-12 mt-1">
	  														<div id='Haplotype_Grid' class="ag-theme-alpine" style="height:260px; width:100%;"><%-- --%></div>
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
    <script src="../../css/app-assets/vendors/js/innorix/innorix.js"></script>
    <script src="../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../css/app-assets/js/scripts/forms/select/form-select2_vb_features.js"></script>
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

	document.addEventListener('DOMContentLoaded', function() {
		//위쪽 캔버스
		const canvas = document.getElementById("chromosomeCanvas");
   		const canvasArea = document.getElementById("chromosomeCanvasArea");
   		
		canvas.width = canvasArea.offsetWidth * ( 1 - parseFloat(canvasArea.style.paddingRight) * 2 / 100 )
   		
   		const startX = canvas.width * 0.2;
   		const startY = canvas.height * 0.45;
   		const width = canvas.width  - (startX * 2);
   		const height = canvas.height - (startY * 2);
		
		drawChromosome(canvas, startX, startY, width, height);

		//1번 염색체 길이정보 획득
		readChrLength(1);
		
		
		
		
   		drawGeneModel();
   		
	})
	
	window.addEventListener('resize', function(e) {
		//위쪽 캔버스
		const canvas = document.getElementById("chromosomeCanvas");
   		const canvasArea = document.getElementById("chromosomeCanvasArea");
   		
		canvas.width = canvasArea.offsetWidth * ( 1 - parseFloat(canvasArea.style.paddingRight) * 2 / 100 )
   		
   		const startX = canvas.width * 0.2;
   		const startY = canvas.height * 0.45;
   		const width = canvas.width  - (startX * 2);
   		const height = canvas.height - (startY * 2);
		
		drawChromosome(canvas, startX, startY, width, height);
		drawChrPosition(canvas, startX, startY, width, height);
		
		
		
   		drawGeneModel();
	})
	
	
	var relativePositionX = null;
   	// resize시 mousemove event로 그렸던 빨간줄이 사라지지 않고 유지
	function drawChrPosition(canvas, startX, startY, width, height) {
		// 염색체 사각형 영역 내에서의 이벤트
			const context = canvas.getContext("2d");
			
			context.beginPath();
   			context.moveTo(startX + relativePositionX * width , startY);
   			context.lineTo(startX + relativePositionX * width , startY + height);
   			context.strokeStyle = '#DC0F00';
   			context.lineWidth = 2;
   			context.stroke();
   		
	}
   	
   	function drawChromosome(canvas, startX, startY, width, height) {
   		
   		if(canvas.getContext) {
   			const context = canvas.getContext("2d");
   			context.strokeStyle="#333333";
   			context.strokeRect(startX, startY, width, height);
   			
   			context.beginPath();
   			context.moveTo(startX + width * 0.1 , startY);
   			context.lineTo(startX + width * 0.1 , startY + height);
   			context.strokeStyle = '#808000';
   			context.lineWidth = 5;
   			context.stroke();
   			
   			context.beginPath();
   			context.moveTo(startX + width * 0.8 , startY);
   			context.lineTo(startX + width * 0.8 , startY + height);
   			context.strokeStyle = '#808000';
   			context.lineWidth = 5;
   			context.stroke();
   			
   		}
   		
   		canvas.addEventListener('mousemove', searchPosition);
   		
   	}
   	
   	function searchPosition(e) {
   		//console.log(e);
   		const canvas = document.getElementById("chromosomeCanvas");
   		const startX = canvas.width * 0.2;
   		const startY = canvas.height * 0.45;
   		const width = canvas.width  - (startX * 2);
   		const height = canvas.height - (startY * 2);
			
		const offsetX = e.offsetX;
		const offsetY = e.offsetY;
		
		// 염색체 사각형 영역 내에서의 이벤트
		if( (startX <= offsetX && offsetX <= startX + width) && (startY <= offsetY && offsetY <= startY + height) && canvas.getContext ) {
  			//console.log(startX, startY);
  			//console.log(width, height);
			//console.log(offsetX, offsetY);
			
			// 영역 안에 들어왔을때 빨간선의 포지션 (ratio) 저장
			relativePositionX = Math.floor(offsetX - startX) / width;
			
			
			const context = canvas.getContext("2d");
			
			context.clearRect(0,0,canvas.width,canvas.height)
			
			context.strokeStyle="#333333";
			context.lineWidth = 1;
   			context.strokeRect(startX, startY, width, height);
   			
   			context.beginPath();
   			context.moveTo(startX + width * 0.1 , startY);
   			context.lineTo(startX + width * 0.1 , startY + height);
   			context.strokeStyle = '#808000';
   			context.lineWidth = 5;
   			context.stroke();
   			
   			context.beginPath();
   			context.moveTo(startX + width * 0.8 , startY);
   			context.lineTo(startX + width * 0.8 , startY + height);
   			context.strokeStyle = '#808000';
   			context.lineWidth = 5;
   			context.stroke();
   			
   			
   			context.beginPath();
   			context.moveTo(offsetX , startY);
   			context.lineTo(offsetX , startY + height);
   			context.strokeStyle = '#DC0F00';
   			context.lineWidth = 2;
   			context.stroke();
   			
   			context.strokeStyle="#333333";
			context.lineWidth = 1;
   			context.strokeRect(offsetX - 30 , startY - 50 , 60 , 30);
   			
   			//context.fillStyle="#000000";
   			context.font = '16px sans-serif';
   			context.fillText( Math.floor(offsetX - startX), offsetX - 13 , 60); 
   			
		}
   	}
   	
   	function drawGeneModel() {
   		const canvas = document.getElementById("geneModelCanvas");
   		const canvasArea = document.getElementById("geneModelCanvasArea");
   		
   		//canvas.width = canvasArea.clientWidth * ( 1 - parseFloat(canvasArea.style.paddingRight) * 2 / 100 )
   		canvas.width = canvasArea.offsetWidth * ( 1 - parseFloat(canvasArea.style.paddingRight) * 2 / 100 )
   		
   		const startX = canvas.width * 0.2;
   		const startY = canvas.height * 0.45;
   		
   		const width = canvas.width  - (startX * 2);
   		const height = canvas.height - (startY * 2);
   		
   		if(canvas.getContext) {
   			const context = canvas.getContext("2d");
   			context.fillStyle="#999999";
   			context.strokeRect(startX, startY, width, height);
   			
   			context.beginPath();
   			context.moveTo(startX + width * 0.3 , startY);
   			context.lineTo(startX + width * 0.3 , startY + height);
   			context.strokeStyle = '#808000';
   			context.lineWidth = 5;
   			context.stroke();
   		}
   	}
   	
   	function readChrLength(chr_num) {
   		//console.log(chr_num);
   		
   		fetch(`./vb_readChrLength.jsp?chr_num=\${chr_num}`)
   		.then((response) => response.json())
   		.then((data) => {
   			//문자열 value값을 숫자화
   			for (key in data) {
   				data[key] = Number(data[key]);
   			}
   			console.log(data);
   		})
   	}
   	
   	function inputNumberRange(HTML_element) {
   		//console.log(HTML_element);
   		HTML_element.value = HTML_element.value.replace(/[^0-9.]/g, '').replace(/(\..*)\./g, '$1');
   		// if(params.value > 1000(chr length)) return 'chr length'
   	}
   	
</script>

</body>
<!-- END: Body-->

</html>