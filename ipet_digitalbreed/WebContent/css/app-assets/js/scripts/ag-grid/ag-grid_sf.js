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
  		fetch("../../../web/b_toolbox/sf/sf_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		})
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
		    url:"../../../web/b_toolbox/sf/sf_delete.jsp",
		    type:"POST",
		    //data:{'params':deleteitems},
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
	    	cellClass: "grid-cell-centered",      
	    	maxWidth: 90,
	    	minWidth: 90,
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
	    	field: "filename",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    	width: 700,
	    	minWidth: 150,
	    },
	    {
	    	headerName: "처리내용",
	    	field: "manufacture",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    	width: 300,
	    	minWidth: 110,
	    },
	    {
	      headerName: "저장",
	      field: "save_cmd",
	      suppressMenu: true,
	      cellClass: "grid-cell-centered",
	      width: 150,
	      minWidth: 80,
	      cellRenderer: function(params) {
	    	  
	    	  console.log(params);
	    	  
	    	  switch(params.value) {
	    	  	case "0":
	    	  		return `<span style='cursor:pointer;' onclick='const status=${Number(params.data.status)}; if(status==0){return alert("분석 중입니다.");} saveToVcf("${params.data.filename}", "${params.data.jobid}", "${params.data.refgenome}", "${params.data.refgenome_id}")'><i class='feather icon-save'></i></span>`;
	    	  	case "1":
	    	  		return `<span style='cursor:pointer;' onclick='moveToVcf("${params.data.jobid}")'><i class='feather icon-link-2'></i></span>`;
	    	  }
	    	  
	      }
	    },
	    {
	    	headerName: "분석일",
	    	field: "cre_dt",
	    	filter: 'agDateColumnFilter',
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
	      	width: 150,
	      	minWidth: 110,
	      	cellClass: "grid-cell-centered", 
	    },
		{
	      headerName: "jobid",
	      field: "jobid",
	      hide: true
	    },  
	    {
		      field: "refgenome_id",
		      hide: true
		},
		{
		      field: "refgenome",
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
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		serverSideInfiniteScroll: true,
		
		defaultCsvExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		
		onCellClicked: params => {
			//console.log("params : ", params);
			
			if(params.colDef.headerName != "번호" &&params.colDef.headerName != "저장"){
				
				
				switch (Number(params.data.status)) {
					case 0:
						alert("분석 중입니다.");
						break;
					case 1:
						$("#iframeLoading").modal('show');
						
						document.getElementById('vcf_status').style.display = "block";
						document.getElementById('qf_1').click();
						
						$('#pill1_frame').attr('height',"130px");
						$('#pill1_frame').attr( 'src', "/ipet_digitalbreed/web/b_toolbox/sf/sf_vcfinfo.jsp?jobid="+params.data.jobid);
						
						// 클릭시 초기화
						$('#pill2_frame').attr('src', '');
						$('#pill3_frame').attr('src', '');
						$('#pill4_frame').attr('src', '');
						$('#pill5_frame').attr('src', '');
						
				   		
				   		// input에 jobid값 저장
				   		$("#jobid").val(params.data.jobid);
				   		$("#resultpath").val(params.data.resultpath);
				   		
						gridOptions.api.sizeColumnsToFit();
						
			  			$("html").animate({ scrollTop: $(document).height() }, 1000);
						
						break;
					case 2:
						//$("#analysis_fail").modal('show');
						alert("분석에 실패했습니다.");
						break;
				}
			}
		}
	};
	
	const selectChromosome_ColumnDefs = [
		{
			checkboxSelection: true,
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			minWidth: 50,
			maxWidth: 50,
		},
		{
			field: "chromosome",
			suppressMenu: true,
			cellClass: "grid-cell-centered",      
			width: 350,
	    },
	    {
	    	field: "length",
	    	hide: true,
	    },
	];
	
	const selectChromosome_gridOptions = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
				resizable: true,
				cellClass: "grid-cell-centered",
				suppressMenu: true,
				suppressMovable: true,
			},
			columnDefs: selectChromosome_ColumnDefs,
			rowHeight: 35,
			rowSelection: "multiple",
			//rowMultiSelectWithClick: true,
			suppressRowClickSelection: true,
			suppressMultiRangeSelection: true,
			suppressDragLeaveHidesColumns: true,
			colResizeDefault: "shift",
			animateRows: true,
			getRowId: params => params.data.chromosome,
			
			onCellClicked: params => {
					
					document.getElementById('addPosition').dataset.chromosome = params.data.chromosome;
					document.getElementById('addPosition').dataset.length = params.data.length;
					
					if(chr_regions[params.data.chromosome] === undefined) {
						chr_regions[params.data.chromosome] = [{'start_pos': 1, 'end_pos': params.data.length}];
					}
					
					//regionByChromosome_gridOptions.api.setRowData(chr_regions.get(params.data.chromosome));
					regionByChromosome_gridOptions.api.setRowData(chr_regions[params.data.chromosome]);
					
			},
			onRowSelected: params => {
				document.getElementById('addPosition').dataset.chromosome = params.data.chromosome;
				document.getElementById('addPosition').dataset.length = params.data.length;
				
				if(chr_regions[params.data.chromosome] === undefined) {
					chr_regions[params.data.chromosome] = [{'start_pos': 1, 'end_pos': params.data.length}];
				}
				
				//regionByChromosome_gridOptions.api.setRowData(chr_regions.get(params.data.chromosome));
				regionByChromosome_gridOptions.api.setRowData(chr_regions[params.data.chromosome]);
				//debugger;
			}
	}
	
	const regionByChromosome_columnDefs = [
		{
			field: "del",
			width: 80,
			editable: false,
			cellRenderer: (params) => {
				//debugger;
				return `<i class='ri-delete-bin-line'></i>`
			}
		},
		{
	    	field: "chromosome",
	    	hide: true,
	    },
	    {
			headerName: "Start pos.",
			field: "start_pos",
			valueFormatter: params => thousands_separator(params.value),
			width: 120,
	    },
	    {
	    	headerName: "End pos.",
			field: "end_pos",
			valueFormatter: params => thousands_separator(params.value),
			width: 120,
	    },
	];
	
	const regionByChromosome_gridOptions = {
			defaultColDef: {
				editable: true, 
			    sortable: true,
				resizable: true,
				cellClass: "grid-cell-centered",
				suppressMenu: true,
				suppressMovable: true,
			},
			columnDefs: regionByChromosome_columnDefs,
			rowHeight: 35,
			rowSelection: "multiple",
			suppressMultiRangeSelection: true,
			suppressDragLeaveHidesColumns: true,
			colResizeDefault: "shift",
			animateRows: true,
			undoRedoCellEditing: true,
			undoRedoCellEditingLimit: 1,
			onCellClicked: params => {
				
			},
			onCellEditingStopped: params => {
				//debugger;
				
				const oldValue = Number(params.oldValue);
				const newValue = Number(params.newValue);
				const chromosome = document.getElementById('addPosition').dataset.chromosome;
				const length = document.getElementById('addPosition').dataset.length
				
				if(isNaN(newValue) || length < newValue || newValue < 1 ) {
					alert(`1부터 ${length}까지의 숫자만 입력할 수 있습니다.`);
					return regionByChromosome_gridOptions.api.undoCellEditing();
					
				}
				
				if(params.colDef.field == 'start_pos' && Number(params.data.end_pos) < newValue) {
					alert('end position보다 큰 값은 입력할 수 없습니다.');
					return regionByChromosome_gridOptions.api.undoCellEditing();
				}
				
				if(params.colDef.field == 'end_pos' && newValue < Number(params.data.start_pos)) {
					alert('start position보다 작은 값은 입력할 수 없습니다.');
					return regionByChromosome_gridOptions.api.undoCellEditing();
				}
				
				//chr_regions.get(chromosome).push({'start_pos': 1, 'end_pos': params.data.length});
				//chr_regions.get(chromosome)[params.colDef.field] = newValue;
				
				
			},
			/*
			onCellValueChanged: params => {
				console.log("changed");
				console.log(params);
			}
			*/
	}
	
	const sampleNameGrid_columnDefs = [
		{
			checkboxSelection: true,
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			minWidth: 50,
			maxWidth: 50,
		},
		{
			headerName: "Sample Name",
			field: "sample",
			suppressMenu: true,
			cellClass: "grid-cell-centered",      
			width: 650,
	    },
	];
	
	const sampleNameGrid_gridOptions = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
				resizable: true,
				cellClass: "grid-cell-centered",
				suppressMenu: true,
				suppressMovable: true,
			},
			columnDefs: sampleNameGrid_columnDefs,
			rowHeight: 35,
			rowSelection: "multiple",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			suppressDragLeaveHidesColumns: true,
			colResizeDefault: "shift",
			animateRows: true,
			onCellClicked: params => {
				/*
				debugger;
				if(!!params.node.selected) {
					sample_map.set(params.)
				}
				*/
			}
	}
	
	// 클릭이벤트 : iframe 로딩 중 로드스피너 출력
	document.addEventListener('click', function(event) {
		//console.log(event.target.id);
		
		const jobid = $("#jobid").val();
		const resultpath = $("#resultpath").val();
		
		//console.log(jobid);
		
		switch(event.target.id) {
			case 'qf_2':
				if(!$('#pill2_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill2_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_variant.html");
				}
				break;
			case 'qf_3':
				if(!$('#pill3_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill3_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_depth.html");
				}
				break;
			case 'qf_4':
				if(!$('#pill4_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill4_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_miss.html");
				}
				break;
			case 'qf_5':
				if(!$('#pill5_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill5_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_density.html");
				}
				break;
		}
	});
	
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
  		fetch("../../../web/b_toolbox/sf/sf_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
			
			if(linkedJobid !== "null") {
				gridOptions.api.forEachNode((rowNode, index) => {
					if(linkedJobid == rowNode.data.jobid) {
						console.log(rowNode.rowIndex);
						
						gridOptions.api.paginationGoToPage(parseInt( Number(rowNode.rowIndex) / 20 ));
						
						gridOptions.api.ensureIndexVisible(Number(rowNode.rowIndex), 'middle');
						rowNode.setSelected(true);
						
						//gridOptions.api.setFocusedCell(Number(rowNode.rowIndex), 'no');
						//console.log($("[row-id='0'] [col-id='displayno']"));
						$(`[row-index=${rowNode.rowIndex}] [col-id='0']`).trigger("click");
					}
				});	
			}
  		})
  		
  		const selectChromosomeGrid = document.getElementById('selectChromosomeGrid')
  		new agGrid.Grid(selectChromosomeGrid, selectChromosome_gridOptions);
  		selectChromosome_gridOptions.api.setRowData([]);
  		//selectChromosome_gridOptions.columnApi.autoSizeColumns();
  		
  		const regionByChromosomeGrid = document.getElementById('regionByChromosomeGrid');
  		new agGrid.Grid(regionByChromosomeGrid, regionByChromosome_gridOptions);
  		regionByChromosome_gridOptions.api.setRowData([]);
  		regionByChromosome_gridOptions.columnApi.autoSizeAllColumns(false);
  		
  		const sampleNameGrid = document.getElementById('sampleNameGrid');
  		new agGrid.Grid(sampleNameGrid, sampleNameGrid_gridOptions);
  		sampleNameGrid_gridOptions.api.setRowData([]);
  		//sampleNameGrid_gridOptions.columnApi.autoSizeAllColumns(true);
	})	
	  	

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
	
	document.addEventListener('click', function(event) {
  		if(event.composedPath()[0].classList.contains("nav-link")) {
  			$("html").animate({ scrollTop: $(document).height() }, 1000);
  		}
  	});
	
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
		selectChromosome_gridOptions.api.sizeColumnsToFit();
    	regionByChromosome_gridOptions.api.sizeColumnsToFit();
    	sampleNameGrid_gridOptions.api.sizeColumnsToFit();
	});
  
