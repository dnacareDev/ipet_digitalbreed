<%@ page language="java" contentType="text/html; charset=utf-8" pageEncoding="utf-8"%>
<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->
<%@ page import="ipet_digitalbreed.*"%>    
<html lang="en" data-layout="twocolumn" data-sidebar="light" data-sidebar-size="lg" data-sidebar-image="none" data-preloader="disable">

<head>

    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Vuexy admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities.">
    <meta name="keywords" content="digital breeding ipet dnacare">
    <meta name="author" content="DNACARE">
    <title>Digital Breeding System- DNACARE</title>
    <link rel="apple-touch-icon" href="../../css/app-assets/images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="/ipet_digitalbreed//css/app-assets/images/ico/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">

    <!--Swiper slider css-->
    <link href="../css/index_assets/libs/swiper/swiper-bundle.min.css" rel="stylesheet" type="text/css" />

    <!-- Layout config Js -->
    <script src="../css/index_assets/js/layout.js"></script>
    <!-- Bootstrap Css -->
    <link href="../css/index_assets/css/bootstrap.min.css" rel="stylesheet" type="text/css" />
    <!-- Icons Css -->
    <link href="../css/index_assets/css/icons.min.css" rel="stylesheet" type="text/css" />
    <!-- App Css-->
    <link href="../css/index_assets/css/app.min.css" rel="stylesheet" type="text/css" />
    <!-- custom Css-->
    <link href="../css/index_assets/css/custom.min.css" rel="stylesheet" type="text/css" />

</head>
<%
	String permissionUid = session.getAttribute("permissionUid")+"";
%>
<body data-bs-spy="scroll" data-bs-target="#navbar-example">

