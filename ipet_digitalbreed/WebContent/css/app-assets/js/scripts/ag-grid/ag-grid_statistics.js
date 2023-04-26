/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	class CustomTooltip {
		init(params) {
			const eGui = (this.eGui = document.createElement('div'));
			const color = params.color || 'white';
			const data = params.api.getDisplayedRowAtIndex(params.rowIndex).data;
	
			console.log(params);
			
			eGui.classList.add('custom-tooltip');
			//@ts-ignore
			eGui.style['background-color'] = color;
			eGui.style['border'] = "1px solid #AAE6E6";
			eGui.innerHTML = `
	            <p style="margin:10px;">
	                <span class"name">aaa </span>
	            </p>
	        `;
		}
		
		getGui() {
		    return this.eGui;
		}
	}


	/*** COLUMN DEFINE ***/
	var columnDefs = [
		{
			headerName: "결과보기",
			//field: "no",
			minWidth: 100,
			suppressMenu: true,
			cellClass: "grid-cell-centered",    
			cellRenderer: function(params) {
				//const linkedJobid = params.data.jobid;

				return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", "${params.data.category}")'>결과보기</span>`
				/*
				switch(params.data.category) {
					case('GWAS'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('GS'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('PCA'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('UPGMA clustering'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('Core selection'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('quality'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('subset'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('merge'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('Minimal marker'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('Ideogram'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('Annotation'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
					case('STRUCTURE'):
						return `<span style='color:#777add; cursor:pointer;' onclick='moveTo("${params.data.jobid}", ${params.data.category})'>결과보기</span>`;
				}
				*/
				
				//console.log(params);
				//return "<a href='#'>결과보기</a>";
			}
	    },
	    {
	    	headerName: "항목",
	    	field: "category",
	    	width: 200,
	    	minWidth: 120,
	    	filter: true,
	    	tooltipField: "category",
			tooltipComponent: CustomTooltip, 
	    	cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "파일명",
	    	field: "filename",
	    	width: 200,
	    	minWidth: 120,
	    	filter: 'agTextColumnFilter',
	    	cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "상세내용",
	    	field: "comment",
	    	width: 300,
	    	minWidth: 140,
	    	filter: 'agTextColumnFilter',
	    	cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "분석일",
	    	field: "cre_dt",
	    	width: 296,
	    	minWidth: 120,
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
			menuTabs: ['filterMenuTab']
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
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		//suppressHorizontalScroll: true,
		serverSideInfiniteScroll: true,
		
		defaultCsvExportParams:{
			columnKeys:["category","filename","comment","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["category","filename","comment","cre_dt"]
		},
	};
	
	document.addEventListener('DOMContentLoaded', () => {
  		
  	  	//const gridTable = document.getElementById("myGrid");
  		const myGrid = new agGrid.Grid(document.getElementById("myGrid"), gridOptions);
  		getAnalysisListGrid();
  		
  		
  		
  		/*
  		const params = new URLSearchParams({
							varietyid: $("#variety-select option:selected").val()
						})
  		fetch('./statistics_json_analysis.jsp?'+params)
  		.then(response => response.json())
  		.then(data => {
  			console.log(data);
  		})
  		*/
  		/*
  		const varietyid = $("#variety-select option:selected").val();
  		
  		let urls = [
  			'../gwas_gs/gs_json.jsp?varietyid='+varietyid,
  			'../gwas_gs/gwas_json.jsp?varietyid='+varietyid,
  			'../pd/pd_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/qf/qf_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/sf/sf_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/vfm/vfm_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/pca/pca_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/upgma/upgma_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/genocore/genocore_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/mini/mini_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/anno/anno_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/ideogram/ideogram_json.jsp?varietyid='+varietyid,
  			'../b_toolbox/structure/structure_json.jsp?varietyid='+varietyid,
  		];
  		let requests = urls.map(url => fetch(url));
  		
  		Promise.all(requests)
  		.then(responses => Promise.all(responses.map(r => r.json())))
  		.then(data => {
  			console.log(data);
  		})
  		 */
  		
  		
  		
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
  			//console.log("statistics : ", data);
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
  
