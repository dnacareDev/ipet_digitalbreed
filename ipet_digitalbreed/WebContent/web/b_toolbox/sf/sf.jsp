<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->
<%@ page import="java.io.*"%>
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
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/vendors.min.css">
 	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/innorix/innorix.css">    
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <!--  
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/nouislider.min.css">
	-->
    <!--  
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/vendors.min.css">
    -->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/tables/ag-grid/ag-grid.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/tables/ag-grid/ag-theme-alpine.css"> 
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/plugins/forms/validation/form-validation.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/forms/select/select2.min.css">
	
	<!--  
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/jquery-ui/jquery-ui.min.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/jquery-ui/jquery-ui.structure.min.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/jquery-ui/jquery-ui.theme.min.css">
    -->
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/themes/dark-layout.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/themes/semi-dark-layout.css">

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/core/menu/menu-types/horizontal-menu.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/dashboard-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/card-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/plugins/tour/tour.css">
    <!--  
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/plugins/extensions/ext-component-sliders.css">
    -->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/aggrid.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/bootstrap5_custom.css">
    <link rel="stylesheet" type="text/css" href="../../../css/index_assets/css/icons.min.css">
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

.select2-container--default .select2-results__option[aria-disabled=true] {
    display: none;
}

/* placeholder float-right */
::-webkit-input-placeholder { 
	text-align:right; 
}

.min-range-max {
	color: gray;
	cursor: pointer;
}

.irx-file-inner-wrapper {
	height: 30px !important;
}

