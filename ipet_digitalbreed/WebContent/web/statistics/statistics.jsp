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
    <link rel="stylesheet" type="text/css" href="../../css/app-assets/css/plugins/charts/chart-apex.css">
    <!-- END: Page CSS-->

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->
<style>
body {
	font-family: 'SDSamliphopangche_Outline';
}

</style>
<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";

	String  drive;
	double  totalSize, freeSize, useSize, percentSize;        

	File[] roots = File.listRoots();
	totalSize = Math.round(roots[0].getTotalSpace() / Math.pow(1024, 3) * 100) / 100.0;
	freeSize = Math.round(roots[0].getUsableSpace() / Math.pow(1024, 3) * 100) / 100.0;
	useSize = Math.round( (totalSize - freeSize) * 100 ) / 100;
	percentSize = Math.round(useSize * 100 / totalSize);
	
	//out.println(String.format("%.2f",freeSize) + " GB Remained");
	
%>
<body class="horizontal-layout horizontal-menu 2-columns  navbar-floating footer-static  " data-open="hover" data-menu="horizontal-menu" data-col="2-columns">

	<jsp:include page="../../css/topmenu.jsp" flush="true"/>

	<jsp:include page="../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="statistics"/>
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
	                            <h2 class="content-header-title float-left mb-0">&nbsp;Statistics</h2>
	                            <div class="breadcrumb-wrapper col-12">
	                                <ol class="breadcrumb">
	                                    <li class="breadcrumb-item"><a href="../mainboard.jsp">Home</a>
	                                    </li>
	                                    <li class="breadcrumb-item active">Statistics
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
	               <div class="col-12">
	                    <div class="card">
	                        <div class="card-content">
	                            <div class="card-body">
	                            	<div class="ag-grid-btns d-flex justify-content-between flex-wrab">
	                                	<div class="dropdown sort-dropdown">                                                
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
	                                             } catch (Exception e){
	                                             	System.out.println(e);
	                                             }
	                                        %>       
	                                        </select>                                          
	                                	</div>           
	                            	</div>
	                            </div>
	                        </div>
	                    </div>
	                </div>
                    <div class="col-12">
                    	<div class="row">
	                    	<div class="col-sm-6 col-lg-4 col-xl-2 mb-1">
		                    	<div class="card">
			                        <div class="card-content">
			                            <div class="card-body" >
											<p class='text-left' style='padding-top: 3%; font-size: 20px;'>Genotype data</p>
	                               			<p id='genotype_data' class='text-right font-weight-bold' style='padding-top: 10%; font-size: 4rem;'>0</p>
			                            </div>
		                            </div>
		                            <div id="line-area-chart-1"></div>
		                        </div>
		                    </div>
		                    <div class="col-sm-6 col-lg-4 col-xl-2 mb-1">
		                    	<div class="card">
			                        <div class="card-content">
			                            <div class="card-body">
											<p class='text-left' style='padding-top: 3%; font-size: 20px;'>Phenotype data</p>
	                               			<p id='phenotype_data' class='text-right font-weight-bold' style='padding-top: 10%; font-size: 4rem;'>0</p>
			                            </div>
		                            </div>
		                            <div id="line-area-chart-2"></div>
		                        </div>
		                    </div>
		                    <div class="col-sm-6 col-lg-4 col-xl-2 mb-1">
		                    	<div class="card">
			                        <div class="card-content">
			                            <div class="card-body">
											<p class='text-left' style='padding-top: 3%; font-size: 2.8vh;'>GWAS</p>
	                               			<p id='GWAS' class='text-right font-weight-bold' style='padding-top: 10%; font-size: 4rem;'>0</p>
			                            </div>
		                            </div>
		                            <div id="line-area-chart-3"></div>
		                        </div>
		                    </div>
		                    <div class="col-sm-6 col-lg-4 col-xl-2 mb-1">
		                    	<div class="card">
			                        <div class="card-content">
			                            <div class="card-body">
			                            	<p class='text-left' style='padding-top: 3%; font-size: 2.8vh;'>GS</p>
	                               			<p id='GS' class='text-right font-weight-bold' style='padding-top: 10%; font-size: 4rem;'>0</p>
			                            </div>
		                            </div>
			                        <div id="line-area-chart-4"></div>
		                        </div>
		                    </div>
		                    <div class="col-sm-6 col-lg-4 col-xl-2 mb-1">
		                    	<div class="card">
			                        <div class="card-content">
			                            <div class="card-body">	
			                            	<p class='text-left' style='padding-top: 3%; font-size: 2.8vh;'>Genotype Analysis</p>
	                               			<p id='genotype_analysis' class='text-right font-weight-bold' style='padding-top: 10%; font-size: 4rem;'>0</p>
			                            </div>
		                            </div>
		                        	<div id="line-area-chart-5"></div>
		                        </div>
		                    </div>
		                    <div class="col-sm-6 col-lg-4 col-xl-2 mb-1">
		                    	<div class="card">
			                        <div class="card-content">
			                            <div class="card-body">
			                            	<p class='text-left' style='padding-top: 3%; font-size: 2.8vh;'>Phenotype Analysis</p>
	                               			<p id='phenotype_analysis' class='text-right font-weight-bold' style='padding-top: 10%; font-size: 4rem;'>0</p>
			                            </div>
		                            </div>
			                        <div id="line-area-chart-6"></div>
		                        </div>
		                    </div>
	                    </div>
                    </div>
                    <div class="col-12">
                    	<div class="row">
		                    <div class="col-sm-12 col-lg-4">
		                    	<div class="card">
			                        <div class="card-content">
					                    	<div class="m-0">
				                           		<h1 class="ml-1 mt-1">Storage</h1>
				                           		<div id="goal-overview-radial-bar-chart" class="mb-1"></div>
			                          			<div class="row border-top text-center mx-0">
			                                    <div class="col-6 border-right py-1">
			                                        <p class="card-text text-muted mb-0">Used</p>
			                                        <h3 class="fw-bolder mb-0"><%=useSize %> GB</h3>
			                                    </div>
			                                    <div class="col-6 py-1">
			                                        <p class="card-text text-muted mb-0">Total</p>
			                                        <h3 class="fw-bolder mb-0"><%=totalSize %> GB</h3>
			                                    </div>
			                                </div>
				                         </div>
				                     </div>
				                 </div>    
		                    </div>
		                    <div class="col-sm-12 col-lg-8">
		                    	<div class="card">
			                        <div class="card-content">
			                            <div class="card-body">
		                               		<div class="row">
		                                		<div class="col-8">
		                                			<h1 class="mt-1 mb-1">Analysis</h1>
		                                		</div>
		                                		<div class="col-2 mt-1">
		                                			<div class="col-12">
			                                			<select class="select2 form-select">
			                                				<option>1</option>
			                                				<option>1</option>
			                                			</select>
			                                		</div>
		                                		</div>
		                                		<div class="col-2 mt-1">
		                                			<div class="col-12">
			                                			<select class="select2 form-select">
			                                				<option>1</option>
			                                				<option>1</option>
			                                			</select>
		                                			</div>
		                                		</div>
		                               		</div>
		                               		<div id="column-chart"></div>
			                            </div>
				                     </div>
				                 </div>    
		                    </div>
                    	</div>
                    </div>
                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
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
    <script src="../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../css/app-assets/js/scripts/forms/select/form-select2.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../../css/app-assets/vendors/js/charts/apexcharts.min.js"></script>
    <script src="../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
	<script src="../../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../../css/app-assets/js/core/app-menu.js"></script>
    <script src="../../css/app-assets/js/core/app.js"></script>
    <script src="../../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <!--  
    <script src="../../css/app-assets/js/scripts/ag-grid/ag-grid_statistics.js"></script>
    -->
    <script src="../../css/app-assets/js/scripts/cards/card-statistics.js"></script>
	<script src="../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->



	<script>
	
	// chartApex 관련 변수
	var percentSize = "<%=percentSize%>";
	var $budgetStrokeColor2 = '#dcdae3';
	var $goalStrokeColor2 = '#51e5a8';
	var $strokeColor = '#ebe9f1';
	var $textHeadingColor = '#5e5873';
	  
	var chartColors = {
	      		column: {
		      		series1: '#826af9',
		      		series2: '#d2b0ff',
		      		bg: 'transparent'
			    }
	}
	
	document.addEventListener('DOMContentLoaded', function() {
		getEachDataCount();
		goalOverviewChart();
		barChart();
	});
	
	
	function goalOverviewChart() {
		const $goalOverviewChart = document.querySelector('#goal-overview-radial-bar-chart');  
		//------------ Goal Overview Chart ------------
		//---------------------------------------------
		goalOverviewChartOptions = {
				chart: {
					height: 245,
					type: 'radialBar',
					sparkline: {
				        enabled: true
				    },
				    dropShadow: {		// 그림자 설정
				        enabled: true,	
				        blur: 3,
				        left: 1,
				        top: 1,
				        opacity: 0.2
				    }
				},
				colors: [$goalStrokeColor2],
				plotOptions: {
					radialBar: {
				        offsetY: -10,
				        startAngle: -150,
				        endAngle: 150,
				        hollow: {
				          size: '77%'
				        },
				        track: {
				          background: $strokeColor,
				          strokeWidth: '50%'
				        },
				        dataLabels: {
				        	name: {
				        		show: false
				        	},
				        	value: {
				        		color: $textHeadingColor,
				        		//fontSize: '2.86rem',
				        		fontSize: '20px',
				        		fontWeight: '600'
				        	}
				        }
					}
			    },
			    fill: {
			    	type: 'gradient',
			    	gradient: {
				        shade: 'dark',
				        type: 'horizontal',
				        shadeIntensity: 0.5,
				        //gradientToColors: [window.colors.solid.success],
				        inverseColors: true,
				        opacityFrom: 1,
				        opacityTo: 1,
				        stops: [0, 100]
				    }
			    },
			    series: [percentSize],
			    stroke: {
			      lineCap: 'round'
			    },
			    grid: {
			    	padding: {
			    		bottom: 30
			    	}
			    }
			};
		const goalOverviewChart = new ApexCharts($goalOverviewChart, goalOverviewChartOptions);
		goalOverviewChart.render();
	}
	
	function barChart() {
		// Column Chart
		// --------------------------------------------------------------------
		const columnChartEl = document.querySelector('#column-chart');
		const columnChartConfig = {
				chart: {
			        height: 235,
			        type: 'bar',
			        stacked: true,
			        parentHeightOffset: 0,
			        toolbar: {
			          show: false
			        }
			    },
			    plotOptions: {
			    	bar: {
			    		columnWidth: '15%',
			    		colors: {
			    			backgroundBarColors: [
			    				chartColors.column.bg,
			    				chartColors.column.bg,
			    				chartColors.column.bg,
			    				chartColors.column.bg,
			    				chartColors.column.bg
				            ],
				            backgroundBarRadius: 10
			    		},
			    		borderRadius: 5
			        }
			    },
			    dataLabels: {
			    	enabled: false
			    },
			    legend: {
			    	show: true,
			        position: 'top',
			        horizontalAlign: 'start'
			    },
			    colors: [chartColors.column.series1, chartColors.column.series2],
			    stroke: {
			    	show: true,
			        colors: ['transparent']
			    },
			    grid: {
			    	xaxis: {
				        lines: {
				        	show: true
				        }
				    }
			    },
			    series: [
			    	{
			    		name: 'Complete',
			    		data: [90, 120, 55, 100, 80, 125]
			        },
			        {
			        	name: 'On Progress',
			        	data: [85, 100, 30, 40, 95, 90]
			        }
			      ],
			      xaxis: {
			        categories: ['GWAS', 'GS', 'Primer\nDesign', 'Genotype\nProcess', 'Genotype\nAnalysis', 'Phetnotype\nAnalysis']
			      },
			      fill: {
			        opacity: 1
			      },
			    };
		  
		    const columnChart = new ApexCharts(columnChartEl, columnChartConfig);
		    columnChart.render();
	}
	
	function getEachDataCount() {
		
		const variety_id = $( "#variety-select option:selected" ).val();
		//const items = ['genotype_data', 'phenotype_data', 'GWAS', 'GS', 'genotype_analysis', 'phenotype_analysis'];
		
		const genotype_data = document.getElementById('genotype_data');
		const phenotype_data = document.getElementById('phenotype_data');
		const GWAS = document.getElementById('GWAS');
		const GS = document.getElementById('GS');
		const genotype_analysis = document.getElementById('genotype_analysis');
		const phenotype_analysis = document.getElementById('phenotype_analysis');
		
		const tableMap = new Map([
			['genotype_data', genotype_data],
			['phenotype_data', phenotype_data],
			['GWAS', GWAS],
			['GS', GS],
			['genotype_analysis', genotype_analysis],
			['phenotype_analysis', phenotype_analysis]
		])
		
		tableMap.forEach(function(value, key) {
			console.log(key); 
			
			$.ajax({
				url: 'statistics_getEachDataCount.jsp',
				method: 'POST',
				data: {
					'variety_id': variety_id,
					'table_name': key,
				},
				success: function(result) {
					console.log(key, " & ", result );
					//tableMap.get(key).value = data;
				}
			})
		})
	}
	
	</script>
</body>
<!-- END: Body-->

</html>