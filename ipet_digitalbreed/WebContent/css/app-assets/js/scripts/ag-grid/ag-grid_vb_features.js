/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	class CustomHeader {
		// 미완성. header영역 작업은 일단 막아놓음
	    init(agParams) {
	    	this.agParams = agParams;
	    	this.eGui = document.createElement('div');
	    	this.eGui.style.display = "flex";
	    	this.eGui.style.justifyContent = "center";
	    	this.eGui.innerHTML = `
	    		<div class="customHeaderLabel" onclick="A_T_G_C_sort('${this.agParams.displayName.reapl}');">${this.agParams.displayName}</div>
	    		`;
	
	    }
	
	    getGui() {
	    	return this.eGui;
	    }
	
	}

	class CustomTooltip {
		init(params) {
			const eGui = (this.eGui = document.createElement('div'));
			const color = params.color || 'white';
			const data = params.api.getDisplayedRowAtIndex(params.rowIndex).data;
	
			eGui.classList.add('custom-tooltip');
			//@ts-ignore
			eGui.style['background-color'] = color;
			eGui.style['border'] = "1px solid #AAE6E6";
			eGui.innerHTML = `
	            <p style="margin:10px;">
	                <span class"name">${tooltipRenderder(params)} </span>
	            </p>
	        `;
		}
		
		getGui() {
		    return this.eGui;
		}
	}
	
	function inverseRowCount(params) {
		return params.api.getDisplayedRowCount() - params.node.rowIndex;
	}

	var VariantBrowser_columnDefs = [];
	var VariantBrowser_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: false, 
				suppressMenu: true, 
				suppressMovable: true,
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: VariantBrowser_columnDefs, 
			rowHeight: 35, 
			headerHeight: 100,
			/*
			components: {
			    agColumnHeader: CustomHeader,
			},
			*/
			enableRangeSelection: false, 
			suppressMultiRangeSelection: true,
			animateRows: true, 
			tooltipShowDelay: 0,
		    tooltipHideDelay: 20000,
		    postSortRows: (params) => {
		    	const rowNodes = params.nodes;

		    	//base_order
		    	
		    	//base_order
		    	for (let i=0 ; i<rowNodes.length; i++) {
		    		//if(rowNodes.)
		    	}
		    	
		    	//[A,T,G,C] => [T,G,C,A] 형태로 정렬버튼을 누를때마다 순환
		    	
		    	if(base_switch) {
		    		const spliced = base_order.shift();
		    		base_order.push(spliced);
		    	}
		    	
		        // 첫번째 Row인 id=reference는 고정
		        for (let i=0, nextInsertPos=0 ; i<rowNodes.length; i++) {
		        	if(rowNodes[i].rowIndex == 0) {
		        		//console.log("post sort??");
		        		rowNodes.splice(nextInsertPos, 0, rowNodes.splice(i, 1)[0]);
		        		nextInsertPos++;
		        	}
		        }
		        //console.log(rowNodes);
		    },
			//onCellClicked: (params) =>
	};

	
	var SnpEff_columnDefs = [
		{
			headerName: "row_id(select link)",
			field: "row_id",
			//valueGetter: (params) => params.data.chr + "_" + params.data.pos,
			hide: true,
	    },
		{ 
			headerName: "",
			field: "selection", 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true, 
			headerCheckboxSelection: true, 
			width: 200, 
			//minWidth: 150, 
			//editable: true, 
			suppressMenu: true,
			pinned: 'left',
			cellRenderer: (params) => {
				if(params.value) {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#b672f5" stroke="#b672f5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`
				} else {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#bcbcbc" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`;
				}
			},
		},
	    { 
			headerName: "Chr",
			field: "chr", 
			filter: true, 
			width: 60, 
			//minWidth: 60, 
		},
	    { 
			headerName: "Pos",
			field: "pos",
			filter: 'agNumberColumnFilter', 
			valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
			width: 70, 
			//minWidth: 70, 
			cellClass: "",
			cellStyle: { color: 'blue' }
		},
	    { 
			headerName: "Impact",
			field: "impact",
			//filter: "agTextColumnFilter",
			filter: 'agSetColumnFilter',
			width: 80, 
			//minWidth: 80, 
		},
	    { 
			headerName: "Effect Classic",
			field: "effect_classic",
			filter: 'agNumberColumnFilter', 
			width: 120, 
			//minWidth: 120, 
		},
	    { 
			headerName: "GeneID",
			field: "gene_id",
			filter: 'agNumberColumnFilter', 
			width: 120, 
			//minWidth: 100, 
		},
	    { 
			headerName: "Description",
			field: "description",
			filter: 'agDateColumnFilter', 
			width: 150, 
			//minWidth: 110, 
		},
	];
	var SnpEff_gridOptions = {
		defaultColDef: { 
			editable: false, 
			sortable: true, 
			resizable: true, 
			suppressMenu: true, 
			suppressMovable: true,
			cellClass: "grid-cell-centered", 
			menuTabs: ['filterMenuTab'], 
		},
		columnDefs: SnpEff_columnDefs, 
		rowHeight: 35, 
		rowSelection: 'multiple',
		rowMultiSelectWithClick: true,
		pivotPanelShow: "always", 
		colResizeDefault: "shift", 
		animateRows: true, 
		//getRowId: (params) => params.data.row_id,
		//getRowId: (params) => params.data.row_id,
		onCellClicked: (params) => {
			//console.log(params);
			
			function nodeSelected(isSelected) {
				return !isSelected;
			}
			
			if (params.column.colId === 'selection' ) {
				const flag = nodeSelected(params.node.selected);
				params.node.setSelected(flag);
				
				// 즐겨찾기 on/off
				const rowNode = SnpEff_gridOptions.api.getRowNode(params.node.id);
				const selection_flag = params.data.selection;
				rowNode.setDataValue('selection', !selection_flag);
				
				// selection 탭에 추가
				const selection_node = SelectionList_gridOptions.api.getRowNode(params.node.data.pos);
				//const selection_row_id = params.node.data.chr + "_" + params.node.data.pos;
				//const selection_node = SelectionList_gridOptions.api.getRowNode(selection_row_id);
				if(!selection_node) {
					SelectionList_gridOptions.api.applyTransaction({add: [{'row_id':selection_node, 'chr':params.node.data.chr, 'pos':params.node.data.pos, 'snpEff':true, 'gwas':false, 'markerCandidate':false}]})
				} else {
					selection_node.setDataValue('snpEff', !selection_flag);
					if(!selection_node.data.snpEff && !selection_node.data.gwas && !selection_node.data.markerCandidate) {
						SelectionList_gridOptions.api.applyTransaction({remove: [selection_node.data]});
						//SelectionList_gridOptions.api.applyTransaction({remove: [{'row_id':selection_row_id}]});
					}
				}
				
	        }
			
			if(params.column.colId === 'pos') {
				const flag = nodeSelected(params.node.selected);
				params.node.setSelected(flag);
				
				const chr_select = document.getElementById('Chr_select')
				const length = chr_select[chr_select.selectedIndex].dataset.length;
				
				const position = params.data.pos;
				
				document.querySelector(`.chromosomeStackDiv[data-order="${parseInt(position * 2000 / length)}"]`).dispatchEvent(new Event('click'));;
			}
		},
		/*
		onSelectionChanged: (params) => {
			const selectedRows = SnpEff_gridOptions.api.getSelectedNodes();
		}
		*/
	};
	
	var GWAS_columnDefs = [
		{
			headerName: "row_id(select link)",
			field: "row_id",
			//valueGetter: (params) => params.data.chr + "_" + params.data.pos,
			hide: true,
	    },
		{ 
			headerName: "",
			field: "selection", 
			width: 120, 
			//minWidth: 100, 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true, 
			headerCheckboxSelection: true, 
			suppressMenu: true, 
			pinned: 'left',
			cellRenderer: (params) => {
				if(params.value) {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#b672f5" stroke="#b672f5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`
				} else {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#bcbcbc" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`;
				}
			},
		},
	    { 
			field: "Chr", 
			filter: true, 
			width: 240, 
			//minWidth: 160, 
		},
	    { 
			field: "Pos",
			filter: 'agNumberColumnFilter', 
			valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
			cellClass: "",
			width: 160, 
			//minWidth: 100,
			cellStyle: { color: 'blue' }
		},
	    { 
			field: "P-value", 
			filter: "agTextColumnFilter",
			valueFormatter: (params) => Number(params.value).toFixed(5),
			cellClass: "",
			width: 360, 
			//minWidth: 180, 
		},
	    { 
			field: "MAF", 
			filter: 'agNumberColumnFilter', 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			cellClass: "",
			width: 360, 
			//minWidth: 180, 
		},
	    { 
			field: "Effect", 
			filter: 'agNumberColumnFilter', 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			cellClass: "",
			width: 360, 
			//minWidth: 200, 
		},
	];
	var GWAS_gridOptions = {
		defaultColDef: { 
			editable: false, 
			sortable: true, 
			resizable: true, 
			suppressMenu: true,
			suppressMovable: true,
			cellClass: "grid-cell-centered", 
			menuTabs: ['filterMenuTab'], 
		},
		columnDefs: GWAS_columnDefs, 
		rowHeight: 35, 
		rowSelection: 'multiple',
		rowMultiSelectWithClick: true,
		pivotPanelShow: "always", 
		colResizeDefault: "shift", 
		animateRows: true, 
		onCellClicked: (params) => {
			//console.log(params);
			
			function nodeSelected(isSelected) {
				return !isSelected;
			}
			
			if (params.column.colId === 'selection' ) {
				const flag = nodeSelected(params.node.selected);
				params.node.setSelected(flag);
				
				
				const model_name = document.querySelector(`#GWAS_button_list .active`).dataset.model;
				console.log(model_name);
				
				const GWAS_gridOptions = GWAS_gridOptions_model[model_name];
				
				/*
				const rowIndex = params.node.rowIndex;
				if(!params.value) {
					GWAS_gridOptions.api.getRowNode(rowIndex).data.selection = true;
				} else {
					GWAS_gridOptions.api.getRowNode(rowIndex).data.selection = false;
				}
				
				GWAS_gridOptions.api.refreshCells(params);
				*/
				
				// 즐겨찾기 on/off
				const rowNode = GWAS_gridOptions.api.getRowNode(params.node.id);
				const selection_flag = params.data.selection;
				rowNode.setDataValue('selection', !selection_flag);
				
				// selection 탭에 추가
				const selection_node = SelectionList_gridOptions.api.getRowNode(params.node.data.pos);
				//const selection_row_id = params.node.data.chr + "_" + params.node.data.pos;
				//const selection_node = SelectionList_gridOptions.api.getRowNode(selection_row_id);
				if(!selection_node) {
					SelectionList_gridOptions.api.applyTransaction({add: [{'row_id':selection_node, 'chr':params.node.data.chr, 'pos':params.node.data.pos, 'snpEff':false, 'gwas':true, 'markerCandidate':false}]})
				} else {
					selection_node.setDataValue('gwas', !selection_flag);
					if(!selection_node.data.snpEff && !selection_node.data.gwas && !selection_node.data.markerCandidate) {
						SelectionList_gridOptions.api.applyTransaction({remove: [selection_node.data]});
						//SelectionList_gridOptions.api.applyTransaction({remove: [{'row_id':selection_row_id}]});
					}
				}
	        }
			
			if(params.column.colId === 'Pos') {
				const flag = nodeSelected(params.node.selected);
				params.node.setSelected(flag);
				
				const chr_select = document.getElementById('Chr_select')
				const length = chr_select[chr_select.selectedIndex].dataset.length;
				
				const position = params.data['Pos'];
				
				document.querySelector(`.chromosomeStackDiv[data-order="${parseInt(position * 2000 / length)}"]`).dispatchEvent(new Event('click'));;
			}
		},
	}
	
	var Marker_columnDefs = [
		{ checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, headerCheckboxSelection: true, width: 50, },
		{ field: "selection", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Chr", filter: true, width: 60, minWidth: 60, },
	    { field: "Pos", filter: 'agNumberColumnFilter', width: 70, minWidth: 70, },
	    { field: "Type", filter: "agTextColumnFilter",width: 80, minWidth: 80, },
	    { field: "Indel Length", filter: 'agNumberColumnFilter', width: 120, minWidth: 120, },
	];
	var Marker_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: Marker_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift",
			animateRows: true, 
			//onCellClicked: (params) =>	
	}
	
	var Selection_columnDefs = [
		{
			headerName: "row_id(select link)",
			field: "row_id",
			//valueGetter: (params) => params.data.chr + "_" + params.data.pos,
			hide: true,
	    },
		{ 
			headerName: "",
			field: "selection", 
			width: 100,
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true, 
			headerCheckboxSelection: true, 
			suppressMenu: true,
			/*
			cellRenderer: (params) => {
				if(params.value) {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#b672f5" stroke="#b672f5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`
				} else {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#bcbcbc" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`;
				}
			},
			*/
		},
	    { 
			headerName: "Chr", 
			field: "chr", 
			filter: true, 
			width: 60, 
			minWidth: 60, 
		},
	    { 
			headerName: "Pos", 
			field: "pos", 
			filter: 'agNumberColumnFilter', 
			width: 70, 
			minWidth: 70, 
		},
	    { 
			headerName: "SnpEff", 
			field: "snpEff", 
			filter: "agTextColumnFilter",
			width: 80, 
			minWidth: 80, 
		},
	    { 
			headerName: "GWAS", 
			field: "gwas", 
			filter: 'agNumberColumnFilter', 
			width: 120, 
			minWidth: 120, 
		},
	    { 
			headerName: "Marker Candidate", 
			field: "markerCandidate", 
			filter: 'agNumberColumnFilter', 
			width: 120, 
			minWidth: 100, 
		},
	];
	var SelectionList_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], },
			columnDefs: Selection_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift", 
			animateRows: true,  
			getRowId: (params) => params.data.pos,
			//getRowId: (params) => params.data.row_id,
			/*
			onCellClicked: (params) =>	{
				console.log(params);
			},
			*/
	}
	
	var UPGMA_columnDefs = [
		/*
		{ 
			headerName: "순번",
			valueGetter: inverseRowCount, 
			width: 80, 
		},
		*/
		{ 
			headerName: "ID", 
			field: "id", 
			maxWidth: 100, 
			minWidth: 100, 
			suppressMenu: true, 
		},
	    { field: "population", 
			filter: true, 
			width: 160, 
			minWidth: 160, 
		},
	    { 
			field: "similarity", 
			filter: 'agNumberColumnFilter', 
			width: 160, 
			minWidth: 160, 
			valueFormatter: (params) => Number(params.value).toFixed(2),
		},
	];
	var UPGMA_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: UPGMA_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift", 
			animateRows: true, 
			//onCellClicked: (params) =>
			
	}
	
	
	var STRUCTURE_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Miss", filter: true, width: 160, minWidth: 160, },
	    { field: "Population", filter: 'agNumberColumnFilter', width: 160, minWidth: 160, },
	    { field: "K", filter: true, width: 100, minWidth: 100, },
	];
	var STRUCTURE_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: STRUCTURE_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift", 
			animateRows: true, 
			//onCellClicked: (params) =>	
	}
	
	var Haplotype_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Haplotype", filter: true, width: 160, minWidth: 160, },
	];
	var Haplotype_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: Haplotype_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift", 
			animateRows: true, 
			//onCellClicked: (params) =>	
	}
	
	
	function inverseRowCount(params) {
		return params.api.getDisplayedRowCount() - params.node.rowIndex;
	}
	
	function filter_SnpEff() {
		/*
		const SnpEff_gridTable = document.getElementById("SnpEff_Grid");
		
		if(!SnpEff_gridTable.innerHTML) {
			const SnpEff_Grid = new agGrid.Grid(SnpEff_gridTable, SnpEff_gridOptions);
			SnpEff_gridOptions.api.setRowData(rowData);
			SnpEff_gridOptions.api.sizeColumnsToFit();
		}
		
  		//gridOptions.api.setRowData(rowData)
  		*/
	}
	
	
	
	
	
	
	
 
	/*** DEFINED TABLE VARIABLE ***/
	var gridTable = document.getElementById("myGrid");


  	
  	/*** INIT TABLE ***/
  	// setup the grid after the page has finished loading
  	document.addEventListener('DOMContentLoaded', () => {
  		/*** DEFINED TABLE VARIABLE ***/
  		
  		
  		
  		
  		const SnpEff_gridTable = document.getElementById("SnpEff_Grid");
  		const SnpEff_Grid = new agGrid.Grid(SnpEff_gridTable, SnpEff_gridOptions);
  		//const SnpEff_rowData = [];
  		//SnpEff_gridOptions.api.setRowData(SnpEff_rowData)
  		
  		
  		const Marker_gridTable = document.getElementById("Marker_Grid");
  		const Marker_Grid = new agGrid.Grid(Marker_gridTable, Marker_gridOptions);
  		const Marker_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Type": "SNP", "Indel Length": 0 } ];
  		Marker_gridOptions.api.setRowData(Marker_rowData)
  		
  		const SelectionList_gridTable = document.getElementById("SelectionList_Grid");
  		const SelectionList_Grid = new agGrid.Grid(SelectionList_gridTable, SelectionList_gridOptions);
  		//const SelectionList_rowData = [ { "selection": true, "Chr": 1, "Pos": 40326, "SnpEff": "O", "GWAS": "X", "Marker Candidate": "X" } ];
  		const SelectionList_rowData = [];
  		SelectionList_gridOptions.api.setRowData(SelectionList_rowData)
  		SelectionList_gridOptions.columnApi.autoSizeAllColumns(false);
  		
  		
  		const UPGMA_gridTable = document.getElementById("UPGMA_Grid");
  		const UPGMA_Grid = new agGrid.Grid(UPGMA_gridTable, UPGMA_gridOptions);
  		//const UPGMA_rowData = [ { "ID": "sample9", "Population": "", "Similarity": "",} ];
  		const UPGMA_rowData = [];
  		UPGMA_gridOptions.api.setRowData(UPGMA_rowData)
  		
  		const STRUCTURE_gridTable = document.getElementById("STRUCTURE_Grid");
  		const STRUCTURE_Grid = new agGrid.Grid(STRUCTURE_gridTable, STRUCTURE_gridOptions);
  		const STRUCTURE_rowData = [ { "ID": "sample9", "Miss(%)": "", "Population": "", "K": "Cluster1",} ];
  		STRUCTURE_gridOptions.api.setRowData(STRUCTURE_rowData)
  		
  		const Haplotype_gridTable = document.getElementById("Haplotype_Grid");
  		const Haplotype_Grid = new agGrid.Grid(Haplotype_gridTable, Haplotype_gridOptions);
  		const Haplotype_rowData = [ { "ID": "sample1", "Haplotype": "Hap1",} ];
  		Haplotype_gridOptions.api.setRowData(Haplotype_rowData)
  		
  		/*** GET TABLE DATA FROM URL ***/
  		/*
  		fetch("./vb_json.jsp?varietyid="+$( "#variety-select option:selected" ).val())
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		});
  		*/
  	});
  	
  	
  	
  	

	
	function tooltipRenderder(params) {
		
		const map = new Map([
			["A", "A"], ["C", "C"], ["G", "G"],["T", "T"], ["I", "I"], 
			["R", "A or G"], ["Y", "C or T"], ["M", "A or C"], ["K", "G or T"],
			["S", "C or G"], ["W", "A or T"], ["H", "A or C or T"], ["B", "C or G or T"], 
			["V", "A or C or G"], ["V", "A or C or G"], ["D", "A or G or T"], ["N", "A or C or G or T"]
		]);
		
		if(map.has(params.value)) {
			return map.get(params.value);
		} else {
			return params.value;
		}
	}
	
	function cellStyle(params) {
		const map = new Map([
			["A", {backgroundColor : '#F69A6D'}], ["C", {backgroundColor : '#8BC2C5'}], ["G", {backgroundColor : '#D3BE58'}],
			["T", {backgroundColor : '#A1D191'}], ["I", {backgroundColor : '#E7E7E7'}], ["R", {backgroundColor : '#E7E7E7'}],
			["Y", {backgroundColor : '#E7E7E7'}], ["M", {backgroundColor : '#E7E7E7'}], ["K", {backgroundColor : '#E7E7E7'}],
			["S", {backgroundColor : '#E7E7E7'}], ["W", {backgroundColor : '#E7E7E7'}], ["H", {backgroundColor : '#E7E7E7'}],
			["B", {backgroundColor : '#E7E7E7'}], ["V", {backgroundColor : '#E7E7E7'}], ["D", {backgroundColor : '#E7E7E7'}],
			["N", {backgroundColor : '#E7E7E7'}]
		]);
		
		if(map.has(params.value)) {
			return map.get(params.value);
		} else {
			return null;
		}
	}
  	
  	
  	
  	

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
	
	/*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/
	$(window).on("resize", function() {
		//gridOptions.api.sizeColumnsToFit();
	});
  
	
	
  
  
