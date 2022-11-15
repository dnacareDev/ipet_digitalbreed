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
    serverSideInfiniteScroll: true,
	onCellClicked: params => {
	
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
		   
	       
		   $('#pill1_frame').attr('height',"130px");
		   $('#pill1_frame').attr( 'src', "/ipet_digitalbreed/web/database/genotype_vcfinfo.jsp?jobid="+params.data.jobid);
		   //$('#pill2_frame').attr('height',"500px", 'src', "/ipet_digitalbreed/web/database/genotype_vcfviewer.jsp?jobid="+params.data.jobid);
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
  };


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
	    pagination: true,
		paginationPageSize: 11,
	    animateRows: true,
	}

	function print_pill2_frame(jobid) {
		const gridTable2 = document.getElementById("pill2_frame");
		const vcfViewerGrid = new agGrid.Grid(gridTable2, gridOptions2);
		
		fetch(`/ipet_digitalbreed/web/database/genotype_vcfviewer.jsp?jobid=${jobid}`)
		.then((response) => response.json())
		.then((data) => {
			const header = data.shift();
			//console.log(header);
			//console.log(data);
			
			columnDefs2 = [];
			let i=0;
			for(key in header) {
				columnDefs2.push({headerName: header[key], field: `column_${i++}`, cellClass: "grid-cell-centered", width: 100, cellRenderer: cellRenderder, cellStyle: cellStyle});
			}
			console.log(columnDefs2);
			gridOptions2.api.setColumnDefs(columnDefs2);
			
			gridOptions2.api.setRowData(data);
			//gridOptions2.api.sizeColumnsToFit();
		})
	}
 
	function cellRenderder(params) {
		//console.log("params : ", params.value);
		switch(params.value) {
			case "A": 
				return "<span title='A'>A</span>";
			case "C":
				return "<span title='C'>C</span>";
			case "G":
				return "<span title='G'>G</span>";
			case "T":
				return "<span title='T'>T</span>";
			case "I":
				return "<span title='I'>I</span>";
			case "R":
				return "<span title='A or G'>R</span>";
			case "Y":
				return "<span title='C or T'>Y</span>";
			case "M":
				return "<span title='A or C'>M</span>";
			case "K":
				return "<span title='G or T'>K</span>";
			case "S":
				return "<span title='C or G'>S</span>";
			case "W":
				return "<span title='A or T'>W</span>";
			case "H":
				return "<span title='A or C or T'>H</span>";
			case "B":
				return "<span title='C or G or T'>B</span>";
			case "V":
				return "<span title='A or C or G'>V</span>";
			case "D":
				return "<span title='A or G or T'>D</span>";
			case "N":
				return "<span title='A or C or G or T'>N</span>";
			default:
				return params.value;
		}
	}
	
	function cellStyle(params) {
		switch(params.value) {
			case "A":
				return {backgroundColor : '#FFC800'};
			case "C":
				return {backgroundColor : '#CBFF75'};
			case "G":
				return {backgroundColor : '#79B9B1'};
			case "T":
				return {backgroundColor : '#FF92B1'};
			case "I":
				return {backgroundColor : '#9DF0E1'};
			case "R":
				return {backgroundColor : '#2C952C'};
			case "Y":
				return {backgroundColor : '#00AFFF'};
			case "M":
				return {backgroundColor : '#6495ED'};
			case "K":
				return {backgroundColor : '#28A0FF'};
			case "S":
				return {backgroundColor : '#0A9696'};
			case "W":
				return {backgroundColor : '#AD733A'};
			case "H":
				return {backgroundColor : '#F3B600'};
			case "B":
				return {backgroundColor : '#182605'};
			case "V":
				return {backgroundColor : '#4D0088'};
			case "D":
				return {backgroundColor : '#808080'};
			case "N":
				return {color: 'white', backgroundColor : '#182605'};
			default:
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
