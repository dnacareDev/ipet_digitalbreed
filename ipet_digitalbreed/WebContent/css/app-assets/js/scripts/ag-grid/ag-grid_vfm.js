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
  		fetch("../../../web/b_toolbox/vfm/vfm_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
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
		    url:"../../../web/b_toolbox/vfm/vfm_delete.jsp",
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
			headerName: "순번",
			//field: "no",
			valueGetter: inverseRowCount,
			maxWidth: 100,
			minWidth: 100,
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
	    	maxWidth: 90,
	    	minWidth: 90,
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
	    	filter: "agTextColumnFilter",
	    	cellClass: "grid-cell-centered",     
	    	sortable: true,
	      	suppressMenu: false,
	    	width: 700,
	    	minWidth: 150,
	    },
	    {
	    	headerName: "처리내용",
	    	field: "manufacture",
	    	//filter: true,
	    	cellClass: "grid-cell-centered",
	    	width: 300,
	    	minWidth: 110,
	    },
	    {
	      headerName: "저장",
	      field: "save_cmd",
	      suppressMenu: true,
	      cellClass: "grid-cell-centered",
	      width: 150,
	      minWidth: 80,
	      cellRenderer: function(params) {
	    	  //console.log(params);
	    	  switch(params.value) {
	    	  	case "0":
	    	  		return `<span style='cursor:pointer;' onclick='const status=${Number(params.data.status)}; if(status==0){return alert("분석 중입니다.");} saveToVcf("${params.data.filename}", "${params.data.jobid}", "${params.data.refgenome}", "${params.data.refgenome_id}", "${params.data.annotation_filename}")'><i class='feather icon-save'></i></span>`;
	    	  	case "1":
	    	  		return `<span style='cursor:pointer;' onclick='moveToVcf("${params.data.jobid}")'><i class='feather icon-link-2'></i></span>`;
	    	  }
	    	  
	      }
	    },
	    {
	    	headerName: "분석일",
	    	field: "cre_dt",
	    	filter: 'agDateColumnFilter',
	    	filterParams: {
	        	comparator: function(filterLocalDateAtMidnight, cellValue) {
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
	      	},
	      	sortable: true,
	      	suppressMenu: false,
	      	width: 150,
	      	minWidth: 110,
	      	cellClass: "grid-cell-centered", 
	    },
		{
	      headerName: "jobid",
	      field: "jobid",
	      hide: true
	    },  
	    {
		      field: "refgenome_id",
		      hide: true
		},
		{
		      field: "refgenome",
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
			menuTabs: ['filterMenuTab'],
			resizable: true,
			sortable: false,
	    	suppressMenu: true,
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
						$('#pill1_frame').attr( 'src', "./vfm_vcfinfo.jsp?jobid="+params.data.jobid);
						
						// 클릭시 초기화
						$('#pill2_frame').attr('src', '');
						$('#pill3_frame').attr('src', '');
						$('#pill4_frame').attr('src', '');
						$('#pill5_frame').attr('src', '');
						
				   		
				   		// input에 jobid값 저장
				   		$("#jobid").val(params.data.jobid);
				   		$("#resultpath").val(params.data.resultpath);
				   		
						gridOptions.api.sizeColumnsToFit();
						
			  			//$("html").animate({ scrollTop: $(document).height() }, 1000);
						
						break;
					case 2:
						//$("#analysis_fail").modal('show');
						alert("분석에 실패했습니다.");
						break;
				}
			}
		}
	};
	
	
	const vcf_columnDefs = [
		{
			checkboxSelection: true,
			headerCheckboxSelectionFilteredOnly: true,
			//headerCheckboxSelection: true,
		},
		{
			headerName: "순번",
			field: "displayno",
			maxWidth: 100,
			minWidth: 100,	
			suppressMenu: true,
			hide:true,
	    },
	    {
	    	headerName: "실제순번",
	    	field: "selectfiles",
	    	hide: true,	
	    },
	    {
	    	headerName: "분석상태",
	    	field: "status",
	    	suppressMenu: true,
	    	maxWidth: 90,
	    	minWidth: 90,
	    	cellClass: "grid-cell-centered",      
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
	    	},
	    	hide:true,
	    },
	    {
	    	headerName: "VCF 파일명",
	    	field: "filename",
	    	filter: "agTextColumnFilter",
	    	width: 500,
	    	minWidth:150,
	    	/*
	    	cellRenderer: function(params){
	    		return params.value+"<a href='/ipet_digitalbreed/"+params.data.uploadpath+params.data.jobid + "/" + params.value + "' download>&nbsp;&nbsp;<i class='feather icon-download'></i></a>";
	    	}
	    	*/
	    },
	    {
	    	headerName: "상세내용",
	    	field: "comment",
	    	filter: "agTextColumnFilter",
	    	cellClass: "ag-header-cell-label",
	    	width: 470,
	    	minWidth:110,
	    	cellStyle: {'cursor': 'pointer'},
	    	hide:true,
	    },
	    {
	    	headerName: "작물",
	    	field: "cropid",
	    	width: 180,
	    	hide: true
	    },
	    {
	    	headerName: "참조유전체",
	    	field: "refgenome",
	    	filter: "agTextColumnFilter",
	    	width: 275,
	    	minWidth: 120,
	    },
	    {
	    	headerName: "샘플수",
	    	field: "samplecnt",
	    	valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
	    	filter: 'agNumberColumnFilter',
	    	width: 120,
	    	minWidth: 100,
	    },
	    {
	    	headerName: "변이수",
	    	field: "variablecnt",
	    	valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
	    	filter: 'agNumberColumnFilter',
	    	width: 120,
	    	minWidth: 100,
	    },
	    {
	        headerName: "등록일자",
	        field: "cre_dt",
	        filter: 'agDateColumnFilter',
	        filterParams: {
	        	comparator: comparator
	        },
	        width: 120,
	        minWidth: 110,
	        hide:true,
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
	
	const vcf_gridOptions = {
			defaultColDef: {
				editable: true, 
			    sortable: true,
				resizable: true,
				cellClass: "grid-cell-centered",
				//suppressMenu: true,
				menuTabs: ["filterMenuTab"], 
				suppressMovable: true,
			},
			columnDefs: vcf_columnDefs,
			rowHeight: 35,
			rowSelection: "multiple",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			suppressDragLeaveHidesColumns: true,
			colResizeDefault: "shift",
			animateRows: true,
			onRowSelected: (params) => {
				if(vcf_gridOptions.api.getSelectedRows().length > 2) {
					alert("vcf를 2개 이상 선택할 수 없습니다.");
					params.node.setSelected(false);
				}
			}
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
	
	
	// 클릭이벤트 : iframe 로딩 중 로드스피너 출력
	document.addEventListener('click', function(event) {
		//console.log(event.target.id);
		
		const jobid = $("#jobid").val();
		const resultpath = $("#resultpath").val();
		
		//console.log(jobid);
		
		switch(event.target.id) {
			case 'qf_1':
				window.scrollTo(0, document.body.scrollHeight);
				break;
			case 'qf_2':
				if(!$('#pill2_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill2_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_variant.html");
				}
				window.scrollTo(0, document.body.scrollHeight);
				break;
			case 'qf_3':
				if(!$('#pill3_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill3_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_depth.html");
				}
				window.scrollTo(0, document.body.scrollHeight);
				break;
			case 'qf_4':
				if(!$('#pill4_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill4_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_miss.html");
				}
				window.scrollTo(0, document.body.scrollHeight);
				break;
			case 'qf_5':
				if(!$('#pill5_frame').attr('src')){
					$("#iframeLoading").modal('show');
					$('#pill5_frame').attr('src', resultpath+"/"+jobid+"/"+jobid+"_density.html");
				}
				window.scrollTo(0, document.body.scrollHeight);
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
  		fetch("../../../web/b_toolbox/vfm/vfm_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
			
			if(linkedJobid !== "null") {
				gridOptions.api.forEachNode((rowNode, index) => {
					if(linkedJobid == rowNode.data.jobid) {
						console.log(rowNode.rowIndex);
						
						gridOptions.api.paginationGoToPage(parseInt( Number(rowNode.rowIndex) / 20 ));
						
						gridOptions.api.ensureIndexVisible(Number(rowNode.rowIndex), 'middle');
						rowNode.setSelected(true);
						
						//gridOptions.api.setFocusedCell(Number(rowNode.rowIndex), 'no');
						//console.log($("[row-id='0'] [col-id='displayno']"));
						$(`[row-index=${rowNode.rowIndex}] [col-id='0']`).trigger("click");
					}
				});	
			}
  		})
  		
  		fetch("../../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val() )
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
  			
  			const gridTable = document.getElementById("VcfGrid");
  			const myGrid = new agGrid.Grid(gridTable, vcf_gridOptions);
  			
  			vcf_gridOptions.api.setRowData(data);
  			//vcf_gridOptions.columnApi.autoSizeAllColumns(false);
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
	
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
	});
  
