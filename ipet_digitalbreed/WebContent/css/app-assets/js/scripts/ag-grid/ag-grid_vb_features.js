/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	var VariantBrowser_columnDefs = [
		{
			field: "position",
			width: 100,
		},
		{
			field: "1",
			width: 80,
		},
		{
			field: "8",
			width: 80,
		}
	]
	var VariantBrowser_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: VariantBrowser_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>
	};

	
	var SnpEff_columnDefs = [
		{ 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true, 
			headerCheckboxSelection: true, 
			width: 50, 
		},
		{ 
			field: "selection", 
			maxWidth: 100, 
			minWidth: 100, 
			suppressMenu: true,
		},
	    { 
			field: "Chr", 
			filter: true, 
			width: 60, 
			minWidth: 60, 
		},
	    { 
			field: "Pos", 
			filter: 'agNumberColumnFilter', 
			width: 70, 
			minWidth: 70, 
		},
	    { 
			field: "Impact", 
			filter: "agTextColumnFilter",
			width: 80, 
			minWidth: 80, 
		},
	    { 
			field: "Effect Classic", 
			filter: 'agNumberColumnFilter', 
			width: 120, 
			minWidth: 120, 
		},
	    { 
			field: "GeneID", 
			filter: 'agNumberColumnFilter', 
			width: 120, 
			minWidth: 100, 
		},
	    { 
			field: "Description", 
			filter: 'agDateColumnFilter', 
			width: 150, 
			minWidth: 110, 
			cellClass: "", 
		},
	];
	var SnpEff_gridOptions = {
		defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
		columnDefs: SnpEff_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
		pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>
	};
	
	var GWAS_columnDefs = [
		{ checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, headerCheckboxSelection: true, width: 50, },
		{ field: "selection", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Chr", filter: true, width: 60, minWidth: 60, },
	    { field: "Pos", filter: 'agNumberColumnFilter', width: 70, minWidth: 70, },
	    { field: "P-value", filter: "agTextColumnFilter",width: 80, minWidth: 80, },
	    { field: "MAF", filter: 'agNumberColumnFilter', width: 120, minWidth: 120, },
	    { field: "Effect", filter: 'agNumberColumnFilter', width: 120, minWidth: 100, },
	];
	var GWAS_gridOptions = {
		defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
		columnDefs: GWAS_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
		pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
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
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: Marker_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	var Selection_columnDefs = [
		{ checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, headerCheckboxSelection: true, width: 50, },
		{ field: "selection", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Chr", filter: true, width: 60, minWidth: 60, },
	    { field: "Pos", filter: 'agNumberColumnFilter', width: 70, minWidth: 70, },
	    { field: "SnpEff", filter: "agTextColumnFilter",width: 80, minWidth: 80, },
	    { field: "GWAS", filter: 'agNumberColumnFilter', width: 120, minWidth: 120, },
	    { field: "Marker Candidate", filter: 'agNumberColumnFilter', width: 120, minWidth: 100, },
	];
	var SelectionList_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: Selection_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	var UPGMA_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Population", filter: true, width: 160, minWidth: 160, },
	    { field: "Similarity", filter: 'agNumberColumnFilter', width: 160, minWidth: 160, },
	];
	var UPGMA_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: UPGMA_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	
	var STRUCTURE_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Miss", filter: true, width: 160, minWidth: 160, },
	    { field: "Population", filter: 'agNumberColumnFilter', width: 160, minWidth: 160, },
	    { field: "K", filter: true, width: 100, minWidth: 100, },
	];
	var STRUCTURE_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: STRUCTURE_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	var Haplotype_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Haplotype", filter: true, width: 160, minWidth: 160, },
	];
	var Haplotype_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: Haplotype_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
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

	/*** GET TABLE DATA FROM URL ***/

  	
  	/*** INIT TABLE ***/
  	// setup the grid after the page has finished loading
  	document.addEventListener('DOMContentLoaded', () => {
  		/*** DEFINED TABLE VARIABLE ***/
  		
  		const VariantBrowser_gridTable = document.getElementById("VariantBrowserGrid");
  		const VariantBrowser_Grid = new agGrid.Grid(VariantBrowser_gridTable, VariantBrowser_gridOptions);
  		const VariantBrowser_rowData = [ {"position":"pos_17445", "1":"T", "8":"G"} ]
  		VariantBrowser_gridOptions.api.setRowData(VariantBrowser_rowData);
  		
  		
  		const SnpEff_gridTable = document.getElementById("SnpEff_Grid");
  		const SnpEff_Grid = new agGrid.Grid(SnpEff_gridTable, SnpEff_gridOptions);
  		const SnpEff_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Impact": "HIGH", } ];
  		SnpEff_gridOptions.api.setRowData(SnpEff_rowData)
  		
  		const GWAS_gridTable = document.getElementById("GWAS_Grid");
  		const GWAS_Grid = new agGrid.Grid(GWAS_gridTable, GWAS_gridOptions);
  		const GWAS_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "P-value": 0.305428246, "MAF": 0.140350877, "Effect": 0.88349949 } ];
  		GWAS_gridOptions.api.setRowData(GWAS_rowData)
  		
  		const Marker_gridTable = document.getElementById("Marker_Grid");
  		const Marker_Grid = new agGrid.Grid(Marker_gridTable, Marker_gridOptions);
  		const Marker_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Type": "SNP", "Indel Length": 0 } ];
  		Marker_gridOptions.api.setRowData(Marker_rowData)
  		
  		const SelectionList_gridTable = document.getElementById("SelectionList_Grid");
  		const SelectionList_Grid = new agGrid.Grid(SelectionList_gridTable, SelectionList_gridOptions);
  		const SelectionList_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "SnpEff": "O", "GWAS": "X", "Marker Candidate": "X" } ];
  		SelectionList_gridOptions.api.setRowData(SelectionList_rowData)
  		
  		
  		
  		const UPGMA_gridTable = document.getElementById("UPGMA_Grid");
  		const UPGMA_Grid = new agGrid.Grid(UPGMA_gridTable, UPGMA_gridOptions);
  		const UPGMA_rowData = [ { "ID": "sample9", "Population": "", "Similarity": "",} ];
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
		gridOptions.api.sizeColumnsToFit();
	});
  
  
  
  
