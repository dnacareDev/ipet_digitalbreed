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
		agGrid
			.simpleHttpRequest({ url: "./pd_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
		    	//console.log("data : ", data);
		    	gridOptions.api.setRowData(data);
		    });
		vcfFileList();
		referenceGenomeList()
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
		
		//console.log("delete row : ", deleteitems);
		
		$.ajax(
		{
		    url:"./pd_delete.jsp",
		    type:"POST",
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
			valueGetter: inverseRowCount,
			maxWidth: 100,
			minWidth: 100,
			suppressMenu: true,
			checkboxSelection: true,
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true
	    },
	    {
		    headerName: "분석상태",
		    field: "status",
		    maxWidth: 90,
		    minWidth: 90,	
		    suppressMenu: true,
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
			width: 600,
			minWidth: 120,
	    },
	    {
			headerName: "상세내용",
			field: "comment",
			filter: true,
			width: 350,
			minWidth: 120,
	    },
	    {
			headerName: "마커 유형",
			field: "marker_category",
			filter: true,
			width: 300,
			minWidth: 100,
	    },
	    {
	    	headerName: "분석일",
	    	field: "cre_dt",
	    	filter: 'agDateColumnFilter',
	    	filterParams: {
	        	comparator: comparator
	        },
	    	width: 200,
	    	minWidth: 100,
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
			cellClass: "grid-cell-centered",
		},
		columnDefs: columnDefs,
		rowHeight: 35,
		rowSelection: "multiple",
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
		pagination: true,
		paginationPageSize: 20,
		colResizeDefault: "shift",
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		//suppressHorizontalScroll: true,
		onCellClicked: params => {
		
			//console.log("cell clicked : " + params.column.getId());
			//console.log("params : ", params);
			
			if(params.column.getId() != "no" && params.column.getId() != "cre_dt"){

				switch (Number(params.data.status)) {
					case 0:
						alert("분석 중입니다.");
						break;
					case 1:
						//console.log('jobid : ', params.data.jobid);
						//console.log('resultpath : ', params.data.resultpath);
						//console.log("model : ", params.data.model)
						
						break;
					case 2:
						alert("분석에 실패했습니다.");
						break;
				}

			} 
		}
	};

	
	const enzyme_columnDefs = [
		{
			field:'n'
		},
		{
			field:'enzyme'
		},
		{
			field:'size'
		},
		{
			field:'price'
		},
		{
			field:'price_for_1000u'
		},
		{
			field:'recognition_sequence'
		},
		{
			field:'seq'
		},
	];

	var enzyme_gridOptions = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
				resizable: true,
				//menuTabs: ['filterMenuTab'],
				suppressMenu: true,
				cellClass: "grid-cell-centered",
			},
			columnDefs: enzyme_columnDefs,
			rowHeight: 35,
			rowSelection: "multiple",
			enableRangeSelection: true,
			suppressMultiRangeSelection: true,
			suppressDragLeaveHidesColumns: true,
			//pagination: true,
			//paginationPageSize: 20,
			colResizeDefault: "shift",
			animateRows: true,
	}
	
	
	

	function showPlot(value) {
		
		const model_name = $('#model_name').val();
		const resultpath = $('#resultpath').val();
		const jobid_param = $('#jobid_param').val();
		
		//console.log(`iframe#${model_name}`);
		//console.log(resultpath+jobid_param+"/"+`${model_name}_${value}.html`);

		
		
		$("#iframeLoading").modal('show');
		$(`iframe#${model_name}`).attr('src', resultpath+jobid_param+"/"+`${model_name}_${value}.html`);
		
	}

	var columnDefs2 = [
		{
			field: "SNP", 
			width: 180, 
			hide: true, 
		},
		{
			field: "Chr", 
			width: 180, 
		},
		{
			field: "Pos", 
			valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
			width: 120, 
		},
		{
			field: "P-value", 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			width: 120, 
			sortable: true, 
			
		},
		{
			field: "MAF", 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			width: 120, 
		},
		{
			field: "Effect", 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			width: 120, 
		}
	]
	
	var gridOptions2 = {
			defaultColDef: { 
				editable: false, 
				sortable: false, 
				resizable: true,
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: columnDefs2,
			colResizeDefault: "shift",
			suppressDragLeaveHidesColumns: true,
			rowHeight: 35,
			rowSelection: "single",
			animateRows: true,
			//suppressHorizontalScroll: true,
	}
	
	var columnDefsTraitName = [
		{ 	
			headerName:'특성', 
			field: "traitname",
			menuTabs: ["filterMenuTab"], 
			width: 420, 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			cellClass: "grid-cell-centered", 
		},
		{
			field: "traitname_key",
			hide:true
		}
	];
	var gridOptionsTraitName = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
			    filter: true,
			},
			columnDefs: columnDefsTraitName,
			rowHeight: 35,
			rowSelection: "multiple",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			animateRows: true,
			suppressHorizontalScroll: true,
	}
	
	//var modelGrid = [];
	function showGrid(value) {
		
		const model_name = $('#model_name').val();
		const resultpath = $('#resultpath').val();
		const jobid_param = $('#jobid_param').val();
		
		//const csv_to_grid = $(`#grid_${model_name}`);
		const csv_to_grid = document.getElementById(`grid_${model_name}`);
		
		try {
			//console.log(csv_to_grid.innerText.trim());
			if(csv_to_grid.innerText.trim()) {
				gridOptions2.api.destroy();
			}
		} catch (error) {
			console.error(error);
		}
		
		
		
		//console.log(`#grid_${model_name}`);
		//console.log("path : ", resultpath+jobid_param+"/GAPIT.Association.GWAS_Results." +model_name+ "." +value+ ".csv");
		
		fetch(resultpath+jobid_param+"/GAPIT.Association.GWAS_Results." +model_name+ "." +value+ ".csv")
		.then((response) => response.blob())
		.then((file) => {
			var reader = new FileReader();
		    reader.onload = function(){
		        var fileData = reader.result;
		        var wb = XLSX.read(fileData, {type : 'binary'});
		        
		        var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
		        //console.log("rowObj : ", rowObj);
		        //console.log(csv_to_grid);
		        const myGrid = new agGrid.Grid(csv_to_grid, gridOptions2);
		        gridOptions2.api.setRowData(rowObj);
		        //gridOptions2.api.sizeColumnsToFit();
		        //console.log(document.querySelector(`#grid_${model_name}`));
		        
		        gridOptions2.columnApi.autoSizeAllColumns();
		        
		    };
		    reader.readAsBinaryString(file);
		});
	}

	function replaceClass(id, oldClass, newClass) {
	    var elem = $(`#${id}`);
	    if (elem.hasClass(oldClass)) {
	        elem.removeClass(oldClass);
	    }
	    elem.addClass(newClass);
	}
 
	/*** DEFINED TABLE VARIABLE ***/
	//var gridTable = document.getElementById("myGrid");

  	function getParams() {
  		return; 
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
	
  	/*** INIT TABLE ***/
	 // setup the grid after the page has finished loading
  	document.addEventListener('DOMContentLoaded', () => {

  		/*** DEFINED TABLE VARIABLE ***/
  		const gridTable = document.getElementById("myGrid");
  		const myGrid = new agGrid.Grid(gridTable, gridOptions);
  		
  		/*** GET TABLE DATA FROM URL ***/
  		fetch("./pd_json.jsp?varietyid="+$( "#variety-select option:selected" ).val() )
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		})
  		
  		
  		//const varietyid = $( "#variety-select option:selected" ).val();

  		/*** DEFINED TABLE VARIABLE ***/
  		//const gridTraitNameTable = document.getElementById("phenotypeSelectGrid");
  		//const TraitNameGrid = new agGrid.Grid(gridTraitNameTable, gridOptionsTraitName);
  		
  		
  		const EnzymeGrid = new agGrid.Grid(document.getElementById('RestrictionEnzymeGrid'), enzyme_gridOptions);
  		enzyme_gridOptions.api.setRowData();
  	});

	/*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/
	
  	document.addEventListener('click', function(event) {
  		if(event.composedPath()[0].classList.contains("nav-link")) {
  			$("html").animate({ scrollTop: $(document).height() }, 1000);
  		}
  	});
	
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
		gridOptionsTraitName.api.sizeColumnsToFit();
	});
  
	//console.log(gridOptions);
	