<!-- BEGIN: Body-->
 <div class="modal fade text-left" id="login_form" tabindex="-1" role="dialog" aria-labelledby="myModalLabel4" aria-hidden="true">
	    <div class="modal-dialog modal-dialog-centered">
	        <div class="modal-content border-0 overflow-hidden">
	            <div class="modal-header p-3">
	                <h4 class="card-title mb-0"><span class="fw-semibold">Login</span></h4>
	                <button type="button" class="btn-close" data-bs-dismiss="modal" aria-label="Close"></button>
	            </div>
	            
	            <div style="background: #f3f3f9;width: 100%; height: 200px; padding: 20px;" class="modal-body">
					<div class="card-content">
                                            <div class="card-body pt-1">
                                                <form method="POST" action="./public/session.jsp">
                                                    <fieldset class="form-label-group form-group position-relative has-icon-left">
                                                        <input type="text" class="form-control" id="user-name" name="user-name"  placeholder="Username" required>
                                                        <div class="form-control-position">
                                                            <i class="feather icon-user"></i>
                                                        </div>
                                                        <label for="user-name"> </label>
                                                    </fieldset>

                                                    <fieldset class="form-label-group position-relative has-icon-left">
                                                        <input type="password" class="form-control" id="user-password" name="user-password"   placeholder="Password" required>
                                                        <div class="form-control-position">
                                                            <i class="feather icon-lock"></i>
                                                        </div>
                                                        <label for="user-password"> </label>
                                                    </fieldset>
                                                    <button type="submit"  style="float: right;"  class="btn btn-primary float-right btn-inline">Login</button>
                                                </form>
                                            </div>
                                        </div>
	            </div>	            
	        </div><!-- /.modal-content -->
	    </div><!-- /.modal-dialog -->
	</div><!-- /.modal -->          

    <!-- END: Content-->
    
    <!-- Begin page -->
    <div class="layout-wrapper landing">
        <nav class="navbar navbar-expand-lg navbar-landing navbar-light fixed-top" id="navbar">
            <div class="container">
                <a class="navbar-brand" href="index.jsp">
                    <img src="/ipet_digitalbreed/images/logo.png"></font> 
                </a>
                <button class="navbar-toggler py-0 fs-20 text-body" type="button" data-bs-toggle="collapse" data-bs-target="#navbarSupportedContent" aria-controls="navbarSupportedContent" aria-expanded="false" aria-label="Toggle navigation">
                    <i class="mdi mdi-menu"></i>
                </button>

                <div class="collapse navbar-collapse" id="navbarSupportedContent">
                    <ul class="navbar-nav mx-auto mt-2 mt-lg-0" id="navbar-example">
                        <li class="nav-item">
                        </li>
                        <li class="nav-item">
                        </li>
                        <li class="nav-item">
                        </li>
                        <li class="nav-item">
                        </li>
                        <li class="nav-item">
                        </li>
                    </ul>

                    <div class="">
                    <%
                   		 if(permissionUid.equals("null")){                   			 
                   			 %><a href="javascript:modal_login()" class="btn btn-success">Login</a><%
                   		 }
                   		 else{
                   			 %><a href="./public/logout.jsp" class="btn btn-success">Logout</a><%                   			 
                   		 }
                    %>                        
                    </div>
                </div>

            </div>
        </nav>
            <div class="bg-overlay bg-overlay-pattern"></div>
        <!-- end navbar -->

        <!-- start hero section -->
        <section class="section nft-hero" id="hero">
            <!--  <div class="bg-overlay"></div>-->
            <div class="container" >
                <div >
                    <div class="col-lg-8 col-sm-10">
						<div class="text-center" style="width:400px;background-color: #003F8F;opacity: 0.5;padding: 30px 30px 30px 30px;">
                            <h2 class="mb-3 fw-bold lh-base text-white">Digital Breeding System</h2>
                            <h4 class="mb-3 lh-base text-white"><u>Genome Interactive</u></h4>
                            <h4 class="mb-3 lh-base text-white"><u>Automated Analysis</u></h4>
                            <h4 class="mb-3 lh-base text-white"><u>Database Construction</u></h4>
                            <!--
                            <div class="hstack gap-2 justify-content-center">
                                <a href="apps-nft-create.html" class="btn btn-primary">Create Own <i class="ri-arrow-right-line align-middle ms-1"></i></a>
                                <a href="apps-nft-explore.html" class="btn btn-danger">Explore Now <i class="ri-arrow-right-line align-middle ms-1"></i></a>
                            </div>
                            -->
                            
                        </div>
                    </div><!--end col-->
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end hero section -->

        <!-- start wallet -->
        <section class="section" id="wallet">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-8">
                        <div class="text-center mb-5">
                            <h2 class="mb-3 fw-bold lh-base">Digital Breeding System is</h2>
                             <h5 class="mb-3 fw-bold lh-base"><p class="text-muted">????????? ???????????? ?????? ????????? ???????????? ?????????, ????????? ????????? ???????????? ??? ????????????<br>???????????? ?????? ???????????? ??????, ?????? ?????? ?????? ??? ?????? ???????????? ???????????? ??????????????? ?????????.</p></h5>
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->

                <div class="row g-4">
                    <div class="col-lg-4">
                        <div class="card text-center border shadow-none">
                            <div class="card-body py-3 px-4">
                                <img src="../css/index_assets/images/main/information.png" alt="" height="150" class="mb-3 pb-2">
                                <h5 class="mb-3 fw-bold lh-base">About</h5>
                                <h6 class="mb-3 fw-bold lh-base"><p class="text-muted pb-1" style="text-align:left">????????????????????? ????????? ??????, ??????, GS/GWAS ??????, ?????? ??? ????????? ??? ????????? ????????? ????????? ???????????? ??????????????? ??? ???????????? ???????????? ???????????????????????? ??????????????? ????????? ??? ????????????.</p></h6>
                                
                                <%
	                                if(permissionUid.equals("null")){                   			 
	                          			 %><a href="javascript:modal_login()" class="btn btn-success">Go to Page</a><%
	                          		 }
	                          		 else{
	                          			 %><a href="./about/about.jsp" class="btn btn-info">Go to Page</a><%                   			 
	                          		 }
                                %>
                            </div>
                        </div>
                    </div><!-- end col -->
                    <div class="col-lg-4">
                        <div class="card text-center border shadow-none">
                            <div class="card-body py-3 px-4">
                                <img src="../css/index_assets/images/main/dna-strand.png" alt="" height="150" class="mb-3 pb-2">
                                <h5 class="mb-3 fw-bold lh-base">Genotype Database</h5>
                                <h6 class="mb-3 fw-bold lh-base"><p class="text-muted pb-1" style="text-align:left">VCF ?????? ????????? ????????? ????????? ?????? ??? ????????????, ????????? ????????? ????????? ??? ????????? ??? ????????? ?????? ????????? ??????????????? ???????????? ??? ???????????? ????????? ?????? ????????? ????????? ???????????????.</p></h6>
                                <%
	                                if(permissionUid.equals("null")){                   			 
	                          			 %><a href="javascript:modal_login()" class="btn btn-success">Go to Page</a><%
	                          		 }
	                          		 else{
	                          			 %><a href="./database/genotype.jsp" class="btn btn-info">Go to Page</a><%                   			 
	                          		 }
                                %>
                            </div>
                        </div>
                    </div>
                    <!-- end col -->
                    <div class="col-lg-4">
                        <div class="card text-center border shadow-none">
                            <div class="card-body py-3 px-4">
                                <img src="../css/index_assets/images/main/plant.png" alt="" height="150" class="mb-3 pb-2">
                                <h5 class="mb-3 fw-bold lh-base">Phenotype Database</h5>
                                <h6 class="mb-3 fw-bold lh-base"><p class="text-muted pb-1" style="text-align:left">????????? ????????? ????????? ???????????? ???????????? ????????? ????????? ???????????? ?????????????????? ?????? ???????????? GS??? GWAS ?????? ????????? ???????????? ?????? ?????? ????????? ???????????????.</p></h6>
                                <%
	                                if(permissionUid.equals("null")){                   			 
	                          			 %><a href="javascript:modal_login()" class="btn btn-success">Go to Page</a><%
	                          		 }
	                          		 else{
	                          			 %><a href="./database/phenotype.jsp" class="btn btn-info">Go to Page</a><%                   			 
	                          		 }
                                %>
                            </div>
                        </div>
                    </div><!-- end col -->
                    <div class="col-lg-4">
                        <div class="card text-center border shadow-none">
                            <div class="card-body py-3 px-4">
                                <img src="../css/index_assets/images/main/renko.png" alt="" height="150" class="mb-3 pb-2">
                                <h5 class="mb-3 fw-bold lh-base">GWAS</h5>
                                <h6 class="mb-3 fw-bold lh-base"><p class="text-muted pb-1" style="text-align:left">GATPIT ????????? ????????? ???????????? ?????? ??????(GLM, MLM, MLMM, FarmCPU, BLINK)??? ???????????? GWAS ?????? ??????(Manhattan plot, QQ plot)??? ?????????????????? ??? ?????????????????? ???????????????</p></h6>
                                <%
	                                if(permissionUid.equals("null")){                   			 
	                          			 %><a href="javascript:modal_login()" class="btn btn-success">Go to Page</a><%
	                          		 }
	                          		 else{
	                          			 %><a href="./gwas_gs/gwas.jsp" class="btn btn-info">Go to Page</a><%                   			 
	                          		 }
                                %>
                            </div>
                        </div>
                    </div><!-- end col -->
                    <div class="col-lg-4">
                        <div class="card text-center border shadow-none">
                            <div class="card-body py-3 px-4">
                                <img src="../css/index_assets/images/main/ai.png" alt="" height="150" class="mb-3 pb-2">
                                <h5 class="mb-3 fw-bold lh-base">Genomic Selection</h5>
                                <h6 class="mb-3 fw-bold lh-base"><p class="text-muted pb-1" style="text-align:left">????????????????????? ???????????????????????? ????????? ????????? GS ????????? ???????????????. ????????? ?????? ??????(rrBLUP, gBLUP, LASSO, Bayesian)??? ???????????? ?????? ??? ????????? ?????????????????? ??? ?????????????????? ???????????????.</p></h6>
                                <%
	                                if(permissionUid.equals("null")){                   			 
	                          			 %><a href="javascript:modal_login()" class="btn btn-success">Go to Page</a><%
	                          		 }
	                          		 else{
	                          			 %><a href="./gwas_gs/gs.jsp" class="btn btn-info">Go to Page</a><%                   			 
	                          		 }
                                %>
                            </div>
                        </div>
                    </div><!-- end col -->
 					<div class="col-lg-4">
                        <div class="card text-center border shadow-none">
                            <div class="card-body py-3 px-4">
                                <img src="../css/index_assets/images/main/data-analysis.png" alt="" height="150" class="mb-3 pb-2">
                                <h5 class="mb-3 fw-bold lh-base">Statistics</h5>
                                <h6 class="mb-3 fw-bold lh-base"><p class="text-muted pb-1" style="text-align:left">????????? ?????? ?????? ??? ?????? ????????? ??????????????? ????????? ????????? ???????????? ????????? ???????????? ????????? ??????????????? ?????? ??? ??? ????????????. ????????? ?????? ?????? ???????????? ?????? ?????? ??? ??? ????????????.</p></h6>
                                <%
	                                if(permissionUid.equals("null")){                   			 
	                          			 %><a href="javascript:modal_login()" class="btn btn-success">Go to Page</a><%
	                          		 }
	                          		 else{
	                          			 %><a href="./statistics/statistics.jsp" class="btn btn-info">Go to Page</a><%                   			 
	                          		 }
                                %>
                            </div>
                        </div>
                    </div><!-- end col -->                    
                    
                </div><!-- end row -->
            </div><!-- end container -->
        </section><!-- end wallet -->

        <!-- start plan -->
        <section class="section bg-light" id="categories">
            <div class="container-fluid">
                <div class="row justify-content-center">
                    <div class="col-lg-5">
                        <div class="text-center mb-5">
                            <h2 class="mb-3 fw-bold lh-base">Automated Analysis Pipeline</h2>
                            <h5 class="mb-3 fw-bold lh-base"><p class="text-muted">??? ?????????????????? ?????? ????????? ????????? ?????? ????????? ???????????? ???????????? ????????? ???????????? ?????? ?????? ????????????<br>????????? ??? ????????? ???????????????.</h5>
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->
                <div class="row">
                    <div class="col-lg-12">
                        <!-- Swiper -->
                        <div class="swiper mySwiper pb-4">
                            <div class="swiper-wrapper">
                                <div class="swiper-slide">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row g-1 mb-3">
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/cluster-1.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/cluster-2.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                            </div><!--end row-->
                                            <h5 class="mb-0 fs-16">Cluster Analysis</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                     <div class="card">
                                        <div class="card-body">
                                            <div class="row g-1 mb-3">
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/GWAS-1.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/GWAS-2.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                            </div><!--end row-->
                                            <h5 class="mb-0 fs-16">GWAS Analysis</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row g-1 mb-3">
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/phenotype-1.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/phenotype-2.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                            </div><!--end row-->
                                            <h5 class="mb-0 fs-16">Phenotype Analysis</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="card">    
                                        <div class="card-body">
                                            <div class="row g-1 mb-3">
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/PCA-1.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/PCA-2.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                            </div><!--end row-->
                                            <h5 class="mb-0 fs-16">PCA Analysis</h5>
                                        </div>
                                    </div>
                                </div>
                                <div class="swiper-slide">
                                    <div class="card">
                                        <div class="card-body">
                                            <div class="row g-1 mb-3">
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/Variant-1.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                                <div class="col-lg-6">
                                                    <img src="../css/index_assets/images/main/swiper/Variant-2.png" alt="" class="img-fluid rounded">
                                                </div><!--end col-->
                                            </div><!--end row-->
                                            <h5 class="mb-0 fs-16">Variant Analysis</h5>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="swiper-pagination swiper-pagination-dark"></div>
                        </div>
                    </div>
                </div>
            </div><!-- end container -->
        </section>
        <!-- end plan -->

        <!-- start cta -->
        <section class="py-5 bg-primary position-relative">
            <div class="bg-overlay bg-overlay-pattern opacity-50"></div>
            <div class="container">
                <div class="row align-items-center gy-4">
                    <div class="col-sm">
                        <div>
                            <h4 class="text-white mb-0 fw-bold">Our Consortium</h4>
                        </div>
                    </div>
                    <!-- end col -->
                    <div class="col-sm-auto">
                        <div>
                            <a href="http://www.dnacare.co.kr/" class="btn bg-gradient btn-success" target="_blank"><b>(???)??????????????????</b></a>
                            <a href="#" class="btn bg-gradient btn-warning" target="_blank"><b>(???)?????????????????????</b></a>
                            <a href="http://www.ppsseed.co.kr/" class="btn bg-gradient btn-info" target="_blank"><b>(???)????????????</b></a>
                            <a href="http://www.hankookseed.co.kr/" class="btn bg-gradient btn-secondary" target="_blank"><b>(???)????????????</b></a>   
                            <a href="https://plus.cnu.ac.kr/html/kr/" class="btn bg-gradient btn-light" target="_blank"><b>???????????????</b></a>
                        </div>
                    </div>
                    <!-- end col -->
                </div>
                <!-- end row -->
            </div>
            <!-- end container -->
        </section>
        <!-- end cta -->

 		<section class="py-4 position-relative">
            <div class="container">
                <div class="row justify-content-center">
                    <div class="col-lg-12">
                        <div class="text-center mb-1">
                            <br><p class="text-dark"><b>??? ???????????? ???????????????????????? ???????????? ?????????????????????????????????????????????????????????????????????????????? ????????? ?????? ???????????????(322076-03-1-CG)</b></p>
                        </div>
                    </div><!-- end col -->
                </div><!-- end row -->                
            </div><!-- end container -->
        </section><!-- end wallet -->
                
        <!-- Start footer -->
        <footer class="custom-footer bg-dark py-5 position-relative">
            <div class="container">
				<span class="float-md-left d-block d-md-inline-block mt-25">COPYRIGHT &copy; 2022 <a class="mb-3  lh-base text-white" href="http://www.dnacare.co.kr" target="_blank">DNACARE Co., LTD </a>All rights Reserved</span>
            </div>
        </footer>
        <!-- end footer -->

        <!--start back-to-top-->
        <button onclick="topFunction()" class="btn btn-danger btn-icon landing-back-top" id="back-to-top">
            <i class="ri-arrow-up-line"></i>
        </button>
        <!--end back-to-top-->

    </div>
    <!-- end layout wrapper -->


	<script>
	  function modal_login() {		
			$('#login_form').modal('show');	
	   }  
	</script>     

    <!-- JAVASCRIPT -->
    <script src="../css/app-assets/vendors/js/vendors.min.js"></script>
    <script src="../css/index_assets/libs/bootstrap/js/bootstrap.bundle.min.js"></script>
   	<script src="../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
    
    <script src="../css/index_assets/libs/simplebar/simplebar.min.js"></script>
    <script src="../css/index_assets/libs/node-waves/waves.min.js"></script>
    <script src="../css/index_assets/libs/feather-icons/feather.min.js"></script>
    <script src="../css/index_assets/js/pages/plugins/lord-icon-2.1.0.js"></script>
    <script src="../css/index_assets/js/plugins.js"></script>

    <!--Swiper slider js-->
    <script src="../css/index_assets/libs/swiper/swiper-bundle.min.js"></script>

    <script src="../css/index_assets/js/pages/nft-landing.init.js"></script>
</body>

</html>