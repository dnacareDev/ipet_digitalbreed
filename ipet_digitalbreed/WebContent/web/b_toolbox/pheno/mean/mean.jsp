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
		<jsp:param name="menu_active" value="mean"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;Mean</h2>
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
                            <div id="myGrid" class="ag-theme-alpine" style="margin: 0px auto; width: 98%; height:320px;"></div><br>
							<button class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal" data-target="#backdrop" data-backdrop="false"><i class="feather icon-upload"></i> New Analysis</button>
                            <button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>
                        </div>
                    </div>
                    <div id="vcf_status" class="card"></div>
                </section>
                <!-- Basic example section end -->
                
                <!-- Hidden Parameters -->
                <input type="hidden" id="jobid_pca">
                <input type='hidden' id='jobid'>
				<input type='hidden' id='resultpath'>
				<!-- Hidden Parameters -->
            </div>
        </div>
    </div>
    
	<!-- Modal start-->
    <div class="modal fade text-left" id="backdrop" role="dialog" aria-labelledby="myModalLabel5" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header bg-warning white">
                    <h4 class="modal-title" id="myModalLabel5">PCA New Analysis</h4>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
					<form class="form" id="uploadPcaForm">
					    <div class="form-body">
					        <div class="row">
					            <div class="col-md-12 col-12 ml-1">
					                <br>
					             	<div class="form-label-group">
					                	<input type="text" id="comment" class="form-control" placeholder="Comment" name="comment" style="width:444px;" autocomplete="off" required data-validation-required-message="This name field is required">						                     
					             		<label for="first-name-column">Comment</label>
					                </div>
					            </div>
					            <div class="col-md-12 col-12 ml-1">
					            	<div class="form-label-group" >
					                    <select class="select2 form-select" id="VcfSelect" style="width: 444px;">
					                    </select>
					                </div>
					            </div>
					            <div class="col-md-12 col-12">
									<div class="form-label-group">
							            <h6 style="margin-left:13px; font-weight:bold;">Population &nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;<button type="button" class="btn btn-info btn-sm" ><a href="/ipet_digitalbreed/uploads/pca_population.xlsx" download="pca_population.xlsx" style="color:white;" ><i class='feather icon-download'></i>예시파일받기</a> </button></h6>
							            <div class="col-md-12 col-12">
											<div id="fileControl" class="col-md-12 col-12"  style="padding: 0; border: 1px solid #48BAE4;"></div>
											<br>
							            </div>
						            </div>
						        </div>
					            <div class="col-12">
					                <button type="button" class="btn btn-success mr-1 mb-1" style="float: right;" onclick="FileUpload();">Run</button>
					                <button type="reset" class="btn btn-outline-warning mr-1 mb-1" style="float: right;" onclick="resetPCA();">Reset</button>
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
    <script src="../../../../css/app-assets/vendors/js/vendors.min.js"></script>
    <script src="../../../../css/app-assets/vendors/js/innorix/innorix.js"></script>
    <script src="../../../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../../../css/app-assets/js/scripts/forms/select/form-select2_B_toolbox.js"></script>
    <!--  
    <script src="../../../css/app-assets/vendors/js/jquery-ui/jquery-ui.min.js"></script>
    -->
        
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../../../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
	<script src="../../../../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
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
   		vcfFileList();
   		$(".select2.select2-container.select2-container--default").eq(1).width("444px");
   	});
   	 

   	function vcfFileList() {
   		
   		$.ajax(
   			{
 	   			//url: "./pca_non_population.jsp",
 	   			url: "../../../../web/database/genotype_json.jsp?varietyid=" + $( "#variety-select option:selected" ).val(),
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
   		resetPCA();
    });    
   	
    function resetPCA() {
    	document.getElementById('uploadPcaForm').reset();
    	vcfFileList();
    	box.removeAllFiles();
    }
   	
    var box = new Object();
    window.onload = function() {
    	
    	//const jobid_pca = $("#jobid_pca").val();
    	//console.log("innorix jobid_pca : ", jobid_pca);
    	
    	// 파일전송 컨트롤 생성
	    box = innorix.create({
	    	el: '#fileControl', // 컨트롤 출력 HTML 객체 ID
	        width			: 445,
	    	height          : 130,
	        maxFileCount   : 1,  
	        //allowType : ["vcf"],
	        allowType : ["xlsx"],
			addDuplicateFile : false,
	        agent: false, // true = Agent 설치, false = html5 모드 사용                    
	        uploadUrl: './pca_population.jsp'
	        //uploadUrl: './pca_fileuploader.jsp?jobid_pca='+jobid_pca,
	    });
    	
    	

	    // 업로드 완료 이벤트
	    box.on('uploadComplete', function (p) {
			document.getElementById('uploadPcaForm').reset();
	    	box.removeAllFiles();
			//backdrop.style.display = "none";	
			//refresh();
			
	    	//시간이 조금 지나면 Rscript 작동 여부에 관계없이 새로고침
	   		setTimeout( function () {
	   			//backdrop.style.display = "none";
	   			refresh();
	   			$("#backdrop").modal("hide");
	   			}
	   		, 1000);
        });
    };
    
    async function FileUpload() {
    	
    	const comment = $('#comment').val();
    	const varietyid = $( "#variety-select option:selected" ).val();
    	const jobid_vcf = $('#VcfSelect').find(':selected').data('jobid');
    	const jobid_pca = await fetch("../../getJobid.jsp")
   						.then((response) => response.text())
   	
   		console.log("jobid_pca : ", jobid_pca);
    	//$("#jobid_pca").val(jobid_pca);
    	const filename = $('#VcfSelect').find(':selected').data('filename');
    	// jobid_vcf: 선택한 vcf파일(=select VCF Files 목록)의 고유한 id 
    	// jobid_pca: pca신규분석으로 생성된 데이터(=grid 각각의 row)가 가진 고유한 id (pca_fileuploader.jsp의 get parameter로 직접 붙어있음)
    	
    	
    	if(Number(jobid_vcf) == -1) {
    		alert("VCF 파일을 선택하세요");
    		return;
    	}
    	
    	
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
    }
    


       
</script>

</body>
<!-- END: Body-->

</html>