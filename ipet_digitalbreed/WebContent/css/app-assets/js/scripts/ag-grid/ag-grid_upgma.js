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
		    .simpleHttpRequest({ url: "../../../web/b_toolbox/upgma/upgma_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
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
		    url:"../../../web/b_toolbox/upgma/upgma_delete.jsp",
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
			width: 100,
			suppressMenu: true,
			cellClass: "grid-cell-centered",      
			checkboxSelection: true,
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true
	    },
	    {
	    	headerName: "분석상태",
	    	field: "status",
	    	suppressMenu: true,
	    	cellClass: "grid-cell-centered",      
	    	width: 80,
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
	      field: "file_name",
	      filter: true,
	      cellClass: "grid-cell-centered",      
	      width: 700,
	    },
	    {
	      headerName: "상세내용",
	      field: "comment",
	      filter: 'agNumberColumnFilter',
	      width: 350
	    },
	    {
	      headerName: "분석일",
	      field: "cre_dt",
	      filter: 'agDateColumnFilter',
	      cellClass: "grid-cell-centered", 
	      width: 150
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
		defaultColDef: {
			editable: false, 
		    sortable: true,
			resizable: true,
			menuTabs: ['filterMenuTab'],
			//floatingFilter: true,
		},
		columnDefs: columnDefs,
		rowHeight: 35,
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		animateRows: true,
		serverSideInfiniteScroll: true,
		suppressHorizontalScroll: true,
		defaultCsvExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		
		onCellClicked: params => {
		
			console.log("cell clicked : " + params.column.getId());
			//console.log("params : ", params);
			
			if(params.column.getId() != "no" && params.column.getId() != "cre_dt"){
				
				switch (Number(params.data.status)) {
				case 0:
					//$("#analysis_process").modal('show');
					alert("분석 중입니다.");
					break;
				case 1:
					$("#iframeLoading").modal('show');
					
					const element = document.getElementById('vcf_status');
					element.innerHTML  = `
										<div class='card-content'>
											<div class='card-body'>
												<div class='row'>
													<div class='col-12'>
														<ul class='nav nav-pills nav-active-bordered-pill'>
															<li class='nav-item'><a class='nav-link active' id='upgma_1' data-toggle='pill' href='#pill1' aria-expanded='true'>Hierarchical Tree</a></li>
						   									<li class='nav-item'><a class='nav-link' id='upgma_2' data-toggle='pill' href='#pill2' aria-expanded='false'>Circular Tree</a></li>
														</ul>
														<div class='tab-content'>
															<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
																<iframe src = '' loading="lazy" height='1000px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill1_frame' id='pill1_frame' onload='hideSpinner(this, ${params.data.jobid})'></iframe>
															</div>
															<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
																<iframe src = '' loading="lazy" height='1000px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill2_frame' id='pill2_frame' onload='hideSpinner(this, ${params.data.jobid})'></iframe>
															</div>
														</div>
													</div>
												</div>
												<input type='hidden' id='jobid'>
				   								<input type='hidden' id='resultpath'>
											</div>
										</div>
										`;	  
				   
					$('#pill1_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_hierarchical_tree.html");
					//$('#pill2_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_circular_tree.html");
					
					// input에 jobid값 저장
			   		$("#jobid").val(params.data.jobid);
			   		$("#resultpath").val(params.data.resultpath);
					
					//gridOptions.api.sizeColumnsToFit();
					break;
				case 2:
					//$("#analysis_fail").modal('show');
					alert("분석에 실패했습니다.");
					break;
				}
			}
		}
	};

	// 클릭이벤트 : iframe 로딩 중 로드스피너 출력
	document.addEventListener('click', function(event) {
		console.log(event.target.id);
		
		const jobid = $("#jobid").val();
		const resultpath = $("#resultpath").val();
		
		switch(event.target.id) {
			case 'upgma_1':
				break;
			case 'upgma_2':
				if(!$('#pill2_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill2_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_circular_tree.html");
				}
				break;
		}
	});

	// 로딩이 완료되면 로딩창 소멸
	function hideSpinner(target, jobid) {
		if(target.src.includes(jobid)) {
			$("#iframeLoading").modal('hide');
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
  var gridTable = document.getElementById("myGrid");

  /*** GET TABLE DATA FROM URL ***/
  agGrid
	  .simpleHttpRequest({ url: "../../../web/b_toolbox/upgma/upgma_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
	  .then(function(data) {
		  console.log("data : ", data);
		  //console.log(agGrid.getColumns());
		  
		  gridOptions.api.setRowData(data);
		  gridOptions.api.sizeColumnsToFit();
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
	gridOptions.api.sizeColumnsToFit();
    /*
	if ($(window).width() < 768) {
      //gridOptions.columnApi.setColumnPinned("email", null);
    } else {
     // gridOptions.columnApi.setColumnPinned("email", "left");
    }
    */
  });
  
  
  
  
