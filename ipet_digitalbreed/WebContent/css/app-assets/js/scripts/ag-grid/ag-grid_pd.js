/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/


	class CheckboxRenderer {
	    init(params) {
	        // create the cell
	        this.eGui = document.createElement('div');
	        //this.eGui.innerHTML = params.node.rowIndex % 3 == 0 ? `<input type="checkbox" class="checkbox" />` : ``;
	        this.eGui.innerHTML = params.node.rowIndex % 3 == 0 ? `<span class="ag-icon ag-icon-checkbox-unchecked" style="background-color:#2196f3;></span>` : ``;
	        this.eGui.addEventListener('click', () => {
	    	    const checkboxSpan = this.eGui.querySelector('span');
	    	    if (checkboxSpan.classList.contains('ag-icon-checkbox-unchecked')) {
	    	        checkboxSpan.classList.remove('ag-icon-checkbox-unchecked');
	    	        checkboxSpan.classList.add('ag-icon-checkbox-checked');
	    	    } else {
	    	        checkboxSpan.classList.remove('ag-icon-checkbox-checked');
	    	        checkboxSpan.classList.add('ag-icon-checkbox-unchecked');
	    	    }
	       });
	   }
	
	   getGui() {
	       return this.eGui;
	   }
	}

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
						//$("#Loading").modal('show');
						
						document.getElementById('vcf_status').style.display = "block";
						$("html").animate({ scrollTop: $(document).height() }, 1000);
						
						fetch(`${params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_primer_design.csv"}`)
						.then((response)=> {
							if(!response.ok) {
								gridOptions2.api.setRowData();
						        //gridOptions2.columnApi.autoSizeAllColumns();
								gridOptions2.api.sizeColumnsToFit();
								throw new Error('primer_design CSV file does not exist');
							} else {
								return response.blob()
							}
						})
						.then((file)=> {
							//console.log(data);
							columnDefs2[0]['cellClassRules'] = params.data.marker_category == 'KASP' ? {'cell-span': "rowIndex % 3 === 0"} : {'cell-span': "rowIndex % 2 === 0"};
							gridOptions2.api.setColumnDefs(columnDefs2);
							gridOptions2.api.setRowData();
							
							var reader = new FileReader();
						    reader.onload = function(){
						        var fileData = reader.result;
						        var wb = XLSX.read(fileData, {type : 'binary', FS:'\t'});
						        
						        var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
						        console.log("rowObj : ", rowObj);
						        //console.log(csv_to_grid);
						        gridOptions2.api.setRowData(rowObj);
						        
						        columnDefs2[1]['minWidth'] = 0;
						        columnDefs2[2]['minWidth'] = 0;
						        gridOptions2.api.setColumnDefs(columnDefs2);
						        gridOptions2.columnApi.autoSizeAllColumns();
						        
						        const width_id = gridOptions2.columnApi.getColumn("ID").actualWidth
						        const width_seq = gridOptions2.columnApi.getColumn("seq").actualWidth
						        
						        
						        columnDefs2[1]['minWidth'] = width_id;
						        columnDefs2[2]['minWidth'] = width_seq;
						        gridOptions2.api.setColumnDefs(columnDefs2);
						        gridOptions2.api.sizeColumnsToFit();
						        
						        //$("#Loading").modal('hide');
						    };
						    reader.readAsBinaryString(file);
						})
						
						
						
						break;
					case 2:
						alert("분석에 실패했습니다.");
						break;
				}

			} 
		}
	};

	var columnDefs2 = [
		{
			headerName: '',
			field: 'checkbox',
			maxWidth: 50,
			minWidth: 50,
			//checkboxSelection: (params) => params.node.rowIndex % 3 == 0 ? true : false,
			//checkboxSelection: (params) => gridOptions.api.getSelectedRows()[0]['marker_category'] == 'KASP' ? (params.node.rowIndex % 3 == 0 ? true : false) : (params.node.rowIndex % 2 == 0 ? true : false),
			checkboxSelection: (params) => gridOptions.api.getSelectedRows()[0]['marker_category'] == 'KASP' ? !!(params.node.rowIndex % 3 == 0) : !!(params.node.rowIndex % 2 == 0),
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			//rowSpan: (params) => params.node.rowIndex % 3 == 0 ? 3 : 0,
			rowSpan: (params) => gridOptions.api.getSelectedRows()[0]['marker_category'] == 'KASP' ? (params.node.rowIndex % 3 == 0 ? 3 : 0) : (params.node.rowIndex % 2 == 0 ? 2 : 0),
			//rowSpan: (params) => gridOptions.api.getSelectedRows()[0]['marker_category'] == 'KASP' ? !!(params.node.rowIndex % 3 == 0) : !!(params.node.rowIndex % 2 == 0),
			/*
			cellClassRules: {
			      'cell-span': "rowIndex % 3 === 0",
			},
			*/
			/*
			cellClassRules: {
			      'cell-span': ` ${gridOptions.api?.getSelectedRows()?.[0]['marker_category']} == 'KASP' && rowIndex % 3 == 0 || ${gridOptions.api?.getSelectedRows()?.[0]['marker_category']} != 'KASP' && rowIndex % 2 == 0`,
			},
			*/
	    },
		{
			headerName: "ID", 
			field: 'ID',
			suppressMenu: true, 
		},
		{
			headerName: "seq",
			field: "seq",
			suppressMenu: true,
		},
		{
			field: "Product_size", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['inRange']
			}
		},
		{
			field: "Any", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['inRange']
			}
		},
		{
			field: "3'", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['inRange']
			}
		},
		{
			field: "End_stability", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['inRange']
			}
		},
		{
			field: "Hairpin", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['inRange']
			}
		},
		{
			field: "Penalty",
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['inRange']
			}
		},
		{
			field: "Compl_any",
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['inRange']
			}
		},
		{
			field: "Compl_end",
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['inRange']
			}
		},
		{
			headerName: "matched",
			field: "matched",
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['inRange']
			}
		},
	]

	let removed_nodes = new Array();
	
	var gridOptions2 = {
			defaultColDef: { 
				editable: false, 
				sortable: false, 
				resizable: true,
				suppressMenu: false, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: columnDefs2,
			colResizeDefault: "shift",
			suppressDragLeaveHidesColumns: true,
			//suppressRowClickSelection: true,
			suppressRowTransform: true,
			rowHeight: 35,
			rowMultiSelectWithClick: true,
			rowSelection: "multiple",
			animateRows: true,
			getRowId: params => params['data']['ID'],
			onCellClicked: (params) => {
			},
			onRowSelected: (params) => {
				const is_selected = params.node.selected;
				const row_index = params.node.rowIndex - (params.node.rowIndex % 3);
				
				gridOptions2.api.forEachNode(node=> {
					if(node.rowIndex ==  row_index || node.rowIndex ==  row_index+1 || (gridOptions.api.getSelectedRows()[0]['marker_category'] == 'KASP' && node.rowIndex ==  row_index+2) ) {
						node.setSelected(is_selected);
					}
				})
			},
			onFilterChanged: (params) => {
				//필터링을 끝낸 이후에는 제거조건용 배열 초기화
				removed_nodes = [];
			},
			isExternalFilterPresent: () => {
				return Object.keys(gridOptions2.api.getFilterModel()).length == 0 ? false : true;
			},
			doesExternalFilterPass: (node) => {
				//console.log(node);
				
				const filtered_columns = gridOptions2.api.getFilterModel();
				
				if(removed_nodes.length == 0 ) {
					gridOptions2.api.forEachNode(node => {
						for(column in filtered_columns) {
							if ( !(filtered_columns[column]['filter'] <= node['data'][column] && node['data'][column] <= filtered_columns[column]['filterTo']) ) {
								removed_nodes.push(node.id.slice(0, node.id.lastIndexOf("-")));
							} 
						}
					});
				}
				
				return removed_nodes.includes(node.id.slice(0, node.id.lastIndexOf("-"))) ? false : true;
				
				/*
				for(column in filtered_columns) {
					return (filtered_columns[column]['filter'] <= node['data'][column] && node['data'][column] <= filtered_columns[column]['filterTo'] ) ? true : false; 
				}
				*/
			},
			defaultCsvExportParams: {
				columnKeys: ["ID", "seq", "Product_size","Any","3'","End_stability","Hairpin","Penalty","Compl_any","Compl_end","matched"]
			},
			defaultExcelExportParams: {
				columnKeys: ["ID", "seq", "Product_size","Any","3'","End_stability","Hairpin","Penalty","Compl_any","Compl_end","matched"]
			}
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
  		
  		const resultGrid = new agGrid.Grid(document.getElementById('resultGrid'), gridOptions2);
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
	
