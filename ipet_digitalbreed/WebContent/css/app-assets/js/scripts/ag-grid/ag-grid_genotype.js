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
      editable: false,
      sortable: true,
      width: 140,	
      filter: 'agMultiColumnFilter',
      cellClass: "grid-cell-centered",      
      checkboxSelection: true,
      headerCheckboxSelectionFilteredOnly: true,
      headerCheckboxSelection: true,
      resizable: true	
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
      editable: false,
      sortable: true,
      filter: true,
      resizable: true,
      cellClass: "grid-cell-centered",      
      width: 300,
	  cellRenderer: function(params){
      return params.value+"<a href='../public/filedownloader.jsp?resultpath="+params.data.uploadpath+params.data.jobid+"/&filename="
        + params.value 
        + "'>&nbsp;&nbsp;<i class='feather icon-download'></i></a>";
    }
    },
    {
      headerName: "상세내용",
      field: "comment",
      editable: false,
      sortable: true,
      filter: true,
      resizable: true,
      cellClass: "ag-header-cell-label",
      width: 670,
      cellStyle: {'cursor': 'pointer'}
    },
    {
      headerName: "작물",
      field: "cropid",
      editable: false,
      sortable: true,
      filter: true,
      resizable: true,
      cellClass: "grid-cell-centered",      
      width: 180,
      hide: true
    },
    {
      headerName: "등록일자",
      field: "cre_dt",
      editable: false,
      sortable: true,
      resizable: true,
      filter: 'agDateColumnFilter',
      cellClass: "grid-cell-centered",      
      width: 150
    },
    {
      headerName: "참조유전체",
      field: "refgenome",
      editable: false,
      sortable: true,
      filter: true,
      resizable: true,
      cellClass: "grid-cell-centered",      
      width: 275,
    },
    {
      headerName: "샘플수",
      field: "samplecnt",
      editable: false,
      sortable: true,
      resizable: true,
      filter: 'agNumberColumnFilter',
      cellClass: "grid-cell-centered",      
      width: 120
    },
    {
      headerName: "변이수",
      field: "variablecnt",
      editable: false,
      sortable: true,
      resizable: true,
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
    columnDefs: columnDefs,
    rowHeight: 35,
    enableRangeSelection: true,
	suppressMultiRangeSelection: true,
    rowSelection: "multiple",
    floatingFilter: true,
    filter: 'agMultiColumnFilter',
    pagination: true,
    paginationPageSize: 20,
    pivotPanelShow: "always",
    colResizeDefault: "shift",
    animateRows: true,
    resizable: true,
    suppressHorizontalScroll: true,
    serverSideInfiniteScroll: true,
	onCellClicked: onCellClicked,
  };
  
  	function onCellClicked(params) {
  		console.log("onCellClicked params : ", params);
  		
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
		   //print_pill2_frame_xlsx(params.data.jobid);
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

	var columnDefs2 = [];

	/*** GRID OPTIONS ***/
	var gridOptions2 = {
		columnDefs: columnDefs2,
	    rowHeight: 35,
	    headerHeight: 100,
	    animateRows: true,
	    suppressFieldDotNotation: true,
	}
	
	function print_pill2_frame(jobid) {
		
		let filter_arr = [];
		
		fetch(`/ipet_digitalbreed/web/database/genotype_parsing_status.jsp?jobid=${jobid}`)
		.then((response) => response.text())
		.then((data) => {
			
			const map = new Map([ 
				["1/3", "업로드 된 VCF 파일을"],["2/3", "SNP 데이타 저장을 위한 데이터 베이스를"],["3/3", "SNP 데이터를 데이터 베이스에"]
			])
			
			const map2 = new Map([
				["1/3", "분석 중입니다."],["2/3", "생성 중입니다."],["3/3", "저장 중입니다."]
			])
			
			switch(data) {
				case "1/3": case "2/3": case "3/3":
					document.getElementById("pill2_frame").style.height = "300px";
					document.getElementById("pill2_frame").innerHTML = `<div class="container h-100">
																		    <div class="row align-items-center h-100">
																		        <div class="col-10 mx-auto">
																		            <div class="jumbotron bg-white">
																		                <div class="d-flex justify-content-center align-middle">
																							<svg width="60px" height="60px" viewBox="0 0 24 24" xmlns="http://www.w3.org/2000/svg"><g data-name="Layer 2"><g data-name="alert-triangle"><rect width="24" height="24" transform="rotate(90 12 12)" opacity="0"/><path d="M22.56 16.3L14.89 3.58a3.43 3.43 0 0 0-5.78 0L1.44 16.3a3 3 0 0 0-.05 3A3.37 3.37 0 0 0 4.33 21h15.34a3.37 3.37 0 0 0 2.94-1.66 3 3 0 0 0-.05-3.04zm-1.7 2.05a1.31 1.31 0 0 1-1.19.65H4.33a1.31 1.31 0 0 1-1.19-.65 1 1 0 0 1 0-1l7.68-12.73a1.48 1.48 0 0 1 2.36 0l7.67 12.72a1 1 0 0 1 .01 1.01z"/><circle cx="12" cy="16" r="1"/><path d="M12 8a1 1 0 0 0-1 1v4a1 1 0 0 0 2 0V9a1 1 0 0 0-1-1z"/></g></g></svg>
																						</div>
																						<div class="d-flex justify-content-center align-middle mt-1">
																							<h4 class="font-weight-bold">${map.get(data)}</h4>
																						</div>
																						<div class="d-flex justify-content-center align-middle">
																							<h4 class="font-weight-bold">${map2.get(data)}</h4>
																						</div>
																		            </div>
																		        </div>
																		    </div>
																		</div>`;
					break;
				case "t":
					const gridTable2 = document.getElementById("pill2_frame");
					const vcfViewerGrid = new agGrid.Grid(gridTable2, gridOptions2);
					return fetch(`/ipet_digitalbreed/web/database/genotype_position_filter.jsp?jobid=${jobid}`);
				default:
					console.log("genotype_parsing_status default case");
			}
		})
		.then((response) => response.text())
		.then((data) => {
			filter_arr = data.slice(1, data.length-1).split(", ");
			
			return fetch(`/ipet_digitalbreed/web/database/genotype_vcfviewer.jsp?jobid=${jobid}`);
		})
		.then((response) => response.json())
		.then((data) => {
			//console.log(data);
			
			const header = data.shift();
			//console.log(header);
			//console.log(data);
			
			
			columnDefs2 = [];
			let pill2_frame_width = 0;
			for(key in header) {
				if(key == 'column_0') {
					//columnDefs2.push({headerName:  header[key], field: key, sortable: true, filter: true, cellClass: "grid-cell-centered", width: 130, cellRenderer: cellRenderder, cellStyle: cellStyle});
					columnDefs2.push({
						headerName:  header[key], 
						field: key, 
						sortable: true, 
						filter: true,
						filterParams: { 
							values: filter_arr, 
							comparator: (a, b) => {
			                    const valA = parseInt(a.replace(/[^0-9]/g,""));
			                    const valB = parseInt(b.replace(/[^0-9]/g,""));
			                    if (valA === valB) return 0;
			                    return valA > valB ? 1 : -1;
			                    } 
							}, 
						cellClass: "grid-cell-centered", 
						width: 140, 
						menuTabs: ["filterMenuTab"], 
						cellRenderer: cellRenderder, 
						cellStyle: cellStyle});
					pill2_frame_width += 140
				} else {
					columnDefs2.push({headerName: header[key], field: key, cellClass: "grid-cell-centered", width: 50, menuTabs: [], cellRenderer: cellRenderder, cellStyle: cellStyle});
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
			//gridOptions2.api.sizeColumnsToFit();
			
			//첫번째 컬럼은 수평
			document.querySelector('#pill2_frame .ag-header-cell-label .ag-header-cell-text').style.writingMode = 'horizontal-tb'
		})
	}
 
	function cellRenderder(params) {
		const map = new Map([
			["A", "<span title='A'>A</span>"], ["C", "<span title='C'>C</span>"], ["G", "<span title='G'>G</span>"],
			["T", "<span title='T'>T</span>"], ["I", "<span title='I'>I</span>"], ["R", "<span title='A or G'>R</span>"],
			["Y", "<span title='C or T'>Y</span>"], ["M", "<span title='A or C'>M</span>"], ["K", "<span title='G or T'>K</span>"],
			["S", "<span title='C or G'>S</span>"], ["W", "<span title='A or T'>W</span>"], ["H", "<span title='A or C or T'>H</span>"],
			["B", "<span title='C or G or T'>B</span>"], ["V", "<span title='A or C or G'>V</span>"], ["V", "<span title='A or C or G'>V</span>"],
			["D", "<span title='A or G or T'>D</span>"], ["N", "<span title='A or C or G or T'>N</span>"]
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
