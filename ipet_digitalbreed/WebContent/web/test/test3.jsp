<%@ page language="java" contentType="text/html; charset=EUC-KR"
    pageEncoding="EUC-KR"%>
<%@ page import="ipet_digitalbreed.*"%>   
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*,java.nio.file.*"%> 
<%@ page import="com.google.gson.*" %>

<%-- vcfViewer를 variant browser에 사용 --%>

<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	//
	
	
	JsonArray variantArr = new JsonArray();
	JsonArray jsonArray = new JsonArray();

	try {
		ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();

		String sql = "select vcf_id, jobid, row_index, contents, contents->'$.Reference' from vcfviewer_t where row_index in (1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20) and jobid='20230112165329'";
		//System.out.println("sql : " + sql);
		ipetdigitalconndb.rs = ipetdigitalconndb.stmt.executeQuery(sql);
		

		
		for(int i=0 ; ipetdigitalconndb.rs.next() ; i++ ) {
			
			JsonObject jsonObj = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();
			jsonArray.add(jsonObj);
			/*
			JsonObject jsonObj = JsonParser.parseString(ipetdigitalconndb.rs.getString("contents")).getAsJsonObject();

			String[] keyArr = jsonObj.keySet().toArray(new String[0]);
			System.out.println(Arrays.toString(keyArr));
			
			if(i==0) {
				System.out.println(i);
				
				
				//List<String> list = new ArrayList<>(jsonObj.keySet());
				//System.out.println(list);
				
				for(int j=1 ; j<keyArr.length ; j++) {
					JsonObject variantObj = new JsonObject();
					variantObj.addProperty("ID", keyArr[j]);
					variantObj.addProperty("position_"+i, jsonObj.get(keyArr[j]).getAsString());
					//System.out.println(keyArr[j]);
					variantArr.add(variantObj);
				}
			} else {
				for(int j=1 ; j<keyArr.length ; j++) {
					JsonObject variantObj = new JsonObject();
					variantObj.addProperty("ID", keyArr[j]);
					variantObj.addProperty("position_"+i, jsonObj.get(keyArr[j]).getAsString());
					//System.out.println(keyArr[j]);
					variantArr.add(variantObj);
				}
			}
			
			System.out.println(variantArr);
			
			//System.out.println(jsonObj.size());
			System.out.println(jsonObj);
			
			
			//jsonArray.add(jsonObj);
			*/
		}
		
		
		//System.out.println(jsonArray);
		//out.print(jsonArray);
		
		
		
	} catch(Exception e) {
		e.printStackTrace();
	} finally {
		ipetdigitalconndb.stmt.close();
		ipetdigitalconndb.rs.close();
		ipetdigitalconndb.conn.close();
	}
	
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
	
	<%--
	var variantArr = <%= variantArr %> 
	console.log(variantArr);
	--%>
	
	var jsonArray = <%= jsonArray %>
	console.log(jsonArray);
	
	
	/*
	fetch('./test.jsp')
	.then((response) => response.text())
	.then((data) => {
		const arr = data.split(",");
		if(arr[arr.length-1] == "") {
			arr.pop();
		}
		console.log(arr);
		for(let i=0 ; i<arr.length ; i++) {
			console.log( Math.floor(Number(arr[i])*100 / 309097251) / 100);
		}
	})
	*/
</script>
</body>
</html>