/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	const filterParams = {
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
	}

	function refresh() {
		gridOptions.api.refreshCells(); 
		agGrid
			.simpleHttpRequest({ url: "./correlation_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
		    	console.log("data : ", data);
		    	gridOptions.api.setRowData(data);
		    });
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
		    url:"./correlation_delete.jsp",
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
		    },
		    hide: true,
	    },
	    {
	    	headerName: "상세내용",
	    	field: "comment",
	    	filter: 'agNumberColumnFilter',
	    	width: 350,
	    	minWidth: 110,
	    },
	    {
	    	headerName: "분석개체 수",
	    	field: "analysis_number",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    	width: 200,
	    	minWidth: 150,
	    },
	    {
	    	headerName: "분석 형질",
	    	field: "phenotype",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    	width: 300,
	    	minWidth: 150,
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
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		serverSideInfiniteScroll: true,
		onCellClicked: params => {
		
			//console.log("params : ", params);
			
			if(params.column.getId() != "no" && params.column.getId() != "cre_dt" ){
				
				fetch(`${params.data.resultpath+params.data.jobid}/Error.txt`)
				.then((response) => {
					if(response.ok) {
						return response.text();
					} else {
						throw new Error("Error, status - ", response.status);
					}
				})
				.then((error_message) => {
					return alert(error_message);
				})
				.catch((not_exist) => {
					$("#iframeLoading").modal('show');
					
					document.getElementById("Extra_Card").style.display = "block";
					
					$('#pill1_frame').attr('src', params.data.resultpath+params.data.jobid+"/Correlation_heatmap.html");
					
					window.scrollTo(0, document.body.scrollHeight);
				})
				
				
				/*
				switch (Number(params.data.status)) {
					case 0:
						//$("#analysis_process").modal('show');
						alert("분석 중입니다.");
						break;
					case 1:
						$("#iframeLoading").modal('show');
						
						document.getElementById("Extra_Card").style.display = "block";
				   		
						$('#pill1_frame').attr('src', params.data.resultpath+params.data.jobid+"/Correlation_heatmap.html");
						
						window.scrollTo(0, document.body.scrollHeight);
						
						break;
					case 2:
						//$("#analysis_fail").modal('show');
						alert("분석에 실패했습니다.");
						break;
				}
				*/
			}
		}
	};
	
	var columnDefsTraitName = [
		{
			rowDrag: true,
			suppressMenu: true,
			width: 40,
		},
		{
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			width: 40,
		},
		{ 	
			headerName:'특성', 
			field: "traitname",
			filter: true,
			menuTabs: ["filterMenuTab"], 
		},
		{
			field: "traitname_key",
			hide:true
		}
	];
	var gridOptionsTraitName = {
			defaultColDef: {
				editable: false, 
				filter: false,
			    sortable: true,
			    cellClass: "grid-cell-centered", 
			},
			columnDefs: columnDefsTraitName,
			rowDragManaged: true,
			rowDragMultiRow: true,
			rowHeight: 35,
			rowSelection: "multiple",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			animateRows: true,
			suppressHorizontalScroll: true,
			onGridReady: (params) => {
			    addGridDropZone3(params);
			},
	}
	
	var columnDefsTraitName_selected = [
		{
			rowDrag: true,
			suppressMenu: true,
			width: 40,
		},
		/*
		{
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true,
			//headerCheckboxSelection: true,
			width: 40,
		},
		*/
		{ 	
			headerName:'특성', 
			field: "traitname",
			filter: true,
			menuTabs: ["filterMenuTab"], 
		},
		{
			headerName: "삭제",
			field: "delete",
			cellRenderer: (params) => {
				//debugger;
				return `<i class='ri-delete-bin-line'></i>`
			}
		},
		{
			field: "traitname_key",
			hide:true
		}
	];
	var gridOptionsTraitName_selected = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
			    filter: false,
			    cellClass: "grid-cell-centered", 
			},
			columnDefs: columnDefsTraitName_selected,
			rowDragManaged: true,
			rowDragMultiRow: true,
			rowHeight: 35,
			rowSelection: "multiple",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			animateRows: true,
			suppressHorizontalScroll: true,
			getRowId: (params) => params.data.traitname_key,
			onCellClicked: (params) => {
				if(params.column.colId == "delete") {
					
					gridOptionsTraitName.api.applyTransaction({
			    		add: [params.node.data]
			    	}),
			    	
			    	gridOptionsTraitName.columnApi.applyColumnState({
			    	    state: [{ colId: 'traitname_key', sort: 'asc' }],
			    	    defaultState: { sort: null },
			    	});
			        
			    	gridOptionsTraitName_selected.api.applyTransaction({
			        	remove: [params.node.data]
			        });
			        
				}
			},
			
	}
	
	const columnDefs_individualName = [
		{
			//dndSource: true,
			rowDrag: true,
			suppressMenu: true,
			width: 40,
		},
		{ 	
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			width: 40,
		},
		{ 	
			headerName:'개체명', 
			field: "samplename",
			menuTabs: ["filterMenuTab"], 
		},
		{
			headerName: "등록일자",
			field: "cre_dt",
			filter: 'agDateColumnFilter',
		    filterParams: filterParams,
		    menuTabs: ["filterMenuTab"], 
		},
		{
			headerName: "조사일자",
			field: "act_dt",
			filter: 'agDateColumnFilter',
		    filterParams: filterParams,
		    menuTabs: ["filterMenuTab"], 
		},
		{
			field: 'no',
			hide: true,
		}
	];
	
	const gridOptions_individualName = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
			    movable: false,
			    filter: true,
			    cellClass: "grid-cell-centered",
			},
			columnDefs: columnDefs_individualName,
			rowDragManaged: true,
			rowDragMultiRow: true,
			rowHeight: 35,
			rowSelection: "multiple",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			animateRows: true,
			//suppressHorizontalScroll: true,
			getRowId: (params) => {
			    return params.data.no;
			},
			onGridReady: (params) => {
			    addGridDropZone(params);
			},
	}
	
	const columnDefs_individualGroupName = [
		{
			rowDrag: true,
			suppressMenu: true,
			width: 40,
		},
		/*
		{ 	
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			width: 40,
		},
		*/
		{ 	
			headerName:'개체명', 
			field: "samplename",
			menuTabs: ["filterMenuTab"], 
		},
		{
			headerName: "등록일자",
			field: "cre_dt",
			filter: 'agDateColumnFilter',
		    filterParams: filterParams,
		    menuTabs: ["filterMenuTab"], 
		},
		{
			headerName: "조사일자",
			field: "act_dt",
			filter: 'agDateColumnFilter',
		    filterParams: filterParams,
		    menuTabs: ["filterMenuTab"], 
		},
		{
			headerName: "삭제",
			field: "delete",
			cellRenderer: (params) => {
				//debugger;
				return `<i class='ri-delete-bin-line'></i>`
			}
		},
		{
			field: 'no',
			hide: true,
		}
		
	];
	
	const gridOptions_individualGroupName = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
			    filter: true,
			    cellClass: "grid-cell-centered",
			},
			columnDefs: columnDefs_individualGroupName,
			rowHeight: 35,
			rowDragManaged: true,
			rowDragMultiRow: true,
			rowSelection: "multiple",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			animateRows: true,
			//suppressHorizontalScroll: true,
			getRowId: (params) => {
			    return params.data.no;
			},
			onCellClicked: (params) => {
				if(params.column.colId == "delete") {
					
					gridOptions_individualName.api.applyTransaction({
			    		add: [params.node.data]
			    	}),
			    	
			    	gridOptions_individualName.columnApi.applyColumnState({
			    	    state: [
			    	    	{ colId: 'cre_dt', sort: 'desc', sortIndex:0 },
			    	    	{ colId: 'no', sort: 'desc', sortIndex:1 }
			    	    ],
			    	    defaultState: { sort: null },
			    	});
			        
			    	gridOptions_individualGroupName.api.applyTransaction({
			        	remove: [params.node.data]
			        });
				}
			},
			/*
			onGridReady: (params) => {
			    addGridDropZone2(params);
			},
			*/
	}
	
	function addGridDropZone(params) {
		const dropZoneParams = gridOptions_individualGroupName.api.getRowDropZoneParams({
		    onDragStop: (params) => {
		    	const nodes = params.nodes;

		    	gridOptions_individualName.api.applyTransaction({
		    		remove: nodes.map(function (node) {
		    			return node.data;
		    		}),
		        })
		    },
		});
		  params.api.addRowDropZone(dropZoneParams);
	}
	
	function addGridDropZone3(params) {
		const dropZoneParams = gridOptionsTraitName_selected.api.getRowDropZoneParams({
		    onDragStop: (params) => {
		    	const nodes = params.nodes;

		    	gridOptionsTraitName.api.applyTransaction({
		    		remove: nodes.map(function (node) {
		    			return node.data;
		    		}),
		        })
		    },
		});
		  params.api.addRowDropZone(dropZoneParams);
	}
	
	
	// 로딩이 완료되면 로딩창 소멸
	function hideSpinner(target, jobid) {
		if(target.src.includes(jobid)) {
			$("#iframeLoading").modal('hide');
		}
	}
 
	document.addEventListener('DOMContentLoaded', () => {
  		
		const varietyid = $( "#variety-select option:selected" ).val();
		
		const gridTable = document.getElementById("myGrid");
  		const myGrid = new agGrid.Grid(gridTable, gridOptions);
  		new agGrid.Grid(document.getElementById('Grid_Phenotype'), gridOptionsTraitName);
  		new agGrid.Grid(document.getElementById('Grid_Phenotype_Selected'), gridOptionsTraitName_selected);
  		
  		fetch("./correlation_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
			
  		})
  		
  		//const gridTraitNameTable = document.getElementById("phenotypeSelectGrid");
  		//const TraitNameGrid = new agGrid.Grid(gridTraitNameTable, gridOptionsTraitName);
  		
  		fetch(`../traitname.jsp?varietyid=${varietyid}`)
  		.then((response) => response.json())
  		.then((data) => {
  			console.log("traitname : ", data);
  			
  			gridOptionsTraitName.api.setRowData(data);
  			gridOptionsTraitName_selected.api.setRowData();
  		})	
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
	
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
	});
  
	//console.log(gridOptions);
  
