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
		    .simpleHttpRequest({ url: "./structure_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
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
		
		const varietyid = $( "#variety-select option:selected" ).val();
		  
		for (var i = 0; i < selectedData.length; i++) {
		    deleteitems.push(selectedData[i].no);
		}
		
		console.log("delete row : ", deleteitems);
		
		$.ajax(
		{
		    url:"./structure_delete.jsp",
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
	    	}
	    },
	    {
	      headerName: "VCF 파일명",
	      field: "file_name",
	      filter: 'agTextColumnFilter',
	      cellClass: "grid-cell-centered",      
	      width: 700,
	      minWidth: 150,
	    },
	    {
	      headerName: "상세내용",
	      field: "comment",
	      filter: 'agTextColumnFilter',
	      width: 350,
	      minWidth: 90,
	      minWidth: 110,
	    },
	    {
		      field: "number_of_k",
		      hide: true
		},
	    {
	      headerName: "분석일",
	      field: "cre_dt",
	      filter: "agDateColumnFilter",
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
	      cellClass: "grid-cell-centered", 
	      width: 150,
	      minWidth: 110
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
		pagination: true,
		paginationPageSize: 20,
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		defaultCsvExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
	
		onCellClicked: params => {
		
			//console.log("cell id : " + params.column.getId());
			//console.log("params : ", params);
			
			if(params.column.getId() != "no"){
				//console.log('cell jobid', params.data.jobid);
				//console.log('cell resultpath', params.data.resultpath);
				
				switch (Number(params.data.status)) {
					case 0:
						//$("#analysis_process").modal('show');
						alert("분석 중입니다.");
						break;
					case 1:
	
						//$("#iframeLoading").modal('show');
						$('#pill1_frame').attr('src', '');
						//$('#pill2_frame').attr('src', '');
						
						document.getElementById('vcf_status').style.display = 'block';
						window.scrollTo(0, document.body.scrollHeight);

						document.getElementById('vcf_status').dataset.jobid = params.data.jobid;
						document.getElementById('vcf_status').dataset.resultpath = params.data.resultpath;
						
						const number_of_k = Number(params.data.number_of_k);
						//$('#pill1_frame').attr('src', `${params.data.resultpath+"/"+params.data.jobid+"/"+params.data.jobid+"_sunburst.html"}`);
						
						const Select_Delta_K = document.getElementById('Select_Delta_K'); 
						Select_Delta_K.textContent = "";
						Select_Delta_K.insertAdjacentHTML('beforeend', `<option></option>`);
						for(let i=1 ; i<=number_of_k ; i++){
							if(i==1) {
								continue;
							}
							Select_Delta_K.insertAdjacentHTML('beforeend', `<option data-number=${i} > ${i} </option>`);
						}
						
						/*
						const Select_Structure_result = document.getElementById('Select_Structure_result');
						Select_Structure_result.textContent = "";
						
						fetch('./structure_html_list.jsp',{
							method: 'POST',
							headers: {
				   				"Content-Type": "application/x-www-form-urlencoded",
				   			},
				   			body: new URLSearchParams({
				   				"jobid": params.data.jobid,
				   			})
						})
						.then((response) => {
							if(!response.ok) {
								throw new Error('Error - ' +response.status);
								$("#iframeLoading").modal('hide');
							} else {
								return response.json();
							}
						})
						.then((data) => {
							//data.sort((a,b) => a.chr>b.chr ? 1 : (a.chr<b.chr ? -1 : 0));
							data.sort((a,b) => {
								
								//Number(a.file_name.substring(a.file_name.indexOf('_K')+2, a.file_name.indexOf('_rep'))) > Number(b.file_name.substring(b.file_name.indexOf('_K')+2, b.file_name.indexOf('_rep'))) ? 1 : (Number(a.file_name.substring(a.file_name.indexOf('_rep')+4, a.file_name.lastIndexOf('_'))) > Number(b.file_name.substring(a.file_name.indexOf('_rep')+4, b.file_name.lastIndexOf('_'))) ? -1 : 0) ; 
								
								const K_a = Number(a.file_name.substring(a.file_name.indexOf('_K')+2, a.file_name.indexOf('_rep')));
								const K_b = Number(b.file_name.substring(b.file_name.indexOf('_K')+2, b.file_name.indexOf('_rep')));
								
								if(K_a > K_b) {
									return 1;
								} else if (K_a < K_b) {
									return -1;
								} else {
									
									const rep_a = Number(a.file_name.substring(a.file_name.indexOf('_rep')+4, a.file_name.lastIndexOf('_')));
									const rep_b = Number(b.file_name.substring(a.file_name.indexOf('_rep')+4, b.file_name.lastIndexOf('_')));
									
									if(rep_a > rep_b) {
										return 1;
									} else if( rep_a < rep_b) {
										return -1;
									} else {
										return 0;
									}
								}
								
								//a.chr>b.chr ? 1 : (a.chr<b.chr ? -1 : 0));
							})
							
							console.log("file list : ", data);
							
							Select_Structure_result.insertAdjacentHTML('beforeend', `<option></option>`);
							for(let i=0 ; i<data.length ; i++){
								Select_Structure_result.insertAdjacentHTML('beforeend', `<option data-file_name=${data[i].file_name} > ${data[i].file_name} </option>`);
							}
						});
						*/
					    
					    break;
					case 2:
						alert("분석에 실패했습니다.");
						break;
					}
				}
			}
		};
	
	// 로딩이 완료되면 로딩창 소멸
	function hideSpinner(target, jobid) {
		if(target.src.includes(jobid)) {
			$("#iframeLoading").modal('hide');
		}
	}
	
	const columnDefs2 = [
	  		{ field: "Chr", width: 212, filter: 'agNumberColumnFilter', },
	  		{ field: "Pos", width: 215, filter: 'agTextColumnFilter', },
	  		{ field: "Impact", width: 220, filter: true, },
	  		{ field: "Effect Classic", width: 220, filter: 'agNumberColumnFilter', },
	  		{ field: "GeneID", width: 220, filter: 'agNumberColumnFilter', },
	  		{ field: "Description", width: 220, filter: 'agNumberColumnFilter', },
	  	];

  	const gridOptions2 = {
		defaultColDef: {
			editable: false, 
		    sortable: true,
			resizable: true,
			cellClass: "grid-cell-centered",
			menuTabs: ['filterMenuTab'],
		},
	  	columnDefs: columnDefs2,
	  	suppressDragLeaveHidesColumns: true,
	  	animateRows: true,
	  	onCellClicked: (params) => {
	  		
	  	},
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
  	
  	/*** FILTER TABLE ***/
  	function updateSearchQuery(val) {
  		gridOptions.api.setQuickFilter(val);
  	}

  	$(".ag-grid-filter").on("keyup", function() {
  		updateSearchQuery($(this).val());
  	});

  	/*** INIT TABLE ***/
 // setup the grid after the page has finished loading
  	document.addEventListener('DOMContentLoaded', () => {
  		/*** DEFINED TABLE VARIABLE ***/
  		const gridTable = document.getElementById("myGrid");
  		new agGrid.Grid(gridTable, gridOptions);
  		
  		/*** GET TABLE DATA FROM URL ***/
  		fetch("./structure_json.jsp?varietyid=" + $("#variety-select option:selected").val() )
  		.then((response) => response.json())
  		.then(data => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		});
  		
  		//const gridTable2 = document.getElementById("snpEffGrid");
  		//new agGrid.Grid(gridTable2, gridOptions2);
  	});
  	
  	$(window).on("resize", function() {
  		gridOptions.api.sizeColumnsToFit();
	  	gridOptions2.api.sizeColumnsToFit();
  	});
  	
  	
  	
  
