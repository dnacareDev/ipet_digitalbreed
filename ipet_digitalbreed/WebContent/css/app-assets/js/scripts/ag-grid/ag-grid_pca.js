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
	
	
	

	function refresh() {
		gridOptions.api.refreshCells(); 
		agGrid
		    //.simpleHttpRequest({ url: "../../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
			.simpleHttpRequest({ url: "../../../web/b_toolbox/pca/pca_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
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
		    url:"../../../web/b_toolbox/pca/pca_delete.jsp",
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
			headerName: "번호",
			//field: "no",
			valueGetter: inverseRowCount,
			editable: false,
			sortable: true,
			width: 150,
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
	    	width: 400,
	    },
	    {
	    	headerName: "분석상태",
	    	field: "status",
	    	editable: false,
	    	sortable: true,
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
	      editable: false,
	      sortable: true,
	      filter: 'agNumberColumnFilter',
	      width: 750
	    },
	    {
	      headerName: "분석일",
	      field: "cre_dt",
	      editable: false,
	      sortable: true,
	      filter: 'agNumberColumnFilter',
	      width: 296,
	      cellClass: "grid-cell-centered", 
	      //cellEditor: DatePicker,
	      //cellEditorPopup: true
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
	
	function inverseRowCount(params) {
		return params.api.getDisplayedRowCount() - params.node.rowIndex;
	}

	/*** GRID OPTIONS ***/
	var gridOptions = {
		columnDefs: columnDefs,
		rowHeight: 35,
		rowSelection: "multiple",
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		animateRows: true,
		suppressHorizontalScroll: true,
		serverSideInfiniteScroll: true,
		cellClass: "grid-cell-centered",
		
		defaultCsvExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		
		onCellClicked: params => {
		
			console.log("cell clicked : " + params.column.getId());
			//console.log("params : ", params);
			
			if(params.column.getId() != "no" && params.column.getId() != "cre_dt" ){
				
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
				   												<li class='nav-item'><a class='nav-link active' id='pca_1' data-toggle='pill' href='#pill1' aria-expanded='true'>PCA 1-2 </a></li>
								   								<li class='nav-item'><a class='nav-link' id='pca_2' data-toggle='pill' href='#pill2' aria-expanded='false'>PCA 2-3</a></li>
								   								<li class='nav-item'><a class='nav-link' id='pca_3' data-toggle='pill' href='#pill3' aria-expanded='false'>PCA 1-3</a></li>
								   								<li class='nav-item'><a class='nav-link' id='pca_4' data-toggle='pill' href='#pill4' aria-expanded='false'>PCA (3D)</a></li>
				   											</ul>
				   											<div class='tab-content'>
				   												<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
				   													<iframe src = '' loading="lazy" height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill1_frame' id='pill1_frame'></iframe>
				   												</div>
				   												<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
				   													<iframe src = '' loading="lazy" height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill2_frame' id='pill2_frame'></iframe>
				   												</div>
				   												<div class='tab-pane' id='pill3' aria-labelledby='base-pill3'>
				   													<iframe src = '' loading="lazy" height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill3_frame' id='pill3_frame'></iframe>
				   												</div>
				   												<div class='tab-pane' id='pill4' aria-labelledby='base-pill4'>
				   													<iframe src = '' loading="lazy" height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill4_frame' id='pill4_frame'></iframe>
				   												</div>
				   											</div>
				   										</div>
				   									</div>
				   								</div>
				   							</div>`;
				   		
				   		$('#pill1_frame').attr('src', params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_vcf_2_pca_pc1_pc2.html");
				   		$('#pill2_frame').attr('src', params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_vcf_2_pca_pc2_pc3.html");
				   		$('#pill3_frame').attr('src', params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_vcf_2_pca_pc1_pc3.html");
				   		$('#pill4_frame').attr('src', params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_vcf_2_pca.html");

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
		.simpleHttpRequest({ url: "../../../web/b_toolbox/pca/pca_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		.then(function(data) {
		console.log("data : ", data);
		  
		gridOptions.api.setRowData(data);
		gridOptions.api.sizeColumnsToFit();
	});
  	
  	function getParams() {
  		return 
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
  
