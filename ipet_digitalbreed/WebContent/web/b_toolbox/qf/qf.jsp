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
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/vendors.min.css">
 	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/innorix/innorix.css">    
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/charts/apexcharts.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/tether-theme-arrows.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/tether.min.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/extensions/shepherd-theme-default.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/vendors.min.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/tables/ag-grid/ag-grid.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/tables/ag-grid/ag-theme-alpine.css"> 
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/plugins/forms/validation/form-validation.css">
	<link rel="stylesheet" type="text/css" href="../../../css/app-assets/vendors/css/forms/select/select2.min.css">
    <!-- END: Vendor CSS-->

    <!-- BEGIN: Theme CSS-->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/bootstrap.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/bootstrap-extended.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/colors.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/components.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/themes/dark-layout.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/themes/semi-dark-layout.css">

    <!-- BEGIN: Page CSS-->
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/core/menu/menu-types/horizontal-menu.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/core/colors/palette-gradient.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/dashboard-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/card-analytics.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/plugins/tour/tour.css">
    <link rel="stylesheet" type="text/css" href="../../../css/app-assets/css/pages/aggrid.css">
    <!-- END: Page CSS-->

</head>
<!-- END: Head-->

<!-- BEGIN: Body-->

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	String permissionUid = session.getAttribute("permissionUid")+"";
	String cropvari_sql = "select a.cropname, a.cropid, b.varietyid, b.varietyname from crop_t a, variety_t b, permissionvariety_t c where c.uid='"+permissionUid+"' and c.varietyid=b.varietyid and a.cropid=b.cropid order by b.varietyid;";
	//System.out.println(cropvari_sql);
	//System.out.println("UID : " + permissionUid);
	
	RunAnalysisTools runAnalysisTools = new RunAnalysisTools();
	String jobid_pca = runAnalysisTools.getCurrentDateTime();
