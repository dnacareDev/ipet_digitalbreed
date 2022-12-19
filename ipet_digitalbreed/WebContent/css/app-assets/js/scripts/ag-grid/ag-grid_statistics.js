/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	/*** COLUMN DEFINE ***/
	var columnDefs = [
		{
			headerName: "결과보기",
			//field: "no",
			width: 130,
			filter: 'agMultiColumnFilter',
			cellClass: "grid-cell-centered",    
			cellRenderer: function(params) {
				//console.log(params);
				return "<a href='#'>결과보기</a>";
			}
	    },
	    {
	    	headerName: "항목",
	    	field: "category",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    	width: 200,
	    },
	    {
	    	headerName: "파일명",
	    	field: "filename",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    	width: 200,
	    },
	    {
	    	headerName: "상세내용",
	    	field: "comment",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    	width: 300,
	    },
	    {
	      headerName: "분석일",
	      field: "cre_dt",
	      filter: 'agNumberColumnFilter',
	      width: 296,
	      cellClass: "grid-cell-centered", 
	    },
		{
	      headerName: "jobid",
	      field: "jobid",
	      hide: true
	    },  
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
			//floatingFilter: true,
		},
		columnDefs: columnDefs,
		rowHeight: 35,
		rowSelection: "multiple",
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
		pagination: true,
		paginationPageSize: 6,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		animateRows: true,
		suppressHorizontalScroll: true,
		serverSideInfiniteScroll: true,
		
		defaultCsvExportParams:{
			columnKeys:["category","filename","comment","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["category","filename","comment","cre_dt"]
		},
		
		onCellClicked: params => {
			console.log("params : ", params);
			
			if(params.colDef.headerName != "결과보기"){
				console.log("move to");
			}
		}
	};
	
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
  		
  		getAnalysisListGrid();
	})	
	
	function getAnalysisListGrid() {
		const varietyid = $("#variety-select option:selected").val();
  		const year = $("#analysisListYear option:selected").val();
  		const month = $("#analysisListMonth option:selected").val();
  		
  		//console.log(year);
  		//console.log(month);
  		
  		/*** GET TABLE DATA FROM URL ***/
  		fetch(`/ipet_digitalbreed/web/statistics/statistics_json.jsp?varietyid=${varietyid}&year=${year}&month=${month}`)
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		})
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
	
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
	});
  
