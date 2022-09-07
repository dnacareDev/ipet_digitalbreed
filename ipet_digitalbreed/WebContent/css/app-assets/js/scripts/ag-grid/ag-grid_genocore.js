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
	      filter: 'agNumberColumnFilter',
	      cellClass: "grid-cell-centered",      
	      width: 750
	    },
	    {
	      headerName: "분석일",
	      field: "cre_dt",
	      editable: false,
	      sortable: true,
	      filter: 'agNumberColumnFilter',
	      cellClass: "grid-cell-centered", 
	      cellStyle: {'background-color' : '#F0F0F0'},
	      width: 314
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
		//rowSelection: "multiple",
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
			console.log("params : ", params);
			
			//if(params.column.getId() != "filename" && params.column.getId() != "refgenome"){
			if(params.column.getId() == "file_name"){
				//console.log('cell jobid', params.data.jobid);
				//console.log('cell resultpath', params.data.resultpath);
				const element = document.getElementById('vcf_status');
			   	element.innerHTML  = `<div class='card-content'>
			   							<div class='card-body'>
			   								<div class='row'>
			   									<div class='col-12'>
			   										<ul class='nav nav-pills nav-active-bordered-pill'>
			   											<li class='nav-item'><a class='nav-link' id='info' data-toggle='pill' href='#pill1' aria-expanded='true'>info</a></li>
						   								<li class='nav-item'><a class='nav-link' id='genocore' data-toggle='pill' href='#pill2' aria-expanded='false'>PCA2 (2D)</a></li>
			   										</ul>
			   										<div class='tab-content'>
			   											<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
			   												<!--
			   												<iframe src = '' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill1_frame' id='pill1_frame'></iframe>
			   												-->
			   												<div id='pill1_frame' style='width:50%; height:470px; float:left;'></div>
			   											</div>
			   											<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
			   												<div class="row">
			   													<div class="col-12">
			   														<input type="button" class="btn btn-primary float-right" onclick="executeSelectCount()" value="execute">
			   														<input type="number" class="form-control w-25 float-right mr-2" id="select_count" placeholder="input count...">
			   													</div>
			   												</div>
			   												<div class="row">
			   													<div id='pill2_frame' style='width:50%; height:470px; overflow-y:scroll; float:left;'></div>
			   													<iframe src = '' width='50%' height='500px'; frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill2_frame' id='pill3_frame' float:'left' ></iframe>
			   												</div>
			   											</div>
			   										</div>
			   										<div class="hidden-parameter">
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
			    console.log(text_url);
			    textToTable(text_url);
			   	
			   	
			   	$('#pill3_frame').attr('src', params.data.resultpath + params.data.jobid+"/"+params.data.jobid+"_genocore.html");
			    
			    // #pill2_frame 
			    const csv_url = params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_genocore_table.csv";
			    csvToTable(csv_url);
			    
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
	        	const row_data = data.replaceAll(" ", "").split(/\r?\n|\r/);
	        	//console.log("text data : ", data);
	        	//console.log(row_data);

	        	let text_table = `<table>`;
	        	for(let i=0 ; i<row_data.length ; i++) {
	        		const cell_data = row_data[i].split(":");
	        		
	        		text_table += `<tr>`;
	        		for(let j=0 ; j<cell_data.length ; j++) {
	        			text_table += `<td>${cell_data[j]}</td>`;
	        			
	        			// coreSamples값을 input에 대입
	        			if(i==1 && j==1) {
	        				$('#coresamples').val(cell_data[j]);
	        			}
	        		}
	        		text_table += `</tr>`;
	        	}
	        	text_table += `</table>`;
	        	
	        	//console.log(text_table);
	        	
	        	$('#pill1_frame').html(text_table);
	        }
	    });
	}
	
	function csvToTable(csv_url) {
		
		$('#pill2_frame').empty();
		
		$.ajax({
	        type: "GET",
	        url: csv_url,
	        dataType: "text",
	        success: function(data) {
	        	const row_data = data.split(/\r?\n|\r/);
	        	const head_data = row_data[0].split(",");
	        	//console.log("csv data : ", data);
	        	//console.log(row_data);

	        	let excel_table = `<table>`;
	        	
	        	excel_table += `<thead><tr>`;
	        	for(let i=0 ; i<head_data.length ; i++) {
	        		excel_table += `<th>${head_data[i]}</th>`;
	        	}
	        	excel_table += `</tr></thead>`;
	        	
	        	excel_table += `<tbody>`;
	        	for(let i=1 ; i<row_data.length ; i++) {
	        		const cell_data = row_data[i].split(",");
	        		
	        		excel_table += `<tr>`;
	        		for(let j=0 ; j<cell_data.length ; j++) {
	        			excel_table += `<td>${cell_data[j]}</td>`;
	        		}
	        		excel_table += `</tr>`;
	        	}
	        	excel_table += `</tbody>`;
	        	
	        	
	        	excel_table += `</table>`;
	        	//console.log(excel_table);
	        	
	        	$('#pill2_frame').html(excel_table);
	        	
	        }
	    });
	}
	
	function executeSelectCount() {
		const count = $("#select_count").val();
		const filename = $('#filename').val();
		const jobid = $('#jobid').val();
		const resultpath = $('#resultpath').val();
		const coresamples = $('#coresamples').val();
		console.log(select_count);
		
		if(count > coresamples) {
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
  				    csvToTable(csv_url);
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
 
	/*** DEFINED TABLE VARIABLE ***/
	var gridTable = document.getElementById("myGrid");

	/*** GET TABLE DATA FROM URL ***/
  	agGrid
		.simpleHttpRequest({ url: "../../../web/b_toolbox/genocore/genocore_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		.then(function(data) {
		console.log("data : ", data);
		  
		gridOptions.api.setRowData(data);
	});
  	

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
  	new agGrid.Grid(gridTable, gridOptions);

  	/*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/

  	if ($(window).width() < 768) {
  		//gridOptions.columnApi.setColumnPinned("email", null);
  	} else {
  		// gridOptions.columnApi.setColumnPinned("email", "left");
  	}
  	
  	$(window).on("resize", function() {
  		if ($(window).width() < 768) {
  			//gridOptions.columnApi.setColumnPinned("email", null);
  		} else {
  			// gridOptions.columnApi.setColumnPinned("email", "left");
  		}
  	});
  
