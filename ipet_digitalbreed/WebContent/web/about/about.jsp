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

.center {
  margin: auto;
  width: 100%;
  padding: 10px;
}


</style>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";

	String linkedJobid = request.getParameter("linkedJobid");
	
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">

	<jsp:include page="../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="genotype"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;About</h2>
                            <div class="breadcrumb-wrapper col-12">
                                <ol class="breadcrumb">
                                    <li class="breadcrumb-item"><a href="../mainboard.jsp">Home</a>
                                    </li>
                                    <li class="breadcrumb-item active">About
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
                    <div class="card center" style="width:70%;">
                        <div class="card-content">
                            <div class="card-body text-center">
	                        	<div style="font-size:30px;">About Us</div>
                                <div class="row mt-3">
                                    <div class="center">
                                    	본 과제는 디지털 육종 활용 시스템의 데이터 처리 기반이 취약한 국내 종자 기업의 유전체 정보 활용을 적극 지원하여 데이터  
                                    </div>
                                </div>	
                                <div class="row mt-1">
                                    <div class="center">
                                    	작물 육종을 위한 유전체/표현체 정보분석 및 육종 현장 활용 확산을 유도하여 궁극적으로 종자 기업의 육종 효율을 향상시키고 
                                    </div>
                                </div>
                                <div class="row mt-1">
                                    <div class="center">
                                    	종자 생산 기술에 글로벌 경쟁력을 확보 하기 위한 시스템 입니다.
                                    </div>
                                </div>
                                <div class="row mt-3">
                                    <div class="center">
										* 본 연구는 농림축산식품부 농림식품기술기획평가원의 지원을 받아 아래의 기업과 함께 수행하고 있습니다. (과제번호 322076-03-1-CG)
                                    </div>
                                </div>	
                                <div class="row mt-3">
                                    <div class="center" style="font-size:30px;">
                                    	Founders
                                    </div>
                                </div>	
                                <div class="row mt-1">
                                    <div class="center">
										우리와 함께 해주셔서 매우 감사합니다. 아래는 DigitalBreeding System을 개발하는 동안 긴밀하게 협력한 주요 협력자 목록입니다.
                                    </div>
                                </div>	
                                <div class="row mt-3 center">
                                	<div class="col-4"><img alt="" src="../../css/app-assets/images/logo/logo1.jpg" style="width: 350px;"></div>
                                    <div class="col-4"><img alt="" src="../../css/app-assets/images/logo/logo2.png" style="width: 350px;"></div>
                                    <div class="col-4"><img alt="" src="../../css/app-assets/images/logo/logo3.png" style="width: 350px;"></div>
                                </div>	
                                <div class="row mt-3 center">
                                	<div class="col-4"><img alt="" src="../../css/app-assets/images/logo/logo4.png" style="width: 350px;"></div>
                                    <div class="col-4"><img alt="" src="../../css/app-assets/images/logo/logo5.png" style="width: 350px;"></div>
                                    <div class="col-4"><img alt="" src="../../css/app-assets/images/logo/logo6.jpg" style="width: 350px;"></div>
                                </div>	
                            </div>
                        </div>
                    </div>                    
                </section>
                <!-- // Basic example section end -->

            </div>
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
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
	<script src="../../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../../css/app-assets/js/core/app-menu.js"></script>
    <script src="../../css/app-assets/js/core/app.js"></script>
    <script src="../../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
	<script src="../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<!-- Modal start-->

                          
	<!-- Modal end-->
	
        <script>
        
        var box = new Object();
        window.onload = function() {
            // 파일전송 컨트롤 생성
            box = innorix.create({
                el: '#fileControl', // 컨트롤 출력 HTML 객체 ID
                height          : 130,
                maxFileCount   : 1,  
                allowExtension: ["vcf", "gvcf"],
				addDuplicateFile : false,
                agent: false, // true = Agent 설치, false = html5 모드 사용                    
                uploadUrl: './fileuploader.jsp' // 업로드 URL
            });

			box.on("addFileError", function(p) {
                alert("VCF 화일만 업로드 가능 합니다.")
            }),

            // 업로드 완료 이벤트
            box.on('uploadComplete', function (p) {
         	    

				document.getElementById('uploadvcfform').reset();
			    box.removeAllFiles();
				$('#backdrop').modal('hide');
				jQuery('#vcf_status').html('');
				$('html').scrollTop(0);
				refresh();
            });
        };
        
        function FileUpload() {
        	if(document.getElementById("comment").value==''){
        		alert("Comment must be entered.");   
        		document.getElementById("comment").focus();
        	    return false;  
        	}
        	
			var postObj = new Object();
			postObj.comment = document.getElementById("comment").value;      
			postObj.varietyid = $( "#variety-select option:selected" ).val();
			box.setPostData(postObj);
			box.upload();
        }            
            
		$('#backdrop').on('hidden.bs.modal', function (e) {
			document.getElementById('uploadvcfform').reset();
			box.removeAllFiles();
		});            
        </script>
</body>
<!-- END: Body-->

</html>