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

.nft-hero {
	width:100%; 
	height:700px;
	color:#000000;
    background-size: cover;
    background-position: center;
    padding: 150px 0 150px 0;
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
		<jsp:param name="menu_active" value="about"/>
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
                    <div class="card center nft-hero" style="background-image: url('../../css/app-assets/images/logo/about_us_8.jpg');">
                        <div class="card-content">
                            <div class="card-body">
	                        	<div class="row mt-5">
	                        		<div class="col-7"></div>
	                        		<div class="col-3 pt-3 pl-4 pr-4" style="font-size:30px; font-weight:600; background-color:#FFFFFFCC; top:-40px;">About Us</div>
	                        		<div class="col-1"></div>
	                        	</div>
                                <div class="row mt-0">
                                    <div class="col-7"></div>
                                    <div class="col-3 pl-4 pr-4" style="font-size:17px; font-weight:300; /*line-height:2*/ background-color:#FFFFFFCC; top:-40px;" >
                                    	<br>
                                    	본 과제는 디지털 육종 활용 시스템의 데이터 처리 기반이 취약한 국내 종자 기업의 유전체 정보 활용을 적극 지원하여 데이터  작물 육종을 위한 유전체/표현체 정보분석 및 육종 현장 활용 확산을 유도하여 궁극적으로 종자 기업의 육종 효율을 향상시키고종자 생산 기술에 글로벌 경쟁력을 확보 하기 위한 시스템 입니다.
                                    	<br>
                                    	<br>
                                    	<br> 
                                    </div>
                                    <div class="col-1"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card center nft-hero" style="background-image: url('../../css/app-assets/images/logo/about_us_9.jpg');">
                    	<div class="card-content">
                            <div class="card-body">
	                        	<div class="row">
	                        		<div class="col-1"></div>
	                        		<div class="col-3 pt-3 pl-4 pr-4" style="font-size:30px; font-weight:600; background-color:#FFFFFF99; top:-50px;">Data Management</div>
	                        		<div class="col-7"></div>
	                        	</div>
                                <div class="row">
                                    <div class="col-1"></div>
                                    <div class="col-3 pl-4 pr-4" style="font-size:17px; font-weight:300; /*line-height:2*/ background-color:#FFFFFF99; top:-50px;" >
                                    	<br>
                                    	유전자 분석 기술 및 영상 기술이 발달함에 따라 수집 되는 데이터는 점차 다양해 지고, 수년 동안 데이터가 점진적으로 쌓이게 되면서 이제는 수집된 방대한 양의 데이터를 어떻게 보다 더 효율적이고 손쉽게 관리 할 수 있는지 중요해 졌습니다.
                                    	<br>
                                    	<br>
                                    	Digital Breeding System은 개체별로 다양한 데이터를 수집 및 관리 할 수 있게 구성되어 있으면 등록된 데이터와 분석 모듈이 서로 긴밀하게 연결되어 있어 시스템에서 분석을 진행 할 수 있으며 해당 분석 결과 또한 유기적으로 확인할 수 있습니다.
                                    	<br>
                                    	<br>
                                    	<br>
                                    </div>
                                    <div class="col-7"></div>
                                </div>
                            </div>
                        </div>
                    </div>  
                    <div class="card center nft-hero" style="background-image: url('../../css/app-assets/images/logo/about_us_10.jpg');">
                    	<div class="card-content">
                            <div class="card-body">
	                        	<div class="row mt-2">
	                        		<div class="col-7"></div>
	                        		<div class="col-3 pt-3 pl-4 pr-4" style="font-size:30px; font-weight:600; background-color:#FFFFFFCC; top:-50px;">Visualization</div>
	                        		<div class="col-1"></div>
	                        	</div>
                                <div class="row mt-0">
                                    <div class="col-7"></div>
                                    <div class="col-3 pl-4 pr-4" style="font-size:17px; font-weight:300; /*line-height:2*/ background-color:#FFFFFFCC; top:-50px;" >
                                    	<br>
                                    	수집된 대용량의 데이터에 대한 통계 처리와 분석 결과를 효율적으로 표현하는 방법은 그래프나 이미지를 통한 정보의 시각화 입니다. 
										<br>
										<br>
										Digital Breeding system은 다양한 시각화 모듈을 지원하여 데이터의 이상 값과 패턴의 강조를 표시할 수 있으며 또한 R 기반의 다양한 통계 및 분석 모듈을 지원하며 웹 베이스의 디스플레이를 통하여 시각화된 그래프와 데이터 테이블 간의 상호 작용을 지원합니다
                                    	<br>
                                    	<br>
                                    	<br>
                                    </div>
                                    <div class="col-1"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card center nft-hero" style="background-image: url('../../css/app-assets/images/logo/about_us_2.jpg');">
                    	<div class="card-content">
                            <div class="card-body">
	                        	<div class="row mt-5">
	                        		<div class="col-2"></div>
	                        		<div class="col-3 pt-3 pl-4 pr-4" style="font-size:30px; font-weight:600; background-color:#FFFFFF99; top:-70px;">User Friendly</div>
	                        		<div class="col-7"></div>
	                        	</div>
                                <div class="row mt-0">
                                    <div class="col-2"></div>
                                    <div class="col-3 pl-4 pr-4" style="font-size:17px; font-weight:300; /*line-height:2;*/ background-color:#FFFFFF99; top:-70px;" >
                                    	<br>
                                    	NGS 기술이 점차 발전함에 따라 이전보다 유전체 데이터를 얻기가 쉬워졌지만 이를 일반 사용자가 활용하기 에는 어려우며 유전체 분석을 위해서는 많은 전문지식과 분석 환경이 필요합니다.
                                    </div>
                                    <div class="col-7"></div>
                                </div>
                                <div class="row mt-0">
                                	<div class="col-2"></div>
                                    <div class="col-3 pl-4 pr-4"style="font-size:17px; font-weight:300; /*line-height:2;*/ background-color:#FFFFFF99; top:-70px;"> 
										<br>
										Digital Breeding System은 유전체 데이터를 일반 사용자들에게 익숙한 형태로 정보를 자동으로 추출 및 정리하여 제공하며 사용자가 다양한 분석을 손쉽게 진행할 수 있도록 셋팅된 다양한 분석모듈을 제공합니다.
										<br>
										<br>
										<br>
                                    </div>
                                    <div class="col-7"></div>
                                </div>	
                                <div class="row mt-1">
                                	<div class="col-6"></div>
                                    <div class="col-4 text-right">
                                    </div>
                                    <div class="col-1"></div>
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
	</script>
</body>
<!-- END: Body-->

</html>