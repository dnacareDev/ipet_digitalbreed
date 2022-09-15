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
		    .simpleHttpRequest({ url: "../../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
		      gridOptions.api.setRowData(data);
		    });
	}

	/*** COLUMN DEFINE ***/
	var columnDefs = [
		{
	      headerName: "번호",
	      field: "check_number",
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
	      field: "analysis_status",
	      editable: false,
	      sortable: true,
	      filter: true,
	      cellClass: "grid-cell-centered",      
	      width: 200,
	    },
	    {
	      headerName: "상세내용",
	      field: "note",
	      editable: false,
	      sortable: true,
	      filter: 'agNumberColumnFilter',
	      cellClass: "grid-cell-centered",      
	      width: 600
	    },
	    {
	      headerName: "분석일",
	      field: "analysis_date",
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
		
		if(params.column.getId() != "no"){
				console.log('cell was clicked', params.data.jobid);
				console.log('cell was clicked', params.data.resultpath);
				const element = document.getElementById('vcf_status');
				element.innerHTML  = `
									<div class='card-content'>
										<div class='card-body'>
											<div class='row'>
												<div class='col-12'>
													<ul class='nav nav-pills nav-active-bordered-pill'>
														<li class='nav-item'><a class='nav-link' id='Linear' data-toggle='pill' href='#pill1' aria-expanded='true'>Linear</a></li>
					   									<li class='nav-item'><a class='nav-link' id='Circular' data-toggle='pill' href='#pill2' aria-expanded='false'>Circular</a></li>
													</ul>
													<div class='tab-content'>
														<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
															<iframe src = '' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill1_frame' id='pill1_frame'></iframe>
														</div>
														<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
															<iframe src = '' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill2_frame' id='pill2_frame'></iframe>
														</div>
													</div>
												</div>
											</div>
										</div>
									</div>
									`;
		       replaceClass("base-pill31", "nav-link", "nav-link active");
		       replaceClass("base-pill32", "nav-link", "nav-link");
		       replaceClass("base-pill33", "nav-link", "nav-link");
		       replaceClass("base-pill34", "nav-link", "nav-link");
		       replaceClass("base-pill35", "nav-link", "nav-link");	  
			   
			   $('#pill1_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_vcfinfo.txt");
			   $('#pill2_frame').attr('src', "");
			   $('#pill3_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_variant.html");
			   $('#pill4_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_depth.html");
			   $('#pill5_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_miss.html");
		}
	}
};


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
    .simpleHttpRequest({ url: "../../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
    .then(function(data) {
    	console.log("data : ", data);
    	gridOptions.api.setRowData(data);
    });
  */
  agGrid
	  .simpleHttpRequest({ url: "../../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
	  .then(function(data) {
		  console.log("data : ", data);
		  //console.log(agGrid.getColumns());
		  
		  const pseudo_data = [
			  {
				  check_number : '12',
				  file_name : 'upgma_5789.vcf',
				  analysis_status : 'progress',
				  note : 'code',
				  analysis_date : '2022-08-22',
				  jobid : '20233331',
				  uploadpath : '/digit/path/upload',
				  resultpath : '/digit/path/upload'
			  },
			  {
				  check_number : '12',
				  file_name : 'upgma_34356.vcf',
				  analysis_status : 'fail',
				  note : 'code',
				  analysis_date : '2022-08-22',
				  jobid : '20233331',
				  uploadpath : '/digit/path/upload',
				  resultpath : '/digit/path/upload'
			  },
			  {
				  check_number : '12',
				  file_name : 'upgma_85659.vcf',
				  analysis_status : 'success',
				  note : 'code111',
				  analysis_date : '2022-08-22',
				  jobid : '20233331',
				  uploadpath : '/digit/path/upload',
				  resultpath : '/digit/path/upload'
			  },
		  ];
		  gridOptions.api.setRowData(pseudo_data);
		  
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
  
  
  
  
