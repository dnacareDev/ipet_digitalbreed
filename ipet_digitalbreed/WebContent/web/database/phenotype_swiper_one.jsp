<%@ page language="java" contentType="text/html; charset=UTF-8"
    pageEncoding="UTF-8"%>
<%@ page import="java.util.*, java.io.*, java.sql.*, java.text.*"%>
<%@ page import="ipet_digitalbreed.*"%>    


<%
	IPETDigitalConnDB ipetdigitalconndb = new IPETDigitalConnDB();
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
	
	String samplename = request.getParameter("samplename");		
	String varietyid = request.getParameter("variety");		
	String sampleno = request.getParameter("one_sampleno");		

	
	ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();	
	
	String sql = "select filename from sampledata_img_t where sampleno='"+sampleno+"' order by no desc";		
	
	System.out.println(sql);
	
	String img_p = "../../uploads/database/phenotype_img/"+varietyid+"_"+samplename+"/";
	
%>
<body>

	<script>document.getElementById("card-header_one").innerHTML = "<font size='3px'>Sample Name : <b><%=samplename%></b></font>"; </script>

	<div id="photo_one_desc" style="height: 237px;" class="swiper-progress swiper-container">
	<div style="height: 237px;" class="swiper-wrapper">	   
	   <%
	   int datacnt=0;
	   try{
		 ipetdigitalconndb.stmt = ipetdigitalconndb.conn.createStatement();
		 ipetdigitalconndb.rs=ipetdigitalconndb.stmt.executeQuery(sql);		
	  	 while (ipetdigitalconndb.rs.next()) { 		
			%>
			<div style="height: 237px;" class="swiper-slide"> <img class="img-fluid" style="height: 100%;width: 100%;" src="<%=img_p+ipetdigitalconndb.rs.getString("filename")%>" alt="banner"></div>
			<%
			datacnt++;
			}
			
		}catch(Exception e){
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.rs.close();
			System.out.println(e);
		}finally { 
			ipetdigitalconndb.stmt.close();
			ipetdigitalconndb.rs.close();
			ipetdigitalconndb.conn.close();
		}
	   
	 	  if(datacnt==0){
			%><div style="height: 237px;" class="swiper-slide"> <font color="black" size="4"><br><br><center><i class='feather icon-alert-triangle'>There is no registered Photo.</i></font></div><%
	 	  }
	   %>
	</div>
	<!-- Add Pagination -->
	<div class="swiper-pagination"></div>
	<!-- Add Arrows -->
	<div class="swiper-button-next"></div>
	<div class="swiper-button-prev"></div>
</div>

    <script src="../../css/app-assets/js/scripts/extensions/swiper.js"></script>

</body>

</html>