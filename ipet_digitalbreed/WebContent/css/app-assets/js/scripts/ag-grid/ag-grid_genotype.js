/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	class CustomTooltip {
		init(params) {
			const eGui = (this.eGui = document.createElement('div'));
			const color = params.color || 'white';
			const data = params.api.getDisplayedRowAtIndex(params.rowIndex).data;
	
			eGui.classList.add('custom-tooltip');
			//@ts-ignore
			eGui.style['background-color'] = color;
			eGui.style['border'] = "1px solid #AAE6E6";
			eGui.innerHTML = `
	            <p style="margin:10px;">
	                <span class"name">${tooltipRenderder(params)} </span>
	            </p>
	        `;
		}
		
		getGui() {
		    return this.eGui;
		}
	}


	function refresh() {
		gridOptions.api.refreshCells(); 
		
		agGrid
	    .simpleHttpRequest({ url: "../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
	    .then(function(data) {
	      gridOptions.api.setRowData(data);
	    });
	}

	function getSelectedRowData() {
		let selectedData = gridOptions.api.getSelectedRows();
		var deleteitems = new Array();
	
		const varietyid = $( "#variety-select option:selected" ).val();
	  
		if(selectedData.length==0){
			alert("선택 된 항목이 없습니다.");	
	    	return;	    		
		}

		for (var i = 0; i < selectedData.length; i++) {
		    deleteitems.push(selectedData[i].selectfiles);
		}    
	  
		//location.href="../../web/database/genotype_delete.jsp?deleteitems="+deleteitems;
	  
		var result = confirm("삭제 된 데이터는 복구 불가능합니다.\n삭제 하시겠습니까?");
	  
		if(result){
	  
			$.ajax({
				url:"../../web/database/genotype_delete.jsp",
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
	}
	
	/*** COLUMN DEFINE ***/
  
	var columnDefs = [
	{
		headerName: "순번",
		field: "displayno",
		maxWidth: 100,
		minWidth: 100,	
		suppressMenu: true,
		checkboxSelection: true,
		headerCheckboxSelectionFilteredOnly: true,
		headerCheckboxSelection: true,
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
    	}
    },
    {
    	headerName: "VCF 파일명",
    	field: "filename",
    	filter: "agTextColumnFilter",
    	width: 500,
    	minWidth:150,
    	cellRenderer: function(params){
    		return params.value+"<a href='/ipet_digitalbreed/"+params.data.uploadpath+params.data.jobid + "/" + params.value + "' download>&nbsp;&nbsp;<i class='feather icon-download'></i></a>";
    	}
    },
    {
    	headerName: "상세내용",
    	field: "comment",
    	filter: "agTextColumnFilter",
    	cellClass: "ag-header-cell-label",
    	width: 470,
    	minWidth:110,
    	cellStyle: {'cursor': 'pointer'}
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
    enableRangeSelection: true,
	suppressMultiRangeSelection: true,
    rowSelection: "multiple",
    pagination: true,
    paginationPageSize: 20,
    pivotPanelShow: "always",
    colResizeDefault: "shift",
    suppressDragLeaveHidesColumns: true,
    animateRows: true,
    //suppressHorizontalScroll: true,
    serverSideInfiniteScroll: true,
	onCellClicked: onCellClicked,
  };
  
  	function onCellClicked(params) {
  		//console.log("onCellClicked params : ", params);
  		
		if(params.column.getId() == "filename" && params.column.getId() == "refgenome"){
			return;
		}
		    
		switch(Number(params.data.status)) {
			case 0:
				alert("분석 중입니다.");
				break;
			case 1:
				const element = document.getElementById('vcf_status');
		   	   	element.innerHTML  = `<div class='card-content'>
		   		   						<div class='card-body'>
		   		   							<div class='row'>
		   		   								<div class='col-12'>
		   		   									<ul class='nav nav-pills nav-active-bordered-pill'>
		   		   										<li class='nav-item'>
		   		   											<a class='nav-link active' id='base-pill31' data-toggle='pill' href='#pill1' aria-expanded='true'>VCF Info</a>
		   		   										</li>
		   		   										<li class='nav-item'>
		   		   											<a class='nav-link' id='base-pill32' data-toggle='pill' href='#pill2' aria-expanded='false'>VCF viewer</a>
		   		   										</li>
		   		   										<li class='nav-item'>
		   		   											<a class='nav-link' id='base-pill33' data-toggle='pill' href='#pill3' aria-expanded='false'>Variant</a>
		   		   										</li>
		   		   										<li class='nav-item'>
		   		   											<a class='nav-link' id='base-pill34' data-toggle='pill' href='#pill4' aria-expanded='false'>DP</a>
		   		   										</li>
		   		   										<li class='nav-item'>
		   		   											<a class='nav-link' id='base-pill35' data-toggle='pill' href='#pill5' aria-expanded='false'>Missing</a>
		   		   										</li>
		   		   									</ul>
		   		   									<div class='tab-content'>
		   		   										<div role='tabpanel' class='tab-pane active' id='pill1' aria-expanded='true' aria-labelledby='base-pill1'>
		   		   											<iframe src = '' loading="lazy" width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill1_frame' onload='gridOptions.api.sizeColumnsToFit();'></iframe>
		   		   										</div>
		   		   										<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
		   		   											<div id='pill2_frame' class="ag-theme-alpine" style='height:501px; margin-top:25px;'></div>
		   		   										</div>
		   		   										<div class='tab-pane' id='pill3' aria-labelledby='base-pill3'>
		   		   											<iframe src = '' loading="lazy" width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill3_frame'></iframe>
		   		   										</div>
		   		   										<div class='tab-pane' id='pill4' aria-labelledby='base-pill4'>
		   		   											<iframe src = '' loading="lazy" width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill4_frame'></iframe>
		   		   										</div>
		   		   										<div class='tab-pane' id='pill5' aria-labelledby='base-pill5'>
		   		   											<iframe src = '' loading="lazy" width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' id='pill5_frame'></iframe>
		   		   										</div>
		   		   									</div>
		   		   								</div>
		   		   							</div>
		   		   						</div>
		   		   					</div>`;
		   	   	replaceClass("base-pill31", "nav-link", "nav-link active");
		   	   	replaceClass("base-pill32", "nav-link", "nav-link");
		   	   	replaceClass("base-pill33", "nav-link", "nav-link");
		   	   	replaceClass("base-pill34", "nav-link", "nav-link");
		   	   	replaceClass("base-pill35", "nav-link", "nav-link");	  
		   	   	
		   	   	$("#base-pill32").data('jobid', params.data.jobid);
		       
		   	   	$('#pill1_frame').attr('height',"130px");
		   	   	$('#pill1_frame').attr( 'src', "/ipet_digitalbreed/web/database/genotype_vcfinfo.jsp?jobid="+params.data.jobid);
		   	   	$('#pill2_frame').empty();
		   	   	print_pill2_frame(params.data.jobid, params.data.variablecnt);
		   	   	$('#pill2_frame').data('jobid',params.data.jobid);
		   	   	$('#pill3_frame').attr('height',"500px");
		   	   	$('#pill3_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_variant.html");
		   	   	$('#pill4_frame').attr('height',"500px");
		   	   	$('#pill4_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_depth.html");
		   	   	$('#pill5_frame').attr('height',"500px");
		   	   	$('#pill5_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_miss.html");
			   
		   	   	//window.scrollTo(0,document.body.scrollHeight);
		   	   	$("html").animate({ scrollTop: $(document).height() }, 1000);
				
				break;
			case 2:
				alert("분석에 실패했습니다.");
				break;
		}
			
			
	}  
  	
	function replaceClass(id, oldClass, newClass) {
	    var elem = $(`#${id}`);
	    if (elem.hasClass(oldClass)) {
	        elem.removeClass(oldClass);
	    }
	    elem.addClass(newClass);
	}

	var columnDefs2 = [{field:"position"}];

	/*** GRID OPTIONS ***/
	var gridOptions2 = {
		defaultColDef: {
			cellClass: "grid-cell-centered", 
		},
		columnDefs: columnDefs2,
	    rowHeight: 35,
	    
	    rowModelType: "infinite",
	    cacheBlockSize: 100,
	    cacheOverflowSize: 2,
	    maxConcurrentDatasourceRequests: 1,
	    infiniteInitialRowCount: 1000,
	    maxBlocksInCache: 10,
	    
	    headerHeight: 120,
	    suppressDragLeaveHidesColumns: true,
	    animateRows: true,
	    suppressFieldDotNotation: true,
	    tooltipShowDelay: 0,
	    tooltipHideDelay: 20000,
	}
	
	
	async function print_pill2_frame(jobid, row_count) {
		
		const header = await fetch(`./genotype_vcfviewer_command.jsp?command=header&jobid=${jobid}`)
								.then((response) => response.text())
								.then((data) => {
									//const row = data.split(",");

									
									const data_arr = data.split(",");
									return data_arr.splice(2,data_arr.length);
									
									//return data.split(",");
								})
		console.log("header : ", header);
	
		// 첫번째 컬럼 filter 대분류(이런식으로 설정하지 않으면 모든 row가 필터에 걸림)
		const filter_arr = await fetch(`./genotype_vcfviewer_command.jsp?command=filter&jobid=${jobid}`)
							.then((response) => response.text())
							.then((data) => {
								const first_row = data.split("\n")
								//console.log(first_row);
								
								let chr_pos = first_row[0].split(",");
								chr_pos.shift();
								//console.log(chr_pos);
								
								let filter = [];
								for(let i=0 ; i< chr_pos.length ; i++) {
									const element = chr_pos[i].substring(0, chr_pos[i].lastIndexOf("_"));
									
									if(!filter.includes(element)){
										filter.push(element);
									}
									//filter.push(chr_pos[i].split("_")[0]);
								}

								//console.log(filter);
								return filter;
							})
		
		
		console.log("filter : ", filter_arr);
		
		let columnDefs2 = [];
		let pill2_frame_width = 0;
		
		const gridTable2 = document.getElementById("pill2_frame");
		const vcfViewerGrid = new agGrid.Grid(gridTable2, gridOptions2);
		
		//Position 컬럼의 filter 정렬 함수
		function filterProcess(a, b) {
			const valA = parseInt(a.replace(/[^0-9]/g,""));
            const valB = parseInt(b.replace(/[^0-9]/g,""));
            if (valA === valB) return 0;
            return valA > valB ? 1 : -1;
		}
		
		for(let i=0 ; i<header.length ; i++) {
			//if(header[i] == 'position') {
			if(header[i] == 'chr_pos') {
				columnDefs2.push({
					headerName: "Position",
					field: header[i],
					filter: true,
					filterParams: { 
						values: filter_arr, 
						comparator: filterProcess // 안하면 filter1, filter10, filter2처럼 정렬됨
					},
					width: 180, 
					menuTabs: ["filterMenuTab"], 
					suppressMovable: true,
					pinned: 'left',
					lockPinned: true,
				});
				pill2_frame_width += 180
			} else {
				columnDefs2.push({
					field: header[i], 
					width: 50, 
					menuTabs: [], 
					tooltipField: header[i], 
					tooltipComponent: CustomTooltip, 
					cellStyle: cellStyle,
				});
				pill2_frame_width += 50
			}
		}
		
		//console.log("pill2_frame_width : ", pill2_frame_width);
		
		//grid 길이가 짧으면 div영역도 축소
		if(pill2_frame_width < 1780) {
			$("#pill2_frame").css('width', pill2_frame_width + 20);
			//$("#pill2_frame").css('width', 6 * 50 + 80);
		}
		
		const datasource = {
				rowCount: undefined,
				getRows: (params) => {
					//console.log(params);
					console.log('asking for ' + params.startRow + ' to ' + params.endRow);
					
					setTimeout(async function() {

						const rowsThisPage = await fetch(`./genotype_vcfviewer_command.jsp?command=rowThisPage&jobid=${jobid}&startRow=${params.startRow}`)
											.then((response) => response.json())
											.then((data) => data);
						
						//console.log(rowsThisPage);
						//row_count = 2228
						
						let lastRow = -1;
						
						if(row_count <= params.endRow) {
							lastRow = Number(row_count);
						}
						
						
						//all_rows = front_arr.concat(rowsThisPage, back_arr);
						
						let all_rows = rowsThisPage.concat(new Array(Number(row_count) - (params.startRow + rowsThisPage.length - 1)));
						
						//console.log(all_rows);
						
						
						//console.log("lastRow : ", lastRow);
						params.successCallback(all_rows, lastRow);
						
						
					}, 100);
				}
		}
		
		gridOptions2.infiniteInitialRowCount = Number(row_count);
		gridOptions2.api.setColumnDefs(columnDefs2);
		gridOptions2.api.setDatasource(datasource);
		
		//'Position' 컬럼을 검색 => 해당 컬럼은 수평처리
		Array.prototype.slice.call(document.querySelectorAll('#pill2_frame .ag-header-cell-label .ag-header-cell-text'))
		.filter((el) => el.textContent === 'Position')[0].style.writingMode = 'horizontal-tb'; 
		
	}
 
	function tooltipRenderder(params) {
		
		const map = new Map([
			["A", "A"], ["C", "C"], ["G", "G"],["T", "T"], ["I", "I"], 
			["R", "A or G"], ["Y", "C or T"], ["M", "A or C"], ["K", "G or T"],
			["S", "C or G"], ["W", "A or T"], ["H", "A or C or T"], ["B", "C or G or T"], 
			["V", "A or C or G"], ["V", "A or C or G"], ["D", "A or G or T"], ["N", "A or C or G or T"]
		]);
		
		if(map.has(params.value)) {
			return map.get(params.value);
		} else {
			return params.value;
		}
	}
	
	function cellStyle(params) {
		const map = new Map([
			/*
			["A", {backgroundColor : '#46FF2D'}], ["C", {backgroundColor : '#F24641'}], ["G", {backgroundColor : '#FFAE01'}],
			["T", {backgroundColor : '#4192FC'}], ["I", {backgroundColor : '#FFFFFF'}], ["R", {backgroundColor : '#FCFC0F'}],
			["Y", {backgroundColor : '#E280EF'}], ["M", {backgroundColor : '#838308'}], ["K", {backgroundColor : '#8A4913'}],
			["S", {backgroundColor : '#FF9D81'}], ["W", {backgroundColor : '#81FFF3'}], ["H", {backgroundColor : '#C0D8FB'}],
			["B", {backgroundColor : '#F7C1C3'}], ["V", {backgroundColor : '#FDE4B9'}], ["D", {backgroundColor : '#C7FFBA'}],
			["N", {backgroundColor : '#E7E7E7'}]
			*/
			["A", {backgroundColor : '#F69A6D'}], ["C", {backgroundColor : '#8BC2C5'}], ["G", {backgroundColor : '#D3BE58'}],
			["T", {backgroundColor : '#A1D191'}], ["I", {backgroundColor : '#E7E7E7'}], ["R", {backgroundColor : '#E7E7E7'}],
			["Y", {backgroundColor : '#E7E7E7'}], ["M", {backgroundColor : '#E7E7E7'}], ["K", {backgroundColor : '#E7E7E7'}],
			["S", {backgroundColor : '#E7E7E7'}], ["W", {backgroundColor : '#E7E7E7'}], ["H", {backgroundColor : '#E7E7E7'}],
			["B", {backgroundColor : '#E7E7E7'}], ["V", {backgroundColor : '#E7E7E7'}], ["D", {backgroundColor : '#E7E7E7'}],
			["N", {backgroundColor : '#E7E7E7'}]
		]);
		
		if(map.has(params.value)) {
			return map.get(params.value);
		} else {
			return null;
		}
	}
	
  /*** DEFINED TABLE VARIABLE ***/
  var gridTable = document.getElementById("myGrid");


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

  document.addEventListener('DOMContentLoaded', () => {
		/*** DEFINED TABLE VARIABLE ***/
		const gridTable = document.getElementById("myGrid");
		const myGrid = new agGrid.Grid(gridTable, gridOptions);
		
		/*** GET TABLE DATA FROM URL ***/
		fetch("../../web/database/genotype_json.jsp?varietyid="+$( "#variety-select option:selected" ).val() )
			.then((response) => {
				response.json().then(data => {
					console.log(data);
					gridOptions.api.setRowData(data);
					gridOptions.api.sizeColumnsToFit();
					
					//console.log(linkedJobid);
					
					if(linkedJobid !== "null") {
						gridOptions.api.forEachNode((rowNode, index) => {
							if(linkedJobid == rowNode.data.jobid) {
								//console.log(rowNode.rowIndex);
								
								gridOptions.api.paginationGoToPage(parseInt( Number(rowNode.rowIndex) / 20 ));
								
								gridOptions.api.ensureIndexVisible(Number(rowNode.rowIndex), 'middle');
								rowNode.setSelected(true);
								
								gridOptions.api.setFocusedCell(Number(rowNode.rowIndex), 'displayno');
								//console.log($("[row-id='0'] [col-id='displayno']"));
								$(`[row-index=${rowNode.rowIndex}] [col-id='displayno']`).trigger("click");
							}
						});	
					} 
				});
			});
	});
  
  	document.addEventListener('click', function(event) {
  		if(event.composedPath()[0].classList.contains("nav-link")) {
  			$("html").animate({ scrollTop: $(document).height() }, 1000);
  		}
  	});

  	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
	});
