/*=========================================================================================
    File Name: ag-grid.js
    Description: Aggrid Table
    --------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: PIXINVENT
    Author URL: http://www.themeforest.net/user/pixinvent
==========================================================================================*/

	class CustomHeader {
	    init(agParams) {
	    	
	    	//console.log(agParams);
	    	
	    	this.agParams = agParams;
	    	this.eGui = document.createElement('div');
	    	
	    	this.eGui.style.display = "flex";
	    	this.eGui.style.alignItems = "center";
	    	this.eGui.style.justifyContent = "center";
	    	this.eGui.dataset.pos = this.agParams.displayName.replaceAll(",","");
	    	this.eGui.dataset.count = "0";
	        this.eGui.innerHTML = `
	            <div class="customHeaderLabel" style="writing-mode: vertical-lr;">${this.agParams.displayName}</div>
	            <div class="customLabel customALabel" style="display:none;" data-base="A">A</div>
	            <div class="customLabel customTLabel" style="display:none;" data-base="T">T</div>
	            <div class="customLabel customGLabel" style="display:none;" data-base="G">G</div>
	            <div class="customLabel customCLabel" style="display:none;" data-base="C">C</div>
	        `;
	        
	        this.eSortcustomHeaderLabelButton = this.eGui.querySelector(".customHeaderLabel");
	        this.eSortAButton = this.eGui.querySelector(".customALabel");
	        this.eSortTButton = this.eGui.querySelector(".customTLabel");
	        this.eSortGButton = this.eGui.querySelector(".customGLabel");
	        this.eSortCButton = this.eGui.querySelector(".customCLabel");
	        
	        if (this.agParams.enableSorting) {
	        	
	        	this.eGui.addEventListener('click', () => {
	        		
	        		const pos = this.eGui.dataset.pos;
	        		
	        		document.querySelectorAll(`[data-pos]:not([data-pos="${pos}"]`).forEach((node) => {
	        			//console.log(node);
	        			node.dataset.count = "0";
	        			node.querySelectorAll('.customLabel').forEach((subNode) => {
	        				subNode.style.display = 'none';
	        			})
	        		});
	        		
	        		if(this.eGui.dataset.base_arr === undefined || this.eGui.dataset.base_arr === null) {
	        			const base_arr = new Array();
	        			
	        			VariantBrowser_gridOptions.api.forEachNode((node) => {
	        				//console.log(node.data[this.eGui.dataset.pos]);
	        				const base = node.data[this.eGui.dataset.pos];
	        				if(!base_arr.includes(base) && (base == 'A' || base == 'T' || base == 'G' || base == 'C') ) {
	        					base_arr.push(base);
	        				}
	        				
	        			})
	        			base_arr.sort(function(a,b){
	        				switch(a) {
		        				case 'A': a = 1; break;
		        				case 'T': a = 2; break;
		        				case 'G': a = 3; break;
		        				case 'C': a = 4; break;
	        				}
	        				switch(b) {
		        				case 'A': b = 1; break;
		        				case 'T': b = 2; break;
		        				case 'G': b = 3; break;
		        				case 'C': b = 4; break;
	        				}
	        				return a > b ? 1 : -1;
	        			})
	        			
	        			base_arr.push('N')
	        			this.eGui.dataset.base_arr = base_arr;
	        		}
	        		
	        		const base_arr = this.eGui.dataset.base_arr.split(",");
	        		const count = Number(this.eGui.dataset.count);
	        		
	        		console.log(base_arr[count%base_arr.length]);
	        		
	        		this.eGui.querySelectorAll('.customLabel').forEach((node) => {
	        			node.style.display = 'none';
	        		});
	        		
	        		
	        		base_sort_order = base_arr[count%base_arr.length];
	        		
	        		if(base_arr[count%base_arr.length] == 'N'){
	        			this.agParams.setSort('', event.shiftKey);
	        		} else {
	        			this.eGui.querySelector(`.custom${base_arr[count%base_arr.length]}Label`).style.display = 'block';
	        			this.agParams.setSort('desc', event.shiftKey);
	        		}
	        		
	        		
	        		this.eGui.dataset.count = Number(this.eGui.dataset.count) + 1;
	        	});
	        } else {
	            this.eGui.removeChild(this.eSortAButton);
	            this.eGui.removeChild(this.eSortTButton);
	            this.eGui.removeChild(this.eSortGButton);
	            this.eGui.removeChild(this.eSortCButton);
	        }
	        
	    }
	    
	    getGui() {
	    	return this.eGui;
	    }
	
	}
	
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
	
	function inverseRowCount(params) {
		return params.api.getDisplayedRowCount() - params.node.rowIndex;
	}

	var VariantBrowser_columnDefs = [];
	var VariantBrowser_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: false, 
				suppressMenu: true, 
				suppressMovable: true,
				cellClass: "grid-cell-centered", 
				//headerClass: "grid-header-red",
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: VariantBrowser_columnDefs, 
			rowHeight: 35, 
			headerHeight: 100,
			
			components: {
			    agColumnHeader: CustomHeader,
			},
			
			rowDragManaged: true,
			enableRangeSelection: false, 
			suppressMultiRangeSelection: true,
			animateRows: true, 
			tooltipShowDelay: 0,
		    tooltipHideDelay: 20000,
		    postSortRows: (params) => {
		    	const rowNodes = params.nodes;
		    	
		        // 첫번째 Row인 id=reference는 고정
		        for (let i=0, nextInsertPos=0 ; i<rowNodes.length; i++) {
		        	if(rowNodes[i].rowIndex == 0) {
		        		//console.log("post sort??");
		        		rowNodes.splice(nextInsertPos, 0, rowNodes.splice(i, 1)[0]);
		        		nextInsertPos++;
		        	}
		        }
		        //console.log(rowNodes);
		    },
		    onBodyScroll: (params) => {
		    	if(params.direction == 'horizontal') {
		    		drawLineBetweenGeneModelAndBrowser();
		    	}
		    },
		    onGridSizeChanged: (params) => {
		    	drawLineBetweenGeneModelAndBrowser();
		    }
			//onCellClicked: (params) =>
	};

	
	
	class snpEffDescriptionTooltip {
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
	                <span class"name">${params.value}</span>
	            </p>
	        `;
		}
		
		getGui() {
		    return this.eGui;
		}
	}
	
	var SnpEff_columnDefs = [
		{
			//headerName: "row_id(select link)",
			field: "row_id",
			hide: true,
	    },
		{ 
			headerName: "",
			field: "selection", 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true, 
			headerCheckboxSelection: true, 
			width: 200, 
			minWidth: 100, 
			//editable: true, 
			suppressMenu: true,
			pinned: 'left',
			tooltipShowDelay: 0,
		    tooltipHideDelay: 20000,
			cellRenderer: (params) => {
				if(params.value) {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#b672f5" stroke="#b672f5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`
				} else {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#bcbcbc" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`;
				}
			},
		},
	    { 
			headerName: "Chr",
			field: "chr", 
			filter: true, 
			//width: 60, 
			minWidth: 90, 
		},
	    { 
			headerName: "Pos",
			field: "pos",
			filter: 'agNumberColumnFilter', 
			valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
			//width: 70, 
			minWidth: 120, 
			cellClass: "",
			cellStyle: { color: 'blue' }
		},
	    { 
			headerName: "Impact",
			field: "impact",
			//filter: "agTextColumnFilter",
			filter: 'agSetColumnFilter',
			suppressMenu: false, 
			//width: 80, 
			minWidth: 120, 
		},
	    { 
			headerName: "Effect Classic",
			field: "effect_classic",
			filter: "agTextColumnFilter",
			suppressMenu: false,
			//width: 120, 
			minWidth: 180, 
		},
	    { 
			headerName: "GeneID",
			field: "gene_id",
			filter: "agTextColumnFilter",
			suppressMenu: false,
			//width: 120, 
			minWidth: 100, 
		},
	    { 
			headerName: "Description",
			field: "description",
			filter: "agTextColumnFilter",
			cellClass: "",
			suppressMenu: false,
			tooltipField: "description",
			tooltipComponent: snpEffDescriptionTooltip,
			tooltipComponentParams: { color: '#f8f8f8' },
			width: 350, 
			minWidth: 160, 
		},
	];
	var SnpEff_gridOptions = {
		defaultColDef: { 
			editable: false, 
			sortable: true, 
			resizable: true, 
			suppressMenu: true, 
			suppressMovable: true,
			cellClass: "grid-cell-centered", 
			menuTabs: ['filterMenuTab'], 
		},
		columnDefs: SnpEff_columnDefs, 
		rowHeight: 35, 
		rowSelection: 'multiple',
		rowMultiSelectWithClick: true,
		pivotPanelShow: "always", 
		colResizeDefault: "shift", 
		animateRows: true, 
		tooltipShowDelay: 0,
	    tooltipHideDelay: 20000,
		getRowId: (params) => params.data.row_id,
		onCellClicked: (params) => {
			//console.log(params);
			
			function nodeSelected(isSelected) {
				return !isSelected;
			}
			
			if (params.column.colId === 'selection' ) {
				const flag = nodeSelected(params.node.selected);
				params.node.setSelected(flag);
				
				// 즐겨찾기 on/off
				const rowNode = SnpEff_gridOptions.api.getRowNode(params.node.id);
				const selection_flag = params.data.selection;
				rowNode.setDataValue('selection', !selection_flag);
				
				// selection 탭에 추가
				const selection_row_id = params.node.data.row_id;
				const selection_node = SelectionList_gridOptions.api.getRowNode(selection_row_id);
				if(!selection_node) {
					// db에 추가
					const url_string = './vb_features_transaction_selection.jsp';
					
					const map_params = new Map();
					map_params.set('command', 'add');
					map_params.set('jobid', linkedJobid);
					map_params.set("chr", selectedOption("Chr_select").dataset.chr);
					map_params.set("pos", params.node.data.pos);
					//map_params.set('vb_selection_id', params.data.vb_selection_id);
					map_params.set('column', 'snpeff');
					map_params.set('value', params.value);
					
					getFetchData(url_string, map_params);
					
					SelectionList_gridOptions.api.applyTransaction({add: [{'row_id':selection_row_id, 'chr':params.node.data.chr, 'pos':params.node.data.pos, 'snpeff':true, 'gwas':false, 'marker_candidate':false}]})
					/*
					(async() => { 
						await getFetchData(url_string, map_params); 
						SelectionList_gridOptions.api.refreshCells(); 
					})();
					 */
					
				} else {
					selection_node.setDataValue('snpeff', !selection_flag);
					/*
					if(!selection_node.data.snpeff && !selection_node.data.gwas && !selection_node.data.marker_candidate) {
						SelectionList_gridOptions.api.applyTransaction({remove: [selection_node.data]});
					}
					*/
				}
				
	        }
			
			if(params.column.colId === 'pos') {
				const flag = nodeSelected(params.node.selected);
				params.node.setSelected(flag);
				
				const chr_select = document.getElementById('Chr_select')
				const length = chr_select[chr_select.selectedIndex].dataset.length;
				
				const position = params.data.pos;
				
				//document.querySelector(`.chromosomeStackDiv[data-order="${parseInt(position * 2000 / length)}"]`).dispatchEvent(new Event('click'));
				document.getElementById('positionInput').value = position.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				document.getElementById('positionInput').dispatchEvent(new Event('blur'));
			}
		},
	};
	
	var GWAS_columnDefs = [
		{
			headerName: "row_id(select link)",
			field: "row_id",
			//valueGetter: (params) => params.data.chr + "_" + params.data.pos,
			hide: true,
	    },
		{ 
			headerName: "",
			field: "selection", 
			width: 120, 
			//minWidth: 100, 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true, 
			headerCheckboxSelection: true, 
			suppressMenu: true, 
			pinned: 'left',
			cellRenderer: (params) => {
				if(params.value) {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="#b672f5" stroke="#b672f5" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`
				} else {
					return `<svg xmlns="http://www.w3.org/2000/svg" width="24" height="24" viewBox="0 0 24 24" fill="none" stroke="#bcbcbc" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" class="feather feather-star">
								<polygon points="12 2 15.09 8.26 22 9.27 17 14.14 18.18 21.02 12 17.77 5.82 21.02 7 14.14 2 9.27 8.91 8.26 12 2"></polygon>
							</svg>`;
				}
			},
		},
	    { 
			headerName: "Chr",
			field: "chr",
			filter: true, 
			width: 240, 
			//minWidth: 160, 
		},
	    { 
			headerName: "Pos",
			field: "pos",
			filter: 'agNumberColumnFilter', 
			valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
			cellClass: "",
			width: 160, 
			//minWidth: 100,
			cellStyle: { color: 'blue' }
		},
	    { 
			field: "P-value", 
			filter: "agTextColumnFilter",
			valueFormatter: (params) => Number(params.value).toFixed(5),
			cellClass: "",
			width: 360, 
			//minWidth: 180, 
		},
	    { 
			field: "MAF", 
			filter: 'agNumberColumnFilter', 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			cellClass: "",
			width: 360, 
			//minWidth: 180, 
		},
	    { 
			field: "Effect", 
			filter: 'agNumberColumnFilter', 
			valueFormatter: (params) => Number(params.value).toFixed(5),
			cellClass: "",
			width: 360, 
			//minWidth: 200, 
		},
	];
	var GWAS_gridOptions = {
		defaultColDef: { 
			editable: false, 
			sortable: true, 
			resizable: true, 
			suppressMenu: true,
			suppressMovable: true,
			cellClass: "grid-cell-centered", 
			menuTabs: ['filterMenuTab'], 
		},
		columnDefs: GWAS_columnDefs, 
		rowHeight: 35, 
		rowSelection: 'multiple',
		rowMultiSelectWithClick: true,
		pivotPanelShow: "always", 
		colResizeDefault: "shift", 
		animateRows: true, 
		getRowId: (params) => params.data.row_id,
		onCellClicked: (params) => {
			//console.log(params);
			
			function nodeSelected(isSelected) {
				return !isSelected;
			}
			
			if (params.column.colId === 'selection' ) {
				const flag = nodeSelected(params.node.selected);
				params.node.setSelected(flag);
				
				// 즐겨찾기 on/off | GWAS에서는 모든 모델, phenotype의 selection을 공유함
				/*
				const selection_flag = params.data.selection;
				const rowNode = GWAS_gridOptions.api.getRowNode(params.node.id);
				rowNode.setDataValue('selection', !selection_flag);
				*/
				const selection_flag = params.data.selection;
				for(const model in GWAS_gridOptions_model) {
					const rowNode = GWAS_gridOptions_model[model].api.getRowNode(params.node.id);
					if(rowNode) {
						rowNode.setDataValue('selection', !selection_flag);
					}
				}
				
				// selection 탭에 추가
				const selection_row_id = params.node.data.row_id;
				const selection_node = SelectionList_gridOptions.api.getRowNode(selection_row_id);
				if(!selection_node) {
					
					// db에 추가
					const url_string = './vb_features_transaction_selection.jsp';
					
					const map_params = new Map();
					map_params.set('command', 'add');
					map_params.set('jobid', linkedJobid);
					map_params.set("chr", selectedOption("Chr_select").dataset.chr);
					map_params.set("pos", params.node.data.pos);
					//map_params.set('vb_selection_id', params.data.vb_selection_id);
					map_params.set('column', 'gwas');
					map_params.set('value', params.value);
					
					getFetchData(url_string, map_params);
					
					SelectionList_gridOptions.api.applyTransaction({add: [{'row_id':selection_row_id, 'chr':params.node.data.chr, 'pos':params.node.data.pos, 'snpeff':false, 'gwas':true, 'marker_candidate':false}]})
				} else {
					selection_node.setDataValue('gwas', !selection_flag);
					/*
					if(!selection_node.data.snpeff && !selection_node.data.gwas && !selection_node.data.marker_candidate) {
						SelectionList_gridOptions.api.applyTransaction({remove: [selection_node.data]});
						//SelectionList_gridOptions.api.applyTransaction({remove: [{'row_id':selection_row_id}]});
					}
					*/
				}
	        }
			
			if(params.column.colId === 'pos') {
				const flag = nodeSelected(params.node.selected);
				params.node.setSelected(flag);
				
				const chr_select = document.getElementById('Chr_select')
				const length = chr_select[chr_select.selectedIndex].dataset.length;
				
				const position = params.data['pos'];
				
				//document.querySelector(`.chromosomeStackDiv[data-order="${parseInt(position * 2000 / length)}"]`).dispatchEvent(new Event('click'));;
				document.getElementById('positionInput').value = position.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
				document.getElementById('positionInput').dispatchEvent(new Event('blur'));
			}
		},
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
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: Marker_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift",
			animateRows: true, 
			//onCellClicked: (params) =>	
	}
	
	var Selection_columnDefs = [
		{
			field: "vb_selection_id",
			hide: true,
		},
		{
			headerName: "row_id(select link)",
			field: "row_id",
			hide: true,
	    },
	    { 
			headerName: "Chr", 
			field: "chr", 
			filter: true, 
			width: 110, 
			maxWidth: 110, 
			checkboxSelection: true, 
			headerCheckboxSelectionFilteredOnly: true, 
			headerCheckboxSelection: true, 
		},
	    { 
			headerName: "Pos", 
			field: "pos", 
			filter: 'agNumberColumnFilter', 
			valueFormatter: (params) => params.value.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ','),
			width: 70, 
			minWidth: 70, 
			cellStyle: { color: 'blue', cursor: 'pointer' },
		},
	    { 
			headerName: "SnpEff", 
			field: "snpeff", 
			filter: "agTextColumnFilter",
			width: 80, 
			minWidth: 80, 
			cellRenderer: param => flag_SVG(param.value),
		},
	    { 
			headerName: "GWAS", 
			field: "gwas", 
			filter: 'agNumberColumnFilter', 
			width: 120, 
			minWidth: 120, 
			cellRenderer: param => flag_SVG(param.value),
		},
	    { 
			headerName: "Marker Candidate", 
			field: "marker_candidate", 
			filter: 'agNumberColumnFilter', 
			width: 120, 
			minWidth: 100, 
			cellRenderer: param => flag_SVG(param.value),
		},
	];
	var SelectionList_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				suppressMovable: true,
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], },
			columnDefs: Selection_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift", 
			animateRows: true,  
			getRowId: (params) => params.data.row_id,
			onCellClicked: (params) => {
				//console.log(params);
				const clicked_column = params.column.colId;
				
				if (clicked_column === 'chr' ) {
					return;
				}

				
				
				if(params.column.colId === 'pos') {
					const flag = nodeSelected(params.node.selected);
					params.node.setSelected(flag);
					
					//const chr_select = document.getElementById('Chr_select')
					//const length = chr_select[chr_select.selectedIndex].dataset.length;
					const chr = selectedOption('Chr_select').dataset.chr;
					const length = selectedOption('Chr_select').dataset.length;
					
					if(params.data.chr != chr) {
						return;
					}
					
					const position = params.data.pos;
					
					//document.querySelector(`.chromosomeStackDiv[data-order="${parseInt(position * 2000 / length)}"]`).dispatchEvent(new Event('click'));;
					document.getElementById('positionInput').value = position.toString().replace(/\B(?=(\d{3})+(?!\d))/g, ',');
					document.getElementById('positionInput').dispatchEvent(new Event('blur'));
					
				}
				
				function nodeSelected(isSelected) {
					return !isSelected;
				}
				
				if (clicked_column === 'snpeff' || clicked_column === 'gwas' || clicked_column === 'marker_candidate') {
					const flag = nodeSelected(params.node.selected);
					params.node.setSelected(flag);
					
					// 즐겨찾기 on/off
					const row_id = params.node.id;
					const selection_node = SelectionList_gridOptions.api.getRowNode(row_id);
					//const selection_flag = params.data.selection;
					
					const selection_flag = params.data[params.column.colId];
					selection_node.setDataValue(clicked_column, !selection_flag);
					
					// 다른 염색체일 경우 다른 Grid에 영향X
					const chr = selectedOption('Chr_select').dataset.chr;
					
					if(params.data.chr != chr) {
						return;
					}
					
					
					
					// true,false에 맞춰서 각 grid의 즐겨찾기 추가,해제
					switch(clicked_column) {
						case 'snpeff':
							const snpEff_node = SnpEff_gridOptions.api.getRowNode(row_id);
							snpEff_node.setDataValue('selection', !selection_flag);
								
							break;
						case 'gwas':
							
							for(const model in GWAS_gridOptions_model) {
								const GWAS_row_node = GWAS_gridOptions_model[model].api.getRowNode(row_id);
								if(GWAS_row_node) {
									GWAS_row_node.setDataValue('selection', !selection_flag);
								}
							}
							
							break;
						case 'markercandidate':
							break;
					}
					
					/*
					// 전부 false일 경우 data 삭제
					if(!selection_node.data.snpeff && !selection_node.data.gwas && !selection_node.data.marker_candidate) {
						//SelectionList_gridOptions.api.applyTransaction({remove: [selection_node.data]});
						
						SelectionList_gridOptions.api.applyTransaction({remove: [{'row_id': row_id}]});
					}
					*/
					
		        }
			},
			onCellValueChanged: (params) => {
				console.log(params);
				
				const node = params.node;
				
				// 전부 false면 delete, 아니면 update
				const url_string = './vb_features_transaction_selection.jsp';
				if(!node.data.snpeff && !node.data.gwas && !node.data.marker_candidate) {
					//SelectionList_gridOptions.api.applyTransaction({remove: [selection_node.data]});
					
					// db에서 제거
					const map_params = new Map();
					map_params.set('command', 'delete');
					//map_params.set("chr", selectedOption("Chr_select").dataset.chr);
					map_params.set("chr", params.node.data.chr);
					map_params.set("pos", params.node.data.pos);
					map_params.set('jobid', linkedJobid);
					map_params.set('vb_selection_id', params.data.vb_selection_id);
					map_params.set('column', params.column.colId);
					map_params.set('value', params.value);
					
					getFetchData(url_string, map_params);
					
					SelectionList_gridOptions.api.applyTransaction({remove: [{'row_id': params.node.id}]});
				} else {
					const map_params = new Map();
					map_params.set('command', 'update');
					map_params.set('jobid', linkedJobid);
					map_params.set('vb_selection_id', params.data.vb_selection_id);
					map_params.set('column', params.column.colId);
					map_params.set('value', params.value);
					
					getFetchData(url_string, map_params);
				}
				
			},
	}
	
	var UPGMA_columnDefs = [
		/*
		{ 
			headerName: "순번",
			valueGetter: inverseRowCount, 
			width: 80, 
		},
		*/
		{ 
			headerName: "ID", 
			field: "id", 
			maxWidth: 100, 
			minWidth: 100, 
			suppressMenu: true, 
		},
	    { field: "population", 
			filter: true, 
			width: 160, 
			minWidth: 160, 
		},
	    { 
			field: "similarity", 
			filter: 'agNumberColumnFilter', 
			width: 160, 
			minWidth: 160, 
			valueFormatter: (params) => Number(params.value).toFixed(2),
		},
	];
	var UPGMA_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: UPGMA_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift", 
			animateRows: true, 
			//onCellClicked: (params) =>
			
	}
	
	
	var STRUCTURE_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Miss", filter: true, width: 160, minWidth: 160, },
	    { field: "Population", filter: 'agNumberColumnFilter', width: 160, minWidth: 160, },
	    { field: "K", filter: true, width: 100, minWidth: 100, },
	];
	var STRUCTURE_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: STRUCTURE_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift", 
			animateRows: true, 
			//onCellClicked: (params) =>	
	}
	
	var Haplotype_columnDefs = [
		{ headerName: "순번",valueGetter: inverseRowCount, width: 80, },
		{ field: "ID", maxWidth: 100, minWidth: 100, suppressMenu: true, },
	    { field: "Haplotype", filter: true, width: 160, minWidth: 160, },
	];
	var Haplotype_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: true, 
				resizable: true, 
				suppressMenu: true, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: Haplotype_columnDefs, 
			rowHeight: 35, 
			rowSelection: 'multiple',
			rowMultiSelectWithClick: true,
			pivotPanelShow: "always", 
			colResizeDefault: "shift", 
			animateRows: true, 
			//onCellClicked: (params) =>	
	}
	
	
	function inverseRowCount(params) {
		return params.api.getDisplayedRowCount() - params.node.rowIndex;
	}
	
	function filter_SnpEff() {

	}
	
	function flag_SVG(flag) {
		if(flag) {
			return `
					<svg width="24" height="28" viewBox="0 0 24 28">
				        <circle cx="12" cy="12" r="10" stroke="#b672f5" stroke-width="2" fill="none"></circle>
				        <polyline points="7,11 11,15 17,8"
			  				style="fill:none;stroke:#b672f5;stroke-width:2" />
				    </svg>
					`;
		} else {
			return `
					<svg width="24" height="28" viewBox="0 0 24 28">
				        <circle cx="12" cy="12" r="11" stroke="#bcbcbc" stroke-width="2" fill="none"></circle>
				        <line x1="8" y1="8" x2="16" y2="16" style="stroke:#bcbcbc;stroke-width:2" />
				        <line x1="8" y1="16" x2="16" y2="8" style="stroke:#bcbcbc;stroke-width:2" />
				    </svg>
					`;
		}
	}
	
	
	
	
	
 
	/*** DEFINED TABLE VARIABLE ***/
	var gridTable = document.getElementById("myGrid");


  	
  	/*** INIT TABLE ***/
  	// setup the grid after the page has finished loading
  	document.addEventListener('DOMContentLoaded', () => {
  		/*** DEFINED TABLE VARIABLE ***/
  		
  		const SnpEff_gridTable = document.getElementById("SnpEff_Grid");
  		const SnpEff_Grid = new agGrid.Grid(SnpEff_gridTable, SnpEff_gridOptions);
  		//const SnpEff_rowData = [];
  		//SnpEff_gridOptions.api.setRowData(SnpEff_rowData)
  		
  		
  		const Marker_gridTable = document.getElementById("Marker_Grid");
  		const Marker_Grid = new agGrid.Grid(Marker_gridTable, Marker_gridOptions);
  		const Marker_rowData = [ { "selection": "star", "Chr": 1, "Pos": 40326, "Type": "SNP", "Indel Length": 0 } ];
  		Marker_gridOptions.api.setRowData(Marker_rowData)
  		
  		const SelectionList_gridTable = document.getElementById("SelectionList_Grid");
  		const SelectionList_Grid = new agGrid.Grid(SelectionList_gridTable, SelectionList_gridOptions);
  		//const SelectionList_rowData = [ { "selection": true, "Chr": 1, "Pos": 40326, "SnpEff": "O", "GWAS": "X", "Marker Candidate": "X" } ];
  		const SelectionList_rowData = [];
  		SelectionList_gridOptions.api.setRowData(SelectionList_rowData)
  		SelectionList_gridOptions.columnApi.autoSizeAllColumns(true);
  		
  		
  		const UPGMA_gridTable = document.getElementById("UPGMA_Grid");
  		const UPGMA_Grid = new agGrid.Grid(UPGMA_gridTable, UPGMA_gridOptions);
  		//const UPGMA_rowData = [ { "ID": "sample9", "Population": "", "Similarity": "",} ];
  		const UPGMA_rowData = [];
  		UPGMA_gridOptions.api.setRowData(UPGMA_rowData)
  		
  		const STRUCTURE_gridTable = document.getElementById("STRUCTURE_Grid");
  		const STRUCTURE_Grid = new agGrid.Grid(STRUCTURE_gridTable, STRUCTURE_gridOptions);
  		const STRUCTURE_rowData = [ { "ID": "sample9", "Miss(%)": "", "Population": "", "K": "Cluster1",} ];
  		STRUCTURE_gridOptions.api.setRowData(STRUCTURE_rowData)
  		
  		const Haplotype_gridTable = document.getElementById("Haplotype_Grid");
  		const Haplotype_Grid = new agGrid.Grid(Haplotype_gridTable, Haplotype_gridOptions);
  		const Haplotype_rowData = [ { "ID": "sample1", "Haplotype": "Hap1",} ];
  		Haplotype_gridOptions.api.setRowData(Haplotype_rowData)
  		
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
  
	
	
  
  
