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
			.simpleHttpRequest({ url: "/ipet_digitalbreed/web/gwas_gs/gwas_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
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
		    url:"/ipet_digitalbreed/web/gwas_gs/gwas_delete.jsp",
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
			headerName: "Genotype",
			field: "genotype_filename",
			filter: "agTextColumnFilter",
			width: 600,
			minWidth: 120,
	    },
	    {
			headerName: "Phenotype",
			field: "phenotype_name",
			filter: "agTextColumnFilter",
			width: 350,
			minWidth: 120,
	    },
	    {
			headerName: "Model",
			field: "model",
			filter: "agTextColumnFilter",
			width: 300,
			minWidth: 100,
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
		pivotPanelShow: "always",
		colResizeDefault: "shift",
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		//suppressHorizontalScroll: true,
		serverSideInfiniteScroll: true,
		
		defaultCsvExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		defaultExcelExportParams:{
			columnKeys:["no","status","cre_dt"]
		},
		
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
						//console.log("model : ", params.data.model)
						
						const model_arr = params.data.model.split(", ");
						//console.log("model[] : ", model_arr);
						
						const phenotype_arr = params.data.phenotype_name.split(",");
						//console.log("phenotype[] : ", phenotype_arr);
						
						$("#gwas_status").css('display','block');
						
						$("#button_list").empty();
						$("#content-list").empty();
						for(let i=0 ; i<model_arr.length ; i++) {
							$('#button_list').append(`<li class='nav-item'><a class='nav-link' id='gwas_${model_arr[i]}' data-toggle='pill' href='#panel_${model_arr[i]}' aria-expanded='true'>${model_arr[i]}</a></li>`);
							$('#content-list').append(`	<div role='tabpanel' class='tab-pane' id='panel_${model_arr[i]}' aria-expanded='true'>
															<div class="row">
																<div class="col-12 col-xl-8 mb-1">
																	<select id='${model_arr[i]}_phenotype' class='select2 form-select float-left' data-width="200px" onchange="showPlotAndGrid(this.options[this.selectedIndex].value);  ">
																	</select>
																</div>
																<div id="cutOffDiv_${model_arr[i]}" class="col-12 col-xl-4 pl-0 mb-1 justify-content-start" style="display:none;">
																	<div class="col-3 col-xl-10" style="max-width:24%; min-width:228px;">
																		<input type="text" id='cutOffValue_${model_arr[i]}' class='form-control' placeholder='cut off value (-log10(P))' oninput="this.value = this.value.replace(/[^0-9.]/g, '').replace(/(\\..*)\\./g, '$1'); if(this.value<0)this.value=0;" >
																	</div>
																	<div class="col-2">
																		<button class="btn btn-primary" data-model="${model_arr[i]}" onclick="const selectEl = document.getElementById('${model_arr[i]}_phenotype'); 
																																				const phenotype = selectEl.options[selectEl.selectedIndex].value; 
																																				const cutOffValue = Number(document.getElementById('cutOffValue_${model_arr[i]}').value); 
																																				if(validCheckCutOff(this.dataset.model, cutOffValue, phenotype)) {
																																					updateCutOff(this.dataset.model, cutOffValue, phenotype);
																																					showGrid(phenotype, cutOffValue);
																																				} ">cutoff</button>
																	</div>
																</div>
															</div>
															<div class="row">
																<div class="col-12 col-xl-8 style="height:445px; margin-top:25px; float:left;">
																	<iframe src = '' height='550px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='${model_arr[i]}' onload="$('#iframeLoading').modal('hide')"></iframe>
																</div>
																<div id='grid_${model_arr[i]}' class="col-12 col-xl-4 ag-theme-alpine">
																</div>
															</div>
														</div>`);
							if(i==0) {
								$('#button_list').children().last().children().addClass('active')
								$('#content-list').children().addClass('active');
								$('#resultpath').val(params.data.resultpath);
								$('#jobid_param').val(params.data.jobid);
								//첫번째 모델은 클릭하지 않아도 기본으로 클릭
								$('#model_name').val(model_arr[i]);
							}
							
							//$(`#${model_arr[i]}_phenotype`).append(`<option value="-1"></option>`)
							$(`#${model_arr[i]}_phenotype`).append(`<option value="-1" hidden disabled selected>Select Phenotype</option>`)
							for(let j=0 ; j<phenotype_arr.length ; j++) {
								$(`#${model_arr[i]}_phenotype`).append(`<option value="${phenotype_arr[j]}" >${phenotype_arr[j]}</option>`)
							}
						}
						
						$('#button_list').append(`<li class='nav-item'><a class='nav-link' id='gwas_Multi' data-toggle='pill' href='#panel_Multi' aria-expanded='true'>Multiple Model</a></li>`);
						$('#content-list').append(`	<div role='tabpanel' class='tab-pane' id='panel_Multi' aria-expanded='true'>
														<div class="row">
															<div class="col-2" style="max-width:12%;">
																<select id='Multi_phenotype' class='select2 form-select float-left' onchange="showMultiPlot();">
																	<option value="-1" hidden disabled selected>Select Phenotype</option>
																</select>
															</div>
															<!--
															<div class="col-2" style="max-width:12%;">
																<select id='isQQ' class='select2 form-select ml-1 mb-1 float-left' onchange="showMultiPlot();">
																	<option value='-1' hidden disabled selected>Select plot type</option>
																	<option value='QQ'>QQ plot</option>
																	<option value='noQQ'>Manhattan plot</option>
																</select>
															</div>
															-->
														</div>
														<div class="row">
															<div class="col-12 col-xl-12 style="height:445px; margin-top:25px; float:left;">
																<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='Multi' onload="$('#iframeLoading').modal('hide')"></iframe>
															</div>
														</div>
													</div>`)
						
						for(let i=0 ; i<phenotype_arr.length ; i++) {
							$(`#Multi_phenotype`).append(`<option value="${phenotype_arr[i]}" >${phenotype_arr[i]}</option>`)
						}
						
						
						$('#button_list').append(`<li class='nav-item'><a class='nav-link' id='gwas_QQ' data-toggle='pill' href='#panel_QQ' aria-expanded='true'>QQ Plot</a></li>`);
						$('#content-list').append(`	<div role='tabpanel' class='tab-pane' id='panel_QQ' aria-expanded='true'>
														<div class="row">
															<div class="col-2" style="max-width:12%;">
																<select id='QQ_phenotype' class='select2 form-select float-left' onchange="showQQPlot()">
																	<option value="-1" hidden disabled selected>Select Phenotype</option>
																</select>
															</div>
															<div class="col-2" style="max-width:12%;">
																<select id='QQ_model' class='select2 form-select ml-1 mb-1 float-left' onchange="showQQPlot()">
																	<option value='-1' hidden disabled selected>Select Model</option>
																</select>
															</div>
														</div>
														<div class="row">
															<div class="col-12 col-xl-12 style="height:445px; margin-top:25px; float:left;">
																<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='QQ' onload="$('#iframeLoading').modal('hide')"></iframe>
															</div>
														</div>
													</div>`)
						
						for(let i=0 ; i<phenotype_arr.length ; i++) {
							$(`#QQ_phenotype`).append(`<option value="${phenotype_arr[i]}" >${phenotype_arr[i]}</option>`)
						}
						
						for(let i=0 ; i<model_arr.length ; i++) {
							$(`#QQ_model`).append(`<option value="${model_arr[i]}" >${model_arr[i]}</option>`)
						}
													
						jQuery(".tab-pane .select2").select2({
							dropdownAutoWidth: true,
							width: '100%',
						});
						
						gridOptions.api.sizeColumnsToFit();
						
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
			//$(`#panel_${model_name}`).children().children().first().prepend(htmlElement);
			$(`#panel_${model_name}`).children().append(htmlElement);
			
		} else {
			// Multiple Model, QQ Plot이 아닐 경우
			$(`#panel_${model_name}`).children().children().first().prepend(htmlElement);
		}
	}

	
	function showPlot(value) {
		
		//const model_name = $('#model_name').val();
		const model_name = document.querySelector(`.nav-link.active`).textContent;
		const resultpath = $('#resultpath').val();
		const jobid_param = $('#jobid_param').val();
		
		//console.log(`iframe#${model_name}`);
		//console.log(resultpath+jobid_param+"/"+`${model_name}_${value}.html`);

		
		
		$("#iframeLoading").modal('show');
		$(`iframe#${model_name}`).attr('src', resultpath+jobid_param+"/"+`${model_name}_${value}.html`);
		
	}
	
	function showMultiPlot() {
		
		const multi_phenotype = document.getElementById('Multi_phenotype').value;
		/*
		const multi_isQQ = document.getElementById('isQQ').value;
		
		if(multi_phenotype == "-1" || multi_isQQ == "-1") {
			return;
		}
		*/
		if(multi_phenotype == "-1") {
			return;
		}
		
		//const model_name = document.getElementById('model_name').value;
		const model_name = document.querySelector(`.nav-link.active`).textContent;
		const resultpath = document.getElementById('resultpath').value;
		const jobid = document.getElementById('jobid_param').value;
		
		//console.log("isQQ : ", isQQ);
		
		/*
		if( $("#status404") ) {
			$("#status404").remove();						// '표현형과의 유사성을 찾을 수 없습니다' 안내문 제거
		}
		*/
		$(`iframe#Multi`).attr('src', '');		// empty plot
		
		/*
		let url;
		if(multi_isQQ == "QQ") {
			url = `${resultpath}${jobid}/multi_QQ_${multi_phenotype}.html`
		} else {
			url = `${resultpath}${jobid}/multi_${multi_phenotype}.html`
		}
		*/
		const url = `${resultpath}${jobid}/multi_${multi_phenotype}.html`
		
		/*
		fetch(url, {method: "HEAD"})
		.then((response) => response.ok)
		.then((ok) => {
			if(!ok) {
				HTMLNotExist(model_name);
				//$("#Multi").height(0);
				return;
			} else {
				//$("#Multi").height("500px");					// iframe 높이 정상
				$("#iframeLoading").modal('show');
				$('iframe#Multi').attr('src', url);
			}
		});
		*/
		fetch(url, {method: "HEAD"})
		.then((response) => {
			if(!response.ok) {
				//HTMLNotExist("Multi");
				//$("#Multi").height(0);
			} else {
				//$("#Multi").height("500px");
				$("#iframeLoading").modal('show');
				$('iframe#Multi').attr('src', url);
			}
		})
	}
	
	function showQQPlot() {
		
		const QQ_phenotype = document.getElementById('QQ_phenotype').value;
		const QQ_model = document.getElementById('QQ_model').value;
		
		if(QQ_phenotype == "-1" || QQ_model == "-1") {
			return;
		}
		
		//const value = event.target.value;
		//const param_phenotype = document.getElementById('param_phenotype').value.trim();
		//const model_name = $('#model_name').val();
		//const QQ_model_name = document.getElementById('QQ_model').value;
		/*
		if(model_name == '-1' || param_phenotype == '-1') {
			return;
		}
		*/
		const resultpath = document.getElementById('resultpath').value;
		const jobid = document.getElementById('jobid_param').value;
		
		/*
		if( $("#status404") ) {
			$("#status404").remove();						// '표현형과의 유사성을 찾을 수 없습니다' 안내문 제거
		}
		*/
		
		const url = `${resultpath}${jobid}/QQ_${QQ_model}_${QQ_phenotype}.html`;
		/*
		fetch(url, {method: "HEAD"})
		.then((response) => response.ok)
		.then((ok) => {
			if(!ok) {
				HTMLNotExist(model_name);
				$("#QQ").height(0);
				return;
			} else {
				$("#QQ").height("500px");					// iframe 높이 정상
				$("#iframeLoading").modal('show');
				$('iframe#QQ').attr('src', url);
			}
		});
		*/
		
		fetch(url, {method: "HEAD"})
		.then((response) => {
			if(!response.ok) {
				//HTMLNotExist("Multi");
				//$("#Multi").height(0);
			} else {
				//$("#Multi").height("500px");
				$("#iframeLoading").modal('show');
				$('iframe#QQ').attr('src', url);
			}
		})
		
		//console.log("QQ process");
	}

	var columnDefs2 = [
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
			headerName: "-log10(P)",
			field: "P-value", 
			//valueFormatter: (params) => Number(params.value).toFixed(5),
			valueFormatter: (params) => -Math.log10(Number(params.value)).toFixed(5),
			comparator: (valueA, valueB, nodeA, nodeB, isDescending) => (-Math.log10(Number(valueA)) == -Math.log10(Number(valueB))) ? 0 : (-Math.log10(Number(valueA)) > -Math.log10(Number(valueB))) ? 1 : -1,
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
	
	var gridOptions2 = {
			defaultColDef: { 
				editable: false, 
				sortable: false, 
				resizable: true,
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: columnDefs2,
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
	
	//var modelGrid = [];
	//function showGrid(value) {
	function showGrid(value, cutOff = -1) {
		
		//const model_name = $('#model_name').val();
		const model_name = document.querySelector(`.nav-link.active`).textContent;
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
		
		const params = new URLSearchParams({
			"model_name" : model_name,
			"phenotype": value,
			"jobid_param" : jobid_param,
			"cutOff": cutOff,
		});
		
		
		fetch(`./gwas_gapit.jsp`, {
			method: "POST",
   			headers: {
   				"Content-Type": "application/x-www-form-urlencoded; charset=utf-8",
   			},
   			body: params,
		})
		.then((response) => {
			if(response.ok) {
				//return response.text();
				return response.json();
			} else {
				throw new Error('error : status ', response.status);
			}
		})
		.then((data) => {
			console.log(data);
			
			//cut off Div display
			//document.getElementById('cutOffDiv').style.display = "flex";
			document.getElementById(`cutOffDiv_${model_name}`).style.display = 'flex';
			
			const myGrid = new agGrid.Grid(csv_to_grid, gridOptions2);
	        gridOptions2.api.setRowData(data);
	        gridOptions2.columnApi.autoSizeAllColumns();
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
  		fetch("/ipet_digitalbreed/web/gwas_gs/gwas_json.jsp?varietyid="+$( "#variety-select option:selected" ).val() )
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
  	});

	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
		gridOptionsTraitName.api.sizeColumnsToFit();
	});
  
	//console.log(gridOptions);
	
	
	
	
	
	
	
	
	
	
	
	
  
