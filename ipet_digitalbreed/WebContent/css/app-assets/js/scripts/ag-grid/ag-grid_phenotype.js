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
    .simpleHttpRequest({ url: "../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
    .then(function(data) {
      gridOptions.api.setRowData(data);
    });
	}

	function getSelectedRowData() {
	  let selectedData = gridOptions.api.getSelectedRows();
	  var deleteitems = new Array();
	  
	  for (var i = 0; i < selectedData.length; i++) {
		    deleteitems.push(selectedData[i].selectfiles);
	  }    
	  
	  //location.href="../../web/database/genotype_delete.jsp?deleteitems="+deleteitems;
	  
	  $.ajax({
		    url:"../../web/database/genotype_delete.jsp",
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
  
 

  /*** GRID OPTIONS ***/
  var gridOptions = {
    columnDefs: columnDefs,
    rowHeight: 35,
    rowSelection: "multiple",
    floatingFilter: true,
    filter: 'agMultiColumnFilter',
    pagination: true,
    paginationPageSize: 20,
    pivotPanelShow: "always",
    colResizeDefault: "shift",
    animateRows: true,
    resizable: true,
    serverSideInfiniteScroll: true,
	onCellClicked: params => {
	
	console.log("cell clicked : " + params.column.getId());
	
	if(params.column.getId() != "filename" && params.column.getId() != "refgenome"){
			console.log('cell was clicked', params.data.jobid);
			console.log('cell was clicked', params.data.resultpath);
			const element = document.getElementById('vcf_status');
	   		element.innerHTML  = "<div style='height:92%;' class='card-content'><div class='card-body'><div class='row'><div class='col-12'><ul class='nav nav-pills nav-active-bordered-pill'><li class='nav-item'><a class='nav-link' id='base-pill31' data-toggle='pill' href='#pill1' aria-expanded='true'>VCF Info</a></li><li class='nav-item'><a class='nav-link' id='base-pill32' data-toggle='pill' href='#pill2' aria-expanded='false'>VCF viewer</a></li><li class='nav-item'><a class='nav-link' id='base-pill33' data-toggle='pill' href='#pill3' aria-expanded='false'>Variant</a></li><li class='nav-item'><a class='nav-link' id='base-pill34' data-toggle='pill' href='#pill4' aria-expanded='false'>DP</a></li><li class='nav-item'><a class='nav-link' id='base-pill35' data-toggle='pill' href='#pill5' aria-expanded='false'>Missing</a></li></ul><div class='tab-content'><div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'><iframe src = '' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill1_frame' id='pill1_frame'></iframe></div><div class='tab-pane' id='pill2' aria-labelledby='base-pill2'><iframe src = '' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill2_frame' id='pill2_frame'></iframe></div><div class='tab-pane' id='pill3' aria-labelledby='base-pill3'><iframe src = '' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill3_frame' id='pill3_frame'></iframe></div><div class='tab-pane' id='pill4' aria-labelledby='base-pill4'><iframe src = '' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill4_frame' id='pill4_frame'></iframe></div><div class='tab-pane' id='pill5' aria-labelledby='base-pill5'><iframe src = '' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill5_frame' id='pill5_frame'></iframe></div></div></div></div></div></div>";
	       replaceClass("base-pill31", "nav-link", "nav-link active");
	       replaceClass("base-pill32", "nav-link", "nav-link");
	       replaceClass("base-pill33", "nav-link", "nav-link");
	       replaceClass("base-pill34", "nav-link", "nav-link");
	       replaceClass("base-pill35", "nav-link", "nav-link");	  
		   
		   $('#pill1_frame').attr('src', "/ipet_digitalbreed/web/database/genotype_vcfinfo.jsp?jobid="+params.data.jobid);
		   //$('#pill2_frame').attr('src', "/ipet_digitalbreed/web/database/genotype_vcfviewer.jsp?jobid="+params.data.jobid);
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

  agGrid
    .simpleHttpRequest({ url: "../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
    .then(function(data) {
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
