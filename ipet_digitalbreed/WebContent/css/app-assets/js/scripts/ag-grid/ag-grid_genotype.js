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
  	  }
	
  /*** COLUMN DEFINE ***/
  
  var columnDefs = [
      {
      headerName: "순번",
      field: "displayno",
      width: 140,	
      filter: 'agMultiColumnFilter',
      cellClass: "grid-cell-centered",      
      checkboxSelection: true,
      headerCheckboxSelectionFilteredOnly: true,
      headerCheckboxSelection: true,
    },
    {
      headerName: "실제순번",
      field: "selectfiles",
      hide: true,	
    },
    /**{
      headerName: "VCF 파일 다운로드",
      field: "fileid",
      editable: false,
      sortable: true,
      filter: 'agMultiColumnFilter',
      cellClass: "grid-cell-centered",      
      width: 175,
      resizable: true,
      cellRenderer: function(params){
      return "<a href='http://example.com/edit/" 
        + params.value 
        + "'>link "+params.value+"</a>";
    }
    },**/
    {
      headerName: "VCF 파일명",
      field: "filename",
      filter: true,
      cellClass: "grid-cell-centered",      
      width: 500,
	  cellRenderer: function(params){
      return params.value+"<a href='../public/filedownloader.jsp?resultpath="+params.data.uploadpath+params.data.jobid+"/&filename="
        + params.value 
        + "'>&nbsp;&nbsp;<i class='feather icon-download'></i></a>";
    }
    },
    {
      headerName: "상세내용",
      field: "comment",
      filter: true,
      cellClass: "ag-header-cell-label",
      width: 470,
      cellStyle: {'cursor': 'pointer'}
    },
    {
      headerName: "작물",
      field: "cropid",
      filter: true,
      cellClass: "grid-cell-centered",      
      width: 180,
      hide: true
    },
    {
      headerName: "등록일자",
      field: "cre_dt",
      filter: 'agDateColumnFilter',
      cellClass: "grid-cell-centered",      
      width: 150
    },
    {
      headerName: "참조유전체",
      field: "refgenome",
      filter: true,
      cellClass: "grid-cell-centered",      
      width: 275,
    },
    {
      headerName: "샘플수",
      field: "samplecnt",
      filter: 'agNumberColumnFilter',
      cellClass: "grid-cell-centered",      
      width: 120
    },
    {
      headerName: "변이수",
      field: "variablecnt",
      filter: 'agNumberColumnFilter',
      cellClass: "grid-cell-centered",      
      width: 120
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
    enableRangeSelection: true,
	suppressMultiRangeSelection: true,
    rowSelection: "multiple",
    //pagination: true,
    //paginationPageSize: 20,
    pivotPanelShow: "always",
    colResizeDefault: "shift",
    animateRows: true,
    suppressHorizontalScroll: true,
    serverSideInfiniteScroll: true,
	onCellClicked: onCellClicked,
  };
  
  	function onCellClicked(params) {
  		//console.log("onCellClicked params : ", params);
  		
		if(params.column.getId() != "filename" && params.column.getId() != "refgenome"){
		   const element = document.getElementById('vcf_status');
	   	   element.innerHTML  = `<div class='card-content'>
	   		   						<div class='card-body'>
	   		   							<div class='row'>
	   		   								<div class='col-12'>
	   		   									<ul class='nav nav-pills nav-active-bordered-pill'>
	   		   										<li class='nav-item'>
	   		   											<a class='nav-link' id='base-pill31' data-toggle='pill' href='#pill1' aria-expanded='true'>VCF Info</a>
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
	   		   											<iframe src = '' loading="lazy" width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill1_frame' id='pill1_frame'></iframe>
	   		   										</div>
	   		   										<div class='tab-pane' id='pill2' aria-labelledby='base-pill2'>
	   		   											<div id='pill2_frame' class="ag-theme-alpine" style='height:501px; margin-top:25px;'></div>
	   		   										</div>
	   		   										<div class='tab-pane' id='pill3' aria-labelledby='base-pill3'>
	   		   											<iframe src = '' loading="lazy" width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill3_frame' id='pill3_frame'></iframe>
	   		   										</div>
	   		   										<div class='tab-pane' id='pill4' aria-labelledby='base-pill4'>
	   		   											<iframe src = '' loading="lazy" width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill4_frame' id='pill4_frame'></iframe>
	   		   										</div>
	   		   										<div class='tab-pane' id='pill5' aria-labelledby='base-pill5'>
	   		   											<iframe src = '' loading="lazy" width='100%' frameborder='0' border='0' scrolling='yes' bgcolor=#EEEEEE bordercolor='#FF000000' marginwidth='0' marginheight='0' name='pill5_frame' id='pill5_frame'></iframe>
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
		   print_pill2_frame(params.data.jobid);
		   $('#pill2_frame').data('jobid',params.data.jobid);
		   $('#pill3_frame').attr('height',"500px");
		   $('#pill3_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_variant.html");
		   $('#pill4_frame').attr('height',"500px");
		   $('#pill4_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_depth.html");
		   $('#pill5_frame').attr('height',"500px");
		   $('#pill5_frame').attr('src', params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_miss.html");
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
	    headerHeight: 100,
	    animateRows: true,
	    suppressFieldDotNotation: true,
	    tooltipShowDelay: 0,
	    tooltipHideDelay: 20000,
	}
	
	async function print_pill2_frame(jobid) {
		
		// 첫번째 컬럼 filter 대분류(이런식으로 설정하지 않으면 모든 row가 필터에 걸림)
		const filter_arr = await fetch(`/ipet_digitalbreed/result/database/genotype_statistics/${jobid}/${jobid}_genotype_matrix.csv`)
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
							
		//console.log(filter_arr);
		
		fetch(`/ipet_digitalbreed/result/database/genotype_statistics/${jobid}/${jobid}_genotype_matrix.json`)
		.then((response) => response.json())
		.then((data) => {
			console.log("json data : ", data)
			
			// header 정의
			//let header = ["position"];
			let header = ["chr_pos"];
			for(key in data[0]) {
				if(key == "Reference") {
					continue;
				}
				if(key !== "chr_pos") {
					header.push(key);
				} 
			}
			//console.log(header);
			
			
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
						pinned: 'left',
						lockPinned: true,
					});
					pill2_frame_width += 180
				} else {
					columnDefs2.push({field: header[i], width: 50, menuTabs: [], tooltipField: header[i], tooltipComponent: CustomTooltip, cellStyle: cellStyle});
					pill2_frame_width += 50
				}
			}
			
			//grid 길이가 짧으면 div영역도 축소
			if(pill2_frame_width < 1780) {
				//$("#pill2_frame").css('width', pill2_frame_width + 20);
				$("#pill2_frame").css('width', 6 * 50 + 80);
			}
			
			//console.log(columnDefs2);
			gridOptions2.api.setColumnDefs(columnDefs2);
			gridOptions2.api.setRowData(data);
			
			//'Position' 컬럼을 검색 => 해당 컬럼은 수평처리
			//document.querySelector('#pill2_frame .ag-header-cell-label .ag-header-cell-text').style.writingMode = 'horizontal-tb'
			Array.prototype.slice.call(document.querySelectorAll('#pill2_frame .ag-header-cell-label .ag-header-cell-text'))
			.filter((el) => el.textContent === 'Position')[0].style.writingMode = 'horizontal-tb'; 
		});
		
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
			["A", {backgroundColor : '#46FF2D'}], ["C", {backgroundColor : '#F24641'}], ["G", {backgroundColor : '#FFAE01'}],
			["T", {backgroundColor : '#4192FC'}], ["I", {backgroundColor : '#FFFFFF'}], ["R", {backgroundColor : '#FCFC0F'}],
			["Y", {backgroundColor : '#E280EF'}], ["M", {backgroundColor : '#838308'}], ["K", {backgroundColor : '#8A4913'}],
			["S", {backgroundColor : '#FF9D81'}], ["W", {backgroundColor : '#81FFF3'}], ["H", {backgroundColor : '#C0D8FB'}],
			["B", {backgroundColor : '#F7C1C3'}], ["V", {backgroundColor : '#FDE4B9'}], ["D", {backgroundColor : '#C7FFBA'}],
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
								gridOptions.api.ensureIndexVisible(Number(rowNode.rowIndex), 'middle');
								rowNode.setSelected(true);
								
								gridOptions.api.setFocusedCell(Number(rowNode.rowIndex), 'displayno');
								//console.log($("[row-id='0'] [col-id='displayno']"));
								$(`[row-index=${rowNode.rowIndex}] [col-id='displayno']`).trigger("click");
							}
						});	
						

					} else {
						//console.log("null");
					}
					
				});
			});
	});

  /*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/

  if ($(window).width() < 768) {
    //gridOptions.columnApi.setColumnPinned("email", null);
  } else {
   // gridOptions.columnApi.setColumnPinned("email", "left");
  }
  $(window).on("resize", function() {
    if ($(window).width() < 768) {
      //gridOptions.columnApi.setColumnPinned("email", null);
    } else {
     // gridOptions.columnApi.setColumnPinned("email", "left");
    }
  });
