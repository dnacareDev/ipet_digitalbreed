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
			.simpleHttpRequest({ url: "./regression_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
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
		    url:"./regression_delete.jsp",
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
	    	filter: 'agTextColumnFilter',
	    	width: 350,
	    	minWidth: 110,
	    },
	    {
	    	headerName: "분석개체 수",
	    	field: "analysis_number",
	    	filter: 'agNumberColumnFilter',
	    	cellClass: "grid-cell-centered",
	    	width: 200,
	    	minWidth: 150,
	    },
	    // 독립과 종속이 뒤바뀌어서 전달됨. 관련변수&컬럼명도 dependent, independent가 바뀌어있는 상태. 
	    // 이미 만들어진걸 뒤집으면 복잡해지니 우선 headerName만 변경
	    {
	    	//headerName: "분석 형질(독립 변수)",
	    	headerName: "분석 형질(종속 변수)",
	    	field: "phenotype_independent",
	    	filter: 'agTextColumnFilter',
	    	cellClass: "grid-cell-centered",      
	    	width: 100,
	    	minWidth: 150,
	    },
	    {
	    	//headerName: "분석 형질(종속 변수)",
	    	headerName: "분석 형질(독립 변수)",
	    	field: "phenotype_dependent",
	    	filter: 'agTextColumnFilter',
	    	cellClass: "grid-cell-centered",      
	    	width: 200,
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
					
					$('#pill1_frame').attr('src', params.data.resultpath+params.data.jobid+"/Regression_paired_plot.html");
					
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
				   		
						//$('#pill1_frame').attr('src', "./t-test_resultInfo.jsp?jobid="+params.data.jobid);
						$('#pill1_frame').attr('src', params.data.resultpath+params.data.jobid+"/Regression_paired_plot.html");
						
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
			headerCheckboxSelection: true,
			headerCheckboxSelectionFilteredOnly: true,
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
	
	var columnDefsTraitName_independent = [
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
	var gridOptionsTraitName_independent = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
			    filter: false,
			    cellClass: "grid-cell-centered", 
			},
			columnDefs: columnDefsTraitName_independent,
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
			        
					gridOptionsTraitName_independent.api.applyTransaction({
			        	remove: [params.node.data]
			        });
			        
				}
			},
			
	}
	
	var columnDefsTraitName_dependent = [
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
	var gridOptionsTraitName_dependent = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
			    filter: false,
			    cellClass: "grid-cell-centered", 
			},
			columnDefs: columnDefsTraitName_dependent,
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
			        
					gridOptionsTraitName_dependent.api.applyTransaction({
			        	remove: [params.node.data]
			        });
			        
				}
			},
			
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
		const dropZoneParams = gridOptionsTraitName_independent.api.getRowDropZoneParams({
		    onDragStop: (params) => {
		    	const nodes = params.nodes;
		    	
		    	//if(nodes.length > 1) {
		    	if(nodes.length > 1 || gridOptionsTraitName_independent.api.getModel().rootNode.allLeafChildren.length > 1) {
		    		alert("독립변수에는 1개의 형질만 넣을 수 있습니다.");
		    		
		    		gridOptionsTraitName_independent.api.applyTransaction({
			    		remove: nodes.map(node => node.data)
			        })
			        
		    		return;
		    	}
		    	
		    	gridOptionsTraitName.api.applyTransaction({
		    		remove: nodes.map(function (node) {
		    			return node.data;
		    		}),
		        })
		    },
		});
		
		const dropZoneParams2 = gridOptionsTraitName_dependent.api.getRowDropZoneParams({
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
		params.api.addRowDropZone(dropZoneParams2);
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
  		new agGrid.Grid(document.getElementById('Grid_Phenotype_Independent'), gridOptionsTraitName_independent);
  		new agGrid.Grid(document.getElementById('Grid_Phenotype_Dependent'), gridOptionsTraitName_dependent);
  		
  		fetch("./regression_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
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
  			gridOptionsTraitName_independent.api.setRowData();
  			gridOptionsTraitName_dependent.api.setRowData();
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
  
