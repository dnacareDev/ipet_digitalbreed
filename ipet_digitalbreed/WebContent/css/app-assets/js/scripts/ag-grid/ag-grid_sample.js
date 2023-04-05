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
  		fetch("../../../web/b_toolbox/qf/qf_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		})
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
		
		const varietyid = $( "#variety-select option:selected" ).val();
		  
		for (var i = 0; i < selectedData.length; i++) {
		    deleteitems.push(selectedData[i].no);
		}
		
		console.log("delete row : ", deleteitems);
		
		$.ajax(
		{
		    url:"../../../web/b_toolbox/qf/qf_delete.jsp",
		    type:"POST",
		    //data:{'params':deleteitems},
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
			field: "KTSM",
			valueGetter: inverseRowCount,
			suppressMenu: true,
			cellClass: "grid-cell-centered",   
			maxWidth: 100,
	    	minWidth: 100,
	    },
	    {
	    	field: "NO",
	    	suppressMenu: true,
	    	cellClass: "grid-cell-centered",      
	    	maxWidth: 70,
	    	minWidth: 70,
	    },
	    {
	    	headerName: "관리분류군",
	    	field: "category",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "Name",
	    	field: "phylum",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "국명",
	    	field: "phylum_kr",
	    	suppressMenu: true,
	    	cellClass: "grid-cell-centered",
	    },
	    {
	    	headerName: "Name",
	    	field: "class",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "국명",
	    	field: "class_kr",
	    	suppressMenu: true,
	    	cellClass: "grid-cell-centered",
	    },
	    {
	    	headerName: "Name",
	    	field: "order",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "국명",
	    	field: "order_kr",
	    	suppressMenu: true,
	    	cellClass: "grid-cell-centered",
	    },
	    {
	    	headerName: "Name",
	    	field: "family",
	    	filter: true,
	    	cellClass: "grid-cell-centered",      
	    },
	    {
	    	headerName: "국명",
	    	field: "family_kr",
	    	suppressMenu: true,
	    	cellClass: "grid-cell-centered",
	    },
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
		rowSelection: "multiple",
		enableRangeSelection: true,
		suppressMultiRangeSelection: true,
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		serverSideInfiniteScroll: true,
		
		defaultCsvExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		
		onCellClicked: params => {
			//console.log("params : ", params);
			
			if(params.colDef.headerName != "번호" &&params.colDef.headerName != "저장"){
				
				
				switch (Number(params.data.status)) {
					case 0:
						alert("분석 중입니다.");
						break;
					case 1:
						$("#iframeLoading").modal('show');
						
						document.getElementById('vcf_status').style.display = "block";
						document.getElementById('qf_1').click();
						
						$('#pill1_frame').attr('height',"130px");
						$('#pill1_frame').attr( 'src', "/ipet_digitalbreed/web/b_toolbox/qf/qf_vcfinfo.jsp?jobid="+params.data.jobid);
						
						// 클릭시 초기화
						$('#pill2_frame').attr('src', '');
						$('#pill3_frame').attr('src', '');
						$('#pill4_frame').attr('src', '');
						$('#pill5_frame').attr('src', '');
						
				   		
				   		// input에 jobid값 저장
				   		$("#jobid").val(params.data.jobid);
				   		$("#resultpath").val(params.data.resultpath);
				   		
						gridOptions.api.sizeColumnsToFit();
						
			  			$("html").animate({ scrollTop: $(document).height() }, 1000);
						
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
		//console.log(event.target.id);
		
		const jobid = $("#jobid").val();
		const resultpath = $("#resultpath").val();
		
		//console.log(jobid);
		
		switch(event.target.id) {
			case 'qf_2':
				if(!$('#pill2_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill2_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_variant.html");
				}
				break;
			case 'qf_3':
				if(!$('#pill3_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill3_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_depth.html");
				}
				break;
			case 'qf_4':
				if(!$('#pill4_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill4_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_miss.html");
				}
				break;
			case 'qf_5':
				if(!$('#pill5_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill5_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_density.html");
				}
				break;
		}
	});
	
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
  		
  		/*** GET TABLE DATA FROM URL ***/
  		/*
  		fetch("../../../web/b_toolbox/qf/qf_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
			
  		})
  		*/
  		fetch(`/ipet_digitalbreed/result/ag-grid_sample.xlsx`)
  		.then((response) => response.blob())
  		.then((file) =>  {
  			var reader = new FileReader();
		    reader.onload = function(){
		    	
		    	var fileData = reader.result;
		        var wb = XLSX.read(fileData, {type : 'binary', encoding:'UTF-8'});
		        var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
		        
		        console.log("rowObj : ", rowObj);
		        gridOptions.api.setRowData(rowObj);
		        //gridOptions.columnApi.autoSizeAllColumns();
		        gridOptions.api.sizeColumnsToFit();
		        /*
		        let i=0;
		        for(const key in rowObj[0]) {
		        	if(i == Number(order) + 1) {
			        	columnDefs_prediction.push({headerName:phenotype, field: key, filter: 'agNumberColumnFilter',})
		        	}
		        	i++;
		        }
		        */
		        //gridOptions_prediction.columnApi.autoSizeAllColumns();
		    };
		    reader.readAsBinaryString(file);
  			
  		})
  		
	})	
	  	

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
	
	document.addEventListener('click', function(event) {
  		if(event.composedPath()[0].classList.contains("nav-link")) {
  			$("html").animate({ scrollTop: $(document).height() }, 1000);
  		}
  	});
	
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
	});
  
