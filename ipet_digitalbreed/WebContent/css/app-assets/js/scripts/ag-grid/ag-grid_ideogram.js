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
		    .simpleHttpRequest({ url: "./ideogram_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
		    	gridOptions.api.setRowData(data);
		    });
		vcfFileList();
	}
	
	function getSelectedRowData() {
		
		if(!gridOptions.api.getSelectedRows().length) {
			alert("선택 된 항목이 없습니다.")
			return;
		}
		
		if( !confirm("삭제하시겠습니까?") ) {
			return;
		}
		
		let selectedData = gridOptions.api.getSelectedRows();
		var deleteitems = new Array();
		
		const varietyid = $( "#variety-select option:selected" ).val();
		  
		for (var i = 0; i < selectedData.length; i++) {
		    deleteitems.push(selectedData[i].no);
		}
		
		console.log("delete row : ", deleteitems);
		
		$.ajax(
		{
		    url:"./ideogram_delete.jsp",
		    type:"POST",
		    data:{'params':deleteitems, 'varietyid':varietyid},
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
	      headerName: "순번",
	      //field: "no",
	      valueGetter: inverseRowCount,
	      maxWidth: 100,
	      minWidth: 100,
	      suppressMenu: true,
	      cellClass: "grid-cell-centered",      
	      checkboxSelection: true,
	      headerCheckboxSelectionFilteredOnly: true,
	      headerCheckboxSelection: true
	    },
	    {
	    	headerName: "분석상태",
	    	field: "status",
	    	suppressMenu: true,
	    	maxWidth: 90,
	    	minWidth: 90,
	    	cellClass: "grid-cell-centered",      
	    	cellRenderer: function(params) {
	    		//console.log("params : ", params.value);
	    		switch(Number(params.value)) {
					case 0: 
						return "<span title='분석 중'><i class='feather icon-loader'></i></span>";
					case 1:
						return "<span title='분석 완료'><i class='feather icon-check-circle'></i></span>";
					case 2:
						return "<span title='분석 실패'><i class='feather icon-x-circle'></i></span>";
	    		}
	    	}
	    },
	    {
	      headerName: "VCF 파일명",
	      field: "file_name",
	      filter: true,
	      cellClass: "grid-cell-centered",      
	      width: 700,
	      minWidth: 150,
	    },
	    {
	      headerName: "상세내용",
	      field: "comment",
	      filter: true,
	      width: 350,
	      minWidth: 90,
	      minWidth: 110,
	    },
	    {
	      headerName: "분석일",
	      field: "cre_dt",
	      filter: "agDateColumnFilter",
	      filterParams: {
	        	comparator: function(filterLocalDateAtMidnight, cellValue) {
	        		if (cellValue == null) {
	        			return 0;
	                }
	        		
	                var dateParts = cellValue.split('-');
	                var year = Number(dateParts[0]);
	                var month = Number(dateParts[1]) - 1;
	                var day = Number(dateParts[2]);
	                var cellDate = new Date(year, month, day);
	                
	                if (cellDate < filterLocalDateAtMidnight) {
	                    return -1;
	                } else if (cellDate > filterLocalDateAtMidnight) {
	                    return 1;
	                } else {
	                    return 0;
	                }
	        	}
	      },
	      cellClass: "grid-cell-centered", 
	      width: 150,
	      minWidth: 110
	    },
		{
	      field: "jobid",
	      hide: true
	    },  
		{
	      field: "uploadpath",
	      hide: true
	    },  
		{
	      field: "resultpath",
	      hide: true
	    }        
	];
	
	function inverseRowCount(params) {
		return params.api.getDisplayedRowCount() - params.node.rowIndex;
	}

    /*** GRID OPTIONS ***/
	var gridOptions = {
		defaultColDef: {
			editable: false, 
		    sortable: true,
			resizable: true,
			menuTabs: ['filterMenuTab'],
			//floatingFilter: true,
		},
		columnDefs: columnDefs,
		rowHeight: 35,
		rowSelection: "multiple",
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		defaultCsvExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
	
		onCellClicked: params => {
		
			//console.log("cell id : " + params.column.getId());
			//console.log("params : ", params);
			
			if(params.column.getId() != "no"){
				//console.log('cell jobid', params.data.jobid);
				//console.log('cell resultpath', params.data.resultpath);
				
				switch (Number(params.data.status)) {
					case 0:
						alert("분석 중입니다.");
						break;
					case 1:
	
						$("#iframeLoading").modal('show');
						
						document.getElementById('vcf_status').style.display = 'block';
						window.scrollTo(0, document.body.scrollHeight);
						
						document.getElementById('vcf_status').dataset.jobid = params.data.jobid;
						document.getElementById('vcf_status').dataset.resultpath = params.data.resultpath;
						

						$('#pill1_frame').attr('src', `${params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_density.html"}`);
						
						fetch(`${params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_totalcount.csv"}`)
						.then((response) => {
							if(!response.ok) {
								throw new Error('Error - ' +response.status);
								$("#iframeLoading").modal('hide');
							} else {
								return response.blob();
							}
						})
						.then((file) => {
							const reader = new FileReader();
						    reader.onload = function(){
						    	
						    	const fileData = reader.result;
						    	const wb = XLSX.read(fileData, {type : 'binary', });
						    	const rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
						        console.log("rowObj : ", rowObj);
						        
						        gridOptions_totalCount.api.setRowData(rowObj);
						        gridOptions_totalCount.api.sizeColumnsToFit();
						        $("#iframeLoading").modal('hide');
						    };
						    reader.readAsBinaryString(file);
						});
						
						fetch(`${params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_binsize.csv"}`)
						.then((response) => {
							if(!response.ok) {
								throw new Error('Error - ' +response.status);
								$("#iframeLoading").modal('hide');
							} else {
								return response.blob();
							}
						})
						.then((file) => {
							const reader = new FileReader();
						    reader.onload = function(){
						    	
						    	const fileData = reader.result;
						    	const wb = XLSX.read(fileData, {type : 'binary', });
						    	const rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
						        console.log("rowObj : ", rowObj);
						        
						        gridOptions_binSize.api.setRowData(rowObj);
						        //gridOptions2.api.sizeColumnsToFit();
						        $("#iframeLoading").modal('hide');
						    };
						    reader.readAsBinaryString(file);
						});
					    
					    break;
					case 2:
						alert("분석에 실패했습니다.");
						break;
					}
				}
			}
		};
	
	// 로딩이 완료되면 로딩창 소멸
	function hideSpinner() {
		$("#iframeLoading").modal('hide');
	}
	
	document.getElementById('Density_Plot').addEventListener('click', function(event) {
		//console.log(event.target.id);
		
		const jobid = document.getElementById('vcf_status').dataset.jobid;
		const resultpath = document.getElementById('vcf_status').dataset.resultpath;
		
		if(!$('#pill1_frame').attr('src')){
			$("#iframeLoading").modal('show');
			$('#pill1_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_density.html");
		}
	});
	
	document.getElementById('Ideogram').addEventListener('click', function(event) {
		//console.log(event.target.id);
		
		const jobid = document.getElementById('vcf_status').dataset.jobid;
		const resultpath = document.getElementById('vcf_status').dataset.resultpath;
		
		if(!$('#pill2_frame').attr('src')){
			$("#iframeLoading").modal('show');
			$('#pill2_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_pos.html");
		}
	});
	
	const columnDefs_totalCount = [
	  		{ field: "chr", width: 212, filter: 'agNumberColumnFilter', },
	  		{ field: "variant_count", width: 215, filter: 'agTextColumnFilter', },
	  	];

  	const gridOptions_totalCount = {
		defaultColDef: {
			editable: false, 
		    sortable: true,
			resizable: true,
			cellClass: "grid-cell-centered",
			menuTabs: ['filterMenuTab'],
		},
	  	columnDefs: columnDefs_totalCount,
	  	suppressDragLeaveHidesColumns: true,
	  	animateRows: true,
	  	onCellClicked: (params) => {
	  		
	  	},
  	}
  	
	const columnDefs_binSize = [
  		{ field: "chr", width: 212, filter: 'agNumberColumnFilter', },
  		{ field: "pos_start", width: 215, filter: 'agTextColumnFilter', },
  		{ field: "pos_end", width: 220, filter: true, },
  		{ field: "count", width: 220, filter: 'agNumberColumnFilter', },
  		{ field: "key", width: 220, filter: 'agNumberColumnFilter', hide: true, },
  	];

	const gridOptions_binSize = {
		defaultColDef: {
			editable: false, 
		    sortable: true,
			resizable: true,
			cellClass: "grid-cell-centered",
			menuTabs: ['filterMenuTab'],
		},
	  	columnDefs: columnDefs_binSize,
	  	suppressDragLeaveHidesColumns: true,
	  	animateRows: true,
	  	onCellClicked: (params) => {
	  		
	  	},
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
  	
  	/*** FILTER TABLE ***/
  	function updateSearchQuery(val) {
  		gridOptions.api.setQuickFilter(val);
  	}

  	$(".ag-grid-filter").on("keyup", function() {
  		updateSearchQuery($(this).val());
  	});

  	/*** INIT TABLE ***/
 // setup the grid after the page has finished loading
  	document.addEventListener('DOMContentLoaded', () => {
  		/*** DEFINED TABLE VARIABLE ***/
  		const gridTable = document.getElementById("myGrid");
  		new agGrid.Grid(gridTable, gridOptions);
  		
  		/*** GET TABLE DATA FROM URL ***/
  		fetch("./ideogram_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
  		.then((response) => response.json())
  		.then(data => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		});
  		
  		new agGrid.Grid(document.getElementById('Density_Grid'), gridOptions_totalCount);
  		new agGrid.Grid(document.getElementById('Ideogram_Grid'), gridOptions_binSize);
  	});
  	
  	$(window).on("resize", function() {
  		gridOptions.api.sizeColumnsToFit();
	  	gridOptions2.api.sizeColumnsToFit();
  	});
  	
  	
  	
  
