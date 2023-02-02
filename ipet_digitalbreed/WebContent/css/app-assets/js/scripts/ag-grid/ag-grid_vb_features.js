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

	var VariantBrowser_columnDefs = [];
	var VariantBrowser_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: false, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: VariantBrowser_columnDefs, 
			rowHeight: 35, 
			headerHeight: 100,
			enableRangeSelection: true, 
			suppressMultiRangeSelection: true, 
			pagination: true, 
			paginationPageSize: 20,
			pivotPanelShow: "always", 
			//colResizeDefault: "shift", 
			animateRows: true, 
			tooltipShowDelay: 0,
		    tooltipHideDelay: 20000,
			//onCellClicked: (params) =>
	};

	
	var SnpEff_columnDefs = [
		{ 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true, 
			headerCheckboxSelection: true, 
			width: 50, 
		},
		{ 
			field: "selection", 
			maxWidth: 100, 
			minWidth: 100, 
			suppressMenu: true,
		},
	    { 
			field: "Chr", 
			filter: true, 
			width: 60, 
			minWidth: 60, 
		},
	    { 
			field: "Pos", 
			filter: 'agNumberColumnFilter', 
			width: 70, 
			minWidth: 70, 
		},
	    { 
			field: "Impact", 
			filter: "agTextColumnFilter",
			width: 80, 
			minWidth: 80, 
		},
	    { 
			field: "Effect Classic", 
			filter: 'agNumberColumnFilter', 
			width: 120, 
			minWidth: 120, 
		},
	    { 
			field: "GeneID", 
			filter: 'agNumberColumnFilter', 
			width: 120, 
			minWidth: 100, 
		},
	    { 
			field: "Description", 
			filter: 'agDateColumnFilter', 
			width: 150, 
			minWidth: 110, 
			cellClass: "", 
		},
	];
	var SnpEff_gridOptions = {
		defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
		columnDefs: SnpEff_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
		pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>
	};
	
	var GWAS_columnDefs = [
		{ 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true, 
			headerCheckboxSelection: true, 
			width: 120, 
		},
		{ 
			field: "selection", 
			width: 120, 
			minWidth: 100, 
			suppressMenu: true, 
		},
	    { 
			field: "Chr", 
			filter: true, 
			width: 240, 
			minWidth: 160, 
		},
	    { 
			field: "Pos",
			filter: 'agNumberColumnFilter', 
			width: 160, 
			minWidth: 100, 
		},
	    { 
			field: "P-value", 
			filter: "agTextColumnFilter",
			width: 360, 
			minWidth: 180, 
			//cellRenderer: (params) => Math.round(params.value * 10000000) / 10000000
		},
	    { 
			field: "MAF", 
			filter: 'agNumberColumnFilter', 
			width: 360, 
			minWidth: 180, 
			//cellRenderer: (params) => Math.round(params.value * 10000000) / 10000000
		},
	    { 
			field: "Effect", 
			filter: 'agNumberColumnFilter', 
			width: 360, 
			minWidth: 200, 
			//cellRenderer: (params) => Math.round(params.value * 10000000) / 10000000
		},
	];
	var GWAS_gridOptions = {
		defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
		columnDefs: GWAS_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
		pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	var Marker_columnDefs = [
		{ checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, headerCheckboxSelection: true, width: 50, },
		{ field: "selection", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Chr", filter: true, width: 60, minWidth: 60, },
	    { field: "Pos", filter: 'agNumberColumnFilter', width: 70, minWidth: 70, },
	    { field: "Type", filter: "agTextColumnFilter",width: 80, minWidth: 80, },
	    { field: "Indel Length", filter: 'agNumberColumnFilter', width: 120, minWidth: 120, },
	];
	var Marker_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: Marker_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	var Selection_columnDefs = [
		{ checkboxSelection: true, headerCheckboxSelectionFilteredOnly: true, headerCheckboxSelection: true, width: 50, },
		{ field: "selection", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Chr", filter: true, width: 60, minWidth: 60, },
	    { field: "Pos", filter: 'agNumberColumnFilter', width: 70, minWidth: 70, },
	    { field: "SnpEff", filter: "agTextColumnFilter",width: 80, minWidth: 80, },
	    { field: "GWAS", filter: 'agNumberColumnFilter', width: 120, minWidth: 120, },
	    { field: "Marker Candidate", filter: 'agNumberColumnFilter', width: 120, minWidth: 100, },
	];
	var SelectionList_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: Selection_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	var UPGMA_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Population", filter: true, width: 160, minWidth: 160, },
	    { field: "Similarity", filter: 'agNumberColumnFilter', width: 160, minWidth: 160, },
	];
	var UPGMA_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: UPGMA_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	
	var STRUCTURE_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Miss", filter: true, width: 160, minWidth: 160, },
	    { field: "Population", filter: 'agNumberColumnFilter', width: 160, minWidth: 160, },
	    { field: "K", filter: true, width: 100, minWidth: 100, },
	];
	var STRUCTURE_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: STRUCTURE_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	var Haplotype_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Haplotype", filter: true, width: 160, minWidth: 160, },
	];
	var Haplotype_gridOptions = {
			defaultColDef: { editable: false, sortable: true, resizable: true, suppressMenu: true, cellClass: "grid-cell-centered", menuTabs: ['filterMenuTab'], },
			columnDefs: Haplotype_columnDefs, rowHeight: 35, enableRangeSelection: true, suppressMultiRangeSelection: true, pagination: true, paginationPageSize: 20,
			pivotPanelShow: "always", colResizeDefault: "shift", animateRows: true, //onCellClicked: (params) =>	
	}
	
	
	function inverseRowCount(params) {
		return params.api.getDisplayedRowCount() - params.node.rowIndex;
	}
	
	function filter_SnpEff() {
		/*
		const SnpEff_gridTable = document.getElementById("SnpEff_Grid");
		
		if(!SnpEff_gridTable.innerHTML) {
			const SnpEff_Grid = new agGrid.Grid(SnpEff_gridTable, SnpEff_gridOptions);
			SnpEff_gridOptions.api.setRowData(rowData);
			SnpEff_gridOptions.api.sizeColumnsToFit();
		}
		
  		//gridOptions.api.setRowData(rowData)
  		*/
	}
	
	
	
	
	
	
	
 
	/*** DEFINED TABLE VARIABLE ***/
	var gridTable = document.getElementById("myGrid");


  	
  	/*** INIT TABLE ***/
  	// setup the grid after the page has finished loading
  	document.addEventListener('DOMContentLoaded', async () => {
  		/*** DEFINED TABLE VARIABLE ***/
  		/*
  		const chrSelectElement = document.getElementById('Chr_select');
  		const vcf_id = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.vcfId_at_firstRow;
		const row_count = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.row_count;
		const chr = chrSelectElement.options[chrSelectElement.selectedIndex].dataset.chr;
  		*/
  		
  		const firstChr = await addChromosomeInfo();
  		//console.log(firstChr);
  		
  		document.getElementById("Chr_select").dispatchEvent(new Event("change"));
  		
  		//여기서 로딩하지말고 dispatchEvent(click)에서 Ag-grid를 로딩해야함. async await가 안 먹힌다.
  		/*
  		setTimeout(() => {
  			document.querySelector(".chromosomeStackDiv[data-order='0']").dispatchEvent(new Event("click"));
  		}, 500);
  		*/
  		
  		
  		/*
  		const selectedLine = document.querySelector('.chromosomeStackDiv[style="width: 0.1003%; height: 19px; display: inline-block; background-color: red;"]').dataset.position;
  		
  		console.log(selectedLine);
  		
  		// 염색체, position 하드코딩
  		//const chr = 1;
  		//const position = 3374674;
  		const position = 0;
  		
  		
  		fetch(`./vb_features_getBrowserData.jsp?chr=${firstChr}&position=${position}&jobid=${linkedJobid}`)
    	.then((response) => response.json())
    	.then((data) => {
    		//console.log("chr=1, position=3374674로 설정")
    		//console.log(data);
    		
    		let columnKeys = new Array('id')
    		
    		for(const key in data[0]) {
    			if(key == 'id')	continue;
    			columnKeys.push(key);
    		}
    		//console.log(columnKeys);
    		
    		for(let i=0 ; i<columnKeys.length ; i++) {
    			if(columnKeys[i] == 'id') {
    				VariantBrowser_columnDefs.push({
    					'field': columnKeys[i], 
    					'width': 150,
    				}) 
    			} else {
    				VariantBrowser_columnDefs.push({
    					'field': columnKeys[i], 
    					'width': 60,
    					tooltipComponent: CustomTooltip, 
    					cellStyle: cellStyle,
    				}) 
    			}
    		}
    		
    		const VariantBrowser_gridTable = document.getElementById("VariantBrowserGrid");
    		const VariantBrowser_Grid = new agGrid.Grid(VariantBrowser_gridTable, VariantBrowser_gridOptions);
    		VariantBrowser_gridOptions.api.setRowData(data);
    		
    		//'Position' 컬럼을 검색 => 해당 컬럼은 수평처리
    		Array.prototype.slice.call(document.querySelectorAll('#VariantBrowserGrid .ag-header-cell-label .ag-header-cell-text'))
    		.filter((el) => el.textContent === 'Id')[0].style.writingMode = 'horizontal-tb'; 
    	})
  		*/
  		
  		
  		
  		const SnpEff_gridTable = document.getElementById("SnpEff_Grid");
  		const SnpEff_Grid = new agGrid.Grid(SnpEff_gridTable, SnpEff_gridOptions);
  		const SnpEff_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Impact": "HIGH", } ];
  		SnpEff_gridOptions.api.setRowData(SnpEff_rowData)
  		
  		/*
  		const GWAS_gridTable = document.getElementById("GWAS_Grid");
  		const GWAS_Grid = new agGrid.Grid(GWAS_gridTable, GWAS_gridOptions);
  		const GWAS_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "P-value": 0.305428246, "MAF": 0.140350877, "Effect": 0.88349949 } ];
  		GWAS_gridOptions.api.setRowData(GWAS_rowData)
  		//GWAS_gridOptions.api.setRowData(new Array());
  		*/
  		
  		
  		
  		const Marker_gridTable = document.getElementById("Marker_Grid");
  		const Marker_Grid = new agGrid.Grid(Marker_gridTable, Marker_gridOptions);
  		const Marker_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Type": "SNP", "Indel Length": 0 } ];
  		Marker_gridOptions.api.setRowData(Marker_rowData)
  		
  		const SelectionList_gridTable = document.getElementById("SelectionList_Grid");
  		const SelectionList_Grid = new agGrid.Grid(SelectionList_gridTable, SelectionList_gridOptions);
  		const SelectionList_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "SnpEff": "O", "GWAS": "X", "Marker Candidate": "X" } ];
  		SelectionList_gridOptions.api.setRowData(SelectionList_rowData)
  		
  		
  		
  		const UPGMA_gridTable = document.getElementById("UPGMA_Grid");
  		const UPGMA_Grid = new agGrid.Grid(UPGMA_gridTable, UPGMA_gridOptions);
  		const UPGMA_rowData = [ { "ID": "sample9", "Population": "", "Similarity": "",} ];
  		UPGMA_gridOptions.api.setRowData(UPGMA_rowData)
  		
  		const STRUCTURE_gridTable = document.getElementById("STRUCTURE_Grid");
  		const STRUCTURE_Grid = new agGrid.Grid(STRUCTURE_gridTable, STRUCTURE_gridOptions);
  		const STRUCTURE_rowData = [ { "ID": "sample9", "Miss(%)": "", "Population": "", "K": "Cluster1",} ];
  		STRUCTURE_gridOptions.api.setRowData(STRUCTURE_rowData)
  		
  		const Haplotype_gridTable = document.getElementById("Haplotype_Grid");
  		const Haplotype_Grid = new agGrid.Grid(Haplotype_gridTable, Haplotype_gridOptions);
  		const Haplotype_rowData = [ { "ID": "sample1", "Haplotype": "Hap1",} ];
  		Haplotype_gridOptions.api.setRowData(Haplotype_rowData)
  		
  		/*** GET TABLE DATA FROM URL ***/
  		/*
  		fetch("./vb_json.jsp?varietyid="+$( "#variety-select option:selected" ).val())
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		});
  		*/
  	});
  	
  	
  	
  	

	
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
	
	/*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/
	$(window).on("resize", function() {
		//gridOptions.api.sizeColumnsToFit();
	});
  
	
	
  
  
