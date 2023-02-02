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
		
		fetch("./vb_json.jsp?varietyid="+$( "#variety-select option:selected" ).val())
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		});
	}
	
	/*** COLUMN DEFINE ***/
	var columnDefs = [
		{
	      headerName: "순번",
	      valueGetter: inverseRowCount,
	      maxWidth: 100,
	      minWidth: 70,
	      suppressMenu: true,
	      cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "VCF 파일명",
	    	field: "filename",
	    	filter: true,
	    	width: 700,
	    	minWidth: 150,
	    	cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "상세내용",
	    	field: "comment",
	    	filter: 'agNumberColumnFilter',
	    	width: 350,
	    	minWidth: 110,
	    },
	    {
	    	headerName: "참조유전체",
	    	field: "refgenome",
	    	filter: "agTextColumnFilter",
	    	width: 275,
	    	minWidth: 120,
	    	cellClass: "grid-cell-centered",
	    },
	    {
	    	headerName: "샘플수",
	    	field: "samplecnt",
	    	valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
	    	filter: 'agNumberColumnFilter',
	    	width: 120,
	    	minWidth: 100,
	    	cellClass: "grid-cell-centered",
	    },
	    {
	    	headerName: "변이수",
	    	field: "variablecnt",
	    	valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
	    	filter: 'agNumberColumnFilter',
	    	width: 120,
	    	minWidth: 100,
	    	cellClass: "grid-cell-centered",
	    },
	    {
	        headerName: "등록일자",
	        field: "cre_dt",
	        filter: 'agDateColumnFilter',
	        filterParams: {comparator: comparator},
	        width: 150,
	        minWidth: 110,
	        cellClass: "grid-cell-centered",
	    },
		{
	      field: "jobid",
	      hide: true
	    },  
	];
	
	function inverseRowCount(params) {
		return params.api.getDisplayedRowCount() - params.node.rowIndex;
	}
	
	function comparator(filterLocalDateAtMidnight, cellValue) {
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

	/*** GRID OPTIONS ***/
	var gridOptions = {
		defaultColDef: {
			editable: false, 
		    sortable: true,
			resizable: true,
			menuTabs: ['filterMenuTab'],
		},
		columnDefs: columnDefs,
		rowHeight: 35,
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		animateRows: true,
		defaultCsvExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		
		onCellClicked: params => {
			//console.log("params : ", params);
			
			const jobid = params.data.jobid;
			const refgenome_id = params.data.refgenome_id;

			// 클릭할때마다 target값을 바꿔서 항상 새창이 열리게 한다  
			const random_number = Math.random().toString(36).substring(2,12);
			
			window.open("", random_number);
			
			let form = document.createElement('form'); // 폼객체 생성
			let objs;
			objs = document.createElement('input'); // 값이 들어있는 녀석의 형식
			objs.setAttribute('type', 'hidden'); // 값이 들어있는 녀석의 type
			objs.setAttribute('name', 'jobid'); // 객체이름
			objs.setAttribute('value', jobid); //객체값
			form.appendChild(objs);
			
			let objs2;
			objs2 = document.createElement('input'); // 값이 들어있는 녀석의 형식
			objs2.setAttribute('type', 'hidden'); // 값이 들어있는 녀석의 type
			objs2.setAttribute('name', 'refgenome_id'); // 객체이름
			objs2.setAttribute('value', refgenome_id); //객체값
			form.appendChild(objs2);
			
			form.setAttribute('method', 'post'); //get,post 가능
			form.setAttribute('action', "./vb_features.jsp"); //보내는 url
			form.target = random_number;
			document.body.appendChild(form);
			form.submit();
		}
	};
	
	
 
	/*** DEFINED TABLE VARIABLE ***/
	var gridTable = document.getElementById("myGrid");

	/*** GET TABLE DATA FROM URL ***/

  	
  	/*** INIT TABLE ***/
  	// setup the grid after the page has finished loading
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
  		/*
  		/*** GET TABLE DATA FROM URL ***/
  		fetch("./vb_json.jsp?varietyid="+$( "#variety-select option:selected" ).val())
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		});
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
  
  
  
  
