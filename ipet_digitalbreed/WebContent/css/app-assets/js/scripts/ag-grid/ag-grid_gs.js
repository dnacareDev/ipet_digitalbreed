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
			filter: true,
			width: 600,
			minWidth: 120,
	    },
	    {
			headerName: "Training Genotype",
			field: "training_genotype",
			filter: true,
			width: 600,
			minWidth: 120,
	    },
	    {
			headerName: "Prediction Genotype",
			field: "prediction_genotype",
			filter: true,
			width: 350,
			minWidth: 120,
	    },
	    {
	    	headerName: "상세내용",
	    	field: "comment",
	    	filter: 'agNumberColumnFilter',
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
						
						document.getElementById('Multiple_Prediction').style.display = params.data.prediction_genotype == "-" ? 'none' : 'block';
						
						document.getElementById('Select-Cross_Validation').innerHTML = `<option hidden disabled selected></option>`;
						document.getElementById('Select-Prediction').innerHTML = `<option hidden disabled selected></option>`;
						document.getElementById('Select-Multiple_Prediction').innerHTML = `<option hidden disabled selected></option>`;
						
						const phenotype_arr = params.data.phenotype.split(",");
						for(let i=0 ; i<phenotype_arr.length ; i++) {
							document.getElementById('Select-Cross_Validation').insertAdjacentHTML('beforeend', `<option data-phenotype="${phenotype_arr[i]}" >${phenotype_arr[i]}</option>`);
							document.getElementById('Select-Prediction').insertAdjacentHTML('beforeend', `<option data-phenotype="${phenotype_arr[i]}" >${phenotype_arr[i]}</option>`);
							document.getElementById('Select-Multiple_Prediction').insertAdjacentHTML('beforeend', `<option data-phenotype="${phenotype_arr[i]}" >${phenotype_arr[i]}</option>`);
						}
						
						gridOptions.api.sizeColumnsToFit();
						
					  	$("html").animate({ scrollTop: $(document).height() }, 1000);
						
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

	function showPlot(value) {
		
		const model_name = $('#model_name').val();
		const resultpath = $('#resultpath').val();
		const jobid_param = $('#jobid_param').val();
		
		//console.log(`iframe#${model_name}`);
		//console.log(resultpath+jobid_param+"/"+`${model_name}_${value}.html`);

		
		
		$("#iframeLoading").modal('show');
		$(`iframe#${model_name}`).attr('src', resultpath+jobid_param+"/"+`${model_name}_${value}.html`);
		
	}

	var columnDefs_multiplePrediction = [
		{
			field: "SNP", 
			width: 180, 
			hide: true, 
		},
		{
			field: "Chr", 
			width: 180, 
		},
		{
			field: "Pos", 
			valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
			width: 120, 
		},
		{
			field: "P-value", 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			width: 120, 
			sortable: true, 
			
		},
		{
			field: "MAF", 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			width: 120, 
		},
		{
			field: "Effect", 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			width: 120, 
		}
	]
	
	var gridOptions_multiplePrediction = {
			defaultColDef: { 
				editable: false, 
				sortable: false, 
				resizable: true,
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: columnDefs_multiplePrediction,
			colResizeDefault: "shift",
			suppressDragLeaveHidesColumns: true,
			rowHeight: 35,
			rowSelection: "single",
			animateRows: true,
			//suppressHorizontalScroll: true,
			serverSideInfiniteScroll: true,
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
	
	//var modelGrid = [];
	function showGrid(value) {
		
		const model_name = $('#model_name').val();
		const resultpath = $('#resultpath').val();
		const jobid_param = $('#jobid_param').val();
		
		//const csv_to_grid = $(`#grid_${model_name}`);
		const csv_to_grid = document.getElementById(`grid_${model_name}`);
		
		try {
			//console.log(csv_to_grid.innerText.trim());
			if(csv_to_grid.innerText.trim()) {
				gridOptions2.api.destroy();
			}
		} catch (error) {
			console.error(error);
		}
		
		
		
		//console.log(`#grid_${model_name}`);
		//console.log("path : ", resultpath+jobid_param+"/GAPIT.Association.GWAS_Results." +model_name+ "." +value+ ".csv");
		
		fetch(resultpath+jobid_param+"/GAPIT.Association.GWAS_Results." +model_name+ "." +value+ ".csv")
		.then((response) => response.blob())
		.then((file) => {
			var reader = new FileReader();
		    reader.onload = function(){
		    	
		    	var fileData = reader.result;
		        var wb = XLSX.read(fileData, {type : 'binary'});
		        var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
		        //console.log("rowObj : ", rowObj);
		        const myGrid = new agGrid.Grid(csv_to_grid, gridOptions2);
		        gridOptions2.api.setRowData(rowObj);
		        gridOptions2.columnApi.autoSizeAllColumns();
		        
		    };
		    reader.readAsBinaryString(file);
		});
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
  		})
  		
  		
  		const varietyid = $( "#variety-select option:selected" ).val();

  		/*** DEFINED TABLE VARIABLE ***/
  		const gridTraitNameTable = document.getElementById("phenotypeSelectGrid");
  		const TraitNameGrid = new agGrid.Grid(gridTraitNameTable, gridOptionsTraitName);
  		
  		/*** GET TABLE DATA FROM URL ***/
  		fetch(`./gwas_traitname.jsp?varietyid=${varietyid}`)
  		.then((response) => response.json())
  		.then((data) => {
  			console.log("traitname : ", data);
  			gridOptionsTraitName.api.setRowData(data);
  			//gridOptionsTraitName.api.sizeColumnsToFit();
  		});
  		
  		new agGrid.Grid(document.getElementById('Model_Grid'), gridOptions_model);
  		gridOptions_model.api.forEachNode((node) => {
  			if(node.data.group == 'BLUP') {
  				node.setSelected(true);
  			}
  		})
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
		
	    if ($(window).width() < 768) {
	      //gridOptions.columnApi.setColumnPinned("email", null);
	    } else {
	     // gridOptions.columnApi.setColumnPinned("email", "left");
	    }
	});
  
	//console.log(gridOptions);
