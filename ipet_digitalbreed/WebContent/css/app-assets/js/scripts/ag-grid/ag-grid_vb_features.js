/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	
	/*** COLUMN DEFINE ***/
	var SnpEff_columnDefs = [
		{ checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, headerCheckboxSelection: true, width: 50, },
		{ field: "selection", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Chr", filter: true, width: 60, minWidth: 60, },
	    { field: "Pos", filter: 'agNumberColumnFilter', width: 70, minWidth: 70, },
	    { field: "Impact", filter: "agTextColumnFilter",width: 80, minWidth: 80, },
	    { field: "Effect Classic", filter: 'agNumberColumnFilter', width: 120, minWidth: 120, },
	    { field: "GeneID", filter: 'agNumberColumnFilter', width: 120, minWidth: 100, },
	    { field: "Description", filter: 'agDateColumnFilter', width: 150, minWidth: 110, cellClass: "", },
	];

	/*** GRID OPTIONS ***/
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
	    { field: "Impact", filter: "agTextColumnFilter",width: 80, minWidth: 80, },
	    { field: "Effect Classic", filter: 'agNumberColumnFilter', width: 120, minWidth: 120, },
	    { field: "GeneID", filter: 'agNumberColumnFilter', width: 120, minWidth: 100, },
	    { field: "Description", filter: 'agDateColumnFilter', width: 150, minWidth: 110, cellClass: "", },
	];
	
	var GWAS_gridOptions = {
		defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
		columnDefs: SnpEff_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
		pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	var Marker_columnDefs = [
		{ checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, headerCheckboxSelection: true, width: 50, },
		{ field: "selection", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Chr", filter: true, width: 60, minWidth: 60, },
	    { field: "Pos", filter: 'agNumberColumnFilter', width: 70, minWidth: 70, },
	    { field: "Impact", filter: "agTextColumnFilter",width: 80, minWidth: 80, },
	    { field: "Effect Classic", filter: 'agNumberColumnFilter', width: 120, minWidth: 120, },
	    { field: "GeneID", filter: 'agNumberColumnFilter', width: 120, minWidth: 100, },
	    { field: "Description", filter: 'agDateColumnFilter', width: 150, minWidth: 110, cellClass: "", },
	];
	
	var Marker_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: SnpEff_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	var Selection_columnDefs = [
		{ checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, headerCheckboxSelection: true, width: 50, },
		{ field: "selection", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Chr", filter: true, width: 60, minWidth: 60, },
	    { field: "Pos", filter: 'agNumberColumnFilter', width: 70, minWidth: 70, },
	    { field: "Impact", filter: "agTextColumnFilter",width: 80, minWidth: 80, },
	    { field: "Effect Classic", filter: 'agNumberColumnFilter', width: 120, minWidth: 120, },
	    { field: "GeneID", filter: 'agNumberColumnFilter', width: 120, minWidth: 100, },
	    { field: "Description", filter: 'agDateColumnFilter', width: 150, minWidth: 110, cellClass: "", },
	];
	
	var SelectionList_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: SnpEff_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
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
  		const SnpEff_gridTable = document.getElementById("SnpEff_Grid");
  		const SnpEff_Grid = new agGrid.Grid(SnpEff_gridTable, SnpEff_gridOptions);
  		const SnpEff_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Impact": "HIGH", } ];
  		SnpEff_gridOptions.api.setRowData(SnpEff_rowData)
  		
  		const GWAS_gridTable = document.getElementById("GWAS_Grid");
  		const GWAS_Grid = new agGrid.Grid(GWAS_gridTable, GWAS_gridOptions);
  		const GWAS_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Impact": "HIGH", } ];
  		GWAS_gridOptions.api.setRowData(GWAS_rowData)
  		
  		const Marker_gridTable = document.getElementById("Marker_Grid");
  		const Marker_Grid = new agGrid.Grid(Marker_gridTable, Marker_gridOptions);
  		const Marker_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Impact": "HIGH", } ];
  		Marker_gridOptions.api.setRowData(Marker_rowData)
  		
  		const SelectionList_gridTable = document.getElementById("SelectionList_Grid");
  		const SelectionList_Grid = new agGrid.Grid(SelectionList_gridTable, SelectionList_gridOptions);
  		const SelectionList_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Impact": "HIGH", } ];
  		SelectionList_gridOptions.api.setRowData(SelectionList_rowData)
  		
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
  
  
  
  
