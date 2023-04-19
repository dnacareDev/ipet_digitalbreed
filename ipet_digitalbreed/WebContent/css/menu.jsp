    <%
    	String menu_active = request.getParameter("menu_active");
   		System.out.println(menu_active);
    %>
    
    <!-- BEGIN: Main Menu-->
    <div class="horizontal-menu-wrapper">
        <div class="header-navbar navbar-expand-sm navbar navbar-horizontal floating-nav navbar-light navbar-without-dd-arrow navbar-shadow menu-border" role="navigation" data-menu="menu-wrapper">
            <div class="navbar-header">
                <ul class="nav navbar-nav flex-row">
                    <li class="nav-item mr-auto"><a class="navbar-brand" href="/ipet_digitalbreed/web./../../html/ltr/horizontal-menu-template/index.html">
									<img src="/ipet_digitalbreed/images/logo.png">
									<!--  
									<font size="4px"  color="#4c8aa9"><b>&nbsp;Digital Breeding</b></font>
									-->           

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
                            <li class="<%if(menu_active.equals("genotype")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/database/genotype.jsp" data-toggle="dropdown" data-i18n="Analytics"><i class="feather icon-crop"></i>Genotype</a>
                            </li>
                            <li class="<%if(menu_active.equals("phenotype")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/database/phenotype.jsp" data-toggle="dropdown" data-i18n="eCommerce"><i class="feather icon-wind"></i>Phenotype</a>
                            </li>
                        </ul>
                    </li>
                    <li class="dropdown nav-item" data-menu="dropdown"><a class="dropdown-toggle nav-link" href="#" data-toggle="dropdown"><i class="feather icon-package"></i><span data-i18n="Apps">GWAS/GS</span></a>
                        <ul class="dropdown-menu">
                            <li class="<%if(menu_active.equals("gwas")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/gwas_gs/gwas.jsp" data-toggle="dropdown" data-i18n="Email"><i class="feather icon-bar-chart-2"></i>GWAS</a>
                            </li>
                            <li class="<%if(menu_active.equals("gs")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/gwas_gs/gs.jsp" data-toggle="dropdown" data-i18n="Chat"><i class="feather icon-share-2"></i>Genome Selection</a>
                            </li>
                        </ul>
                    </li>
                    <li class="<%if(menu_active.equals("vb")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/vb/vb.jsp" data-i18n="Chat"><i class="feather icon-sliders"></i>Variants browser</a></li>
                    <li class="<%if(menu_active.equals("pd")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/pd/pd.jsp" data-i18n="Chat"><i class="feather icon-link"></i>Primer design</a></li>

                    <%-- 
                    <li class="dropdown nav-item" data-menu="dropdown"><a class="dropdown-toggle nav-link" href="#" data-toggle="dropdown"><i class="feather icon-package"></i><span data-i18n="Apps">Primer design</span></a>
                    	<ul class="dropdown-menu">
                            <li class="<%if(menu_active.equals("pd1")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/pd/pd_1.jsp" data-toggle="dropdown" data-i18n="Email"><i class="feather icon-bar-chart-2"></i>design-1</a>
                            </li>
                            <li class="<%if(menu_active.equals("pd2")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/pd/pd_2.jsp" data-toggle="dropdown" data-i18n="Chat"><i class="feather icon-share-2"></i>design-2</a>
                            </li>
                        </ul>
                    </li>  
                    --%>
                      
                    <li class="dropdown nav-item" data-menu="dropdown"><a class="dropdown-toggle nav-link" href="#" data-toggle="dropdown"><i class="feather icon-settings"></i><span data-i18n="Forms &amp; Tables">Breeder's toolbox</span></a>
                        <ul class="dropdown-menu">
                            <li class="dropdown dropdown-submenu" data-menu="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="#" data-toggle="dropdown" data-i18n="Form Elements"><i class="feather icon-activity"></i>Genotype Process</a>
                                <ul class="dropdown-menu">
                                    <li class="<%if(menu_active.equals("qf")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/qf/qf.jsp" data-toggle="dropdown" data-i18n="Select"><i class="feather icon-circle"></i>Quality filter</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("sf")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/sf/sf.jsp" data-toggle="dropdown" data-i18n="Switch"><i class="feather icon-circle"></i>Subset filter</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("vfm")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/vfm/vfm.jsp" data-toggle="dropdown" data-i18n="Checkbox"><i class="feather icon-circle"></i>Vcf file merge</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("vft")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/vft/vft.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>Vcf file transformation</a>
                                    </li>
                                    
                                </ul>
                            </li>
                            <li class="dropdown dropdown-submenu" data-menu="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="#" data-toggle="dropdown" data-i18n="Form Elements"><i class="feather icon-monitor"></i>Genotype Analyses</a>
                                <ul class="dropdown-menu">
                                    <li class="<%if(menu_active.equals("pca")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/pca/pca.jsp" data-toggle="dropdown" data-i18n="Select"><i class="feather icon-circle"></i>PCA</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("upgma")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/upgma/upgma.jsp" data-toggle="dropdown" data-i18n="Switch"><i class="feather icon-circle"></i>UPGMA clustering</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("genocore")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/genocore/genocore.jsp" data-toggle="dropdown" data-i18n="Checkbox"><i class="feather icon-circle"></i>Core selection</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("mini")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/mini/mini.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>Minimal marker</a>
                                    </li>
                                    <%-- 
                                    <li class="<%if(menu_active.equals("mabc")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/mabc/mabc.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>MABC Transformation</a>
                                    </li>
                                    --%>
                                    <li class="<%if(menu_active.equals("anno")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/anno/anno.jsp" data-toggle="dropdown" data-i18n="Input"><i class="feather icon-circle"></i>Annotation</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("ideogram")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/ideogram/ideogram.jsp" data-toggle="dropdown" data-i18n="Input"><i class="feather icon-circle"></i>Ideogram</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("structure")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/structure/structure.jsp" data-toggle="dropdown" data-i18n="Input"><i class="feather icon-circle"></i>Structure</a>
                                    </li>
                                </ul>
                            </li>
							<li class="dropdown dropdown-submenu" data-menu="dropdown-submenu"><a class="dropdown-item dropdown-toggle" href="#" data-toggle="dropdown" data-i18n="Chat"><i class="feather icon-sliders"></i>Phenotype Analyses</a>
								<ul class="dropdown-menu">
                                    <li class="<%if(menu_active.equals("statistical_summary")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/pheno/statistical_summary/statistical_summary.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>Statistical summary</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("t-test")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/pheno/t-test/t-test.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>T-test</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("anova")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/pheno/anova/anova.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>One-way ANOVA</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("phenotype_pca")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/pheno/phenotype_pca/phenotype_pca.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>Phenotype PCA</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("correlation")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/pheno/correlation/correlation.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>Correlation analysis</a>
                                    </li>
                                    <li class="<%if(menu_active.equals("regression")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/b_toolbox/pheno/regression/regression.jsp" data-toggle="dropdown" data-i18n="Radio"><i class="feather icon-circle"></i>Regression analysis</a>
                                    </li>
								</ul>
							</li>
                            
                        </ul>
                    </li>
					<li class="<%if(menu_active.equals("statistics")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/statistics/statistics.jsp" data-i18n="Chat"><i class="feather icon-bar-chart"></i>Statistics</a></li>
					<li class="<%if(menu_active.equals("about")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/about/about.jsp" data-i18n="Chat"><i class="feather icon-heart"></i>About</a></li>
					<li class="<%if(menu_active.equals("refDB")){out.println("active");}%>" data-menu=""><a class="dropdown-item" href="/ipet_digitalbreed/web/refgenome/refgenome.jsp" data-i18n="Chat"><i class="feather icon-archive"></i>Reference Genome</a></li>
                </ul>
            </div>
        </div>
    </div>
    <!-- END: Main Menu-->