%>
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
			                <li class="nav-item"><a class="navbar-brand" href="../mainboard.jsp">
									<img src="../../../images/logo.png"><font size="4px"  color="#4c8aa9"><b>&nbsp;Digital Breeding</b></font>           
			                    </a></li>
			            </ul>
                    </div>
                    <ul class="nav navbar-nav float-right">
                        <li class="dropdown dropdown-user nav-item"><a class="dropdown-toggle nav-link dropdown-user-link" href="#" data-toggle="dropdown">
                                <div class="user-nav d-sm-flex d-none"><span class="user-name text-bold-600">DNACARE(master)</span><span class="user-status">Available</span></div><span><img class="round" src="../../../css/app-assets/images/portrait/small/avatar-s-11.jpg" alt="avatar" height="40" width="40"></span>
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

		<jsp:include page="../../../css/menu.jsp" flush="true">
		<jsp:param name="menu_active" value="qf"/>
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
                            <h2 class="content-header-title float-left mb-0">&nbsp;Genotype Database</h2>
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
                <!-- Basic example section start -->
                <section id="basic-examples">
                    <div class="card">
                        <div class="card-content">
                            <div class="card-body">
                                <div class="row">
                                    <div class="col-12">
                                        <div class="ag-grid-btns d-flex justify-content-between flex-wrap mb-1">
                                            <div class="dropdown sort-dropdown mb-1 mb-sm-0">                                                
                                                <select class="select2-bg form-control" id="excel-select" onchange="javascript:refresh();" data-bgcolor="success" data-bgcolor-variation="lighten-3" data-text-color="white">                                                   
                                                    <option value="-1" hidden="hidden" selected disabled>Select Excel File</option>
                                                    <%
	                                                    int new_excel_id = 0;

                                                    	try{
                                                    		//엑셀 정보 리스트
                                                    		String sql = "select * from test_excel_file";
                                                    		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
                                                    		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
                                                    		while(ipetdigitalconndb.rs.next()) {
                                                    			out.println("<option data-excel_id='" +ipetdigitalconndb.rs.getString("excel_id")+ "' data-column_length='" +ipetdigitalconndb.rs.getString("column_length")+    "' >" + ipetdigitalconndb.rs.getString("file_name") + "</option>");
                                                    		}
                                                    		
                                                    		//엑셀 개수
                                                    		String count_id_sql = "select max(excel_id) max from test_excel_file";
                                                    		ipetdigitalconndb.stmt1 = ipetdigitalconndb.conn.createStatement();
                                                			ipetdigitalconndb.rs1 = ipetdigitalconndb.stmt1.executeQuery(count_id_sql);
                                                			while(ipetdigitalconndb.rs1.next()) {
                                                				new_excel_id = ipetdigitalconndb.rs1.getInt("max") + 1;
                                                			}
                                                			
                                                    	} catch(Exception e) {
	                                                		System.out.println(e);
	                                                	} finally { 
	                                                		ipetdigitalconndb.stmt.close();
	                                                		ipetdigitalconndb.stmt1.close();
	                                                		ipetdigitalconndb.rs.close();
	                                                		ipetdigitalconndb.rs1.close();
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
                            <button class="btn btn-warning mr-1 mb-1" style="margin-left: 20px;float: left;" onclick="addnewrow()"><i class="feather icon-plus-square"></i> Add</button>
							<button id="excel_upload" class="btn btn-success mr-1 mb-1"  style="float: right;" data-toggle="modal" data-target="#backdrop" data-backdrop="false"><i class="feather icon-upload"></i> new Excel</button>
                            <button class="btn btn-danger mr-1 mb-1" style="float: right;" onclick="getSelectedRowData()"><i class="feather icon-trash-2"></i> Del</button>
                            <input type="file" id="excel_file" style="display:none;">
                        </div>
                    </div>
                    <div id="vcf_status" class="card"></div>
                </section>
                <!-- // Basic example section end -->
                
                <!-- hidden input parameter -->
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
    <script src="../../../css/app-assets/vendors/js/vendors.min.js"></script>
    <script src="../../../css/app-assets/vendors/js/innorix/innorix.js"></script>
    <script src="../../../css/app-assets/vendors/js/forms/select/select2.full.min.js"></script>
    <script src="../../../css/app-assets/js/scripts/forms/select/form-select2.js"></script>    
    <script src="../../../css/app-assets/js/scripts/sheetjs/xlsx.full.min.js"></script>
    <!-- BEGIN Vendor JS-->

    <!-- BEGIN: Page Vendor JS-->
    <script src="../../../css/app-assets/vendors/js/tables/ag-grid/ag-grid-community.min.noStyle.js"></script>
	<script src="../../../css/app-assets/vendors/js/ui/jquery.sticky.js"></script>
    <!-- END: Page Vendor JS-->

    <!-- BEGIN: Theme JS-->
    <script src="../../../css/app-assets/js/core/app-menu.js"></script>
    <script src="../../../css/app-assets/js/core/app.js"></script>
    <script src="../../../css/app-assets/js/scripts/components.js"></script>
    <!-- END: Theme JS-->

    <!-- BEGIN: Page JS-->
    <script src="../../../css/app-assets/js/scripts/ag-grid/ag-grid_test.js"></script>
    <script src="../../../css/app-assets/js/scripts/plotly-latest.min.js"></script>   
	<script src="../../../css/app-assets/vendors/js/forms/validation/jqBootstrapValidation.js"></script>    
    <script src="../../../css/app-assets/js/scripts/forms/validation/form-validation.js"></script>
    <!-- END: Page JS-->

<script>      
	
	$(document).ready(function() {

		/*
		fetch('./test.jsp')
		.then((response) => response.json())
		.then((data) => {
			//console.log(data);
			
			const column_length = data.pop();
			
			console.log(column_length);
			console.log(data);
		})
		*/
		
	})
	
	$("#excel_upload").click( function() {
		$("#excel_file").click();
	})
	
	
	document.getElementById("excel_file").onchange = (evt) => {
		 
		var reader = new FileReader(); 
	 
		reader.addEventListener("loadend", (evt) => {
		
	    	let workbook = XLSX.read(
	    		evt.target.result, {type: "binary"}),
	    	    worksheet = workbook.Sheets[workbook.SheetNames[0]],
	    	    range = XLSX.utils.decode_range(worksheet["!ref"]
	    	    );
	 
	    	var data = [];
	    	for (let row=range.s.r; row<=range.e.r; row++) {
	    		let i = data.length;
	    		data.push([]);
	    		for (let col=range.s.c; col<=range.e.c; col++) {
	    	    	let cell = worksheet[XLSX.utils.encode_cell({r:row, c:col})];
	    	    	if(!cell?.v) {
	    	    		data[i].push("");
	    	    	} else {
			    	    data[i].push(cell.v);
	    	    	}
	    		}
	    	}
	    uploadExcel(data);
	    
	  	});
	 
		reader.readAsArrayBuffer(evt.target.files[0]);
		
	};
	
	function uploadExcel(data) {
		console.log(data);
		
		const new_excel_id = <%=new_excel_id%>;
		const file_name = $("#excel_file")[0].files[0].name;
		const row_length = data.length;
		const column_length = data[0].length;
		const header = data[0];
		
		console.log("file_name : ", file_name);
		
		
		let json_header = [];
		for(let i=0 ; i<column_length ; i++) {
			json_header.push("column_"+i);
		}
		console.log(json_header);
		
		let json_array = [];
		for(let i=0 ; i<row_length ; i++) {
			const obj = {};
			for(let j=0 ; j<column_length ; j++) {
				obj[json_header[j]] = data[i][j];
			}
			json_array.push(obj);
			
		}
		
		console.log("json_array : ", json_array);
		
		$.ajax({
			url: './insertExcel.jsp',
			method: 'POST',
			data: {
				new_excel_id : new_excel_id,
				file_name : file_name, 
				column_length : column_length,
				file_contents : JSON.stringify(json_array),
				},
			succenss: function(result) {
				//console.log(result);
				//refresh();
				alert("엑셀 업로드 성공");
			}
			
		})
	}
	

	
   
</script>
</body>
<!-- END: Body-->

</html>