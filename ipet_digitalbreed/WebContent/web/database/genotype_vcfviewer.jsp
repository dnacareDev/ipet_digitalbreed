<script src="https://code.datagridxl.com/datagridxl2.js"></script>
<script src="http://code.jquery.com/jquery-latest.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/PapaParse/5.3.1/papaparse.min.js"></script>

	<style>
	#grid {
	  height: 200px;
	}
	</style>

	<%
		String jobid = request.getParameter("jobid");
	%>

	<div id="grid"></div>

	<script>

	var grid = new DataGridXL("grid", {
		  data: DataGridXL.createEmptyData(20,20),
	});

	$.ajax({
		type: 'POST',
		url:"../../result/database/genotype_statistics/<%=jobid%>/<%=jobid%>_genotype_matrix.csv",
		dataType: "text",
		data: {},
		success: function(result){

			  var file =result;
				Papa.parse(file, {
				  header: true,
				  dynamicTyping: true,
				  complete: function(results) {
				  grid = new DataGridXL("grid", {
							  data: results.data,
							  allowInsertRows : false,
							  allowInsertCols : false,
							  allowDeleteRows : false,
							  allowHideRows  : false,
							  allowHideCols  : false, 
							  allowDeleteCols : false, 
							  allowDeleteRows : false,
							  allowEditCells  : false,
							  allowCopy  : true,
							  allowCut  : false,
							  allowPaste  : false,
							  allowSort: false,
							  colHeaderLabelAlign : "center",
							  colWidth : 100,
							  rowHeight: 15,
							  colHeaderHeight: 15,
							  colAlign : "center"
					});

				var cellRange = [{
				  x:0,
				  y:0
				}, {
				  x:grid._cols.indexList.length,
				  y:grid._rows.indexList.length
				}];
				
				var cellRef;

				for(var y = cellRange[0].y; y < cellRange[1].y; y++){
				  for(var x = cellRange[0].x; x < cellRange[1].x; x++){
				  
							  cellRef = grid.getCellFromStore(grid.getRowIdByCoord(y), grid.getColIdByCoord(x));
					
							   if(cellRef.value=="A"){
									cellRef.color="#FFC800";
							   }
							   else  if(cellRef.value=="C"){
									cellRef.color="#CBFF75";
							   }				   
							   else  if(cellRef.value=="G"){
									cellRef.color="#79B9B1";
							   }
							   else  if(cellRef.value=="T"){
									cellRef.color="#FF92B1";
							   }
							   else  if(cellRef.value=="I"){
									cellRef.color="#9DF0E1";
							   }
							   else  if(cellRef.value=="R"){
									cellRef.color="#2C952C";
							   }
							   else  if(cellRef.value=="Y"){
									cellRef.color="#00AFFF";
							   }
							   else  if(cellRef.value=="M"){
									cellRef.color="#6495ED";
							   }
							   else  if(cellRef.value=="K"){
									cellRef.color="#28A0FF";
							   }
							   else  if(cellRef.value=="S"){
									cellRef.color="#0A9696";
							   }
							   else  if(cellRef.value=="W"){
									cellRef.color="#AD733A";
							   }
							   else  if(cellRef.value=="H"){
									cellRef.color="#F3B600";
							   }
							   else  if(cellRef.value=="B"){
									cellRef.color="	#182605";
							   }
							   else  if(cellRef.value=="V"){
									cellRef.color="	#4D0088";
							   }
							   else  if(cellRef.value=="D"){
									cellRef.color="#808080";
							   }
							   else  if(cellRef.value=="N"){
									cellRef.color="#182605";
							   }
						   }
						}
				  }
				});
				grid.redraw();
		}
});

</script>
