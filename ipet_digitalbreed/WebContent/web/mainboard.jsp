<!DOCTYPE html>
<html class="loading" lang="en" data-textdirection="ltr">
<!-- BEGIN: Head-->

<head>
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0, user-scalable=0, minimal-ui">
    <meta name="description" content="Vuexy admin is super flexible, powerful, clean &amp; modern responsive bootstrap 4 admin template with unlimited possibilities.">
    <meta name="keywords" content="digital breeding ipet dnacare">
    <meta name="author" content="DNACARE">
    <title>Digital Breeding System- DNACARE</title>
    <link rel="apple-touch-icon" href="../css/app-assets/images/ico/apple-icon-120.png">
    <link rel="shortcut icon" type="image/x-icon" href="../css/app-assets/images/ico/favicon.ico">
    <link href="https://fonts.googleapis.com/css?family=Montserrat:300,400,500,600" rel="stylesheet">

    <!-- BEGIN: Vendor CSS-->
    <link rel="stylesheet" type="text/css" href="../css/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/themes/dark-layout.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/themes/semi-dark-layout.css">

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/core/menu/menu-types/horizontal-menu.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/pages/dashboard-analytics.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/pages/card-analytics.css">
    <link rel="stylesheet" type="text/css" href="../css/app-assets/css/plugins/tour/tour.css">
    <!-- END: Page CSS-->

    <!-- BEGIN: Custom CSS-->
    <link rel="stylesheet" type="text/css" href="../../../assets/css/style.css">
    <!-- END: Custom CSS-->

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">

    <!-- BEGIN: Header-->
    <nav class="header-navbar navbar-expand-lg navbar navbar-with-menu navbar-fixed navbar-shadow navbar-brand-center">
        <div class="navbar-wrapper">
            <div class="navbar-container content">
                <div class="navbar-collapse" id="navbar-mobile">
                    <div class="mr-auto float-left bookmark-wrapper d-flex align-items-center">
                        <ul class="nav navbar-nav">
                            <li class="nav-item mobile-menu d-xl-none mr-auto"><a class="nav-link nav-menu-main menu-toggle hidden-xs" href="#"><i class="ficon feather icon-menu"></i></a></li>
                        </ul>
			            <ul class="nav navbar-nav flex-row">
			                <li class="nav-item"><a class="navbar-brand" href="./mainboard.jsp">
									<img src="../images/logo.png"><font size="4px"  color="#4c8aa9"><b>&nbsp;Digital Breeding</b></font>           
			                    </a></li>
			            </ul>
                    </div>
                    <ul class="nav navbar-nav float-right">
                        <li class="dropdown dropdown-user nav-item"><a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
                                <div class="user-nav d-sm-flex d-none"><span class="user-name text-bold-600">DNACARE(master)</span><span class="user-status">Available</span></div><span><img class="round" src="../css/app-assets/images/portrait/small/avatar-s-11.jpg" alt="avatar" height="40" width="40"></span>
                            </a>
                            <div class="dropdown-menu dropdown-menu-right"><a class="dropdown-item" href="page-user-profile.html"><i class="feather icon-user"></i> Edit Profile</a><a class="dropdown-item" href="app-email.html"><i class="feather icon-mail"></i> My Inbox</a><a class="dropdown-item" href="app-todo.html"><i class="feather icon-check-square"></i> Task</a><a class="dropdown-item" href="app-chat.html"><i class="feather icon-message-square"></i> Chats</a>
                                <div class="dropdown-divider"></div><a class="dropdown-item" href="auth-login.html"><i class="feather icon-power"></i> Logout</a>
                            </div>
                        </li>
                    </ul>
                </div>
            </div>
        </div>
    </nav>

    <!-- BEGIN: Main Menu-->
    <div class="horizontal-menu-wrapper">
        <div class="header-navbar navbar-expand-sm navbar navbar-horizontal floating-nav navbar-light navbar-without-dd-arrow navbar-shadow menu-border" role="navigation" data-menu="menu-wrapper">
            <div class="navbar-header">
                <ul class="nav navbar-nav flex-row">
                    <li class="nav-item mr-auto"><a class="navbar-brand" href="../../../html/ltr/horizontal-menu-template/index.html">
									<img src="../images/logo.png"><font size="4px"  color="#4c8aa9"><b>&nbsp;Digital Breeding</b></font>           

                        </a></li>
                    <li class="nav-item nav-toggle"><a class="nav-link modern-nav-toggle pr-0" data-toggle="collapse"><i class="feather icon-x d-block d-xl-none font-medium-4 primary toggle-icon"></i><i class="toggle-icon feather icon-disc font-medium-4 d-none d-xl-block collapse-toggle-icon primary" data-ticon="icon-disc"></i></a></li>
                </ul>
            </div>
            <!-- Horizontal menu content-->
            <div class="navbar-container main-menu-content" data-menu="menu-container">
                <!-- include ../../../includes/mixins-->
                <ul class="nav navbar-nav" id="main-menu-navigation" data-menu="menu-navigation">
                    <li class="dropdown nav-item" data-menu="dropdown"><a class="dropdown-toggle nav-link" href="index.html" data-toggle="dropdown"><i class="feather icon-cpu"></i><span data-i18n="Dashboard ">Database</span></a>
                        <ul class="dropdown-menu">
                            <li class="active" data-menu=""><a class="dropdown-item" href="./database/genotype.jsp" data-toggle="dropdown" data-i18n="Analytics"><i class="feather icon-crop"></i>Genotype</a>
                            </li>
                            <li data-menu=""><a class="dropdown-item" href="./database/phenotype.jsp" data-toggle="dropdown" data-i18n="eCommerce"><i class="feather icon-wind"></i>Phenotype</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown nav-item" data-menu="dropdown"><a class="dropdown-toggle nav-link" href="#" data-toggle="dropdown"><i class="feather icon-package"></i><span data-i18n="Apps">GWAS/GS</span></a>
                        <ul class="dropdown-menu">
                            <li data-menu=""><a class="dropdown-item" href="./gwas_gs/gwas.jsp" data-toggle="dropdown" data-i18n="Email"><i class="feather icon-bar-chart-2"></i>GWAS</a>
                            </li>
                            <li data-menu=""><a class="dropdown-item" href="./gwas_gs/gs.jsp" data-toggle="dropdown" data-i18n="Chat"><i class="feather icon-share-2"></i>Genome Selection</a>
                            </li>
                        </ul>
                    </li>
                      <li data-menu=""><a class="dropdown-item" href="./vb/vb.jsp" data-i18n="Chat"><i class="feather icon-sliders"></i>Variants browser</a></li>
                      <li data-menu=""><a class="dropdown-item" href="./pd/pd.jsp" data-i18n="Chat"><i class="feather icon-link"></i>Primer design</a></li>
                      
                    <li class="dropdown nav-item" data-menu="dropdown"><a class="dropdown-toggle nav-link" href="#" data-toggle="dropdown"><i class="feather icon-settings"></i><span data-i18n="Forms &amp; Tables">Breeder's toolbox</span></a>
                        <ul class="dropdown-menu">
                            <li class="dropdown dropdown-submenu" data-menu="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="#" data-toggle="dropdown" data-i18n="Form Elements"><i class="feather icon-activity"></i>Genotype Process</a>
                                <ul class="dropdown-menu">
                                    <li data-menu=""><a class="dropdown-item" href="./b_toolbox/qf/qf.jsp" data-toggle="dropdown" data-i18n="Select"><i class="feather icon-circle"></i>Quality filter</a>
                                    </li>
                                    <li data-menu=""><a class="dropdown-item" href="./b_toolbox/sf/sf.jsp" data-toggle="dropdown" data-i18n="Switch"><i class="feather icon-circle"></i>Subset filter</a>
                                    </li>
                                    <li data-menu=""><a class="dropdown-item" href="./b_toolbox/vfm/vfm.jsp" data-toggle="dropdown" data-i18n="Checkbox"><i class="feather icon-circle"></i>Vcf file merge</a>
                                    </li>
                                    <li data-menu=""><a class="dropdown-item" href="./b_toolbox/vft/vft.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>Vcf file transformation</a>
                                    </li>
                                    <li data-menu=""><a class="dropdown-item" href="./b_toolbox/anno/anno.jsp" data-toggle="dropdown" data-i18n="Input"><i class="feather icon-circle"></i>Annotation</a>
                                    </li>
                                </ul>
                            </li>
                            <li class="dropdown dropdown-submenu" data-menu="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="#" data-toggle="dropdown" data-i18n="Form Elements"><i class="feather icon-monitor"></i>Genotype Analyses</a>
                                <ul class="dropdown-menu">
                                    <li data-menu=""><a class="dropdown-item" href="./b_toolbox/pca/pca.jsp" data-toggle="dropdown" data-i18n="Select"><i class="feather icon-circle"></i>PCA</a>
                                    </li>
                                    <li data-menu=""><a class="dropdown-item" href="./b_toolbox/upgma/upgma.jsp" data-toggle="dropdown" data-i18n="Switch"><i class="feather icon-circle"></i>UPGMA clustering</a>
                                    </li>
                                    <li data-menu=""><a class="dropdown-item" href="./b_toolbox/genocore/genocore.jsp" data-toggle="dropdown" data-i18n="Checkbox"><i class="feather icon-circle"></i>Genocore</a>
                                    </li>
                                    <li data-menu=""><a class="dropdown-item" href="./b_toolbox/mini/mini.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>Minimal marker</a>
                                    </li>
                                </ul>
                            </li>
							<li data-menu=""><a class="dropdown-item" href="./b_toolbox/pheno/pheno.jsp" data-i18n="Chat"><i class="feather icon-sliders"></i>Phenotype Analyses</a></li>
                            
                        </ul>
                    </li>
					<li data-menu=""><a class="dropdown-item" href="./about/about.jsp" data-i18n="Chat"><i class="feather icon-heart"></i>About</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- END: Main Menu-->

    <!-- BEGIN: Content-->
    <div class="app-content content">
        <div class="content-overlay"></div>
        <div class="header-navbar-shadow"></div>
        <div class="content-wrapper">
             <div class="content-body">
                <!-- apex charts section start -->
                <section id="apexchart">
                    <div class="row">
                        <!-- Line Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Line Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="line-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Line Area Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Line Area Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="line-area-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Column Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Column Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="column-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Bar Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Bar Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="bar-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Mixed Chart -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Mixed Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="mixed-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Candlestick Chart -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Candlestick Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="candlestick-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- 3D Bubble Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">3D Bubble Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="bubble-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Scatter Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Scatter Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="scatter-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <!-- Heat map Chart -->
                    <div class="row">
                        <div class="col-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Heat Map Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="heat-map-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>

                    <div class="row">
                        <!-- Pie Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Pie Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="pie-chart" class="mx-auto"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Donut Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Donut Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="donut-chart" class="mx-auto"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Radial Bar Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Radial Bar Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="radial-bar-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>

                        <!-- Radar Chart -->
                        <div class="col-lg-6 col-md-12">
                            <div class="card">
                                <div class="card-header">
                                    <h4 class="card-title">Radar Chart</h4>
                                </div>
                                <div class="card-content">
                                    <div class="card-body">
                                        <div id="radar-chart"></div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </section>
                <!-- // Apex charts section end -->

            </div>
        </div>
    </div>
    <!-- END: Content-->
    <div class="sidenav-overlay"></div>
    <div class="drag-target"></div>

    <!-- BEGIN: Footer-->
    <footer class="footer footer-static footer-light navbar-shadow">
        <p class="clearfix blue-grey lighten-2 mb-0"><span class="float-md-left d-block d-md-inline-block mt-25">COPYRIGHT &copy; 2020<a class="text-bold-800 grey darken-2" href="https://1.envato.market/pixinvent_portfolio" target="_blank">Pixinvent,</a>All rights Reserved</span><span class="float-md-right d-none d-md-block">Hand-crafted & Made with<i class="feather icon-heart pink"></i></span>
            <button class="btn btn-primary btn-icon scroll-top" type="button"><i class="feather icon-arrow-up"></i></button>
        </p>
    </footer>
    <!-- END: Footer-->


    <!-- BEGIN: Vendor JS-->
    <script src="../css/app-assets/vendors/js/vendors.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
    <script src="../css/app-assets/vendors/js/charts/apexcharts.min.js"></script>
    <script src="../css/app-assets/vendors/js/extensions/tether.min.js"></script>
    <script src="../css/app-assets/vendors/js/extensions/shepherd.min.js"></script>    
    <script src="../css/app-assets/vendors/js/vendors.min.js"></script>
    <script src="../css/app-assets/vendors/js/charts/chart.min.js"></script>
    <script src="../css/app-assets/vendors/js/pickers/flatpickr/flatpickr.min.js"></script>
    <script src="../css/app-assets/js/core/app-menu.js"></script>
    <script src="../css/app-assets/js/core/app.js"></script>
    <script src="../css/app-assets/js/scripts/charts/chart-chartjs.js"></script>
    <script src="../css/app-assets/vendors/js/charts/apexcharts.min.js"></script>
    <script src="../css/app-assets/js/core/app-menu.min.js"></script>
    <script src="../css/app-assets/js/core/app.min.js"></script>
    <script src="../css/app-assets/js/scripts/customizer.min.js"></script>
    <script src="../css/app-assets/js/scripts/charts/chart-apex.min.js"></script>    
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../css/app-assets/js/core/app-menu.js"></script>
    <script src="../css/app-assets/js/core/app.js"></script>
    <script src="../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="../css/app-assets/js/scripts/pages/dashboard-analytics.js"></script>
    <!-- END: Page JS-->

</body>
<!-- END: Body-->

</html>