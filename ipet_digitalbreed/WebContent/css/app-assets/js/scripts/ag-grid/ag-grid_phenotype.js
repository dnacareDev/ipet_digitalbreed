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
    .simpleHttpRequest({ url: "../../web/database/phenotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
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
	  
	  alert("deleteitems : " + deleteitems);	  
	  
		/*
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
		*/
	}
	
	  /*** GRID OPTIONS ***/
	  var gridOptions = {
	    columnDefs: columnDefs,
		enableRangeSelection: true,
	    rowHeight: 35,
	  	rowSelection: 'multiple',	  	
	    floatingFilter: true,
	    filter: 'agMultiColumnFilter',
	    pagination: true,
	    paginationPageSize: 20,
	    pivotPanelShow: "always",
	    colResizeDefault: "shift",
	    animateRows: true,
	    resizable: true,
	    serverSideInfiniteScroll: true,
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
    .simpleHttpRequest({ url: "../../web/database/phenotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
    .then(function(data) {
      gridOptions.api.setRowData(data);
    });


  /*** FILTER TABLE ***/
  function updateSearchQuery(val) {
    gridOptions.api.setQuickFilter(val);
  }

  function addCol(fieldp, headerNamep) {
	var columnDefs = gridOptions.columnDefs;
	columnDefs.push({ field:fieldp, headerName: headerNamep, width: "120",  editable: true,  sortable: true, filter: true, cellClass: "grid-cell-centered"});
	gridOptions.api.setColumnDefs(columnDefs);
  }

  function addnewrow() {
		var newRows = [{                
			name:'Insert row 3',                
			sex:'Female',                
			age: 44            
		}]; 		           
		gridOptions.api.updateRowData({add: newRows, addIndex:0});
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
