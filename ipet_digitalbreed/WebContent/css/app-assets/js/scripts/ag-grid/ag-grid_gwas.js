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
		  
		for (var i = 0; i < selectedData.length; i++) {
		    deleteitems.push(selectedData[i].no);
		}
		
		//console.log("delete row : ", deleteitems);
		
		$.ajax(
		{
		    url:"/ipet_digitalbreed/web/gwas_gs/gwas_delete.jsp",
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
			width: 160,
			filter: 'agMultiColumnFilter',
			cellClass: "grid-cell-centered",      
			checkboxSelection: true,
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true
	    },
	    {
		    headerName: "분석상태",
		    field: "status",
		    width: 150,
		    filter: true,
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
			headerName: "Genotype",
			field: "genotype_filename",
			filter: true,
			cellClass: "grid-cell-centered",      
			width: 400,
	    },
	    {
			headerName: "Phenotype",
			field: "phenotype_name",
			filter: true,
			cellClass: "grid-cell-centered",      
			width: 300,
	    },
	    {
			headerName: "Model",
			field: "model",
			filter: true,
			cellClass: "grid-cell-centered",      
			width: 300,
	    },
	    {
	    	headerName: "상세내용",
	    	field: "comment",
	    	filter: 'agNumberColumnFilter',
	    	cellClass: "grid-cell-centered",      
	    	width: 400
	    },
	    {
	    	headerName: "분석일",
	    	field: "cre_dt",
	    	filter: 'agNumberColumnFilter',
	    	width: 350,
	    	cellClass: "grid-cell-centered", 
	    	//cellEditor: DatePicker,
	    	//cellEditorPopup: true
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
		animateRows: true,
		suppressHorizontalScroll: true,
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
	
	document.querySelector('#param_phenotype').addEventListener('change', function(event) {
		//console.log("param_phenotype changed");
		const value = event.target.value;
		if(value == '-1') {
			return;
		}

		const model_name = $('#model_name').val();
		if( !(model_name == 'Multi' || model_name == 'QQ') ) {
			showPlot(value);
			showGrid(value);
		}
	});
	
	// form-select2_gwas의 'select2:select' 
	// => document.getElementById('isQQ').dispatchEvent(new Event('change'));를 거쳐서 온다. 
	document.querySelector('#isQQ').addEventListener('change', function(event) {
		
		const value = event.target.value;
		const isQQ = document.getElementById('isQQ').value;
		const param_phenotype = document.getElementById('param_phenotype').value;
		
		if(isQQ == '-1') {
			return;
		}
		
		const resultpath = document.getElementById('resultpath').value;
		const jobid = document.getElementById('jobid_param').value;
		
		//console.log("isQQ : ", isQQ);
		
		if(param_phenotype == "-1") {
			alert("특성을 선택해주세요");
			$("#isQQ").val("-1").trigger('change');
		} else {
			if(isQQ == "QQ") {
				$("#iframeLoading").modal('show');
				$('iframe#Multi').attr('src', `${resultpath}${jobid}/multi_QQ_${param_phenotype}.html`);
			} else {
				$("#iframeLoading").modal('show');
				$('iframe#Multi').attr('src', `${resultpath}${jobid}/multi_${param_phenotype}.html`);
			}
		}
	});
	
	document.querySelector('#QQ_model').addEventListener('change', function(event) {
		const value = event.target.value;
		const param_phenotype = document.getElementById('param_phenotype').value;
		const model_name = document.getElementById('QQ_model').value;

		if(model_name == '-1') {
			return;
		}
		
		const resultpath = document.getElementById('resultpath').value;
		const jobid = document.getElementById('jobid_param').value;
		
		if(param_phenotype == "-1") {
			alert("특성을 선택해주세요");
			$("#QQ_model").val("-1").trigger('change');
		} else {
			$("#iframeLoading").modal('show');
			$('iframe#QQ').attr('src', `${resultpath}${jobid}/QQ_${model_name}_${param_phenotype}.html`);
		}
	})
	
	
	

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
		{field: "SNP",cellClass: "grid-cell-centered", width: 110, resizable: true, hide: true, },
		{field: "Chr",cellClass: "grid-cell-centered", width: 80,  resizable: true,},
		{field: "Pos",cellClass: "grid-cell-centered", width: 90,  resizable: true,},
		{field: "P-value",cellClass: "grid-cell-centered", width: 90, sortable: true, resizable: true,},
		{field: "MAF",cellClass: "grid-cell-centered", width: 80, resizable: true,},
		{field: "Effect",cellClass: "grid-cell-centered", width: 90, resizable: true,}]
	
	var gridOptions2 = {
			columnDefs: columnDefs2,
			colResizeDefault: "shift",
			rowHeight: 35,
			rowSelection: "single",
			animateRows: true,
			suppressHorizontalScroll: true,
			serverSideInfiniteScroll: true,
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
		        //modelGrid[model_name] = new agGrid.Grid(csv_to_grid, gridOptions2);
		        gridOptions2.api.setRowData(rowObj);
		        gridOptions2.api.sizeColumnsToFit();
		        //console.log(document.querySelector(`#grid_${model_name}`));
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

	/*** GET TABLE DATA FROM URL ***/
/*
  	agGrid
		.simpleHttpRequest({ url: "/ipet_digitalbreed/web/gwas_gs/gwas_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		.then(function(data) {
		console.log("data : ", data);
		
		gridOptions.api.setRowData(data);
		gridOptions.api.sizeColumnsToFit();
	});
*/	
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
			.then((response) => {
				response.json().then(data => {
					console.log(data);
					gridOptions.api.setRowData(data);
					gridOptions.api.sizeColumnsToFit();
				});
			});
  	});

	/*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/
	
	
	
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
		
	    if ($(window).width() < 768) {
	      //gridOptions.columnApi.setColumnPinned("email", null);
	    } else {
	     // gridOptions.columnApi.setColumnPinned("email", "left");
	    }
	});
  
	//console.log(gridOptions);
	
	
	
	
	
	
	
	
	
	
	
	
  
