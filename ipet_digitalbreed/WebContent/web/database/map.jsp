<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>   

<head>
<meta http-equiv="Page-Enter" content="BlendTrans(Duration=0.2)">
<meta http-equiv="Page-exit" content="BlendTrans(Duration=0.2)">
<meta http-equiv="Content-Type" content="text/html; charset=UTF-8">	
<link rel="stylesheet" type="text/css" href="./css/style.css"/>
<%
	String imggps = request.getParameter("imggps");		
%>
<body>
<div id="map" style="width:580;height:292;"></div>

<script type="text/javascript" src="//dapi.kakao.com/v2/maps/sdk.js?appkey=627045c47f219b7e9a2f56ca315a10db"></script>
<script>
var mapContainer = document.getElementById('map'), // 지도를 표시할 div 
    mapOption = { 
        center: new kakao.maps.LatLng(<%=imggps%>), // 지도의 중심좌표
        level: 6 // 지도의 확대 레벨
    };

var map = new kakao.maps.Map(mapContainer, mapOption); // 지도를 생성합니다

// 마커가 표시될 위치입니다 
var markerPosition  = new kakao.maps.LatLng(<%=imggps%>); 

// 마커를 생성합니다
var marker = new kakao.maps.Marker({
    position: markerPosition
});

// 마커가 지도 위에 표시되도록 설정합니다
marker.setMap(map);

// 아래 코드는 지도 위의 마커를 제거하는 코드입니다
// marker.setMap(null);    
</script>
</body>
</html>
