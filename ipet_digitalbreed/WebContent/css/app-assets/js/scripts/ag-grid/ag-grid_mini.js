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
		    //.simpleHttpRequest({ url: "../../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
			.simpleHttpRequest({ url: "../../../web/b_toolbox/mini/mini_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
		    	console.log("data : ", data);
		    	gridOptions.api.setRowData(data);
		    });
		vcfFileList();
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
		  
		for (var i = 0; i < selectedData.length; i++) {
		    deleteitems.push(selectedData[i].no);
		}
		
		console.log("delete row : ", deleteitems);
		
		$.ajax(
		{
		    url:"../../../web/b_toolbox/mini/mini_delete.jsp",
		    type:"POST",
		    data:{'params':deleteitems},
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
	      width: 130,
	      filter: 'agMultiColumnFilter',
	      cellClass: "grid-cell-centered",      
	      checkboxSelection: true,
	      headerCheckboxSelectionFilteredOnly: true,
	      headerCheckboxSelection: true
	    },
	    {
	      headerName: "VCF 파일명",
	      field: "file_name",
	      filter: true,
	      cellClass: "grid-cell-centered",      
	      width: 400,
	    },
	    {
	    	headerName: "분석상태",
	    	field: "status",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    	width: 200,
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
	    	headerName: "상세내용",
	    	field: "comment",
	    	filter: 'agNumberColumnFilter',
	    	//cellClass: "grid-cell-centered",      
	    	width: 650,
	    },
	    {
	      headerName: "분석일",
	      field: "cre_dt",
	      filter: 'agNumberColumnFilter',
	      cellClass: "grid-cell-centered", 
	      width: 296
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
			//floatingFilter: true,
		},
		// 주석처리한 옵션 작동안함. 전부 다른 이름으로 바꿔야한다.
		columnDefs: columnDefs,
		rowHeight: 35,
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
		//rowSelection: "multiple",
		//floatingFilter: true,
		//filter: 'agMultiColumnFilter',
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		animateRows: true,
		suppressHorizontalScroll: true,
		serverSideInfiniteScroll: true,
		defaultCsvExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		
		onCellClicked: params => {
			//console.log("params : ", params);
			
			if(params.column.getId() != "no"){
				
				switch (Number(params.data.status)) {
					case 0:
						//$("#analysis_process").modal('show');
						alert("분석 중입니다.");
						break;
					case 1:
						const element = document.getElementById('vcf_status');
				   		element.innerHTML  = `<div class='card-content'>
				   								<div class='card-body'>
				   									<div class='row'>
				   										<div class='col-12'>
				   											<ul class='nav nav-pills nav-active-bordered-pill'>
				   												<!--
				   												<li class='nav-item'><a class='nav-link active' id='mini_1' data-toggle='pill' href='#pill1' aria-expanded='true'>PCA1 (2D)</a></li>
				   												-->
				   											</ul>
				   											<div class='tab-content'>
				   												<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
				   													<div id='pill2_frame' class="col-12 col-xl-12 ag-theme-alpine" style='height:445px; margin-top:25px; float:left;'></div>
				   												</div>
				   											</div>
				   										</div>
				   									</div>
				   								</div>
				   							</div>`;

				   		//gridOptions2.api.destroy();
				   		printExcel(params.data);
				   		gridOptions.api.sizeColumnsToFit();
				   		
						break;
					case 2:
						//$("#analysis_fail").modal('show');
						alert("분석에 실패했습니다.");
						break;
				}
			}
		}
	};
	

	
  	const gridOptions2 = {
	  	columnDefs: [],
	  	animateRows: true
  	}
	
	function printExcel(param_data) {
		
  		const gridTable2 = document.getElementById("pill2_frame");
  		const myGrid2 = new agGrid.Grid(gridTable2, gridOptions2);
		
  		console.log(param_data);
		console.log(param_data.resultpath+param_data.jobid+"/"+param_data.jobid+"_minimal_markers.xlsx");
		
		fetch(param_data.resultpath+param_data.jobid+"/"+param_data.jobid+"_minimal_markers.xlsx")
		.then((response) => response.blob())
		.then((file) => {
			//console.log(file);
			var reader = new FileReader();
		    reader.onload = function(){
		        var fileData = reader.result;
		        var wb = XLSX.read(fileData, {type : 'binary'});
		        
		        var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
		        console.log(rowObj);
		        
		        const colDefs = [];
		        const keys = Object.keys(rowObj[0]);
		        keys.forEach(key => colDefs.push({field: key, sortable: true,resizable: true, cellClass: "grid-cell-centered",  width: 200}))
		        
		        gridOptions2.api.setColumnDefs([]);
		        gridOptions2.api.setColumnDefs(colDefs);
		        gridOptions2.api.setRowData(rowObj);
		    };
		    reader.readAsBinaryString(file);
		})
	}

	function replaceClass(id, oldClass, newClass) {
	    var elem = $(`#${id}`);
	    if (elem.hasClass(oldClass)) {
	        elem.removeClass(oldClass);
	    }
	    elem.addClass(newClass);
	}
 
	/*** DEFINED TABLE VARIABLE ***/
	var gridTable = document.getElementById("myGrid");

	/*** GET TABLE DATA FROM URL ***/

	/*
  	agGrid
		.simpleHttpRequest({ url: "../../../web/b_toolbox/mini/mini_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		.then(function(data) {
		console.log("data : ", data);
		  
		//pca 테이블이 만들어질때까지는 하드코딩 데이터
		gridOptions.api.setRowData(data);
		gridOptions.api.sizeColumnsToFit();
		
		// 모달창에 genotype vcf파일 리스트 option목록 생성
	});
	*/
  	
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
  		fetch("../../../web/b_toolbox/mini/mini_json.jsp?varietyid="+$( "#variety-select option:selected" ).val())
		.then((response) => {
			response.json().then(data => {
				console.log(data);
				gridOptions.api.setRowData(data);
				gridOptions.api.sizeColumnsToFit();
			});
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
	
	/*** INIT TABLE ***/
	//new agGrid.Grid(gridTable, gridOptions);
	
	/*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/
	
	if ($(window).width() < 768) {
	    //gridOptions.columnApi.setColumnPinned("email", null);
	} else {
	   // gridOptions.columnApi.setColumnPinned("email", "left");
	}
	
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
		
	    if ($(window).width() < 768) {
	      //gridOptions.columnApi.setColumnPinned("email", null);
	    } else {
	     // gridOptions.columnApi.setColumnPinned("email", "left");
	    }
	});
  
  
  
  
