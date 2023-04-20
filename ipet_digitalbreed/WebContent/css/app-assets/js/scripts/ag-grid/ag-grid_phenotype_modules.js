
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

	var columnDefsTraitName = [
		{
			rowDrag: true,
			suppressMenu: true,
			width: 40,
		},
		{
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true,
			//sheaderCheckboxSelection: true,
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
			onRowSelected: (params) => {
				if(gridOptionsTraitName.api.getSelectedRows().length + gridOptionsTraitName_selected.api.getModel().rootNode.allLeafChildren.length > 2) {
					params.node.setSelected(false);
					return alert("형질은 2개까지만 선택 가능합니다.")
				}
			}
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
			field: 'displayno',
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
			    return params.data.displayno;
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
			field: 'displayno',
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
			    return params.data.displayno;
			},
			onCellClicked: (params) => {
				if(params.column.colId == "delete") {
					
					gridOptions_individualName.api.applyTransaction({
			    		add: [params.node.data]
			    	}),
			    	
			    	gridOptions_individualName.columnApi.applyColumnState({
			    	    state: [
			    	    	{ colId: 'cre_dt', sort: 'desc', sortIndex:0 },
			    	    	{ colId: 'displayno', sort: 'desc', sortIndex:1 }
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