.innorix_basic div.irx_filetree, .irx_container {
	border : none !important;
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

    <jsp:include page="../../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="sf"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;Subset Filter</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../../mainboard.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item">Breeder's toolbox
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
                    <div id="vcf_status" class="card" style="display:none">
                    	<div class='card-content'>
							<div class='card-body'>
								<div class='row'>
									<div class='col-12'>
										<ul class='nav nav-pills nav-active-bordered-pill'>
											<li class='nav-item'><a class='nav-link active' id='qf_1' data-toggle='pill' href='#pill1' aria-expanded='true'>Filtering Info </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_2' data-toggle='pill' href='#pill2' aria-expanded='false'>Variant </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_3' data-toggle='pill' href='#pill3' aria-expanded='false'>DP </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_4' data-toggle='pill' href='#pill4' aria-expanded='false'>Missing </a></li>
											<li class='nav-item'><a class='nav-link' id='qf_5' data-toggle='pill' href='#pill5' aria-expanded='false'>Density Plot </a></li>
										</ul>
										<div class='tab-content'>
											<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill1_frame' onload='hideSpinner(); gridOptions.api.sizeColumnsToFit();'></iframe>
											</div>
											<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill2_frame' onload='hideSpinner()'></iframe>
											</div>
											<div class='tab-pane' id='pill3' aria-labelledby='base-pill3'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill3_frame' onload='hideSpinner()'></iframe>
											</div>
											<div class='tab-pane' id='pill4' aria-labelledby='base-pill4'>
												<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill4_frame' onload='hideSpinner()'></iframe>
											</div>
											<div class='tab-pane' id='pill5' aria-labelledby='base-pill4'>
												<iframe src = '' height='650px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill5_frame' onload='hideSpinner()'></iframe>
											</div>
										</div>
									</div>
								</div>
								<input type='hidden' id='jobid'>
								<input type='hidden' id='resultpath'>
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
        <div class="modal-dialog  modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">Subset Filter New analysis</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadForm">
					    <div class="form-body">
					    	<div class="row">
					            <div class="col-md-12 col-12 mt-1">
					            	<div class="form-label-group mb-1" >
					                    <select class="select2 form-select" id="VcfSelect" onchange="onChangeVcf();">
					                    </select>
					                </div>
					            </div>
					    	</div>
					        <div class="row">
					            <fieldset class="border w-100 ml-1 mr-1">
						        <legend class="w-auto ml-1 mr-1">Select specific regions</legend>
						            <div class="col-12">
					            		<div class="row pl-2 pr-2" style="display:flex; column-gap:10px;">
							            	<div class="form-check col-12 col-lg-3 pl-1">
							            		<input type="radio" class="form-check-input" id="userSelect" name="selectRegion" value="userSelect" onclick="document.getElementById('userSelectDiv').style.display='flex'; document.getElementById('fileUploadDiv').style.display='none'; box.removeAllFiles();" checked/>
		                                        <label class="form-check-label" for="userSelect" style="margin-left:4px;" >User select</label>
							            	</div>
							            	<div class="form-check col-12 col-lg-3 pl-1">
							            		<input type="radio" class="form-check-input" id="bedFileUpload" name="selectRegion" value="bedFileUpload" onclick="document.getElementById('userSelectDiv').style.display='none'; document.getElementById('fileUploadDiv').style.display='flex'; box.removeAllFiles();" />
		                                        <label class="form-check-label" for="bedFileUpload" style="margin-left:4px;" >BED file upload</label>
		                                        <i class="ri-question-line" data-toggle="popover" data-trigger="hover" data-container="#backdrop" data-content="• BED file<br>염색체명, 시작 위치, 끝 위치 세 열이 comma(,)로 구분된 파일<br>* 예시<br>chr1&nbsp;&nbsp;&nbsp;&nbsp;1&nbsp;&nbsp;&nbsp;&nbsp;1000000" data-html="true" ></i>
							            	</div>
							            	<div class="form-check col-12 col-lg-3 pl-1">
							            		<input type="radio" class="form-check-input" id="posFileUpload" name="selectRegion" value="posFileUpload" onclick="document.getElementById('userSelectDiv').style.display='none'; document.getElementById('fileUploadDiv').style.display='flex'; box.removeAllFiles();" />
		                                        <label class="form-check-label" for="posFileUpload" style="margin-left:4px;" >Pos. file upload</label>
		                                        <i class="ri-question-line" data-toggle="popover" data-trigger="hover" data-container="#backdrop" data-content="• Pos file<br>변이 위치를 담은 position 파일로 염색체명, 변이위치 정보가 comma(,)로 구분되어 작성된 파일<br>* 예시<br>chr1&nbsp;&nbsp;&nbsp;&nbsp;1" data-html="true" ></i> 
							            	</div>
					            		</div>
						            </div>
						            <div class="col-12 mt-1">
						            	<div id="userSelectDiv" class="row" style="display:flex; justify-content:space-between;">
					            			<div class="col-12 col-lg-6">
												<div class="col-12 mb-2 p-0">Select chromosome</div>
												<div id="selectChromosomeGrid" class="ag-theme-alpine mb-1" style="margin: 0px auto; width: 98%; height:220px;"></div>
											</div>
					            			<div class="col-12 col-lg-6">
					            				<div class="col-12 mb-2 p-0">
						            				<span>Region by chromosome</span>
						            				<span><button type="button" id="addPosition" class="btn btn-sm btn-warning" style="float: right; display:flex; justify-content:center;" onclick="addPositionToRegion(this.dataset.chromosome, this.dataset.length);">
						            						<i class="feather icon-plus-square" style="font-size:12px;"> Add</i>
						            					</button>
						            				</span>
					            				</div>
					            				<div id="regionByChromosomeGrid" class="ag-theme-alpine mb-1" style="margin: 0px auto; width: 98%; height:220px;"></div>
					            			</div>
					            		</div>
					            		<div id="fileUploadDiv" class="row" style="display:none;">
					            			<div class="col-12 p-1">
					            				<div id="fileControl" style="margin: 0px auto; border: 1px solid #48BAE4;"></div>
					            			</div>
					            		</div>
						            </div>
						        </fieldset>
						        <fieldset class="border w-100 m-1">
						        <legend class="w-auto ml-1 mr-1">Select a subset of sample</legend>
						            <div class="col-md-12 col-12">
					            		<div class="row pl-2 pr-2" style="display:flex; column-gap:10px;">
							            	<div class="form-check col-12 col-lg-3 pl-1">
							            		<input type="radio" class="form-check-input" id="userSelectSample" name="selectSubSetOfSample" onclick="document.getElementById('sampleNameGrid').style.display='block'; document.getElementById('sampleFileControl').style.display='none'; sample_box.removeAllFiles();" checked />
		                                        <label class="form-check-label" for="userSelectSample" style="margin-left:4px;" >User Select</label>
							            	</div>
							            	<div class="form-check col-12 col-lg-6 pl-1">
							            		<input type="radio" class="form-check-input" id="sampleNameFileUpload" name="selectSubSetOfSample" onclick="document.getElementById('sampleNameGrid').style.display='none'; document.getElementById('sampleFileControl').style.display='block'; sample_box.removeAllFiles();" />
		                                        <label class="form-check-label" for="sampleNameFileUpload" style="margin-left:4px;" >Sample name file upload</label>
		                                        <i class="ri-question-line" data-toggle="popover" data-trigger="hover"  data-container="#backdrop" data-content="• 샘플 목록 파일<br>* 예시<br>sample1<br>sample2<br>...<br>sample10<br>" data-html="true"></i>
							            	</div>
					            		</div>
						            </div>
						            <div class="col-md-12 col-12 mt-1 mb-1">
						            	<div class="row">
					            			<div class="col-12">
												<div id="sampleNameGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:220px;"></div>
												<div id="sampleFileControl" style="display:none; margin: 0px auto; border: 1px solid #48BAE4;"></div>
											</div>
					            		</div>
						            </div>
						        </fieldset>
					            <div class="col-12">
					                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="Execute();">Run</button>
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="javascript:resetQF();">Reset</button>
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
    <script src="../../../css/app-assets/vendors/js/vendors.min.js"></script>
    <script src="../../../css/app-assets/vendors/js/innorix/innorix.js"></script>
    <script src="../../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../../css/app-assets/js/scripts/forms/select/form-select2_B_toolbox.js"></script>
    <!--  
    <script src="../../../css/app-assets/vendors/js/jquery-ui/jquery-ui.min.js"></script>
    -->
        
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
	<script src="../../../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../../../css/app-assets/js/core/app-menu.js"></script>
    <script src="../../../css/app-assets/js/core/app.js"></script>
    <script src="../../../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="../../../css/app-assets/js/scripts/ag-grid/ag-grid_sf.js"></script>
    <!--  
    <script src="../../../css/app-assets/js/scripts/plotly-latest.min.js"></script>
    -->   
	<script src="../../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">

	//Statistics에서 링크를 타고 왔을때 받는 전역변수. AG-Grid 로딩직후 cell click 용도로 사용
	var linkedJobid = "<%=linkedJobid%>";
	
	const vcf_map = new Map();
	//const chr_regions = new Map();
	const chr_regions = {};

	$(function () {
   		$('[data-toggle="popover"]').popover()
	});
	
   	$(document).ready(function(){
   		vcfFileList();
   	});
   	
   	let sample_box = new Object();
   	let box = new Object();
    window.onload = function() {
        
    	box = innorix.create({
            el: '#fileControl', // 컨트롤 출력 HTML 객체 ID
            height          : 150,
            width			: '99%',
            maxFileCount   : 1,  
            allowExtension: ["csv"],
			addDuplicateFile : false,
            agent: false, // true = Agent 설치, false = html5 모드 사용                    
            uploadUrl: './sf_fileUploader.jsp' // 업로드 URL
        });

        box.on("addFileError", function(p) {
            alert("하나의 csv 파일만 업로드 할 수 있습니다.")
        }),

        // 업로드 완료 이벤트
        box.on('uploadComplete', function (p) {
        	
        	console.log("p : ", p);
        	//console.log("filename : ", p.files[0].file.name);
			p.postData['subset_filename'] = p.files[0]['file']['name'];
			if (p.postData.sample_select == "sampleNameFileUpload") {
    	    	sample_box.setPostData(p.postData);
    	    	sample_box.upload();
        	} else {
        		fetch(`./sf_analysis.jsp`, {
    	    		method: "POST",
    	    		headers: {
    	    			"Content-Type": "application/json",
    	    		},
    	    		body: JSON.stringify(p.postData)
    	    	})
        	}
        });
    	
    	
    	// 파일전송 컨트롤 생성
        sample_box = innorix.create({
            el: '#sampleFileControl', // 컨트롤 출력 HTML 객체 ID
            height          : 150,
            width			: '99%',
            maxFileCount   : 1,  
            allowExtension: ["csv"],
			addDuplicateFile : false,
            agent: false, // true = Agent 설치, false = html5 모드 사용                    
            uploadUrl: './sf_sampleFileuploader.jsp' // 업로드 URL
        });

        sample_box.on("addFileError", function(p) {
            alert("하나의 csv 파일만 업로드 할 수 있습니다.")
        }),

        // 업로드 완료 이벤트
        sample_box.on('uploadComplete', function (p) {
        	
        	console.log("sample_box p : ", p);
        	
        	p.postData['sample_filename'] = p.files[0]['file']['name'];
        	
        	fetch(`./sf_analysis.jsp`, {
	    		method: "POST",
	    		headers: {
	    			"Content-Type": "application/json",
	    		},
	    		body: JSON.stringify(p.postData)
	    	})

        });
        
        
        
        
        
    };

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
			// ${data}값을 jsp에서는 넘기고 javascript의 백틱에서 받으려면 \${data} 형식으로 써야한다 
			$("#VcfSelect").append(`<option data-jobid=\${data[i].jobid} data-filename=\${data[i].filename} data-uploadpath=\${data[i].uploadpath} data-refgenome_id=\${data[i].refgenome_id} > \${data[i].filename} (\${data[i].comment}) </option>`);
		}
    }
    
	// 로딩이 완료되면 로딩창 소멸
	function hideSpinner() {
		$("#iframeLoading").modal('hide');
	}
   	
	function saveToVcf(filename, jobid, refgenome, refgenome_id, annotation_filename) { 
		if(!confirm("결과를 Genotype DB에 저장하시겠습니까?")) {
			return;
		}
		
		
	   	const variety_id = $( "#variety-select option:selected" ).val();
	   	
	   	//console.log(variety_id);
	   	//console.log(filename);
	   	//console.log(jobid);
	   	console.log("saveToVcf refgenome :", refgenome );
	   	
	   	
	   	fetch(`./sf_fileupload_ext.jsp?jobid=\${jobid}&vcf_filename=\${filename}&variety_id=\${variety_id}&refgenome=\${refgenome}&refgenome_id=\${refgenome_id}&annotation_filename=\${annotation_filename}`);
	   	
	   	$("#iframeLoading").modal('show');
	   	
	   	//시간이 조금 지나면 Rscript 작동 여부에 관계없이 새로고침
   		setTimeout( function () {
   			refresh();
   			hideSpinner();
   			$("#backdrop").modal("hide");
   			}
   		, 2000);
	}
	
	function moveToVcf(jobid) {
		console.log(jobid);
		
		let form = document.createElement('form'); // 폼객체 생성
		let objs;
		objs = document.createElement('input'); // 값이 들어있는 녀석의 형식
		objs.setAttribute('type', 'hidden'); // 값이 들어있는 녀석의 type
		objs.setAttribute('name', 'linkedJobid'); // 객체이름
		objs.setAttribute('value', jobid); //객체값
		form.appendChild(objs);
		form.setAttribute('method', 'post'); //get,post 가능
		form.setAttribute('action', "../../database/genotype.jsp"); //보내는 url
		form.target = "VCF";
		document.body.appendChild(form);
		form.submit();
	}
	
	async function onChangeVcf() {

		//chr_regions.clear();
		for (const prop of Object.getOwnPropertyNames(chr_regions)) {
			delete chr_regions[prop];
		}
		//sample_map.clear();
		
		const jobid = selectedOption('VcfSelect').dataset.jobid;
		const filename = selectedOption('VcfSelect').dataset.filename;
		
		//vcf_map
		if( vcf_map.get(jobid) !== null && vcf_map.get(jobid) !== undefined ) {
			selectChromosome_gridOptions.api.setRowData(vcf_map.get(jobid)?.chr);
			sampleNameGrid_gridOptions.api.setRowData(vcf_map.get(jobid)?.sample);
			selectChromosome_gridOptions.api.forEachNode((node) => {
				node.setSelected(true);
			});
			return;
		}
		
		const url_string = './sf_getSubsetOfRegionsAndSamples.jsp';
		const map_params = new Map();
		map_params.set("jobid", jobid);
		map_params.set("filename", filename);
		
		const vcf_information = await getFetchData(url_string, map_params);
		vcf_map.set(jobid, vcf_information);
		
		//debugger;
		selectChromosome_gridOptions.api.setRowData(vcf_information.chr);
		selectChromosome_gridOptions.api.forEachNode((node) => {
			node.setSelected(true);
		});
		regionByChromosome_gridOptions.api.setRowData();
		sampleNameGrid_gridOptions.api.setRowData(vcf_information.sample);
	}
	
	function addPositionToRegion(chromosome, length) {
		if(chromosome === null || chromosome === undefined) {
			return;
		}
		
		//chr_regions.get(chromosome).push({'start_pos': 1, 'end_pos': length});
		chr_regions[chromosome].push({'start_pos': '1', 'end_pos': length.toString()});
		regionByChromosome_gridOptions.api.setRowData(chr_regions[chromosome]);
		
		//console.log(chromosome);
	}
   	
	function resetQF() {
		//document.getElementById('uploadForm').reset();
		
		//document.getElementById('userSelect').checked = true;
		//document.getElementById('userSelectSample').checked = true;
		document.getElementById('userSelect').click();
		document.getElementById('userSelectSample').click();
		
		vcfFileList();
		
		selectChromosome_gridOptions.api.setRowData();
    	regionByChromosome_gridOptions.api.setRowData();
    	sampleNameGrid_gridOptions.api.setRowData();
		
	}
   	
    async function Execute() {
    	
	   	const variety_id = $( "#variety-select option:selected" ).val();
    	
    	const select_vcf = document.getElementById('VcfSelect');
    	const jobid_vcf = select_vcf.options[select_vcf.selectedIndex].dataset.jobid;
    	const file_name = select_vcf.options[select_vcf.selectedIndex].dataset.filename;
    	const refgenome_id = select_vcf.options[select_vcf.selectedIndex].dataset.refgenome_id;
    	
    	const jobid_sf = await fetch('../../getJobid.jsp')
    					.then((response) => response.text());
    	
    	
    	const region_select = document.querySelector(`input[name='selectRegion']:checked`).id;
    	const sample_select = document.querySelector(`input[name='selectSubSetOfSample']:checked`).id;
    	
    	selectChromosome_gridOptions.api.forEachNode((node) => {
    		//console.log("node", node);
    		if(node.selected == false) {
    			//chr_regions.delete(node.data.chromosome);
    			delete chr_regions[node.data.chromosome];
    		}
    	})
    	
    	const region = JSON.parse(JSON.stringify(chr_regions));
    	
    	const sample_arr = new Array();
    	sampleNameGrid_gridOptions.api.forEachNode((node) => {
    		if(node.selected == true) {
	    		sample_arr.push(node.data.sample);
    		}
    	})
    	
    	const data = {
    		"variety_id": variety_id,
    		"refgenome_id": refgenome_id,
    		"jobid_vcf": jobid_vcf,
    		"jobid_sf": jobid_sf,
    		"region_select": region_select,
    		"sample_select": sample_select,
    		"file_name": file_name,
    		"region": region,
    		"sample_arr": sample_arr,
    	}
    	
    	//debugger;
    	
    	if(jobid_vcf == -1) {
    		alert("VCF 파일을 선택하세요");
    		return;
    	}
    	
    	if(region_select != "userSelect") {
	    	box.setPostData(data);
	    	box.upload();
    	} else if (sample_select == "sampleNameFileUpload") {
	    	sample_box.setPostData(data);
	    	sample_box.upload();
    	}
    	
    	
    	
    	
    	fetch(`./sf_insertSql.jsp`, {
    		method: "POST",
    		headers: {
    			"Content-Type": "application/json",
    		},
    		body: JSON.stringify(data)
    	})
    	
    	
    	if(region_select == "userSelect" && sample_select == "userSelectSample" ) {
	    	fetch(`./sf_analysis.jsp`, {
	    		method: "POST",
	    		headers: {
	    			"Content-Type": "application/json",
	    		},
	    		body: JSON.stringify(data)
	    	})
    	}
    	
    	
    	
    	//시간이 조금 지나면 Rscript 작동 여부에 관계없이 새로고침
   		setTimeout( function () {
   			refresh();
   			$("#backdrop").modal("hide");
   			}
   		, 1000);
    	
    }
    
    $('#backdrop').on('shown.bs.modal', function (e) {
    	selectChromosome_gridOptions.api.sizeColumnsToFit();
    	regionByChromosome_gridOptions.api.sizeColumnsToFit();
    	sampleNameGrid_gridOptions.api.sizeColumnsToFit();
    });
	
   	$('#backdrop').on('hidden.bs.modal', function (e) {
   		resetQF();
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
	
	function selectedOption(id) {
		const selectEl = document.getElementById(id);
		return selectEl[selectEl.selectedIndex];
	}
	
	const thousands_separator = (number) => number.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
       
</script>

</body>
<!-- END: Body-->

</html>