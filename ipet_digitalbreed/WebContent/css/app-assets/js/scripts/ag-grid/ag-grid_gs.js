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
			.simpleHttpRequest({ url: "/ipet_digitalbreed/web/gwas_gs/gs_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
		    	//console.log("data : ", data);
		    	gridOptions.api.setRowData(data);
		    });
		vcfFileList();
		phenotypeList();
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
		    url:"/ipet_digitalbreed/web/gwas_gs/gs_delete.jsp",
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
			field: "no",
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
			headerName: "Phenotype",
			field: "phenotype",
			filter: "agTextColumnFilter",
			width: 600,
			minWidth: 120,
	    },
	    {
			headerName: "Training Genotype",
			field: "training_genotype",
			filter: "agTextColumnFilter",
			width: 600,
			minWidth: 120,
	    },
	    {
			headerName: "Prediction Genotype",
			field: "prediction_genotype",
			filter: "agTextColumnFilter",
			width: 350,
			minWidth: 120,
	    },
	    {
	    	headerName: "상세내용",
	    	field: "comment",
	    	filter: 'agTextColumnFilter',
	    	cellClass: "",
	    	width: 300,
	    	minWidth: 110,
	    },
	    {
	    	headerName: "분석일",
	    	field: "cre_dt",
	    	filter: 'agDateColumnFilter',
	    	filterParams: {
	        	comparator: comparator
	        },
	    	width: 300,
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
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		onCellClicked: params => {
		
			//console.log("cell clicked : " + params.column.getId());
			//console.log("params : ", params);
			
			if(params.column.getId() != "no" && params.column.getId() != "cre_dt"){

				switch (Number(params.data.status)) {
					case 0:
						alert("분석 중입니다.");
						break;
					case 1:
						//console.log('jobid : ', params.data.jobid);
						//console.log('resultpath : ', params.data.resultpath);
						
						$('iframe#iframe-Cross_Validation').attr('src', '');
						$('iframe#iframe-Prediction').attr('src', '');
						document.getElementById('Cross_Validation').click()
						
						document.getElementById('Extra_Card').style.display = 'block';
						
						document.getElementById('Prediction').style.display = params.data.prediction_genotype == "null" ? 'none' : 'block';
						document.getElementById('Grid-Prediction').style.display='none';
						
						document.getElementById('Multiple_Prediction').style.display = params.data.prediction_genotype == "null" || params.data.phenotype.split(",").length<2 ? 'none' : 'block';
						//document.getElementById('iframe-Multiple_Prediction').style.display = 'none';
						$('iframe#iframe-Multiple_Prediction').attr('src', '');
						
						document.getElementById('Select-Cross_Validation').innerHTML = `<option hidden disabled selected></option>`;
						document.getElementById('Select-Prediction').innerHTML = `<option hidden disabled selected></option>`;
						//document.getElementById('Select-Multiple_Prediction').innerHTML = `<option hidden disabled selected></option>`;
						
						const phenotype_arr = params.data.phenotype.split(",");
						for(let i=0 ; i<phenotype_arr.length ; i++) {
							document.getElementById('Select-Cross_Validation').insertAdjacentHTML('beforeend', `<option data-phenotype="${phenotype_arr[i]}" >${phenotype_arr[i]}</option>`);
							document.getElementById('Select-Prediction').insertAdjacentHTML('beforeend', `<option data-phenotype="${phenotype_arr[i]}" data-order="${i}" >${phenotype_arr[i]}</option>`);
							//document.getElementById('Select-Multiple_Prediction').insertAdjacentHTML('beforeend', `<option data-phenotype="${phenotype_arr[i]}" >${phenotype_arr[i]}</option>`);
						}
						
						document.getElementById('Extra_Card').dataset.jobid = params.data.jobid;
						document.getElementById('Extra_Card').dataset.resultpath = params.data.resultpath;
						
						if(params.data.prediction_genotype != "null" &&  params.data.phenotype.split(",").length>=2 ) {
							showMultiPredictionPlot(params.data.phenotype.split(","));
						}
						
						
						gridOptions.api.sizeColumnsToFit();
						
					  	//$("html").animate({ scrollTop: $(document).height() }, 1000);
						window.scrollTo(0, document.body.scrollHeight);
						
						break;
					case 2:
						alert("분석에 실패했습니다.");
						break;
				}

			} 
		}
	};


	
	
	
	function HTMLNotExist(model_name) {
		$(`iframe#${model_name}`).attr('src', '');		// empty plot
		
		const htmlElement = `
							<div id="status404">
								<div class="row mt-5">
									<div class="col-12 d-flex justify-content-center">
										<svg xmlns="http://www.w3.org/2000/svg" width="180" height="180" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
											<path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
											<line x1="12" y1="9" x2="12" y2="13"></line>
											<line x1="12" y1="17" x2="12.01" y2="17"></line>
										</svg>
									</div>
								</div>
								<div class="row mt-1 mb-5">
									<div class="col-12 d-flex justify-content-center" style="font-size:20px; color:black;">
										표현형과의 유사성을 찾을 수 없습니다.
									</div>
								</div>
							</div>
							`;
		
		if( (model_name == 'Multi' || model_name == 'QQ') ) {
			$(`#panel_${model_name}`).children().append(htmlElement);
		} else {
			$(`#panel_${model_name}`).children().children().first().prepend(htmlElement);
		}
	}

	const columnDefs_prediction = [];
	const gridOptions_prediction = {
			defaultColDef: {
				editable: false, 
				filter: true,
			    rezible: true,
			    sortable: true,
			    //suppressMenu: true,
			    cellClass: "grid-cell-centered", 
			    menuTabs: ['filterMenuTab'], 
			},
			//columnDefs: columnDefs_prediction,
			rowHeight: 35,
			rowSelection: "single",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			animateRows: true,
			suppressHorizontalScroll: true,
	}
	
	const columnDefs_multiplePrediction = [];
	const gridOptions_multiplePrediction = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true,
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			//columnDefs: columnDefs_multiplePrediction,
			colResizeDefault: "shift",
			suppressDragLeaveHidesColumns: true,
			rowHeight: 35,
			rowMultiSelectWithClick: true,
			rowSelection: "multiple",
			animateRows: true,
			//suppressHorizontalScroll: true,
			serverSideInfiniteScroll: true,
			onRowSelected: (params) => {
				
				const rows = gridOptions_multiplePrediction.api.getSelectedRows(); 
				
				if(rows.length == 0) {
					$('iframe#iframe-Multiple_Prediction').attr('src', '');
					return;
				}
				
				if(rows.length > 10) {
					params.node.setSelected(false);
					return alert("10개까지만 선택 가능합니다.");
				}
				
				$("#Loading").modal('show');
				
				const jobid = document.getElementById('Extra_Card').dataset.jobid;
				const resultpath = document.getElementById('Extra_Card').dataset.resultpath;
				
				let selected_row_index = ""
				for(let i=0 ; i<rows.length ; i++) {
					selected_row_index += rows[i]['__rowNum__'];
					if(i != rows.length -1) {
						selected_row_index += ",";
					}
				}
				
				//console.log(selected_row_index);
				
				setTimeout(() => {
					fetch(`./gs_spyderPlot.jsp?jobid=${jobid}&selected_row=${selected_row_index}`)
					.then((response) => {
						if(!response.ok) {
							$("#Loading").modal('hide');
							throw new Error('Error - ' +response.status);
						} else {
							return response.text();
						}
					})
					.then((data) => {
						const url = `${resultpath+jobid}/spyder.html`;
						//$('iframe#iframe-Multiple_Prediction').attr('src', '');
						//document.getElementById('iframe-Multiple_Prediction').style.display = 'block';
						
						$('iframe#iframe-Multiple_Prediction').attr('src', url);
						
						
						
						/*
						setTimeout(function() {
							$('iframe#iframe-Multiple_Prediction').attr('src', url);
						}, 2000)
						*/
					})
				}, 3000);
				
				
			},
			/*
			onFirstDataRendered: (params) => {
				
				const jobid = document.getElementById('Extra_Card').dataset.jobid;
				const resultpath = document.getElementById('Extra_Card').dataset.resultpath;
				
				//$('iframe#iframe-Multiple_Prediction').attr('src', '');
				fetch(`./gs_spyderPlot.jsp?jobid=${jobid}&selected_row=`)
				.then((response) => {
					if(!response.ok) {
						throw new Error('Error - ' +response.status);
					} else {
						return response.text();
					}
				})
				.then((data) => {
					const url = `${resultpath+jobid}/spyder.html`;
					//$('iframe#iframe-Multiple_Prediction').attr('src', '');
					//sleep(200);
					$('iframe#iframe-Multiple_Prediction').attr('src', url);
				})
			}
			 */
			
	}
	
	var columnDefsTraitName = [
		{ 	
			headerName:'특성', 
			field: "traitname",
			menuTabs: ["filterMenuTab"], 
			width: 420, 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			cellClass: "grid-cell-centered", 
		},
		{
			field: "traitname_key",
			hide:true
		}
	];
	var gridOptionsTraitName = {
			defaultColDef: {
				editable: false, 
			    sortable: true,
			    filter: true,
			},
			columnDefs: columnDefsTraitName,
			rowHeight: 35,
			rowSelection: "multiple",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			animateRows: true,
			suppressHorizontalScroll: true,
	}
	
	const columnDefs_model = [
		{
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			minWidth: 50,
			maxWidth: 50,
		},
		{
			field: 'model',
		},
		{
			field : 'group'
		},
	];
	
	const gridOptions_model = {
			defaultColDef: {
				editable: false, 
				filter: true,
			    rezible: true,
			    sortable: true,
			    //suppressMenu: true,
			    cellClass: "grid-cell-centered", 
			},
			columnDefs: columnDefs_model,
			rowData: [
				{'model': 'GBLUP', 'group': 'BLUP'}, 
				{'model': 'EGBLUP', 'group': 'BLUP'}, 
				{'model': 'RR', 'group': 'BLUP'}, 
				{'model': 'LASSO', 'group': 'BLUP'}, 
				{'model': 'EN', 'group': 'BLUP'}, 
				{'model': 'BRR', 'group': 'Bayesian'}, 
				{'model': 'BL', 'group': 'Bayesian'}, 
				{'model': 'BA', 'group': 'Bayesian'}, 
				{'model': 'BB', 'group': 'Bayesian'}, 
				{'model': 'BC', 'group': 'Bayesian'}, 
				{'model': 'RKHS', 'group': 'Semi-parametic'},
				{'model': 'RF', 'group': 'Semi-parametic'},
				{'model': 'SVM', 'group': 'Semi-parametic'},
			],
			rowHeight: 35,
			rowSelection: "multiple",
			rowMultiSelectWithClick: true,
			suppressMultiRangeSelection: true,
			animateRows: true,
			suppressHorizontalScroll: true,
			onRowSelected: (params) => {
				const group = params.data.group;
				const group_id = document.getElementById(group);
				const all_nodes = gridOptions_model.api.getModel().nodeManager.allNodesMap;
				
				group_id.checked = true;
				//for(let i=0 ; i<all_nodes.length ; i++) {
				for(let i=0 ; i<Object.keys(all_nodes).length ; i++) {
					if(all_nodes[i].data.group != group) {
						continue;
					}
					
					if(all_nodes[i].selected == false) {
						group_id.checked = false;
						break;
					}
				}
				//debugger;
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
  		fetch("/ipet_digitalbreed/web/gwas_gs/gs_json.jsp?varietyid="+$( "#variety-select option:selected" ).val() )
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
						
						document.querySelector(`[row-index="${rowNode.rowIndex}"] [col-id='status']`).click();
					}
				});	
			}
  		})
  		
  		
  		const varietyid = $( "#variety-select option:selected" ).val();

  		/*** DEFINED TABLE VARIABLE ***/
  		const gridTraitNameTable = document.getElementById("phenotypeSelectGrid");
  		const TraitNameGrid = new agGrid.Grid(gridTraitNameTable, gridOptionsTraitName);
  		
  		/*
  		fetch(`./gwas_traitname.jsp?varietyid=${varietyid}`)
  		.then((response) => response.json())
  		.then((data) => {
  			console.log("traitname : ", data);
  			gridOptionsTraitName.api.setRowData(data);
  			//gridOptionsTraitName.api.sizeColumnsToFit();
  		});
  		*/
  		
  		new agGrid.Grid(document.getElementById('Grid-Prediction'), gridOptions_prediction);
  		new agGrid.Grid(document.getElementById('Grid-Multiple_Prediction'), gridOptions_multiplePrediction);
  		
  		new agGrid.Grid(document.getElementById('Model_Grid'), gridOptions_model);
  		modelCheckList();
  	});

	/*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
		gridOptionsTraitName.api.sizeColumnsToFit();
		
	});
  
	//console.log(gridOptions);
