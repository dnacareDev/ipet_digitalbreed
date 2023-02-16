<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%-- vcfViewer를 variant browser에 사용 --%>

<%


%>


<!DOCTYPE html>
<html>
<head>
<meta charset="EUC-KR">
<title>Insert title here</title>

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
	
	<!--  
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/jquery-ui/jquery-ui.min.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/jquery-ui/jquery-ui.structure.min.css">
	<link rel="stylesheet" type="text/css" href="../../css/app-assets/vendors/css/jquery-ui/jquery-ui.theme.min.css">
    -->
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
<body>

	<div>
		<svg height="5" width="6">
			<polygon points="3,5 6,0 0,0" style="fill:#0073E5;" />
		</svg>
		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#bcbcbc" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
			<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
		</svg> 
		<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#b672f5" stroke="#b672f5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
			<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
		</svg>



		<svg width="81.760757" height="11.519"
			viewBox="0 0 21.632545 3.047735" 
			xmlns="http://www.w3.org/2000/svg"
			xmlns:svg="http://www.w3.org/2000/svg">
  			<g transform="translate(-0.9,-1.3)">
		   		<path
					style="fill:#c4bd97;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.264583"
					d="m 3.0536216,1.3147886 v 3.047842 h 4.360107 v -3.047842 z"
					/>
		   		<path
					style="fill:#c4bd97;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.264583"
					d="m 9.4032916,1.3147886 v 3.047842 h 1.9895634 v -3.047842 z"
					/>
		   		<path
					style="fill:#c4bd97;fill-opacity:1;fill-rule:evenodd;stroke:none;stroke-width:0.264583"
					d="m 19.097122,1.3147886 v 3.047842 h 3.428822 v -3.047842 z"
					/>
		   		<path
					style="fill:#000000;fill-opacity:1;fill-rule:nonzero;stroke:#000000;stroke-width:0.0026457px;stroke-linecap:butt;stroke-linejoin:round;stroke-miterlimit:4;stroke-dasharray:none;stroke-opacity:1"
					d="M 22.356619,2.5847226 H 2.6594126 v 0.253987 H 22.356619 Z M 3.0112906,1.6534376 0.89473358,2.7117166 3.0112906,3.7699946 Z"
					/>
  			</g>
		</svg>
		<svg style="border:1px solid black; position: absolute; top: 37px;" width="28" height="11" xmlns:svg="http://www.w3.org/2000/svg">
			<line style="stroke:#000000;stroke-width:1;" x1="4" y1="5" x2="20" y2="5"></line>
			<polygon points="0,5 5,2 5,8" style="fill:#000000;" />
			<polygon points="20,2 20,8 25,5" style="fill:#000000;" />
		</svg>
		<div id="test"></div>
	</div>

	<!-- BEGIN: Vendor JS-->
	<script src="../../css/app-assets/vendors/js/vendors.min.js"></script>
	    
	<!-- BEGIN Vendor JS-->
	
	<!-- BEGIN: Page Vendor JS-->
	   <script src="../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
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

<script type="text/javascript">
	
	const selectedDiv = document.getElementById('test');
	
	const xmlns = "http://www.w3.org/2000/svg";
	
	const svg = document.createElementNS(xmlns, "svg");
    svg.setAttribute('style', `border:1px solid black; position: absolute; top: 37px;`);
    svg.setAttribute('width', '20');
    svg.setAttribute('height', '11');
    //svg.setAttribute('viewBox', '0 0 21.63 3.05');
    svg.setAttributeNS("http://www.w3.org/2000/xmlns/", "xmlns:svg", "http://www.w3.org/2000/svg");
    
    const line = document.createElementNS(xmlns, "line");
    line.setAttribute('style', 'stroke:#000000;stroke-width:3;')
	line.setAttributeNS(null, 'line', `x1='0', y1='5' x2='20' y2='5'`);
    
    svg.appendChild(line);
    
	selectedDiv.append(svg);
</script>
</body>
</html>