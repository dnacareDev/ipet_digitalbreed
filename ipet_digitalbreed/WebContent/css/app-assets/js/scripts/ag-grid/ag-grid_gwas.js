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
			filter: true,
			width: 600,
			minWidth: 120,
	    },
	    {
			headerName: "Phenotype",
			field: "phenotype_name",
			filter: true,
			width: 350,
			minWidth: 120,
	    },
	    {
			headerName: "Model",
			field: "model",
			filter: true,
			width: 300,
			minWidth: 100,
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
																<div class="col-12 col-xl-8 style="height:445px; margin-top:25px; float:left;">
																	<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='${model_arr[i]}' onload="$('#iframeLoading').modal('hide')"></iframe>
																</div>
																<div id='grid_${model_arr[i]}' class="col-12 col-xl-4 ag-theme-alpine">
																</div>
															</div>
														</div>`)
							if(i==0) {
								$('#button_list').children().last().children().addClass('active')
								$('#content-list').children().addClass('active');
								$('#resultpath').val(params.data.resultpath);
								$('#jobid_param').val(params.data.jobid);
								//첫번째 모델은 클릭하지 않아도 기본으로 입력
								$('#model_name').val(model_arr[i]);
							}
						}
						
						$('#button_list').append(`<li class='nav-item'><a class='nav-link' id='gwas_Multi' data-toggle='pill' href='#panel_Multi' aria-expanded='true'>Multiple Model</a></li>`);
						$('#content-list').append(`	<div role='tabpanel' class='tab-pane' id='panel_Multi' aria-expanded='true'>
														<div class="row">
														</div>
														<div class="row">
															<div class="col-12 col-xl-12 style="height:445px; margin-top:25px; float:left;">
																<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='Multi' onload="$('#iframeLoading').modal('hide')"></iframe>
															</div>
														</div>
													</div>`)
						
						
						
						$('#button_list').append(`<li class='nav-item'><a class='nav-link' id='gwas_QQ' data-toggle='pill' href='#panel_QQ' aria-expanded='true'>QQ Plot</a></li>`);
						$('#content-list').append(`	<div role='tabpanel' class='tab-pane' id='panel_QQ' aria-expanded='true'>
														<div class="row">
														</div>
														<div class="row">
															<div class="col-12 col-xl-12 style="height:445px; margin-top:25px; float:left;">
																<iframe src = '' height='500px' width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='QQ' onload="$('#iframeLoading').modal('hide')"></iframe>
															</div>
														</div>
													</div>`)
						
						
						$("#param_phenotype").empty();
						$("#param_phenotype").append(`<option value="-1" hidden disabled selected>Select Phenotype</option>`)
						for(let j=0 ; j<phenotype_arr.length ; j++) {
							$("#param_phenotype").append(`<option value="${phenotype_arr[j]}" >${phenotype_arr[j]}</option>`);
							//document.getElementById('param_phenotype').options.add(new Option(phenotype_arr[j], phenotype_arr[j]))
						}
						
						$("#QQ_model").empty();
						$("#QQ_model").append(`<option value="-1" hidden disabled selected>Select Model</option>`)
						for(let j=0 ; j<model_arr.length ; j++) {
							document.getElementById('QQ_model').options.add(new Option(model_arr[j], model_arr[j]))
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

	
	document.addEventListener('click', function(event) {
		if(event.target.id.includes('gwas_')) {
//			$("#param_phenotype").val('-1').trigger('change');
			document.getElementById('param_phenotype').value = '-1';
			document.getElementById('param_phenotype').dispatchEvent(new Event('change'));
			
			document.getElementById('isQQ').value = '-1';
			document.getElementById('isQQ').dispatchEvent(new Event('change'));
			
			document.getElementById('QQ_model').value = '-1';
			document.getElementById('QQ_model').dispatchEvent(new Event('change'));
			
			$('#model_name').val(event.target.id.replaceAll("gwas_",""));
			
			const model_name = $('#model_name').val();
			
			$('iframe').each(function(index, item) {
				item.src = "";
			});
			
			//console.log(document.getElementById('grid_'+model_name));
			if(document.getElementById('grid_'+model_name)) {
				document.getElementById('grid_'+model_name).innerHTML = "";
			}
			
			if( $("#status404") ) {
				$("#status404").remove();						// '표현형과의 유사성을 찾을 수 없습니다' 안내문 제거
			}
			
			if (event.target.id == "gwas_Multi") {
				$("#isQQ").parent().css('display','');
				$("#QQ_model").parent().css('display','none');
			} else if (event.target.id == "gwas_QQ") {
				$("#isQQ").parent().css('display','none');
				$("#QQ_model").parent().css('display','');
			} else {
				$("#isQQ").parent().css('display','none');
				$("#QQ_model").parent().css('display','none');
			}
		} 
	})
	
	/*
	// form-select2_gwas.js 로 넘어가서 현재 아무기능도 없는것으로 보임
	document.querySelector('#param_phenotype').addEventListener('change', function(event) {
		//console.log("param_phenotype changed");
		const value = event.target.value;
		if(value == '-1') {
			return;
		}
		
		//const model_name = $('#model_name').val();
		if( !(model_name == 'Multi' || model_name == 'QQ') ) {
			showPlot(value);
			showGrid(value);
		}
	});
	*/
	
	
	// form-select2_gwas의 'select2:select' 
	// => document.getElementById('isQQ').dispatchEvent(new Event('change'));를 거쳐서 온다. 
	document.querySelector('#isQQ').addEventListener('change', function(event) {
		
		const model_name = $('#model_name').val();
		const value = event.target.value.trim();
		const isQQ = document.getElementById('isQQ').value;
		const param_phenotype = document.getElementById('param_phenotype').value.trim();
		
		if(isQQ == '-1' || param_phenotype == '-1') {
			return;
		}
		
		const resultpath = document.getElementById('resultpath').value;
		const jobid = document.getElementById('jobid_param').value;
		
		//console.log("isQQ : ", isQQ);
		
		
		if( $("#status404") ) {
			$("#status404").remove();						// '표현형과의 유사성을 찾을 수 없습니다' 안내문 제거
		}
		
		$(`iframe#${model_name}`).attr('src', '');		// empty plot
		
		
		let url;
		if(isQQ == "QQ") {
			url = `${resultpath}${jobid}/multi_QQ_${param_phenotype}.html`
		} else {
			url = `${resultpath}${jobid}/multi_${param_phenotype}.html`
		}
		
		fetch(url, {method: "HEAD"})
		.then((response) => response.ok)
		.then((ok) => {
			if(!ok) {
				HTMLNotExist(model_name);
				$("#Multi").height(0);
				return;
			} else {
				$("#Multi").height("500px");					// iframe 높이 정상
				$("#iframeLoading").modal('show');
				$('iframe#Multi').attr('src', url);
			}
		});
		
		
		if(param_phenotype == "-1") {
			alert("특성을 선택해주세요");
			$("#isQQ").val("-1").trigger('change');
		}
		
	});
	
	
	document.querySelector('#QQ_model').addEventListener('change', function(event) {
		
		const value = event.target.value;
		const param_phenotype = document.getElementById('param_phenotype').value.trim();
		const model_name = $('#model_name').val();
		const QQ_model_name = document.getElementById('QQ_model').value;

		if(model_name == '-1' || param_phenotype == '-1') {
			return;
		}
		
		const resultpath = document.getElementById('resultpath').value;
		const jobid = document.getElementById('jobid_param').value;
		
		
		if( $("#status404") ) {
			$("#status404").remove();						// '표현형과의 유사성을 찾을 수 없습니다' 안내문 제거
		}
		
		
		const url = `${resultpath}${jobid}/QQ_${QQ_model_name}_${param_phenotype}.html`;
		
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
		
		if(param_phenotype == "-1") {
			alert("특성을 선택해주세요");
			$("#QQ_model").val("-1").trigger('change');
		}
	})
	
	
	function HTMLNotExist(model_name) {
		$(`iframe#${model_name}`).attr('src', '');		// empty plot
		
		if( (model_name == 'Multi' || model_name == 'QQ') ) {
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
			$(`#panel_${model_name}`).children().children().first().prepend(htmlElement);
			
		} else {
			// Multiple Model, QQ Plot이 아닐 경우
			const htmlElement = `
								<div id="status404">
									<div class="row mt-5">
										<div class="col-xl-6"></div>
										<div class="col-12 col-xl-6 d-flex justify-content-center">
											<svg xmlns="http://www.w3.org/2000/svg" width="180" height="180" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
												<path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
												<line x1="12" y1="9" x2="12" y2="13"></line>
												<line x1="12" y1="17" x2="12.01" y2="17"></line>
											</svg>
										</div>
									</div>
									<div class="row mt-1 mb-5">
										<div class="col-xl-6"></div>
										<div class="col-12 col-xl-6 d-flex justify-content-center" style="font-size:20px; color:black;">
											표현형과의 유사성을 찾을 수 없습니다.
										</div>
									</div>
								</div>
								`;
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

	var columnDefs2 = [
		{field: "SNP", width: 180, hide: true, },
		{field: "Chr", width: 180, },
		{field: "Pos", width: 120, },
		{field: "P-value", width: 120, sortable: true, },
		{field: "MAF", width: 120, },
		{field: "Effect", width: 120, }
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
		        //console.log(csv_to_grid);
		        const myGrid = new agGrid.Grid(csv_to_grid, gridOptions2);
		        gridOptions2.api.setRowData(rowObj);
		        //gridOptions2.api.sizeColumnsToFit();
		        //console.log(document.querySelector(`#grid_${model_name}`));
		        
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
	
	
	
	
	
	
	
	
	
	
	
	
  
