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
    <link rel="apple-touch-icon" href="../../css/app-assets/images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="../../css/app-assets/images/ico/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/vendors.min.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/swiper.min.css">    
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/tables/ag-grid/ag-grid.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/tables/ag-grid/ag-theme-alpine.css"> 
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/css/plugins/forms/validation/form-validation.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/forms/select/select2.min.css">
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/plugins/extensions/swiper.css">	
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
    <link rel="stylesheet" href="../../css/app-assets/vendors/css/jquery-ui/jquery-ui.css">
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
</style>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">

	<jsp:include page="../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="phenotype"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;Phenotype Database</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../mainboard.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">Database
                                    </li>
                                </ol>
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <div class="content-body">
                <div id="user-profile">
                    <section id="profile-info">
                        <div class="row">
                            <div class="col-xl-6 col-12">
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
			                                               <!-- <div class="btn-export">
			                                                    <button class="btn btn-primary mr-1 mb-1">
			                                                        Export as CSV
			                                                    </button>-->
		                                                </div>
		                                            </div>
		                                        </div>
		                                    </div>
		                                    <div id="myGrid" class="ag-theme-alpine" style="margin: 0 auto;width: 100%;height:526px;" ></div>
			                                <div class="row" style="display:flex; justify-content:space-between">
		                                		<div class="col-12 col-md-6 mt-1">
				                                	<button class="btn btn-warning mr-1" style="float: left;" onclick="addnewrow()"><i class="feather icon-plus-square"></i> Add</button>
													<button class="btn btn-danger" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>
		                                		</div>
												<div class="col-12 col-md-6 mt-1 d-flex justify-content-start justify-content-md-end" style="column-gap:10px;">
													<!--  
													<div class="dropup">
														<button id="dropdownMenuButton_analysis" class="btn btn-secondary dropdown-toggle" type="button" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Analysis</button>
														<div class="dropdown-menu" aria-labelledby="dropdownMenuButton_analysis" style="z-index:9999">
				                                           	<a class="dropdown-item" href="javascript:openAnalysisModal('statistical_summary');">Statistical summary</a>
				                                            <a class="dropdown-item" href="javascript:openAnalysisModal('t-test');">T-test</a>
				                                            <a class="dropdown-item" href="javascript:openAnalysisModal('anova');">One-way ANOVA</a>
				                                            <a class="dropdown-item" href="javascript:openAnalysisModal('phenotype_pca');">Phenotype PCA</a>
				                                            <a class="dropdown-item" href="javascript:openAnalysisModal('correlation');">Correlation analysis</a>
				                                            <a class="dropdown-item" href="javascript:openAnalysisModal('regression');">Regression analysis</a>
				                                        </div>
													</div>
													-->
													<div>
														<button class="btn btn-success" onclick="getAllData()"><i class="feather icon-save"></i> Save</button>
														<!--  
														<button class="btn btn-success" onclick="saveData()"><i class="feather icon-save"></i> Save</button>
														-->
													</div>
													<div class="dropup">
														<button class="btn btn-info dropdown-toggle" type="button" id="dropdownMenuButton3" data-toggle="dropdown" aria-haspopup="true" aria-expanded="false">Upload</button>
				                                       	<div class="dropdown-menu" aria-labelledby="dropdownMenuButton3">
				                                           	<a class="dropdown-item" href="javascript:ajaxFileDownload();">Template Download</a>
				                                            <a class="dropdown-item" href="javascript:ajaxFileUpload();">Template Upload</a>
				                                        </div>
			                                        </div>
												</div>
			                                </div>
		                                </div>	
										<input type="file" id="ajaxFile" name="ajaxFile" onChange="ajaxFileTransmit();" style="display:none;"/>
		                            </div>
                                </div>
                            </div>

							<div class="col-xl-6 col-12">
								<div class="row">									
									<div class="col-6">                                    
						                <!-- navigations swiper start -->
					                <section id="component-swiper-progress_one">
					                    <div class="card ">
					                        <div id="card-header_one" class="card-header">
					                            <font size="3px"><b>Sample #1</b></font>
					                        </div>
					                        <div class="card-content">
					                            <div class="card-body">
					                                <div id="photo_one" style="border:2px dashed; padding:0px;height: 237px;background-color: #D4EFDF" >					                                
					                               			<div id="photo_one_desc" style="height: 237px;">
					                               				<br><br><center><font color="black" size="4"><i class='feather icon-share'> Drag and Drop Sample Here.</i></font>
					                               			</div>						                               		
					                                </div>
					                            </div>
					                        </div>
					                    </div>
					                </section>
						                <!-- navigations swiper ends -->						                
								    </div>           
									
									<div class="col-6">                                    
						                <!-- navigations swiper start -->
					                <section id="component-swiper-progress_two">
					                    <div class="card ">
					                        <div id="card-header_two" class="card-header">
					                            <font size="3px"><b>Sample #2</b></font>
					                        </div>
					                        <div class="card-content">
					                            <div class="card-body">
					                                <div id="photo_two" style="border:2px dashed; padding:0px;height: 237px;background-color: #FAE5D3" >
					                               			<div id="photo_two_desc" style="height: 237px;">
					                               				<br><br><center><font color="black" size="4"><i class='feather icon-share'> Drag and Drop Sample Here.</i></font>
					                               			</div>						                                
					                               	</div>
					                            </div>
					                        </div>
					                    </div>
					                </section>
						                <!-- navigations swiper ends -->						                
								    </div>	
								    
								</div>
								<div class="row">
									<div class="col-xl-12 col-12">                                    
						                <!-- navigations swiper start -->
						                <section id="component-swiper-navigations">
						                    <div class="card ">
						                        
						                        <div class="card-content">
						                            <div style="height: 321px;" class="card-body"><font size="3px"><b>Spyder Plot</b></font>
						                                    <div >
															   <div id="spyderplot_div" ></div>
						                                       <center><iframe id="spyderplot" frameBorder="0" src="" style="display:block; width:100%; height: 260px"></iframe>
						                                    </div>
						                            </div>
						                        </div>
						                    </div>
						                </section>
						                <!-- navigations swiper ends -->					                
						                						                
								    </div>	
								</div>
							</div>
                        </div>   
					</section> 
                </div>                
            </div>            
        </div>        
    </div>
    
    <div class="modal" id="Loading" tabindex="-1" role="dialog" aria-labelledby="exampleModalCenterTitle" aria-hidden="true" data-backdrop="false">
		<div class="modal-dialog modal-dialog-centered modal-xs" role="document">
   			<center><img src='/ipet_digitalbreed/images/loading.gif'/><center>
			<div><strong>Loading Result...</strong></div>
	  	</div>
	</div>
    
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
    <script src="../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../css/app-assets/js/scripts/forms/select/form-select2.js"></script>    
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
    <!--  
  	<script src="../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-enterprise.min.js">
  	-->
    
	<script src="../../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
	<script src="../../css/app-assets/vendors/js/extensions/swiper.min.js"></script>
	
    

    <script src="../../css/app-assets/vendors/js/innorix/innorix.js"></script>	

      <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../../css/app-assets/js/core/app-menu.js"></script>
    <script src="../../css/app-assets/js/core/app.js"></script>
    <script src="../../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

 	<script> 	
	 	var variety_id = $( "#variety-select option:selected" ).val();
	 	var grid_array;	
		$.ajax({
			url : "traitnamertn.jsp",
			type : "post",
			async: false,
			data : {"varietyid" : variety_id},
			dataType : "json",
			success : function(result){
				grid_array = result;			
			}
		});    
    </script>
        
    <!-- BEGIN: Page JS-->
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_phenotype.js"></script>
    <!--  
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_phenotype_modules.js"></script>
    -->
    <script src="../../css/app-assets/js/scripts/plotly-latest.min.js"></script>   
	<script src="../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->
   
    <!-- BEGIN: Page JS-->
    <script src="../../css/app-assets/js/scripts/extensions/swiper.js"></script>
    <!-- END: Page JS-->
           
    <script>

	    function ajaxFileDownload() {       
			location.href="./phenotype_downloadfile.jsp?varietyid="+$("#variety-select option:selected").val();		
		}
    
	    function ajaxFileUpload() {       
			jQuery("#ajaxFile").click();  
		}
	
	    function ajaxFileChange() {        
	    	ajaxFileTransmit();   
	    }
    
	    function ajaxFileTransmit() {     
		 
	     	if (!confirm("업로드 엑셀 화일의 데이타가 입력 됩니다. 계속 진행하시겠습니까?")) {
	            //alert("취소 되었습니다.");
	        } 
	     	else {	       	    
		    	var formData = new FormData();
		        formData.append("variety", $("#variety-select option:selected").val());
	      		formData.append("ajaxFile", $("input[name=ajaxFile]")[0].files[0]);
	   	
		    	jQuery.ajax({             
		    		url : "./phenotype_uploadfile.jsp", 
		    		 data: formData,
		       	    processData: false,
		       	    contentType: false,
		       	    type: 'POST',	 
					success:function(data) {	
						alert("업데이트가 정상적으로 처리 되었습니다.");  
						refresh();
					}       
				});	           
	        }
	    }
    	
		for (var i=0; i<grid_array.length; i++) {
			for (key in grid_array[i]) {		
				//addCol(key, grid_array[i][key] );
				addCol(i+"_key", grid_array[i][key] );				
			}
		}
	</script>
	
		<!-- Modal start-->
	    <div class="modal fade text-left" id="backdrop" tabindex="-1" role="dialog" aria-labelledby="myModalLabel16" aria-hidden="true">
	        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable modal-xl" role="document">
	            <div class="modal-content">
	                <div class="modal-header bg-warning white">
	                    <h4 class="modal-title" id="myModalLabel4">Photo gallery</h4>
	                   <!--  <button type="button" class="close" data-dismiss="modal" aria-label="Close"> -->
	                  	<button type="button" class="close" aria-label="Close" onclick="$('#backdrop').modal('hide');">	                    
	                        <span aria-hidden="true">&times;</span>
	                    </button>
	                </div>
	                <div class="modal-body">
						<form class="form" id="uploadvcfform">
						     <div class="form-body">
						         <div class="row">
						             <div class="col-md-12 col-12">
						                 <div style="height: 680px" class="form-label-group" id="photo_list"></div>
						             </div>					             
						         </div>
						     </div>
						</form>
	                </div>
	            </div>
	    	</div>
	    </div>                          
	    
	    
	    
	    <div class="modal fade text-left" id="Modal_Analysis" tabindex="-1" role="dialog" aria-labelledby="myModalLabel17" aria-hidden="true">
	    </div>
	    
		<!-- Modal end-->
     
