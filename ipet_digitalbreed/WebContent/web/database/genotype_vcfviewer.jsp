<!DOCTYPE html>
<html>
 <head>
	<script src="http://code.jquery.com/jquery-latest.min.js"></script>
 </head>

 <style>
 <style type="text/css">
    tr.row:hover { background-color: #E29348; }
table {
  border-collapse: collapse;
  font-size: 10pt;
}
.tableWrapper {
  border-top: 3px solid #168;
    width: 400px;
    height: 300px;
    overflow: auto;
    position: relative;
}

#userListTable th {
    position: sticky;
    top: 0px;}

.bluetop {
  border-collapse: collapse;
  line-height:16px;
} 
.bluetop th, .bluetop td {
  border: 1px solid #ddd;
  text-align:center;
}
.bluetop th {
  color: #000000;
  background: #A8A7A7;
}
.bluetop th:first-child, .bluetop td:first-child {
  border-left: 0;
}
.bluetop th:last-child, .bluetop td:last-child {
  border-right: 0;
}
td.fixed {
    position: sticky;
    left: 0;
    z-index: 1;

    background-color: #A8A7A7;
}

 </style>
 
 
 <body>

  <div class="container">
   <div class="table-responsive">
     <input type="text"  style="margin-left: 50px; margin-bottom: 5px" id="myInput" onkeyup="myFunction()" placeholder="Search for names.."><br>
	 <center>
    <div id="employee_table" style='width:95%; height:122px; overflow:auto'>
	</center>
    </div>
   </div>
  </div>
 </body>
</html>

<script>
	function myFunction() {
	  // Declare variables
	  var input, filter, table, tr, td, i, txtValue;
	  input = document.getElementById("myInput");
	  filter = input.value.toUpperCase();
	  table = document.getElementById("userListTable");
	  tr = table.getElementsByTagName("tr");

	  // Loop through all table rows, and hide those who don't match the search query
	  for (i = 0; i < tr.length; i++) {
		td = tr[i].getElementsByTagName("td")[0];
		if (td) {
		  txtValue = td.textContent || td.innerText;
		  if (txtValue.toUpperCase().indexOf(filter) > -1) {
			tr[i].style.display = "";
		  } else {
			tr[i].style.display = "none";
		  }
		}
	  }
	}
</script>
<%
	String jobid = request.getParameter("jobid");
%>
<script>
$(document).ready(function(){
$.ajaxSetup({cache : false})
$.ajax({
    type: 'POST',
	url:"../../result/database/genotype_statistics/<%=jobid%>/<%=jobid%>_genotype_matrix.csv",
	dataType: "text",
    data: {},
    success: function(data){

           var employee_data = data.split(/\r?\n|\r/);
			var table_data = '<table  style="width:95%;" class="bluetop" id="userListTable" border="1: px solid #444444;">';
			for(var count = 0; count<employee_data.length; count++)
			{
				 var cell_data = employee_data[count].split(",");

				 table_data += '<tr>';

				 //for(var cell_count=0; cell_count<cell_data.length; cell_count++)
				 for(var cell_count=0; cell_count<100; cell_count++)
				 {
				  if(count === 0)
				  {
					  var chr_pos="";
					  if(cell_data[cell_count]!="chr_pos"){						  
							chr_pos =cell_data[cell_count];
					  }
				  // table_data += '<th align="left" width="1px" STYLE="writing-mode: tb-rl;padding-right:0px">'+chr_pos+'</th>';
					  table_data += '<th style="padding-left: 8px; padding-right: 8px;" align="center" width="1px">'+chr_pos+'</th>';
				  }
				  else
				  {
				   var cell_val = cell_data[cell_count];
				   var cell_val_color="#FFFFFF";
				   var cell_val_help;

				   if(cell_val=="A"){
						cell_val_color="#FFC800";
						cell_val_help="Nucleotides : A";
				   }

				   else  if(cell_val=="C"){
						cell_val_color="#CBFF75";
						cell_val_help="Nucleotides : C";
				   }
				   
				   else  if(cell_val=="G"){
						cell_val_color="#79B9B1";
						cell_val_help="Nucleotides : G";
				   }

				   else  if(cell_val=="T"){
						cell_val_color="#FF92B1";
						cell_val_help="Nucleotides : T";
				   }
				   else  if(cell_val=="I"){
						cell_val_color="#9DF0E1";
						cell_val_help="Nucleotides : I";
				   }
				   else  if(cell_val=="R"){
						cell_val_color="#2C952C";
						cell_val_help="Nucleotides : A or G";
				   }
				   else  if(cell_val=="Y"){
						cell_val_color="#00AFFF";
						cell_val_help="Nucleotides : C or T";
				   }
				   else  if(cell_val=="M"){
						cell_val_color="#6495ED";
						cell_val_help="Nucleotides : A or C";
				   }
				   else  if(cell_val=="K"){
						cell_val_color="#28A0FF";
						cell_val_help="Nucleotides : G or T";
				   }
				   else  if(cell_val=="S"){
						cell_val_color="#0A9696";
						cell_val_help="Nucleotides : C or G";
				   }
				   else  if(cell_val=="W"){
						cell_val_color="#AD733A";
						cell_val_help="Nucleotides : A or T";
				   }
				   else  if(cell_val=="H"){
						cell_val_color="#F3B600";
						cell_val_help="Nucleotides : A or C or T";
				   }
				   else  if(cell_val=="B"){
						cell_val_color="	#182605";
						cell_val_help="Nucleotides : C or G or T";
				   }
				   else  if(cell_val=="V"){
						cell_val_color="	#4D0088";
						cell_val_help="Nucleotides : A or C or G";
				   }
				   else  if(cell_val=="D"){
						cell_val_color="#808080";
						cell_val_help="Nucleotides : A or G or T";
				   }
				   else  if(cell_val=="N"){
						cell_val_color="#182605";
						cell_val_help="Nucleotides : A or C or G or T";
				   }
				   if(cell_count==0){
					    table_data += '<td style="padding-left: 8px; padding-right: 8px;" class="fixed" title="'+cell_val_help+'" width="1px"  height="1px;"  bgcolor='+cell_val_color+' align="center"><b>'+cell_data[cell_count]+'</b></td>';
				   }
				   else{
						table_data += '<td title="'+cell_val_help+'" width="1px"  height="1px;"  bgcolor='+cell_val_color+' align="center">'+cell_data[cell_count]+'</td>';
				   }				  }
				 }
				 table_data += '</tr>';
				}
				table_data += '</table>';


			   $('#employee_table').html(table_data);
    }
});

 
});
</script>