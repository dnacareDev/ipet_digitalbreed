/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	/*
	class DatePicker {
	  // gets called once before the renderer is used
	  init(params) {
	    // create the cell
	    this.eInput = document.createElement('input');
	    this.eInput.value = params.value;
	    this.eInput.classList.add('ag-input');
	    this.eInput.style.height = '100%';
	    
	    const $j = jQuery.noConflict();
	
	    // https://jqueryui.com/datepicker/
	    $j(this.eInput).datepicker({
	      dateFormat: 'yy-mm-dd',
	      onSelect: () => {
	        this.eInput.focus();
	      }
	    });
	  }
	
	  // gets called once when grid ready to insert the element
	  getGui() {
	    return this.eInput;
	  }
	
	  // focus and select can be done after the gui is attached
	  afterGuiAttached() {
	    this.eInput.focus();
	    this.eInput.select();
	  }
	
	  // returns the new value after editing
	  getValue() {
	    return this.eInput.value;
	  }
	
	  // any cleanup we need to be done here
	  destroy() {
	    // but this example is simple, no cleanup, we could
	    // even leave this method out as it's optional
	  }
	
	  // if true, then this editor will appear in a popup
	  isPopup() {
	    // and we could leave this method out also, false is the default
	    return false;
	  }
	}
	*/
	

	
	/*** COLUMN DEFINE ***/
	var columnDefs = [];

	function refresh() {
		gridOptions.api.refreshCells(); 
		
		const excel_id = $("#excel-select :selected").data('excel_id');
		const column_length = $("#excel-select :selected").data('column_length');
		
		console.log("column_length : ", column_length);
		
		agGrid
		.simpleHttpRequest({ url: `/ipet_digitalbreed/web/b_toolbox/qf/test.jsp?excel_id=${excel_id}`})
		.then(function(data) {
			console.log([...data]);
			
			columnDefs = [
				{
					headerName: "",
					editable: false,
					sortable: false,
					checkboxSelection: true,
					headerCheckboxSelection: true,
					headerCheckboxSelectionFilteredOnly: true,
					cellClass: "grid-cell-centered",      
					width: 50,
				}
			];
			for(let i=0 ; i<column_length ; i++) {
				columnDefs.push(
						{
							headerName: data[data.length - 1][`column_${i}`],
							field: `column_${i}`,
							editable: true,
							sortable: false,
							filter: true,
							cellClass: "grid-cell-centered",      
							width: 200,
						}
				)
			}
			
			console.log("columnDefs : ", columnDefs);
			
			const header = data.pop();
			
			gridOptions.api.setColumnDefs(columnDefs);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
			
		});
	}
	
	function getSelectedRowData() {
		let selectedData = gridOptions.api.getSelectedRows();
		
		const excel_id = selectedData[0].excel_id;
		
		let row_index_arr = new Array();
		for(let i=0 ; i<selectedData.length ; i++) {
			row_index_arr.push(selectedData[i].row_index)
		}
		
		console.log(excel_id);
		console.log(row_index_arr);
		
		/*
		if(!confirm("정말 삭제하시겠습니까?")) {
			return;
		}
		*/
		
		$.ajax({
			url:"./deleteExcel.jsp",
			type:"POST",
			data:{
				'excel_id' : excel_id,
				'row_index_arr' : row_index_arr
			},
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
	
	/*** GRID OPTIONS ***/
	var gridOptions = {
		columnDefs: columnDefs,
		defaultColDef: {
			initialWidth: 100,
			sortable: true,
			resizable: true,
		},
		rowHeight: 35,
		rowSelection: "multiple",
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		animateRows: true,
		serverSideInfiniteScroll: true,
		undoRedoCellEditing: true,
	    undoRedoCellEditingLimit: 20,
	    onCellValueChanged: onCellValueChanged,
	    onSelectionChanged: onSelectionChanged,
	};
	
	function onCellValueChanged(event) {
		console.log(event.oldValue, " -> ", event.newValue);
		
		const excel_id = event.data.excel_id;
		const column_name = event.colDef.field;
		const row_index = event.data.row_index;
		const new_value = event.newValue;
		
		
		const data = {
				"excel_id" : excel_id,
				"column_name" : column_name,
				"row_index" : row_index,
				"new_value" : new_value
		}
		console.log(data);
		
		$.ajax({
			url: "/ipet_digitalbreed/web/b_toolbox/qf/modifyExcel.jsp",
			method: "POST",
			data: {
				"excel_id" : excel_id,
				"column_name" : column_name,
				"row_index" : row_index,
				"new_value" : new_value
			},
			success: function(result) {
				console.log("modify success : ", result);
			}
		})
	}
	
	function onSelectionChanged(event) {
		console.log("selection event : ", event);
		console.log(gridOptions.api.getDisplayedRowAtIndex(0));
	}
	
	/*** DEFINED TABLE VARIABLE ***/
	var gridTable = document.getElementById("myGrid");

	/*** GET TABLE DATA FROM URL ***/

	/*
  	agGrid
	.simpleHttpRequest({ url: "/ipet_digitalbreed/web/b_toolbox/qf/test.jsp"})
	.then(function(data) {
		const columns = data.pop();
		
		const columns_arr = columns.replaceAll(/[\[\]'"]+/g, "").split(", ");
		
		console.log(columns_arr);
		console.log(data);
		
		
		for(let i=0 ; i<columns_arr.length ; i++) {
			columnDefs.push({
				headerName: columns_arr[i],
			    field: columns_arr[i],
			    editable: true,
			    sortable: false,
			    filter: true,
			    cellClass: "grid-cell-centered",      
			    width: 200,
			})
		}
		
		gridOptions.api.setColumnDefs(columnDefs);
		gridOptions.api.setRowData(data);
		gridOptions.api.sizeColumnsToFit();
	});
	*/
  	
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
	new agGrid.Grid(gridTable, gridOptions);
	
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
  
	//console.log(gridOptions);
  
