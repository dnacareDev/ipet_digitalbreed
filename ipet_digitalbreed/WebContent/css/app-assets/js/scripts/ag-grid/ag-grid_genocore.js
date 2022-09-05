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
		    .simpleHttpRequest({ url: "../../../web/database/genocore_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
		    	gridOptions.api.setRowData(data);
		    });
	}

	/*** COLUMN DEFINE ***/
	var columnDefs = [
		{
	      headerName: "번호",
	      field: "no",
	      editable: false,
	      sortable: true,
	      width: 180,
	      filter: 'agMultiColumnFilter',
	      cellClass: "grid-cell-centered",      
	      checkboxSelection: true,
	      headerCheckboxSelectionFilteredOnly: true,
	      headerCheckboxSelection: true
	    },
	    {
	      headerName: "파일명",
	      field: "file_name",
	      editable: false,
	      sortable: true,
	      filter: true,
	      cellClass: "grid-cell-centered",      
	      width: 280,
	    },
	    {
	      headerName: "분석상태",
	      field: "status",
	      editable: false,
	      sortable: true,
	      filter: true,
	      cellClass: "grid-cell-centered",      
	      width: 200,
	    },
	    {
	      headerName: "상세내용",
	      field: "comment",
	      editable: false,
	      sortable: true,
	      filter: 'agNumberColumnFilter',
	      cellClass: "grid-cell-centered",      
	      width: 600
	    },
	    {
	      headerName: "분석일",
	      field: "cre_dt",
	      editable: false,
	      sortable: true,
	      filter: 'agNumberColumnFilter',
	      cellClass: "grid-cell-centered", 
	      cellStyle: {'background-color' : '#F0F0F0'},
	      width: 300
	    },
		{
	      headerName: "jobid",
	      field: "jobid",
	      hide: true
	    },  
		{
	      headerName: "uploadpath",
	      field: "uploadpath",
	      hide: true
	    },  
		{
	      headerName: "resultpath",
	      field: "resultpath",
	      hide: true
	    }        
	];
	

    /*** GRID OPTIONS ***/
	var gridOptions = {
		// 주석처리한 옵션 전부 작동안함. 다른 이름으로 바꿔야한다.
		columnDefs: columnDefs,
		rowHeight: 35,
		//rowSelection: "multiple",
		//floatingFilter: true,
		//filter: 'agMultiColumnFilter',
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		animateRows: true,
		//resizable: true,
		serverSideInfiniteScroll: true,
	
		onCellClicked: params => {
		
			console.log("cell clicked : " + params.column.getId());
			//console.log("params : ", params);
			
			if(params.column.getId() != "filename" && params.column.getId() != "refgenome"){
				console.log('cell was clicked', params.data.jobid);
				console.log('cell was clicked', params.data.resultpath);
				const element = document.getElementById('vcf_status');
			   	element.innerHTML  = `<div class='card-content'>
			   							<div class='card-body'>
			   								<div class='row'>
			   									<div class='col-12'>
			   										<ul class='nav nav-pills nav-active-bordered-pill'>
			   											<li class='nav-item'><a class='nav-link' id='info' data-toggle='pill' href='#pill1' aria-expanded='true'>info</a></li>
						   								<li class='nav-item'><a class='nav-link' id='genocore' data-toggle='pill' href='#pill2' aria-expanded='false'>PCA2 (2D)</a></li>
			   										</ul>
			   										<div class='tab-content'>
			   											<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
			   												<iframe src = '' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill1_frame' id='pill1_frame'></iframe>
			   											</div>
			   											<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
			   												<iframe src = '' width='50%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill2_frame' id='pill2_frame' style='float:right;'></iframe>
			   												<iframe src = '' width='50%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill3_frame' id='pill3_frame' style='float:right;'></iframe>
			   											</div>
			   										</div>
			   									</div>
			   								</div>
			   							</div>
			   						</div>`;
			    /*   
			   	replaceClass("base-pill31", "nav-link", "nav-link active");
			    replaceClass("base-pill32", "nav-link", "nav-link");
			    replaceClass("base-pill33", "nav-link", "nav-link");
			    replaceClass("base-pill34", "nav-link", "nav-link");
			    replaceClass("base-pill35", "nav-link", "nav-link");
			    */	  
			    $('#pill1_frame').attr('src', params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_vcfinfo.txt");
			    
			    //파일을 다운받아버림. 다운받지말고 화면에 출력되도록
			    $('#pill2_frame').attr('src', params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_genocore.html");
			    //$('#pill3_frame').attr('src', params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_genocore_table.csv");
			    
			    const csv_url = params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_genocore_table.csv";
			    
			    csvToTable(csv_url);
			}
		}
	};
	
	function csvToTable(csv_url) {
		
		$.ajax({
	        type: "GET",
	        url: csv_url,
	        dataType: "text",
	        success: function(data) {
	        	//console.log("csv function data : ", data);
	        	
	        	
	        	
	        	let excel_table = `<table><thead><th>`;
	        }
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
  var gridTable = document.getElementById("myGrid");

  /*** GET TABLE DATA FROM URL ***/
  	agGrid
		.simpleHttpRequest({ url: "../../../web/b_toolbox/genocore/genocore_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		.then(function(data) {
		console.log("data : ", data);
		  
		
		
		//pca 테이블이 만들어질때까지는 하드코딩 데이터
		gridOptions.api.setRowData(data);
	  
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
  new agGrid.Grid(gridTable, gridOptions);

  /*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/

  if ($(window).width() < 768) {
    //gridOptions.columnApi.setColumnPinned("email", null);
  } else {
   // gridOptions.columnApi.setColumnPinned("email", "left");
  }
  $(window).on("resize", function() {
    if ($(window).width() < 768) {
      //gridOptions.columnApi.setColumnPinned("email", null);
    } else {
     // gridOptions.columnApi.setColumnPinned("email", "left");
    }
  });
  
  
  
  
