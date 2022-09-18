/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	function refresh() {	
	
		var columnDefs = [	
		  {
		    rowDrag: true,
		    maxWidth: 30,
		    suppressMenu: true,
		    rowDragText: (params, dragItemCount) => {
		      if (dragItemCount > 1) {
		        return dragItemCount + ' athletes';
		      }
		      return params.rowNode.data.athlete;
		    },
		  },		
        {
            headerName: "순번",
            field: "selectfiles",
            editable: false,
            sortable: true,
            width: 140,	
            filter: 'agMultiColumnFilter',
            cellClass: "grid-cell-centered",      
            checkboxSelection: true,
            headerCheckboxSelectionFilteredOnly: true,
            headerCheckboxSelection: true,
		},
        {
            headerName: "사진",
            field: "photo_status",
            editable: false,
            sortable: true,
            filter: true,
            cellClass: "grid-cell-centered",      
            width: 120,	
            cellRenderer: deltaIndicator,
		},
        {
            headerName: "등록일자",
            field: "cre_dt",
            editable: false,
            sortable: true,
            filter: true,
            cellClass: "grid-cell-centered",      
            width: 150
		},
        {
            headerName: "개체명",
            field: "samplename",
            editable: true,
            sortable: true,
            filter: true,
            cellClass: "grid-cell-centered",      
            width: 150
		}
	];
		
			var variety_id = $( "#variety-select option:selected" ).val();
	 	var grid_array;	
		$.ajax({
			url : "../../web/database/traitnamertn.jsp",
			type : "post",
			async: false,
			data : {"varietyid" : variety_id},
			dataType : "json",
			success : function(result){			
				grid_array = result;	
				for (var i=0; i<grid_array.length; i++) {
					for (key in grid_array[i]) {		
						//addCol(key, grid_array[i][key] );
						//addCol(i+"", grid_array[i][key] );						
						//var columnDefs = columnDefs;												
						columnDefs.push({ field:i+"_key", headerName: grid_array[i][key], width: "210",  editable: true,  sortable: true, filter: true, cellClass: "grid-cell-centered"});
						gridOptions.api.setColumnDefs(columnDefs);										
					}
				}		
			}
		});  
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

		
		  	$.ajax({
			    url:"../../web/database/phenotype_delete.jsp",
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
	    
	const deltaIndicator = (params) => {
	  const element = document.createElement('span');
	  const imageElement = document.createElement('img');	
	  
	  if (params.value ==  1) {
  		return '<span><i class="ficon feather icon-file-text"></i></span>';
	  } 
	  else if (params.value ==  0) {
  		return '<span><i class="ficon feather icon-file"></i></span>';
	  }
	  else {
  		return '<span></span>';
	  }
	 
	  element.appendChild(imageElement);
	  element.appendChild(document.createTextNode(params.value));
	  return element;
	};
		
	var columnDefs = [
		  {
		    rowDrag: true,
		    maxWidth: 30,
		    suppressMenu: true,
		    rowDragText: (params, dragItemCount) => {
		      if (dragItemCount > 1) {
		        return dragItemCount + ' athletes';
		      }
		      return params.rowNode.data.athlete;
		    },
		  },	
        {
            headerName: "순번",
            field: "selectfiles",
            editable: false,
            sortable: true,
            width: 140,	
            filter: 'agMultiColumnFilter',
            cellClass: "grid-cell-centered",      
            checkboxSelection: true,
            headerCheckboxSelectionFilteredOnly: true,
            headerCheckboxSelection: true,
            
		},
        {
            headerName: "사진",
            field: "photo_status",
            editable: false,
            sortable: true,
            filter: true,
            cellClass: "grid-cell-centered",      
            width: 120,	
            cellRenderer: deltaIndicator,
		},
        {
            headerName: "등록일자",
            field: "cre_dt",
            editable: false,
            sortable: true,
            filter: true,
            cellClass: "grid-cell-centered",      
            width: 150
		},
        {
            headerName: "개체명",
            field: "samplename",
            editable: true,
            sortable: true,
            filter: true,
            cellClass: "grid-cell-centered",      
            width: 150
		}
	];
    
		function addDropZones(params) {
		  var tileContainer = document.querySelector('.tile-container');
		  var dropZone = {
		    getContainer: () => {
		      return tileContainer;
		    },
		    onDragStop: (params) => {
		      var tile = createTile(params.node.data);
		      tileContainer.appendChild(tile);
		    },
		  };
		
		  params.api.addRowDropZone(dropZone);
		}

	  function addCheckboxListener(params) {
		  var checkbox = document.querySelector('input[type=checkbox]');
		
		  checkbox.addEventListener('change', function () {
		    params.api.setSuppressMoveWhenRowDragging(checkbox.checked);
		  });
	  }


	function createTile(data) {
	  var el = document.createElement('div');
	
	  el.classList.add('tile');
	  el.innerHTML = data.selectfiles;
	
	  return el;
	}

	  /*** GRID OPTIONS ***/
	  var gridOptions = {
	    flex: 1,
	    rowDragManaged: true,
	    columnDefs: columnDefs,
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
  	    rowHeight: 35,
	  	rowSelection: 'multiple',	  	
	    floatingFilter: true,
	    filter: 'agMultiColumnFilter',
	    //pagination: true,
	    //paginationPageSize: 20,
	    pivotPanelShow: "always",
	    colResizeDefault: "shift",
	    animateRows: true,
	    resizable: true,
	    serverSideInfiniteScroll: true,	    
	    onGridReady: (params) => {
	      addDropZones(params);
	      addCheckboxListener(params);
	    },
		onCellClicked: params => {
			if(params.column.getId() == "photo_status"){
					$.ajax({
						 url:"../../web/database/phenotype_photo_view.jsp",
						 type:"POST",
					     data:{'no':params.data.selectfiles},
						 success: function(result) {						 	
						 	$("#photo_list").html(result);												
						 }
					});						             	   	 	
					$('#backdrop').modal({ show: true });				
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
      
		}]; 		           
		gridOptions.api.updateRowData({add: newRows, addIndex:0});
  }
   		 
  function getAllData() {

		let saveList = [];
		
		saveList.push(gridOptions.api.getDataAsCsv());
		
			$.ajax({
			    url:"../../web/database/phenotype_update.jsp",
			    type:"POST",
			    data:{'params':saveList, 'varietyid':$( "#variety-select option:selected" ).val()},
			    success: function(result) {
			    
			       if(result.trim()===""){
			      	 alert("저장되었습니다.");
			         refresh();
			       }
			       else{
			      	 alert(result.trim());
			       }
			    }
		});			
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
