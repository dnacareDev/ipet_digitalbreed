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
	                        		<div class="col-1 col-md-4 col-lg-5 col-xl-7"></div>
	                        		<div class="col-10 col-md-6 col-lg-5 col-xl-3 pt-3 pl-4 pr-4" style="font-size:30px; font-weight:600; background-color:#FFFFFFCC; top:-40px; min-width:365px;">About Us</div>
	                        		<div class="col-1 col-md-2 col-lg-2 col-xl-1"></div>
	                        	</div>
                                <div class="row mt-0">
                                    <div class="col-1 col-md-4 col-lg-5 col-xl-7"></div>
                                    <div class="col-10 col-md-6 col-lg-5 col-xl-3 pl-4 pr-4" style="font-size:17px; font-weight:300; /*line-height:2*/ background-color:#FFFFFFCC; top:-40px; min-width:365px;" >
                                    	<br>
                                    	??? ????????? ????????? ?????? ?????? ???????????? ????????? ?????? ????????? ????????? ?????? ?????? ????????? ????????? ?????? ????????? ?????? ???????????? ?????????  ?????? ????????? ?????? ?????????/????????? ???????????? ??? ?????? ?????? ?????? ????????? ???????????? ??????????????? ?????? ????????? ?????? ????????? ????????????????????? ?????? ????????? ????????? ???????????? ?????? ?????? ?????? ????????? ?????????.
                                    	<br>
                                    	<br>
                                    	<br> 
                                    </div>
                                    <div class="col-1 col-md-2 col-lg-2 col-xl-1"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card center nft-hero" style="background-image: url('../../css/app-assets/images/logo/about_us_9.jpg');">
                    	<div class="card-content">
                            <div class="card-body">
	                        	<div class="row">
	                        		<div class="col-1 col-md-1 col-lg-1 col-xl-1"></div>
	                        		<div class="col-10 col-md-8 col-lg-5 col-xl-3 pt-3 pl-4 pr-4" style="font-size:30px; font-weight:600; background-color:#FFFFFF99; top:-100px; min-width:365px;">Data Management</div>
	                        		<div class="col-1 col-md-3 col-lg-6 col-xl-7"></div>
	                        	</div>
                                <div class="row">
                                    <div class="col-1 col-md-1 col-lg-1 col-xl-1"></div>
                                    <div class="col-10 col-md-8 col-lg-5 col-xl-3 pl-4 pr-4" style="font-size:17px; font-weight:300; /*line-height:2*/ background-color:#FFFFFF99; top:-100px; min-width:365px;" >
                                    	<br>
                                    	????????? ?????? ?????? ??? ?????? ????????? ???????????? ?????? ?????? ?????? ???????????? ?????? ????????? ??????, ?????? ?????? ???????????? ??????????????? ????????? ????????? ????????? ????????? ????????? ?????? ???????????? ????????? ?????? ??? ??????????????? ????????? ?????? ??? ??? ????????? ????????? ????????????.
                                    	<br>
                                    	<br>
                                    	Digital Breeding System??? ????????? ????????? ???????????? ?????? ??? ????????? ??? ????????? ????????? ???????????? ?????? ????????? ?????? ???????????? ???????????? ?????? ?????? ?????? ?????? ??????????????? ????????? ??? ????????????.
                                    	<br>
                                    	<br>
                                    	<br>
                                    </div>
                                    <div class="col-1 col-md-3 col-lg-6 col-xl-7"></div>
                                </div>
                            </div>
                        </div>
                    </div>  
                    <div class="card center nft-hero" style="background-image: url('../../css/app-assets/images/logo/about_us_10.jpg');">
                    	<div class="card-content">
                            <div class="card-body">
	                        	<div class="row mt-2">
	                        		<div class="col-1 col-md-5 col-lg-6 col-xl-7"></div>
	                        		<div class="col-10 col-md-6 col-lg-5 col-xl-4 pt-3 pl-4 pr-4" style="font-size:30px; font-weight:600; background-color:#FFFFFFCC; top:-50px; min-width:365px;">Visualization</div>
	                        		<div class="col-1 col-md-1 col-lg-1 col-xl-1"></div>
	                        	</div>
                                <div class="row mt-0">
                                    <div class="col-1 col-md-5 col-lg-6 col-xl-7"></div>
                                    <div class="col-10 col-md-6 col-lg-5 col-xl-4 pl-4 pr-4" style="font-size:17px; font-weight:300; /*line-height:2*/ background-color:#FFFFFFCC; top:-50px; min-width:365px;" >
                                    	<br>
                                    	????????? ???????????? ???????????? ?????? ?????? ????????? ?????? ????????? ??????????????? ???????????? ????????? ???????????? ???????????? ?????? ????????? ????????? ?????????. 
										<br>
										<br>
										Digital Breeding system??? ????????? ????????? ????????? ???????????? ???????????? ?????? ?????? ????????? ????????? ????????? ??? ????????? ?????? R ????????? ????????? ?????? ??? ?????? ????????? ???????????? ??? ???????????? ?????????????????? ????????? ???????????? ???????????? ????????? ????????? ?????? ?????? ????????? ???????????????
                                    	<br>
                                    	<br>
                                    	<br>
                                    </div>
                                    <div class="col-1 col-md-1 col-lg-1 col-xl-1"></div>
                                </div>
                            </div>
                        </div>
                    </div>
                    <div class="card center nft-hero" style="background-image: url('../../css/app-assets/images/logo/about_us_2.jpg');">
                    	<div class="card-content">
                            <div class="card-body">
	                        	<div class="row mt-5">
	                        		<div class="col-1 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
	                        		<div class="col-10 col-sm-8 col-md-6 col-lg-4 col-xl-3 pt-3 pl-4 pr-4" style="font-size:30px; font-weight:600; background-color:#FFFFFF99; top:-140px; min-width:365px;">User Friendly</div>
	                        		<div class="col-1 col-sm-2 col-md-4 col-lg-6 col-xl-7"></div>
	                        	</div>
                                <div class="row mt-0">
                                    <div class="col-1 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                    <div class="col-10 col-sm-8 col-md-4 col-lg-4 col-xl-3 pl-4 pr-4" style="font-size:17px; font-weight:300; /*line-height:2;*/ background-color:#FFFFFF99; top:-140px; min-width:365px;" >
                                    	<br>
                                    	NGS ????????? ?????? ???????????? ?????? ???????????? ????????? ???????????? ????????? ??????????????? ?????? ?????? ???????????? ???????????? ?????? ???????????? ????????? ????????? ???????????? ?????? ??????????????? ?????? ????????? ???????????????.
                                    </div>
                                    <div class="col-1 col-sm-2 col-md-6 col-lg-6 col-xl-7"></div>
                                </div>
                                <div class="row mt-0">
                                	<div class="col-1 col-sm-2 col-md-2 col-lg-2 col-xl-2"></div>
                                    <div class="col-10 col-sm-8 col-md-4 col-lg-4 col-xl-3 pl-4 pr-4"style="font-size:17px; font-weight:300; /*line-height:2;*/ background-color:#FFFFFF99; top:-140px; min-width:365px;"> 
										<br>
										Digital Breeding System??? ????????? ???????????? ?????? ?????????????????? ????????? ????????? ????????? ???????????? ?????? ??? ???????????? ???????????? ???????????? ????????? ????????? ????????? ????????? ??? ????????? ????????? ????????? ??????????????? ???????????????.
										<br>
										<br>
										<br>
                                    </div>
                                    <div class="col-1 col-sm-2 col-md-6 col-lg-6 col-xl-7"></div>
                                </div>	
                                <div class="row mt-1">
                                	<div class="col-xl-6"></div>
                                    <div class="col-xl-4 text-right">
                                    </div>
                                    <div class="col-xl-1"></div>
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