<script>

	/*
	async function openAnalysisModal(id) {
		//console.log("ID : ", id);
		
		
		await fetch(`../b_toolbox/pheno/\${id}/\${id}.jsp`)
				.then((response) => response.text())
				.then((html) => {
					const regex = /<!--__module-start__-->([\s\S]*?)<!--__module-end__-->/;
					const matches = html.match(regex);
					const content = matches[1];
					
					//console.log(content);
					document.getElementById('Modal_Analysis').insertAdjacentHTML('beforeend', content);
					document.getElementById('Modal_Analysis').dataset.analysis_category = id;
					
					//const analysis_arr = ['statistical_summary','t-test','anova','phenotype_pca','correlation','regression'];
				})
		
		
		const traitName_arr = new Array();
		const traitName_key_arr = new Array();
		
		const colDef = gridOptions.columnDefs;
		for(let i=0 ; i<colDef.length ; i++) {
			if(colDef[i]?.field?.includes('_key')) {
				traitName_arr.push(colDef[i].headerName);
				traitName_key_arr.push(colDef[i].field.replaceAll("_key",""));
			}
		}
		
		new agGrid.Grid(document.getElementById('Grid_Phenotype'), gridOptionsTraitName);
		//gridOptionsTraitName.api.setRowData(data);
		if(id == 'regression') {
			new agGrid.Grid(document.getElementById('Grid_Phenotype_dependent'), gridOptionsTraitName_dependent);
			new agGrid.Grid(document.getElementById('Grid_Phenotype_Independent'), gridOptionsTraitName_independent);
		} else {
	  		new agGrid.Grid(document.getElementById('Grid_Phenotype_Selected'), gridOptionsTraitName_selected);
  			gridOptionsTraitName_selected.api.setRowData();
		}
		
		if(id == 't-test') {
			$("#Select_Phenotype_1").append(`<option></option>`);
			for(let i=0 ; i<traitName_arr.length ; i++) {
				$("#Select_Phenotype_1").append(`<option data-traitname=\${traitName_arr[i]} data-traitname_key=\${traitName_key_arr[i]}> \${traitName_key_arr[i]} </option>`);
			}
			
			new agGrid.Grid(document.getElementById('Grid_Individual'), gridOptions_individualName);
			new agGrid.Grid(document.getElementById('Grid_Individual_Group'), gridOptions_individualGroupName);
			
			const data_selected = gridOptions.api.getSelectedRows();
			gridOptions_individualName.api.setRowData(data_selected);
	
			$("#Select_Phenotype_1").select2();
		}
		
		$("#Modal_Analysis").modal("show");
	}
	
	$("#Modal_Analysis").on("shown.bs.modal", function(e) {
		gridOptions_individualName.api.sizeColumnsToFit();
		gridOptions_individualGroupName.api.sizeColumnsToFit();
	})
	
	$("#Modal_Analysis").on("hidden.bs.modal", function(e) {
		document.getElementById('Modal_Analysis').innerHTML = "";
	});
	*/ 
</script>
</body>
<!-- END: Body-->

</html>