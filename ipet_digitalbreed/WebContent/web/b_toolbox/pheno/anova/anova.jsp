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
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/vendors.min.css">
 	<link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/innorix/innorix.css">    
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/tables/ag-grid/ag-grid.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/tables/ag-grid/ag-theme-alpine.css"> 
	<link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/plugins/forms/validation/form-validation.css">
	<link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/forms/select/select2.min.css">
	
	<!--  
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/jquery-ui/jquery-ui.min.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/jquery-ui/jquery-ui.structure.min.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/jquery-ui/jquery-ui.theme.min.css">
    -->
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/themes/dark-layout.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/themes/semi-dark-layout.css">

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/core/menu/menu-types/horizontal-menu.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/pages/dashboard-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/pages/card-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/plugins/tour/tour.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/pages/aggrid.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/css/bootstrap5_custom.css">
    <link rel="stylesheet" type="text/css" href="../../../../css/app-assets/vendors/css/pickers/flatpickr/flatpickr.min.css"> 
    <link rel="stylesheet" type="text/css" href="../../../../css/index_assets/css/icons.min.css">
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

    <jsp:include page="../../../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="anova"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;One-way ANOVA</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../../mainboard.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">Breeder's toolbox
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
                            <div id="myGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:450px;"></div><br>
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
											<li class='nav-item'><a class='nav-link active' id='nav1' data-toggle='pill' data-pill='individual' href='#pill1' aria-expanded='true'>Result</a></li>
										</ul>
				                    	<div id='content-list' class='tab-content'>
											<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
												<div class="row">
													<div class="col-12">
														<iframe src = '' loading="lazy" width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill1_frame' onload=' $("#iframeLoading").modal("hide"); gridOptions.api.sizeColumnsToFit();'></iframe>
													</div>
												</div>
												<div class="row">
													<div class="col-lg-8 col-12">
														<iframe src = '' loading="lazy" width='100%' height='480px' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill2_frame' onload='$("#iframeLoading").modal("hide"); gridOptions.api.sizeColumnsToFit();'></iframe>
													</div>
													<div class="col-lg-4 col-12">
														<iframe src = '' loading="lazy" width='100%' height='480px' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill3_frame' onload='$("#iframeLoading").modal("hide"); gridOptions.api.sizeColumnsToFit();'></iframe>
													</div>
												</div>
											</div>
				                    	</div>
									</div>
								</div>
							</div>
						</div>
                    	
                    </div>
                </section>
                <!-- Basic example section end -->
            </div>
        </div>
    </div>
    
	<!-- Modal start-->
	<!--  
    <div class="modal fade text-left" id="backdrop" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
    -->
    <div class="modal fade text-left" id="backdrop" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-lg" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">One-way ANOVA New Analysis</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                	<ul id='button_list' class='nav nav-pills nav-active-bordered-pill'>
						<li class='nav-item'><a class='nav-link active' id='navModal1' data-toggle='pill' data-pill='individual' href='#pillModal1' aria-expanded='true'>개체비교</a></li>
						<li class='nav-item'><a class='nav-link' id='navModal2' data-toggle='pill' data-pill='phenotype' href='#pillModal2' aria-expanded='true' onclick='gridOptionsTraitName.api.sizeColumnsToFit();gridOptionsTraitName_selected.api.sizeColumnsToFit();'>형질비교</a></li>
					</ul>
		            <div class="col-12">
		             	<div class="d-flex justify-content-start">
		                	<input type="text" id="comment" class="form-control" placeholder="Comment" name="comment" style="width:100%;" autocomplete="off" required data-validation-required-message="This name field is required">						                     
		                </div>
		            </div>
                	<div id='content-list' class='tab-content'>
						<div role='tabpanel' class='tab-pane active' id='pillModal1' aria-expanded='true' aria-labelledby='base-pill1'>
					        <div class="row">
					            <fieldset class="border w-100 mt-1 ml-1 mr-1 pt-1 pl-1 pr-1">
					            	<legend  class="w-auto">Options</legend>
							        <div class="row mb-1">
							            <div class="col-12 pl-2" style="display:flex;">
							            	<div class="col-3">
							            		<input class="form-check-input" type="radio" name="radio_phenotype" id="RadioPhenotype" onclick="radioSelect(false, 'individual')" value="0" checked>
												<label class="form-check-label" for="RadioPhenotype" style="padding-left: 14px;"> Phenotype Database</label>
							            	</div>
							            	<div class="col-3">
							            		<input class="form-check-input" type="radio" name="radio_phenotype" id="RadioCsvFile" onclick="radioSelect(true,  'individual')" value="1">
												<label class="form-check-label" for="RadioCsvFile" style="padding-left: 14px;"> New Phenotype</label>
							            	</div>
						            	</div>
						            </div>
					            	<div class="d-flex justify-content-start" >
					                    <select class="select2 form-select" id="Select_Phenotype_1" data-width="50%" data-placeholder="Select Phenotype">
					                    </select>
					                </div>
						            <div>
							            <div id="isPhenotype_individual" class="form-label-group" >
						                    <div>
						                    	<div class="col-12 p-0" style="font-size:16px; margin:5px 0;">Group</div>
							                    <div id="Grid_Individual" class="ag-theme-alpine" style="margin: 0px auto; height:190px;"></div>
						                    </div>
						                    <div class="row">
						                    	<div class="col-12 mt-1 mb-1 p-0 d-flex justify-content-center">
													<i class="feather icon-arrow-down" style="font-size:26px;"></i>
												</div>
											</div>
											<div class="row">
												<div class="col-12 d-flex justify-content-between" style="margin-bottom:5px;">
													<div>You can create up to 5 groups</div>
													<div class="d-flex justify-content-end" style="column-gap:5px;">
														<button id="Button_Group_Delete" class="btn btn-sm btn-danger" data-group_count="0" onclick="deleteIndividualGroup(document.getElementById('Button_Group_Add'), this, this.dataset.group_count)">Delete group</button>
														<button id="Button_Group_Add" class="btn btn-sm btn-success" data-group_count="0" onclick="addIndividualGroup(this, document.getElementById('Button_Group_Delete'), this.dataset.group_count)">Add group</button>
													</div>
												</div>
											</div>
											<div class="row">
												<div id="Grid_Groups" class="col-12" style="height: 445px; overflow-y:scroll;" ></div>
						                    </div>
							            </div>
					                    <div id="isNewFile_individual" class="form-label-group justify-content-center" style="display:none; flex-direction:column;">
											<div class="col-12 d-flex justify-content-space-between">
												<div class="col-6" style="font-weight:bold;">File Upload</div>
												<div id="exampleFile" class="col-6" style="display:none;">
								            		<button class="btn btn-sm btn-info float-right">예시파일</button>
								            	</div>
											</div>
											<div class="col-12 mt-1 d-flex justify-content-center">
								            	<div id="FileControl_individual" class="col-12"  style="border: 1px solid #48BAE4;"></div>
											</div>
							            </div>
							        </div>
						        </fieldset>
					        </div>
					        <div class="mt-1">
				                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="execute();">Run</button>
				                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="resetForm();">Reset</button>
				            </div>
						</div>
						<div class='tab-pane' id='pillModal2' aria-expanded='true' aria-labelledby='base-pill1'>
							<div class="row">
					            <fieldset class="border w-100 mt-1 ml-1 mr-1 pt-1 pl-1 pr-1">
					            	<legend  class="w-auto">Options</legend>
					            	<div class="row mb-1">
							            <div class="col-12 pl-2" style="display:flex;">
							            	<div class="col-3">
							            		<input class="form-check-input" type="radio" name="radio_phenotype2" id="RadioPhenotype2" onclick="radioSelect(false, 'phenotype')" value="0" checked>
												<label class="form-check-label" for="RadioPhenotype2" style="padding-left: 14px;"> Phenotype Database</label>
							            	</div>
							            	<div class="col-3">
							            		<input class="form-check-input" type="radio" name="radio_phenotype2" id="RadioCsvFile2" onclick="radioSelect(true, 'phenotype')" value="1">
												<label class="form-check-label" for="RadioCsvFile2" style="padding-left: 14px;"> New Phenotype</label>
							            	</div>
						            	</div>
						            </div>
						            <!--  
						            <div class="form-label-group d-flex justify-content-start" >
					                    <select class="select2 form-select" id="Select_Phenotype_2" data-width="50%" data-placeholder="Select Phenotype">
					                    </select>
					                </div>
					                -->
						            <div>
							            <div id="isPhenotype_phenotype" class="mt-1" style="display:flex;">
						                    <div class="col-6 p-0">
							                    <div id="Grid_Phenotype" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:190px;" ></div><br>
						                    </div>
						                    <div class="col-6 p-0">
							                    <div id="Grid_Phenotype_Selected" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:190px;"></div><br>
						                    </div>
							            </div>
							            <div id="isNewFile_phenotype" class="form-label-group mt-1 justify-content-center" style="display:none; flex-direction:column;">
											<div class="col-12 d-flex justify-content-space-between">
												<div class="col-6" style="font-weight:bold;">File Upload</div>
												<div class="col-6">
								            		<button class="btn btn-sm btn-info float-right">예시파일</button>
								            	</div>
											</div>
											<div class="col-12 mt-1 d-flex justify-content-center">
								            	<div id="FileControl_phenotype" class="col-12"  style="border: 1px solid #48BAE4;"></div>
											</div>
							            </div>
                                    	<input type="text" id="cre_date" class="form-control flatpickr-range" style="display:inline; background-color:white; width:49%;" name="cre_date" placeholder=" (Optional) 등록일자" />
                                    	<input type="text" id="inv_date" class="form-control flatpickr-range" style="display:inline; background-color:white; width:49%;" name="inv_date" placeholder=" (Optional) 조사일자" />
                                    	<div class="mt-1"></div>
							        </div>
						        </fieldset>
					        </div>
					        <div class="mt-1">
				                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="execute();">Run</button>
				                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="resetForm();">Reset</button>
				            </div>
						</div>
					</div>
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
    <script src="../../../../css/app-assets/vendors/js/vendors.min.js"></script>
    <script src="../../../../css/app-assets/vendors/js/innorix/innorix.js"></script>
    <script src="../../../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../../../css/app-assets/js/scripts/forms/select/form-select2.js"></script>
    <!--  
    <script src="../../../css/app-assets/vendors/js/jquery-ui/jquery-ui.min.js"></script>
    -->
        
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../../../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
	<script src="../../../../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
    <script src="../../../../css/app-assets/vendors/js/pickers/flatpickr/flatpickr.min.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../../../../css/app-assets/js/core/app-menu.js"></script>
    <script src="../../../../css/app-assets/js/core/app.js"></script>
    <script src="../../../../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="../../../../css/app-assets/js/scripts/ag-grid/ag-grid_anova.js"></script>
    <script src="../../../../css/app-assets/js/scripts/plotly-latest.min.js"></script>   
	<script src="../../../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script type="text/javascript">

	//Statistics에서 링크를 타고 왔을때 받는 전역변수. AG-Grid 로딩직후 cell click 용도로 사용
	var linkedJobid = "<%=linkedJobid%>";

   	$(document).ready(function(){ 
   		//vcfFileList();
   		flatpickr();
   	});
   	 
   	
   	$('#backdrop').on('hidden.bs.modal', function (e) {
   		resetForm();
   		document.getElementById('navModal1').click();
    	document.getElementById('RadioPhenotype').click();
    	document.getElementById('RadioPhenotype2').click();
    });    
   	
    function resetForm() {
    	document.getElementById('comment').value = "";
    	resetFlatpickr();
    	resetPhenotype();
    	deselectIndividualGrid();
    	deselectTraitNameGrid();
    	box.removeAllFiles();
    	box_phenotype.removeAllFiles();
    }
    
    function resetPhenotype() {
    	selectEl = document.getElementById('Select_Phenotype_1');
    	selectEl.selectedIndex = 0;
    	selectEl.dispatchEvent(new Event("change"));
    } 
    
    function deselectIndividualGrid() {
    	
    	
		for(const key in gridOptions_individualGroups) {
    		const nodes = gridOptions_individualGroups[key].api.getModel().rootNode.allLeafChildren;
    		
    		const rowData = new Array();
        	for(let i=0 ; i<nodes.length ; i++) {
        		rowData.push(nodes[i].data);
        	}
        	
        	gridOptions_individualName.api.applyTransaction({
        		add: rowData
        	}),
        	
            
        	gridOptions_individualGroups[key].api.applyTransaction({
            	remove: rowData
            });
		}
		
		gridOptions_individualName.columnApi.applyColumnState({
    	    state: [
    	    	{ colId: 'cre_dt', sort: 'desc', sortIndex:0 },
    	    	{ colId: 'no', sort: 'desc', sortIndex:1 }
    	    ],
    	    defaultState: { sort: null },
    	});
		
		gridOptions_individualName.api.deselectAll();
    }
    
	function deselectTraitNameGrid() {
    	
    	const nodes = gridOptionsTraitName_selected.api.getModel().rootNode.allLeafChildren;
    	
    	const rowData = new Array();
    	for(let i=0 ; i<nodes.length ; i++) {
    		rowData.push(nodes[i].data);
    	}
    	
    	gridOptionsTraitName.api.applyTransaction({
    		add: rowData
    	}),
		
		gridOptionsTraitName_selected.api.applyTransaction({
        	remove: rowData
        });
    	
    	
    	gridOptionsTraitName.columnApi.applyColumnState({
    	    state: [{ colId: 'traitname_key', sort: 'asc' }],
    	    defaultState: { sort: null },
    	});
        
    	gridOptionsTraitName.api.deselectAll();
    }
   	
    var box = new Object();
    var box_phenotype = new Object();
    window.onload = function() {
    	
    	//const jobid_pca = $("#jobid_pca").val();
    	//console.log("innorix jobid_pca : ", jobid_pca);
    	
    	// 파일전송 컨트롤 생성
	    box = innorix.create({
	    	el: '#FileControl_individual', // 컨트롤 출력 HTML 객체 ID
	        width			: 445,
	    	height          : 190,
	        maxFileCount   : 1,  
	        //allowType : ["vcf"],
	        allowType : ["xlsx"],
			addDuplicateFile : false,
	        agent: false, // true = Agent 설치, false = html5 모드 사용                    
	        uploadUrl: './anova_fileuploader.jsp'
	        //uploadUrl: './pca_fileuploader.jsp?jobid_pca='+jobid_pca,
	    });

	    // 업로드 완료 이벤트
	    box.on('uploadComplete', function (p) {
			$("#iframeLoading").modal('show'); 
	   		
   			const params = new URLSearchParams({
   				"varietyid": p.postData.varietyid,
   				"jobid": p.postData.jobid,
   				"jobid_anova": p.postData.jobid_anova,
	   			"comment": p.postData.comment,
	   			//"traitname": data.traitname,
	   			//"seq": data.seq,
	   			//"analysis_number": data.analysis_number,
   			})
   			
	   		// read file & return parameters
	    	fetch('../readPhenotypeCSV_group.jsp',{
	    		method: "POST",
	   			headers: {
	   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
	   			},
	   			body: params
	    	})
	   		.then(response => response.json())
	   		.then(data => {
	   			console.log(data);
	   			
	   			let row = "";
	   			for(let i=1 ; i<=Number(data.analysis_number) ; i++) {
	   				row += i;
	   				if(i != Number(data.analysis_number)) {
	   					row += ",";
	   				}
	   			}
	   			
	   			params.set("traitname", data.traitname);
	   			params.set("seq", data.seq);
	   			params.set("analysis_number", data.analysis_number);
	   			params.set("row", row);
	   			
		    	// insertSql
		    	fetch('./anova_insertSql_phenotype.jsp', {
		   			method: "POST",
		   			headers: {
		   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
		   			},
		   			body: params
		   		})
		   		.then(response => response.ok)
		    	.then(ok => {
		    		refresh();
		    	})
		    	
		    	
		    	// analysis
		    	fetch('./anova_analysis_fileupload_samplename.jsp',{
		    		method: "POST",
		   			headers: {
		   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
		   			},
		   			body: params
		    	})
		    	.then(response => response.ok)
		    	.then(ok => {
		   			$("#backdrop").modal("hide");
		   			const node = gridOptions.api.getModel().rootNode.allLeafChildren[0];
					node.setSelected(true);
					
					document.querySelector(`#myGrid [row-index="0"] [col-id="comment"]`).click();
		    	})
	   		})
        });
	    
	 // 파일전송 컨트롤 생성
	    box_phenotype = innorix.create({
	    	el: '#FileControl_phenotype', // 컨트롤 출력 HTML 객체 ID
	        width			: 445,
	    	height          : 190,
	        maxFileCount   : 1,  
	        //allowType : ["vcf"],
	        allowType : ["xlsx"],
			addDuplicateFile : false,
	        agent: false, // true = Agent 설치, false = html5 모드 사용                    
	        uploadUrl: './anova_fileuploader.jsp'
	        //uploadUrl: './pca_fileuploader.jsp?jobid_pca='+jobid_pca,
	    });

	    // 업로드 완료 이벤트
	    box_phenotype.on('uploadComplete', function (p) {
			
	    	$("#iframeLoading").modal('show'); 
	   		
   			const params = new URLSearchParams({
   				"varietyid": p.postData.varietyid,
   				"jobid": p.postData.jobid,
   				"jobid_anova": p.postData.jobid_anova,
	   			"comment": p.postData.comment,
	   			//"traitname": data.traitname,
	   			//"seq": data.seq,
	   			//"analysis_number": data.analysis_number,
   			})
   			
	   		// read file & return parameters
	    	fetch('../readPhenotypeCSV_noGroup.jsp',{
	    		method: "POST",
	   			headers: {
	   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
	   			},
	   			body: params
	    	})
	   		.then(response => response.json())
	   		.then(data => {
	   			console.log(data);
	   			
	   			params.set("traitname", data.traitname);
	   			params.set("seq", data.seq);
	   			params.set("analysis_number", data.analysis_number);
	   			
		    	// insertSql
		    	fetch('./anova_insertSql_phenotype.jsp', {
		   			method: "POST",
		   			headers: {
		   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
		   			},
		   			body: params
		   		})
		   		.then(response => response.ok)
		    	.then(ok => {
		    		refresh();
		    	})
		    	
		    	
		    	// analysis
		    	fetch('./anova_analysis_fileupload_phenotype.jsp',{
		    		method: "POST",
		   			headers: {
		   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
		   			},
		   			body: params
		    	})
		    	.then(response => response.ok)
		    	.then(ok => {
		   			$("#backdrop").modal("hide");
		   			const node = gridOptions.api.getModel().rootNode.allLeafChildren[0];
					node.setSelected(true);
					
					document.querySelector(`#myGrid [row-index="0"] [col-id="comment"]`).click();
		    	})
	   		})
        });
	    
    };
    
	//radio 선택에 따라 파일창 노출여부 결정  | true: New Phenotype , false: Phenotype Database
	function radioSelect(flag, category) {
		
		if(category == "individual") {
			if(flag) {
				document.getElementById('Select_Phenotype_1').nextSibling.style.display = 'none';
				document.getElementById('Select_Phenotype_1').selectedIndex = 0;
		    	document.getElementById('Select_Phenotype_1').dispatchEvent(new Event("change"));
				document.getElementById('isPhenotype_individual').style.display = 'none';
				$("#isNewFile_individual").css('display','flex');
				$("#exampleFile").css('display','block');
				
				// New Phenotype 선택시 특성 체크박스 해제
				//gridOptionsTraitName.api.deselectAll();
			} else {
				document.getElementById('Select_Phenotype_1').nextSibling.style.display='';
				document.getElementById('isPhenotype_individual').style.display = '';
				$("#isNewFile_individual").css('display','none');
				$("#exampleFile").css('display','none');
				
				// Phenotype Database 선택시 innorix 파일목록 해제
				box.removeAllFiles();
			}
		} else if(category == "phenotype") {
			if(flag) {
				//document.getElementById('Select_Phenotype_2').nextSibling.style.display = 'none';
				document.getElementById('isPhenotype_phenotype').style.display = 'none';
				document.getElementById("cre_date").style.display = "none";
				document.getElementById("inv_date").style.display = "none";
				resetFlatpickr();
				$("#isNewFile_phenotype").css('display','flex');
				$("#exampleFile").css('display','block');
				
				// New Phenotype 선택시 특성 체크박스 해제
				//gridOptionsTraitName.api.deselectAll();
			} else {
				//document.getElementById('Select_Phenotype_2').nextSibling.style.display='';
				document.getElementById('isPhenotype_phenotype').style.display = 'flex';
				document.getElementById("cre_date").style.display = "inline";
				document.getElementById("inv_date").style.display = "inline";
				$("#isNewFile_phenotype").css('display','none');
				$("#exampleFile").css('display','none');
				
				// Phenotype Database 선택시 innorix 파일목록 해제
				box.removeAllFiles();
			}
		}
		
		//console.log(flag);
	}
    
    function addIndividualGroup(add_button, delete_button, group_count) {
    	if(group_count == 5) {
    		return alert("그룹은 최대 5개까지 만들 수 있습니다.");
    	}
    	
    	const new_count = Number(group_count) + 1;
    	
    	add_button.dataset.group_count = new_count;
    	delete_button.dataset.group_count = new_count;
    	
    	const groups = document.getElementById("Grid_Groups");
    	groups.insertAdjacentHTML('beforeend',`
    			<div id="Div_Group_\${new_count}">
	    			<div class="row font-weight-bold" style="margin: 5px 0;">
	    				Group \${new_count}
	    			</div>
	   				<div id="Grid_Individual_Group_\${new_count}" class="ag-theme-alpine" style="margin: 0px auto; height:190px;"></div>
   				</div>
    			`
    	);
    	
    	//gridOptions_individualGroups[`gridOptions_individualGroupName_\${new_count}`] = {};
    	
    	
    	gridOptions_individualGroups[`gridOptions_individualGroupName_\${new_count}`] = {
  			defaultColDef: {
  				editable: false, 
  			    sortable: true,
  			    filter: true,
  			    cellClass: "grid-cell-centered",
  			},
  			columnDefs: columnDefs_individualGroupName,
  			rowHeight: 35,
  			rowDragManaged: true,
  			rowDragMultiRow: true,
  			rowSelection: "multiple",
  			rowMultiSelectWithClick: true,
  			suppressMultiRangeSelection: true,
  			animateRows: true,
  			//suppressHorizontalScroll: true,
  			getRowId: (params) => {
  			    return params.data.no;
  			},
  			onCellClicked: (params) => {
  				if(params.column.colId == "delete") {
  					
  					gridOptions_individualName.api.applyTransaction({
  			    		add: [params.node.data]
  			    	}),
  			    	
  			    	gridOptions_individualName.columnApi.applyColumnState({
  			    	    state: [
  			    	    	{ colId: 'cre_dt', sort: 'desc', sortIndex:0 },
  			    	    	{ colId: 'no', sort: 'desc', sortIndex:1 }
  			    	    ],
  			    	    defaultState: { sort: null },
  			    	});
  			        
  					gridOptions_individualGroups[`gridOptions_individualGroupName_\${new_count}`].api.applyTransaction({
  			        	remove: [params.node.data]
  			        });
  				}
  			},
  		}
    	
    	let gridOptions_group_count = gridOptions_individualGroups[`gridOptions_individualGroupName_\${new_count}`];
    	
    	new agGrid.Grid(document.getElementById(`Grid_Individual_Group_\${new_count}`), gridOptions_group_count);
    	gridOptions_group_count.api.sizeColumnsToFit();
    	
    	const dropZoneParams = gridOptions_group_count.api.getRowDropZoneParams({
		    onDragStop: (params) => {
		    	const nodes = params.nodes;

		    	gridOptions_individualName.api.applyTransaction({
		    		remove: nodes.map(function (node) {
		    			return node.data;
		    		}),
		        })
		    },
		});
    	gridOptions_individualName.api.addRowDropZone(dropZoneParams);
    	
    	gridOptions_group_count.api.setRowData();
    }
    
    function deleteIndividualGroup(add_button, delete_button, group_count) {
    	if(group_count == 2) {
    		return alert("분석을 위해서는 최소 2개의 그룹이 있어야 합니다.");
    	}
    	
    	let gridOptions_group_count = gridOptions_individualGroups[`gridOptions_individualGroupName_\${group_count}`];
    	
    	// 그룹 삭제시 sample list grid에 데이터 복구
    	const nodes = gridOptions_group_count.api.getModel().rootNode.allLeafChildren;
		
		const rowData = new Array();
    	for(let i=0 ; i<nodes.length ; i++) {
    		rowData.push(nodes[i].data);
    	}
    	
    	gridOptions_individualName.api.applyTransaction({
    		add: rowData
    	}),
        
    	gridOptions_group_count.api.applyTransaction({
        	remove: rowData
        });
    	
    	// 정렬
    	gridOptions_individualName.columnApi.applyColumnState({
    	    state: [
    	    	{ colId: 'cre_dt', sort: 'desc', sortIndex:0 },
    	    	{ colId: 'no', sort: 'desc', sortIndex:1 }
    	    ],
    	    defaultState: { sort: null },
    	});
    	
    	gridOptions_group_count.api.destroy();
    	document.getElementById(`Div_Group_\${group_count}`).remove();
    	
		const new_count = Number(group_count) - 1;
    	
    	add_button.dataset.group_count = new_count;
    	delete_button.dataset.group_count = new_count;
    	
    	
    	
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
    	
    	//const varietyid = $( "#variety-select option:selected" ).val();
    	const varietyid = document.querySelector("#variety-select option:checked").value
    	const jobid_anova = await fetch("../../../getJobid.jsp")
   									.then((response) => response.text())

   		const comment = $('#comment').val();
    	
    	if(!comment) {
    		return alert("comment를 입력해주세요.");
    	}
    	
    	
    	
    	const category = document.querySelector(".modal-body .nav-link.active").dataset.pill;
    	//console.log(category);
    	
    	if(category == "individual") {
    		//console.log("indi");
    		
    		if(document.querySelector('input[name="radio_phenotype"]:checked').value == '0') {
	    		const selectEl = document.getElementById("Select_Phenotype_1");
	    		const traitname = selectEl.options[selectEl.selectedIndex].dataset.traitname;
	    		const traitname_key = Number(selectEl.options[selectEl.selectedIndex].dataset.traitname_key);
	    		
	    		if(selectEl.selectedIndex == 0) {
	    			return alert("형질을 선택해주세요.");
	    		}
	    		
	    		const params = new URLSearchParams({
	    			"varietyid": varietyid,
	    			"jobid_anova": jobid_anova,
	    			"comment": comment,
	    			"traitname": traitname,
	    			"seq": traitname_key+1,
	    		});
	    		
	    		//const sampleno = new Array();
	    		//const samplename = new Array();
	
	    		
	    		const grid_group_count = Object.keys(gridOptions_individualGroups).length;
	    		
	    		let count = 1;
	    		for(const key in gridOptions_individualGroups) {
		    		const row = new Array();
		    		//const sampleno = new Array();
		    		const nodes = gridOptions_individualGroups[key].api.getModel().rootNode.allLeafChildren;
		    		if(nodes.length <3) {
		    			return alert("각 그룹에 최소 3개의 개체를 넣어주세요.")
		    		}
		    		for(let i=0 ; i<nodes.length ; i++) {
		    			//sampleno.push(nodes[i].data.no);
		    			row.push(nodes[i].data.row);
		    		}
		    		
		    		//params.append(`group_\${count}`, sampleno);
		    		params.append(`group_\${count}`, row);
		    		count++;
	    		}
	    		
	    		$("#iframeLoading").modal('show');
	    		
	    		fetch('./anova_analysis_samplename.jsp', {
	    			method: "POST",
	    			headers: {
	    				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
	    			},
	    			body: params
	    		})
	    		.then(response => response.ok)
	    		.then(ok => {
	    			$("#iframeLoading").modal('hide');
	    			const node = gridOptions.api.getModel().rootNode.allLeafChildren[0];
	    			node.setSelected(true);
	    			//gridOptions.api.setFocusedCell(0, 'comment');
	    			document.querySelector(`#myGrid [row-index="0"] [col-id="comment"]`).click();
	    		});
	    		
	    		fetch('./anova_insertSql.jsp', {
	    			method: "POST",
	    			headers: {
	    				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
	    			},
	    			body: params
	    		})
	    		.then(response => response.ok)
	    		.then(ok => {
	    			refresh();
	    		})
	    		/*
	    		*/
    		} else {
    			
    			if(box.fileList.files.length == 0) {
    				return alert("분석할 파일을 DRAG & DROP 영역에 넣어주세요.");
    			}
    			
    			const postObj = new Object();
    	    	postObj.comment = comment;	       
    	        postObj.varietyid = varietyid;
    	        postObj.jobid = jobid_anova;
    	        postObj.jobid_anova = jobid_anova;
    	        postObj.filename = box.fileList.files[0].file.name;
    	        box.setPostData(postObj);
    	        //box_phenotype.option.uploadUrl = './statistical_summary_fileuploader.jsp;
    	        box.upload();
    		}
    		
    		
    	} else if(category == "phenotype") {
    		//console.log("pheno");
    		
    		if(document.querySelector('input[name="radio_phenotype2"]:checked').value == '0') {
    			const traitname = new Array();
        		const traitname_key = new Array();
        		const nodes = gridOptionsTraitName_selected.api.getModel().rootNode.allLeafChildren;
        		if(nodes.length < 2) {
    				return alert("형질은 2~5개만 선택 가능합니다.")
    			}
        		for(let i=0 ; i<nodes.length ; i++) {
        			traitname.push(nodes[i].data.traitname);
        			traitname_key.push(Number(nodes[i].data.traitname_key) + 2);
        		}
        		
        		const cre_date = document.getElementById('cre_date').value;
        		const inv_date = document.getElementById('inv_date').value;
        		
        		const params = new URLSearchParams({
        			"varietyid": varietyid,
        			"jobid_anova": jobid_anova,
        			"comment": comment,
        			"traitname": traitname,
        			"seq": traitname_key,
        			"cre_date": cre_date,
        			"inv_date": inv_date,
        		})
        		
        		const phenotypeDB = await fetch('../setPhenotypeDB.jsp', {
    								   			method: "POST",
    								   			headers: {
    								   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
    								   			},
    								   			body: params
    								   		})
    								   		.then(response => response.json());

    			if(phenotypeDB.length <= 0) {
    				return alert(`조건에 맞는 표현형이 \${phenotypeDB.length}개입니다. 분석을 시작할 수 없습니다.`)
    			}
    			
    			//console.log(phenotypeDB);
    			
    			params.set("phenotypeDB", JSON.stringify(phenotypeDB));
    			params.set("analysis_number", phenotypeDB.length);
        		
        		
        		$("#iframeLoading").modal('show');
        		
        		fetch('anova_analysis_phenotype.jsp', {
        			method: "POST",
        			headers: {
        				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
        			},
        			body: params
        		})
        		.then(response => response.ok)
        		.then(ok => {
        			$("#iframeLoading").modal('hide');
        			
        			const node = gridOptions.api.getModel().rootNode.allLeafChildren[0];
        			node.setSelected(true);
        			//gridOptions.api.setFocusedCell(0, 'comment');
        			document.querySelector(`#myGrid [row-index="0"] [col-id="comment"]`).click();
        		});
        		
        		fetch('./anova_insertSql_phenotype.jsp', {
        			method: "POST",
        			headers: {
        				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8"
        			},
        			body: params
        		})
        		.then(response => response.ok)
	    		.then(ok => {
	    			refresh();
	    		})
	    		
    		} else {
    			
    			if(box_phenotype.fileList.files.length == 0) {
    				return alert("분석할 파일을 DRAG & DROP 영역에 넣어주세요.");
    			}
    			
    			const postObj = new Object();
    	    	postObj.comment = comment;	       
    	        postObj.varietyid = varietyid;
    	        postObj.jobid = jobid_anova;
    	        postObj.jobid_anova = jobid_anova;
    	        postObj.filename = box_phenotype.fileList.files[0].file.name;
    	        box_phenotype.setPostData(postObj);
    	        //box_phenotype.option.uploadUrl = './statistical_summary_fileuploader.jsp;
    	        box_phenotype.upload();
    		}
    		
    		
    	}
    	setTimeout( function () {
   			refresh();
   			$("#backdrop").modal("hide");
    	}, 1000);
    	/*
    	*/
    	
    	// jobid_vcf: 선택한 vcf파일(=select VCF Files 목록)의 고유한 id 
    	// jobid_pca: pca신규분석으로 생성된 데이터(=grid 각각의 row)가 가진 고유한 id (pca_fileuploader.jsp의 get parameter로 직접 붙어있음)
    	
    	
		    	
    	/*
    	if(box.fileList.files.length) {
			console.log("file exists -> with_population");
			console.log(box.fileList.files[0].file.name);
			
			const population_name = box.fileList.files[0].file.name;
			
			
    		// 파일 업로드 영역
	    	var postObj = new Object();
	    	postObj.comment = comment;	       
	        postObj.varietyid = varietyid;
	        postObj.jobid_vcf = jobid_vcf;
	        postObj.jobid_pca = jobid_pca;
	        postObj.filename = filename;
	        box.setPostData(postObj);
	        box.option.uploadUrl = './pca_fileuploader.jsp?jobid_pca='+jobid_pca;
	        box.upload();
	        
	        
			// with_population 영역
	    	fetch('./pca_population.jsp?jobid_vcf=' +jobid_vcf+ '&jobid_pca=' +jobid_pca+ '&population_name=' +population_name+ '&filename=' +filename+ '&varietyid=' +varietyid); 
	    	
	        
	    	
	    	setTimeout( function () {
		   		refresh();
		   		$("#backdrop").modal("hide");
		   	}, 1000);
	        
    	} else {
    		
    		// without_population 영역
    		$.ajax(
				{
					url: "./pca_non_population.jsp",
					method: 'POST',
					data: {
 						"comment" : comment, 
 						"varietyid" : varietyid, 
 						"jobid_vcf" : jobid_vcf, 
 						"jobid_pca" : jobid_pca,
 						"filename" : filename },
 					success: function(result) {
						console.log("pca_non_population.jsp");
 					}
	  		});
    		
    		//시간이 조금 지나면 Rscript 작동 여부에 관계없이 새로고침
	   		setTimeout( function () {
	   			//backdrop.style.display = "none";
	   			refresh();
	   			$("#backdrop").modal("hide");
	   			}
	   		, 1000);
    		
    	}
    	*/
    }
    
	$("#backdrop").on("shown.bs.modal", function(e) {
		gridOptions_individualName.api.sizeColumnsToFit();
		
		for(const key in gridOptions_individualGroups) {
			gridOptions_individualGroups[key].api.sizeColumnsToFit();
		}
		
	});

       
</script>

</body>
<!-- END: Body-->

</html>