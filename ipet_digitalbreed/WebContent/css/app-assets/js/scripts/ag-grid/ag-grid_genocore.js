/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	function refresh() {
		gridOptions.api.refreshCells(); 
		agGrid
		    .simpleHttpRequest({ url: "../../../web/b_toolbox/genocore/genocore_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
		    	gridOptions.api.setRowData(data);
		    });
		vcfFileList();
	}
	
	function getSelectedRowData() {
		
		if( !confirm("삭제하시겠습니까?") ) {
			return;
		}
		
		let selectedData = gridOptions.api.getSelectedRows();
		var deleteitems = new Array();
		  
		for (var i = 0; i < selectedData.length; i++) {
		    deleteitems.push(selectedData[i].no);
		}
		
		console.log("delete row : ", deleteitems);
		
		$.ajax(
		{
		    url:"../../../web/b_toolbox/genocore/genocore_delete.jsp",
		    type:"POST",
		    data:{'params':deleteitems},
		    success: function(result) {
		        if (result) {
					alert("정상적으로 삭제되었습니다.");
					refresh();
		        } else {
		            alert("삭제하는 과정에서 에러가 발생 되었습니다. 관리자에게 문의 바랍니다.");
		        }
		    }
		});
	}

	/*** COLUMN DEFINE ***/
	var columnDefs = [
		{
	      headerName: "번호",
	      field: "no",
	      editable: false,
	      sortable: true,
	      width: 150,
	      filter: 'agMultiColumnFilter',
	      cellClass: "grid-cell-centered",      
	      checkboxSelection: true,
	      headerCheckboxSelectionFilteredOnly: true,
	      headerCheckboxSelection: true
	    },
	    {
	      headerName: "파일명",
	      field: "file_name",
	      editable: false,
	      sortable: true,
	      filter: true,
	      cellClass: "grid-cell-centered",      
	      width: 400,
	    },
	    {
	      headerName: "분석상태",
	      field: "status",
	      editable: false,
	      sortable: true,
	      filter: true,
	      cellClass: "grid-cell-centered",      
	      width: 200,
	    },
	    {
	      headerName: "상세내용",
	      field: "comment",
	      editable: false,
	      sortable: true,
	      filter: true,
	      cellClass: "grid-cell-centered",      
	      width: 750
	    },
	    {
	      headerName: "분석일",
	      field: "cre_dt",
	      editable: false,
	      sortable: true,
	      filter: "agDateColumnFilter",
	      cellClass: "grid-cell-centered", 
	      //cellStyle: {'background-color' : '#F0F0F0'},
	      //width: 314
	      width: 296
	    },
		{
	      headerName: "jobid",
	      field: "jobid",
	      hide: true
	    },  
		{
	      headerName: "uploadpath",
	      field: "uploadpath",
	      hide: true
	    },  
		{
	      headerName: "resultpath",
	      field: "resultpath",
	      hide: true
	    }        
	];
	

    /*** GRID OPTIONS ***/
	var gridOptions = {
		// 주석처리한 옵션 전부 작동안함. 다른 이름으로 바꿔야한다.
		columnDefs: columnDefs,
		rowHeight: 35,
		rowSelection: "multiple",
		//floatingFilter: true,
		//filter: 'agMultiColumnFilter',
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		animateRows: true,
		//resizable: true,
		serverSideInfiniteScroll: true,
	
		onCellClicked: params => {
		
			//console.log("cell id : " + params.column.getId());
			//console.log("params : ", params);
			
			//if(params.column.getId() != "filename" && params.column.getId() != "refgenome"){
			if(params.column.getId() != "no"){
				//console.log('cell jobid', params.data.jobid);
				//console.log('cell resultpath', params.data.resultpath);
				const element = document.getElementById('vcf_status');
			   	element.innerHTML  = `<div class='card-content'>
			   							<div class='card-body'>
			   								<div class='row'>
			   									<div class='col-12'>
			   										<ul class='nav nav-pills nav-active-bordered-pill'>
			   											<li class='nav-item'><a class='nav-link active' id='info' data-toggle='pill' href='#pill1' aria-expanded='true'>INFO</a></li>
						   								<li class='nav-item'><a class='nav-link' id='genocore' data-toggle='pill' href='#pill2' aria-expanded='false'>GENOCORE</a></li>
			   										</ul>
			   										<div class='tab-content'>
			   											<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
			   												<div id='pill1_frame' style='width:75%; height:130px; float:left;'></div>
			   											</div>
			   											<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
			   												<div class="row">
			   													<div class="col-12">
			   														<input type="text" class="form-control w-25 float-left" id="select_count" autocomplete="off">
			   														<input type="button" class="btn btn-primary ml-1 float-left" onclick="executeSelectCount()" value="execute">
			   													</div>
			   												</div>
			   												<div class="row">
			   													<div id='pill2_frame' class="col-12 col-xl-6 ag-theme-alpine" style='height:445px; margin-top:25px; float:left;'></div>
			   													<div class="col-12 col-xl-6">
			   														<iframe src = '' width='100%' height='500px'; frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill2_frame' id='pill3_frame' float:'left' ></iframe>
			   													</div>
			   												</div>
			   											</div>
			   										</div>
			   										<div class="hidden-parameter">
			   											<!-- parameters -->
			   											<input type='text' id='jobid' style='display:none;'>
			   											<input type='text' id='filename' style='display:none;'>
			   											<input type='text' id='resultpath' style='display:none;'>
			   											<input type='text' id='coresamples' style='display:none;'>
			   										</div>
			   									</div>
			   								</div>
			   							</div>
			   						</div>`;
			   	
			    //$('#pill1_frame').attr('src', params.data.resultpath + params.data.jobid+"/"+params.data.jobid+"_vcfinfo.txt");
			    
			    
			    // 단순 텍스트를 table화하고 sample값을 뽑아낸다. -> input count 제한값에 적용해야 함
			    const text_url = params.data.resultpath + params.data.jobid+"/"+params.data.jobid+"_vcfinfo.txt";
			    //console.log(text_url);
			    textToTable(text_url);
			   	
			    
			   	
			   	//$('#pill3_frame').attr('src', params.data.resultpath + params.data.jobid+"/"+params.data.jobid+"_genocore.html");
			    
			    /** #pill2_frame | 두번째 ag-grid */
			   	const csv_url = params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_genocore_table.csv";
			   	csvToGrid(csv_url);
			   	
		  	  	// input에 parameter 주입
			    $('#jobid').val(params.data.jobid);
			    $('#filename').val(params.data.file_name);
			    $('#resultpath').val(params.data.resultpath);
			}
		}
	};
	
	function textToTable(text_url) {
		$('#pill1_frame').empty();
		
		$.ajax({
	        type: "GET",
	        url: text_url,
	        dataType: "text",
	        success: function(data) {
	        	const raw_data = data.replaceAll(" ", "").split(/\r?\n|\r/);
	        	const row_data = raw_data.filter((element) => element !== "");
	        	//console.log("text data : ", data);
	        	//console.log(row_data);

	        	const text_table = `
	        					<table>
	        						<tr height='30px'>
	        							<th width='25%' bgcolor='f8f8f8'>${row_data[0].split(":")[0]}</th>
	        							<th width='25%' bgcolor='f8f8f8'>${row_data[1].split(":")[0]}</th>
	        							<th width='25%' bgcolor='f8f8f8'>${row_data[2].split(":")[0]}</th>
	        							<th width='25%' bgcolor='f8f8f8'>${row_data[3].split(":")[0]}</th>
	        						</tr>
	        						<tr height='30px'>
	        							<td width='25%'>${row_data[0].split(":")[1]}</td>
	        							<td width='25%'>${row_data[1].split(":")[1]}</td>
	        							<td width='25%'>${row_data[2].split(":")[1]}</td>
	        							<td width='25%'>${row_data[3].split(":")[1]}</td>
	        						</tr>
	        					</table>	
	        					`;
	        	
	        	$("#coresamples").val(row_data[1].split(":")[1]);
	        	
	        	//console.log("text_table : ", text_table);
	        	
	        	$('#pill1_frame').html(text_table);
	        }
	    });
	}
	
	const columnDefs2 = [
	  		{ field: "Iteration", cellClass: "grid-cell-centered", width: 212, filter: 'agNumberColumnFilter', },
	  		{ field: "Sample_name", cellClass: "grid-cell-centered", width: 215, filter: 'agTextColumnFilter', },
	  		{ field: "Coverage", cellClass: "grid-cell-centered", width: 220, filter: 'agNumberColumnFilter', },
	  		{ field: "Difference", cellClass: "grid-cell-centered", width: 220, filter: 'agNumberColumnFilter', }
	  	];

  	const gridOptions2 = {
	  	columnDefs: columnDefs2,
	  	animateRows: true
  	}
	
	function csvToGrid(csv_url) {
  		
  	  	const gridTable2 = document.getElementById("pill2_frame");
  	  	const PCA2Grid = new agGrid.Grid(gridTable2, gridOptions2);

  	  	fetch(csv_url)
	  	  	.then((response) => {
	  	  		response.text().then(data => {
	  	  			//console.log(data);
	  	  			
	  	  			let json_data = [];
	  	  			
		  	  		const raw_data = data.split(/\r?\n|\r/);
		        	const row_data = raw_data.filter((element) => element !== "");
		        	
		        	//console.log(row_data);
		        	
		        	for(let i=1 ; i<row_data.length ; i++) {
		        		const cell_data = row_data[i].split(",");
		        		
	        			json_data.push(
	        					{
	        						Iteration : cell_data[0],
	        						Sample_name : cell_data[1],
	        						Coverage : cell_data[2],
	        						Difference : cell_data[3]
	        					}
	        			);
		        	}
		        	
		        	console.log(json_data);
	  	  			
	  	  			gridOptions2.api.setRowData(json_data);
	  	  			gridOptions.api.sizeColumnsToFit();
	  	  			//gridOptions2.api.sizeColumnsToFit();
	  	  		});
	  	  	});
	}
	
	function executeSelectCount() {
		const count = $("#select_count").val();
		const filename = $('#filename').val();
		const jobid = $('#jobid').val();
		const resultpath = $('#resultpath').val();
		const coresamples = $('#coresamples').val();
		console.log(count);
		console.log(coresamples);
		
		console.log(Number(coresamples));
		
		//console.log("test end");
		//return;
		
		if(Number(count) > Number(coresamples)) {
			alert("Core Samples 값 " + coresamples + "보다 높은 값은 입력할 수 없습니다.")
			return;
		}
		
   		$.ajax({
   				url: "./genocore_select_count.jsp",
   				method: 'POST',
   				data: {
   					"count" : count,
   					"filename" : filename,
   					"jobid" : jobid, 
   					},
   				success: function(result) {
  					console.log("genocore_select_count.jsp success");
  					
  					//$('#pill3_frame').empty();
  				    $('#pill3_frame').attr('src', resultpath + jobid+"/"+jobid+"_genocore_filtering.html");
  				    
  				    // #pill2_frame 
  				    const csv_url = resultpath+"/"+jobid+"/"+jobid+"_genocore_table_filtering.csv";
  				    gridOptions2.api.destroy();
  				    csvToGrid(csv_url);
  				    gridOptions2.api.sizeColumnsToFit();
   				}
  		});
	}

	function replaceClass(id, oldClass, newClass) {
	    var elem = $(`#${id}`);
	    if (elem.hasClass(oldClass)) {
	        elem.removeClass(oldClass);
	    }
	    elem.addClass(newClass);
	}
	
	document.addEventListener('click', function(event) {
		if(event.target.id == "genocore" && !$("#pill3_frame").attr('src')) {
			
			const jobid = $('#jobid').val();
			const resultpath = $('#resultpath').val();
			
			gridOptions2.api.sizeColumnsToFit();
			$('#pill3_frame').attr('src', resultpath + jobid +"/"+ jobid+"_genocore.html");
		}
	})
	
  	$(".sort-dropdown .dropdown-item").on("click", function() {
  		var $this = $(this);
  		changePageSize($this.text());
  		$(".filter-btn").text("1 - " + $this.text() + " of 500");
  	});

  	/*** EXPORT AS CSV BTN ***/
  	$(".ag-grid-export-btn").on("click", function(params) {
  		gridOptions.api.exportDataAsCsv();
  	});

  	/*** INIT TABLE ***/
 // setup the grid after the page has finished loading
  	document.addEventListener('DOMContentLoaded', () => {
  		/*** DEFINED TABLE VARIABLE ***/
  		const gridTable = document.getElementById("myGrid");

  	  	/*** FILTER TABLE ***/
  	  	function updateSearchQuery(val) {
  	  		gridOptions.api.setQuickFilter(val);
  	  	}

  	  	$(".ag-grid-filter").on("keyup", function() {
  	  		updateSearchQuery($(this).val());
  	  	});
  	  	


  	  	/*** CHANGE DATA PER PAGE ***/
  	  	function changePageSize(value) {
  	  		gridOptions.api.paginationSetPageSize(Number(value));
  	  	}

  		
  		const myGrid = new agGrid.Grid(gridTable, gridOptions);
  		
  		/*** GET TABLE DATA FROM URL ***/
  	  	/*
  		agGrid
  			.simpleHttpRequest({ url: "../../../web/b_toolbox/genocore/genocore_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
  			.then(function(data) {
  			console.log("data : ", data);
  			  
  			gridOptions.api.setRowData(data);
  		});
  		*/
  		
  		fetch("../../../web/b_toolbox/genocore/genocore_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
			.then((response) => {
				response.json().then(data => {
					console.log(data);
					gridOptions.api.setRowData(data);
					gridOptions.api.sizeColumnsToFit();
				});
			});
  	});
  		
  	/*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/

  	if ($(window).width() < 768) {
  		//gridOptions.columnApi.setColumnPinned("email", null);
  	} else {
  		// gridOptions.columnApi.setColumnPinned("email", "left");
  	}
  	
  	$(window).on("resize", function() {
  		gridOptions.api.sizeColumnsToFit();
	  	gridOptions2.api.sizeColumnsToFit();
  		/*
  		if ($(window).width() < 768) {
  			//gridOptions.columnApi.setColumnPinned("email", null);
  		} else {
  			// gridOptions.columnApi.setColumnPinned("email", "left");
  		}
  		*/
  	});
  	
  	
  	
  
