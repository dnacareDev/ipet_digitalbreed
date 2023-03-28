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
			.simpleHttpRequest({ url: "./pd_json.jsp?varietyid="+$( "#variety-select option:selected" ).val()})
		    .then(function(data) {
		    	//console.log("data : ", data);
		    	gridOptions.api.setRowData(data);
		    });
		vcfFileList();
		referenceGenomeList()
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
		    url:"./pd_delete.jsp",
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
			headerName: "VCF 파일명",
			field: "filename",
			filter: true,
			width: 600,
			minWidth: 120,
	    },
	    {
			headerName: "상세내용",
			field: "comment",
			filter: true,
			width: 350,
			minWidth: 120,
			cellClass:"",
	    },
	    {
			headerName: "마커 유형",
			field: "marker_category",
			filter: true,
			maxWidth: 120,
			minWidth: 100,
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
	    	field: "restriction_enzymes",
	    	hide: true
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
		colResizeDefault: "shift",
		suppressDragLeaveHidesColumns: true,
		animateRows: true,
		//suppressHorizontalScroll: true,
		onCellClicked: params => {
		
			//console.log("cell clicked : " + params.column.getId());
			//console.log("params : ", params);
			
			if(params.column.getId() != "no" && params.column.getId() != "cre_dt"){

				switch (Number(params.data.status)) {
					case 0:
						alert("분석 중입니다.");
						break;
					case 1:
						//$("#Loading").modal('show');
						
						document.getElementById('Marker_Info').dataset.marker_category = params.data.marker_category;
						document.getElementById('vcf_status').style.display = "block";
						$("html").animate({ scrollTop: $(document).height() }, 1000);
						
						gridOptions2.api.setFilterModel(null);
						
						if(params.data.marker_category == 'CAPs') {
							jQuery("#Enzyme_Select").next().show();
						} else {
							jQuery("#Enzyme_Select").next().hide();
							jQuery("#Enzyme_Select").empty();
							jQuery("#Enzyme_Select").html(`<option data-enzyme="-"></option>`);
							jQuery("#Enzyme_Select option:eq(0)").prop("selected", true);
							jQuery("#Enzyme_Select").trigger("change");
						}
						
						
						fetch(`${params.data.resultpath+params.data.jobid+"/"+params.data.jobid+"_primer_design.csv"}`)
						.then((response)=> {
							if(!response.ok) {
								gridOptions2.api.setRowData();
						        //gridOptions2.columnApi.autoSizeAllColumns();
								gridOptions2.api.sizeColumnsToFit();
								throw new Error('primer_design CSV file does not exist');
							} else {
								return response.blob()
							}
						})
						.then((file)=> {
							//console.log(data);
							columnDefs2[0]['cellClassRules'] = params.data.marker_category == 'KASP' ? {'cell-span': "rowIndex % 3 === 0"} : {'cell-span': "rowIndex % 2 === 0"};
							gridOptions2.api.setColumnDefs(columnDefs2);
							gridOptions2.api.setRowData();
							
							var reader = new FileReader();
						    reader.onload = function(){
						        var fileData = reader.result;
						        var wb = XLSX.read(fileData, {type : 'binary', FS:'\t'});
						        
						        var rowObj = XLSX.utils.sheet_to_json(wb.Sheets[wb.SheetNames[0]]);
						        console.log("rowObj : ", rowObj);
						        //console.log(csv_to_grid);
						        gridOptions2.api.setRowData(rowObj);
						        
						        
						        
						        columnDefs2[1]['minWidth'] = 0;
						        columnDefs2[2]['minWidth'] = 0;
						        gridOptions2.api.setColumnDefs(columnDefs2);
						        gridOptions2.columnApi.autoSizeAllColumns();
						        
						        const resultGrid_width = document.getElementById('resultGrid').clientWidth;
						        const all_columns = gridOptions2.columnApi.getColumns();
						        let columns_width = 0;
						        for(let i=0 ; i<all_columns.length ; i++) {
						        	columns_width += all_columns[i].actualWidth;
						        }
						        
						        if(resultGrid_width > columns_width) {
						        	const width_id = gridOptions2.columnApi.getColumn("ID").actualWidth
						        	const width_seq = gridOptions2.columnApi.getColumn("seq").actualWidth
						        	
						        	columnDefs2[1]['minWidth'] = width_id;
						        	columnDefs2[2]['minWidth'] = width_seq;
						        	gridOptions2.api.setColumnDefs(columnDefs2);
						        	gridOptions2.api.sizeColumnsToFit();
						        }
						        
						        gridOptions.api.sizeColumnsToFit();
						        
						        
						        
						        const selectEl = document.getElementById('Enzyme_Select');
								selectEl.innerHTML = `<option data-enzyme="-">- Select All -</option>`;
								
								const enzymes_arr = params.data.restriction_enzymes.split(",");
								for(let i=0 ; i<enzymes_arr.length ; i++) {
									selectEl.insertAdjacentHTML('beforeend',`<option data-enzyme="${enzymes_arr[i]}">${enzymes_arr[i]}</option>`);
								}
								
						        
						        //$("#Loading").modal('hide');
						    };
						    reader.readAsBinaryString(file);
						})
						
						break;
					case 2:
						alert("분석에 실패했습니다.");
						break;
				}

			} 
		}
	};

	var columnDefs2 = [
		{
			headerName: '',
			field: 'checkbox',
			maxWidth: 50,
			minWidth: 50,
			//checkboxSelection: (params) => params.node.rowIndex % 3 == 0 ? true : false,
			//checkboxSelection: (params) => gridOptions.api.getSelectedRows()[0]['marker_category'] == 'KASP' ? !!(params.node.rowIndex % 3 == 0) : !!(params.node.rowIndex % 2 == 0),
			checkboxSelection: (params) => document.getElementById('Marker_Info').dataset.marker_category == 'KASP' ? !!(params.node.rowIndex % 3 == 0) : !!(params.node.rowIndex % 2 == 0),
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			pinned: 'left',
			rowSpan: (params) => document.getElementById('Marker_Info').dataset.marker_category == 'KASP' ? (params.node.rowIndex % 3 == 0 ? 3 : 0) : (params.node.rowIndex % 2 == 0 ? 2 : 0),
	    },
		{
			headerName: "ID", 
			field: 'ID',
			filter: 'agTextColumnFilter',
			//suppressMenu: true, 
		},
		{
			headerName: "seq",
			field: "seq",
			suppressMenu: true,
		},
		{
			field: "Product_size", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['lessThanOrEqual','greaterThanOrEqual','inRange'],
			}
		},
		{
			field: "Any", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['lessThanOrEqual','greaterThanOrEqual','inRange'],
			}
		},
		{
			field: "3'", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['lessThanOrEqual','greaterThanOrEqual','inRange'],
				inRangeInclusive: true,
			}
		},
		{
			field: "End_stability", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				//buttons: ['reset'],
				maxNumConditions: 1,
				//numAlwaysVisibleConditions: 1,
				filterOptions: ['lessThanOrEqual','greaterThanOrEqual','inRange'],
			}
		},
		{
			field: "Hairpin", 
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['lessThanOrEqual','greaterThanOrEqual','inRange'],
			}
		},
		{
			field: "Penalty",
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['lessThanOrEqual','greaterThanOrEqual','inRange'],
			}
		},
		{
			field: "Compl_any",
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['lessThanOrEqual','greaterThanOrEqual','inRange'],
			}
		},
		{
			field: "Compl_end",
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['lessThanOrEqual','greaterThanOrEqual','inRange'],
			}
		},
		{
			headerName: "matched",
			field: "matched",
			filter: 'agNumberColumnFilter',
			filterParams: {
				filterOptions: ['lessThanOrEqual','greaterThanOrEqual','inRange'],
			}
		},
	]

	let removed_nodes = new Array();
	
	var gridOptions2 = {
			defaultColDef: { 
				editable: false, 
				sortable: false, 
				resizable: true,
				suppressMenu: false, 
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			columnDefs: columnDefs2,
			colResizeDefault: "shift",
			suppressDragLeaveHidesColumns: true,
			//suppressRowClickSelection: true,
			suppressRowTransform: true,
			rowHeight: 35,
			rowMultiSelectWithClick: true,
			rowSelection: "multiple",
			animateRows: true,
			//getRowId: params => params['data']['ID'],
			onCellClicked: (params) => {
			},
			onRowSelected: (params) => {
				const is_selected = params.node.selected;
				
				const marker_category = document.getElementById('Marker_Info').dataset.marker_category;
				
				const row_index = marker_category == 'KASP' ? (params.node.rowIndex - (params.node.rowIndex % 3)) : (params.node.rowIndex - (params.node.rowIndex % 2));
				
				gridOptions2.api.forEachNode(node => {
					if(node.rowIndex ==  row_index || node.rowIndex ==  row_index+1 || (marker_category=='KASP' && node.rowIndex ==  row_index+2) ) {
						node.setSelected(is_selected);
					}
				})
			},
			onFilterChanged: (params) => {
				//필터링을 끝낸 이후에는 제거조건용 배열 초기화
				removed_nodes = [];
			},
			isExternalFilterPresent: () => {
				return Object.keys(gridOptions2.api.getFilterModel()).length == 0 ? false : true;
			},
			doesExternalFilterPass: (node) => {
				//console.log(node);
				
				const filtered_columns = gridOptions2.api.getFilterModel();
				
				//debugger;
				
				if(removed_nodes.length == 0 ) {
					gridOptions2.api.forEachNode(node => {
						for(column in filtered_columns) {
							
							switch(filtered_columns[column]['type']) {
								case "lessThanOrEqual":
									if( !(node['data'][column] <= filtered_columns[column]['filter']) ) {
										//removed_nodes.push(node.id.slice(0, node.id.lastIndexOf("-")));
										removed_nodes.push(node.data.ID.slice(0, node.data.ID.lastIndexOf("-")));
									}
									break;
								case "greaterThanOrEqual":
									if( !(filtered_columns[column]['filter'] <= node['data'][column]) ) {
										removed_nodes.push(node.data.ID.slice(0, node.data.ID.lastIndexOf("-")));
									}
									break;
								case "inRange":
									if ( !(filtered_columns[column]['filter'] <= node['data'][column] && node['data'][column] <= filtered_columns[column]['filterTo']) ) {
										removed_nodes.push(node.data.ID.slice(0, node.data.ID.lastIndexOf("-")));
									} 
									break;
							}
							
						}
					});
				}
				
				//return removed_nodes.includes(node.id.slice(0, node.id.lastIndexOf("-"))) ? false : true;
				return removed_nodes.includes(node.data.ID.slice(0, node.data.ID.lastIndexOf("-"))) ? false : true;
			},
			defaultCsvExportParams: {
				columnKeys: ["ID", "seq", "Product_size","Any","3'","End_stability","Hairpin","Penalty","Compl_any","Compl_end","matched"]
			},
			defaultExcelExportParams: {
				columnKeys: ["ID", "seq", "Product_size","Any","3'","End_stability","Hairpin","Penalty","Compl_any","Compl_end","matched"]
			}
	}
	
	const enzyme_columnDefs = [
		{
			checkboxSelection: true,
			headerCheckboxSelectionFilteredOnly: true,
			headerCheckboxSelection: true,
			minWidth:50,
			maxWidth:50,
			pinned: 'left',
		},
		{
			field: 'N'
		},
		{
			field: 'Enzyme'
		},
		{
			field: 'Size'
		},
		{
			field: 'Price'
		},
		{
			field: 'Price for 1000 U'
		},
		{
			field: 'Recognition Sequence'
		},
		{
			field: 'Seq'
		},
	];
	
	const enzyme_gridOptions = {
			defaultColDef: { 
				editable: false, 
				sortable: false, 
				resizable: true,
				filter: 'agTextColumnFilter',
				cellClass: "grid-cell-centered", 
				menuTabs: ['filterMenuTab'], 
			},
			animateRows: true,
			columnDefs: enzyme_columnDefs,
			colResizeDefault: "shift",
			suppressDragLeaveHidesColumns: true,
			suppressRowTransform: true,
			rowHeight: 35,
			rowMultiSelectWithClick: true,
			rowSelection: "multiple",
			rowData: [{"N":"261","Enzyme":"BstZ17I","Size":"1000","Price":"67","Price for 1000 U":"67","Recognition Sequence":"G/GTNACC","Seq":"GGTNACC"},{"N":"262","Enzyme":"DraIII","Size":"1000","Price":"67","Price for 1000 U":"67","Recognition Sequence":"CACNNN/GTG","Seq":"CACNNNGTG"},{"N":"263","Enzyme":"ScaI","Size":"1000","Price":"64","Price for 1000 U":"64","Recognition Sequence":"AGT/ACT","Seq":"AGTACT"},{"N":"138","Enzyme":"HindIII","Size":"10000","Price":"58","Price for 1000 U":"6","Recognition Sequence":"A/AGCTT","Seq":"AAGCTT"},{"N":"124","Enzyme":"EcoRI","Size":"10000","Price":"58","Price for 1000 U":"6","Recognition Sequence":"G/AATTC","Seq":"GAATTC"},{"N":"29","Enzyme":"BamHI","Size":"10000","Price":"58","Price for 1000 U":"6","Recognition Sequence":"G/GATCC","Seq":"GGATCC"},{"N":"215","Enzyme":"PstI","Size":"10000","Price":"63","Price for 1000 U":"6","Recognition Sequence":"CTGCA/G","Seq":"CTGCAG"},{"N":"71","Enzyme":"BsoBI","Size":"10000","Price":"63","Price for 1000 U":"6","Recognition Sequence":"C/YCGRG","Seq":"CYCGRG"},{"N":"217","Enzyme":"PvuII","Size":"5000","Price":"58","Price for 1000 U":"12","Recognition Sequence":"CAG/CTG","Seq":"CAGCTG"},{"N":"139","Enzyme":"HinfI","Size":"5000","Price":"60","Price for 1000 U":"12","Recognition Sequence":"G/ANTC","Seq":"GANTC"},{"N":"169","Enzyme":"MspI","Size":"5000","Price":"63","Price for 1000 U":"13","Recognition Sequence":"C/CGG","Seq":"CCGG"},{"N":"30","Enzyme":"BanI","Size":"5000","Price":"66","Price for 1000 U":"13","Recognition Sequence":"G/GYRCC","Seq":"GGYRCC"},{"N":"257","Enzyme":"XhoI","Size":"5000","Price":"68","Price for 1000 U":"14","Recognition Sequence":"C/TCGAG","Seq":"CTCGAG"},{"N":"17","Enzyme":"ApaI","Size":"5000","Price":"68","Price for 1000 U":"14","Recognition Sequence":"GGGCC/C","Seq":"GGGCCC"},{"N":"125","Enzyme":"EcoRV","Size":"4000","Price":"58","Price for 1000 U":"15","Recognition Sequence":"GAT/ATC","Seq":"GATATC"},{"N":"246","Enzyme":"TaqI","Size":"4000","Price":"60","Price for 1000 U":"15","Recognition Sequence":"T/CGA","Seq":"TCGA"},{"N":"181","Enzyme":"NdeI","Size":"4000","Price":"63","Price for 1000 U":"16","Recognition Sequence":"CA/TATG","Seq":"CATATG"},{"N":"155","Enzyme":"KpnI","Size":"4000","Price":"63","Price for 1000 U":"16","Recognition Sequence":"GGTAC/C","Seq":"GGTACC"},{"N":"92","Enzyme":"BstNI","Size":"3000","Price":"58","Price for 1000 U":"19","Recognition Sequence":"CC/WGG","Seq":"CCWGG"},{"N":"39","Enzyme":"BclI","Size":"3000","Price":"58","Price for 1000 U":"19","Recognition Sequence":"T/GATCA","Seq":"TGATCA"},{"N":"134","Enzyme":"HaeIII","Size":"3000","Price":"61","Price for 1000 U":"20","Recognition Sequence":"GG/CC","Seq":"GGCC"},{"N":"244","Enzyme":"StyI","Size":"3000","Price":"68","Price for 1000 U":"23","Recognition Sequence":"C/CWWGG","Seq":"CCWWGG"},{"N":"232","Enzyme":"SfiI","Size":"3000","Price":"68","Price for 1000 U":"23","Recognition Sequence":"GGCCNNNN/NGGCC","Seq":"GGCCNNNNNGGCC"},{"N":"255","Enzyme":"XbaI","Size":"3000","Price":"68","Price for 1000 U":"23","Recognition Sequence":"T/CTAGA","Seq":"TCTAGA"},{"N":"90","Enzyme":"BstBI","Size":"2500","Price":"60","Price for 1000 U":"24","Recognition Sequence":"TT/CGAA","Seq":"TTCGAA"},{"N":"18","Enzyme":"ApaLI","Size":"2500","Price":"63","Price for 1000 U":"25","Recognition Sequence":"G/TGCAC","Seq":"GTGCAC"},{"N":"45","Enzyme":"BglII","Size":"2000","Price":"58","Price for 1000 U":"29","Recognition Sequence":"A/GATCT","Seq":"AGATCT"},{"N":"198","Enzyme":"PaeR7I","Size":"2000","Price":"58","Price for 1000 U":"29","Recognition Sequence":"C/TCGAG","Seq":"CTCGAG"},{"N":"220","Enzyme":"SacI","Size":"2000","Price":"58","Price for 1000 U":"29","Recognition Sequence":"GAGCT/C","Seq":"GAGCTC"},{"N":"44","Enzyme":"BglI","Size":"2000","Price":"58","Price for 1000 U":"29","Recognition Sequence":"GCCNNNN/NGGC","Seq":"GCCNNNNNGGC"},{"N":"136","Enzyme":"HhaI","Size":"2000","Price":"58","Price for 1000 U":"29","Recognition Sequence":"GCG/C","Seq":"GCGC"},{"N":"91","Enzyme":"BstEII","Size":"2000","Price":"60","Price for 1000 U":"30","Recognition Sequence":"G/GTNACC","Seq":"GGTNACC"},{"N":"133","Enzyme":"HaeII","Size":"2000","Price":"60","Price for 1000 U":"30","Recognition Sequence":"RGCGC/Y","Seq":"RGCGCY"},{"N":"235","Enzyme":"SmaI","Size":"2000","Price":"61","Price for 1000 U":"31","Recognition Sequence":"CCC/GGG","Seq":"CCCGGG"},{"N":"221","Enzyme":"SacII","Size":"2000","Price":"61","Price for 1000 U":"31","Recognition Sequence":"CCGC/GG","Seq":"CCGCGG"},{"N":"222","Enzyme":"SalI","Size":"2000","Price":"61","Price for 1000 U":"31","Recognition Sequence":"G/TCGAC","Seq":"GTCGAC"},{"N":"74","Enzyme":"BspDI","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"AT/CGAT","Seq":"ATCGAT"},{"N":"22","Enzyme":"AseI","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"AT/TAAT","Seq":"ATTAAT"},{"N":"142","Enzyme":"HpaII","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"C/CGG","Seq":"CCGG"},{"N":"179","Enzyme":"NciI","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"CC/SGG","Seq":"CCSGG"},{"N":"9","Enzyme":"AflII","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"C/TTAAG","Seq":"CTTAAG"},{"N":"24","Enzyme":"AvaI","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"C/YCGRG","Seq":"CYCGRG"},{"N":"200","Enzyme":"PflFI","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"GACN/NNGTC","Seq":"GACNNNGTC"},{"N":"25","Enzyme":"AvaII","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"G/GWCC","Seq":"GGWCC"},{"N":"55","Enzyme":"BsaHI","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"GR/CGYC","Seq":"GRCGYC"},{"N":"95","Enzyme":"BstYI","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"R/GATCY","Seq":"RGATCY"},{"N":"122","Enzyme":"EcoO109I","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"RG/GNCCY","Seq":"RGGNCCY"},{"N":"113","Enzyme":"DraI","Size":"2000","Price":"63","Price for 1000 U":"32","Recognition Sequence":"TTT/AAA","Seq":"TTTAAA"},{"N":"245","Enzyme":"SwaI","Size":"2000","Price":"66","Price for 1000 U":"33","Recognition Sequence":"ATTT/AAAT","Seq":"ATTTAAAT"},{"N":"208","Enzyme":"PmlI","Size":"2000","Price":"66","Price for 1000 U":"33","Recognition Sequence":"CAC/GTG","Seq":"CACGTG"},{"N":"54","Enzyme":"BsaBI","Size":"2000","Price":"66","Price for 1000 U":"33","Recognition Sequence":"GATNN/NNATC","Seq":"GATNNNNATC"},{"N":"140","Enzyme":"HinP1I","Size":"2000","Price":"66","Price for 1000 U":"33","Recognition Sequence":"G/CGC","Seq":"GCGC"},{"N":"3","Enzyme":"Acc65I","Size":"2000","Price":"66","Price for 1000 U":"33","Recognition Sequence":"G/GTACC","Seq":"GGTACC"},{"N":"31","Enzyme":"BanII","Size":"2000","Price":"66","Price for 1000 U":"33","Recognition Sequence":"GRGCY/C","Seq":"GRGCYC"},{"N":"101","Enzyme":"BtsCI","Size":"2000","Price":"68","Price for 1000 U":"34","Recognition Sequence":"GGATG(2/0)","Seq":"GGATG"},{"N":"109","Enzyme":"CviQI","Size":"2000","Price":"68","Price for 1000 U":"34","Recognition Sequence":"G/TAC","Seq":"GTAC"},{"N":"213","Enzyme":"PspOMI","Size":"1500","Price":"60","Price for 1000 U":"40","Recognition Sequence":"G/GGCCC","Seq":"GGGCCC"},{"N":"120","Enzyme":"Eco53kI","Size":"1000","Price":"58","Price for 1000 U":"58","Recognition Sequence":"GAG/CTC","Seq":"GAGCTC"},{"N":"218","Enzyme":"RsaI","Size":"1000","Price":"58","Price for 1000 U":"58","Recognition Sequence":"GT/AC","Seq":"GTAC"},{"N":"188","Enzyme":"NruI","Size":"1000","Price":"58","Price for 1000 U":"58","Recognition Sequence":"TCG/CGA","Seq":"TCGCGA"},{"N":"93","Enzyme":"BstUI","Size":"1000","Price":"60","Price for 1000 U":"60","Recognition Sequence":"CG/CG","Seq":"CGCG"},{"N":"137","Enzyme":"HincII","Size":"1000","Price":"60","Price for 1000 U":"60","Recognition Sequence":"GTY/RAC","Seq":"GTYRAC"},{"N":"242","Enzyme":"StuI","Size":"1000","Price":"61","Price for 1000 U":"61","Recognition Sequence":"AGG/CCT","Seq":"AGGCCT"},{"N":"180","Enzyme":"NcoI","Size":"1000","Price":"61","Price for 1000 U":"61","Recognition Sequence":"C/CATGG","Seq":"CCATGG"},{"N":"259","Enzyme":"XmnI","Size":"1000","Price":"61","Price for 1000 U":"61","Recognition Sequence":"GAANN/NNTTC","Seq":"GAANNNNTTC"},{"N":"225","Enzyme":"Sau96I","Size":"1000","Price":"61","Price for 1000 U":"61","Recognition Sequence":"G/GNCC","Seq":"GGNCC"},{"N":"160","Enzyme":"MluCI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"/AATT","Seq":"AATT"},{"N":"161","Enzyme":"MluI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"A/CGCGT","Seq":"ACGCGT"},{"N":"84","Enzyme":"BsrI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"ACTGG(1/-1)","Seq":"ACTGG"},{"N":"105","Enzyme":"ClaI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"AT/CGAT","Seq":"ATCGAT"},{"N":"189","Enzyme":"NsiI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"ATGCA/T","Seq":"ATGCAT"},{"N":"201","Enzyme":"PflMI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"CCANNNN/NTGG","Seq":"CCANNNNNTGG"},{"N":"66","Enzyme":"BslI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"CCNNNNN/NNGG","Seq":"CCNNNNNNNGG"},{"N":"98","Enzyme":"BtgI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"C/CRYGG","Seq":"CCRYGG"},{"N":"97","Enzyme":"Bsu36I","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"CC/TNAGG","Seq":"CCTNAGG"},{"N":"212","Enzyme":"PspGI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"/CCWGG","Seq":"CCWGG"},{"N":"162","Enzyme":"MlyI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"GAGTC(5/5)","Seq":"GAGTC"},{"N":"205","Enzyme":"PleI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"GAGTC(4/5)","Seq":"GAGTC"},{"N":"111","Enzyme":"DpnI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"GA/TC","Seq":"GATC"},{"N":"182","Enzyme":"NgoMIV","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"G/CCGGC","Seq":"GCCGGC"},{"N":"143","Enzyme":"HphI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"GGTGA(8/7)","Seq":"GGTGA"},{"N":"64","Enzyme":"BsiHKAI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"GWGCW/C","Seq":"GWGCWC"},{"N":"81","Enzyme":"BsrFI","Size":"1000","Price":"63","Price for 1000 U":"63","Recognition Sequence":"R/CCGGY","Seq":"RCCGGY"},{"N":"14","Enzyme":"AluI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"AG/CT","Seq":"AGCT"},{"N":"256","Enzyme":"XcmI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"CCANNNNN/NNNNTGG","Seq":"CCANNNNNNNNNTGG"},{"N":"94","Enzyme":"BstXI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"CCANNNNN/NTGG","Seq":"CCANNNNNNTGG"},{"N":"35","Enzyme":"BccI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"CCATC(4/5)","Seq":"CCATC"},{"N":"79","Enzyme":"BsrBI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"CCGCTC(-3/-3)","Seq":"CCGCTC"},{"N":"228","Enzyme":"ScrFI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"CC/NGG","Seq":"CCNGG"},{"N":"57","Enzyme":"BsaJI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"C/CNNGG","Seq":"CCNNGG"},{"N":"121","Enzyme":"EcoNI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"CCTNN/NNNAGG","Seq":"CCTNNNNNAGG"},{"N":"63","Enzyme":"BsiEI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"CGRY/CG","Seq":"CGRYCG"},{"N":"234","Enzyme":"SgrAI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"CR/CCGGYG","Seq":"CRCCGGYG"},{"N":"110","Enzyme":"DdeI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"C/TNAG","Seq":"CTNAG"},{"N":"210","Enzyme":"PshAI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"GACNN/NNGTC","Seq":"GACNNNNGTC"},{"N":"183","Enzyme":"NheI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"G/CTAGC","Seq":"GCTAGC"},{"N":"129","Enzyme":"FokI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"GGATG(9/13)","Seq":"GGATG"},{"N":"56","Enzyme":"BsaI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"GGTCTC(1/5)","Seq":"GGTCTC"},{"N":"40","Enzyme":"BcoDI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"GTCTC(1/5)","Seq":"GTCTC"},{"N":"67","Enzyme":"BsmAI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"GTCTC(1/5)","Seq":"GTCTC"},{"N":"75","Enzyme":"BspEI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"T/CCGGA","Seq":"TCCGGA"},{"N":"145","Enzyme":"Hpy188I","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"TCN/GA","Seq":"TCNGA"},{"N":"83","Enzyme":"BsrGI","Size":"1000","Price":"66","Price for 1000 U":"66","Recognition Sequence":"T/GTACA","Seq":"TGTACA"},{"N":"241","Enzyme":"SspI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"AAT/ATT","Seq":"AATATT"},{"N":"177","Enzyme":"Nb.BssSI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"CACGAG","Seq":"CACGAG"},{"N":"174","Enzyme":"Nb.BbvCI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"CCTCAGC","Seq":"CCTCAGC"},{"N":"192","Enzyme":"Nt.BbvCI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"CCTCAGC(-5/-7)","Seq":"CCTCAGC"},{"N":"175","Enzyme":"Nb.BsmI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"GAATGC","Seq":"GAATGC"},{"N":"195","Enzyme":"Nt.BstNBI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"GAGTC(4/-5)","Seq":"GAGTC"},{"N":"112","Enzyme":"DpnII","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"/GATC","Seq":"GATC"},{"N":"176","Enzyme":"Nb.BsrDI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"GCAATG","Seq":"GCAATG"},{"N":"178","Enzyme":"Nb.BtsI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"GCAGTG","Seq":"GCAGTG"},{"N":"194","Enzyme":"Nt.BspQI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"GCTCTTC(1/-7)","Seq":"GCTCTTC"},{"N":"144","Enzyme":"Hpy166II","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"GTN/NAC","Seq":"GTNNAC"},{"N":"20","Enzyme":"ApoI","Size":"1000","Price":"68","Price for 1000 U":"68","Recognition Sequence":"R/AATTY","Seq":"RAATTY"},{"N":"12","Enzyme":"AhdI","Size":"1000","Price":"71","Price for 1000 U":"71","Recognition Sequence":"GACNNN/NNGTC","Seq":"GACNNNNNGTC"},{"N":"4","Enzyme":"AccI","Size":"1000","Price":"71","Price for 1000 U":"71","Recognition Sequence":"GT/MKAC","Seq":"GTMKAC"},{"N":"253","Enzyme":"TspRI","Size":"1000","Price":"72","Price for 1000 U":"72","Recognition Sequence":"NNCASTGNN/","Seq":"NNCASTGNN"},{"N":"237","Enzyme":"SnaBI","Size":"500","Price":"58","Price for 1000 U":"116","Recognition Sequence":"TAC/GTA","Seq":"TACGTA"},{"N":"1","Enzyme":"AatII","Size":"500","Price":"60","Price for 1000 U":"120","Recognition Sequence":"GACGT/C","Seq":"GACGTC"},{"N":"172","Enzyme":"NaeI","Size":"500","Price":"60","Price for 1000 U":"120","Recognition Sequence":"GCC/GGC","Seq":"GCCGGC"},{"N":"141","Enzyme":"HpaI","Size":"500","Price":"61","Price for 1000 U":"122","Recognition Sequence":"GTT/AAC","Seq":"GTTAAC"},{"N":"117","Enzyme":"EagI","Size":"500","Price":"63","Price for 1000 U":"126","Recognition Sequence":"C/GGCCG","Seq":"CGGCCG"},{"N":"118","Enzyme":"EarI","Size":"500","Price":"63","Price for 1000 U":"126","Recognition Sequence":"CTCTTC(1/4)","Seq":"CTCTTC"},{"N":"72","Enzyme":"Bsp1286I","Size":"500","Price":"63","Price for 1000 U":"126","Recognition Sequence":"GDGCH/C","Seq":"GDGCHC"},{"N":"233","Enzyme":"SfoI","Size":"500","Price":"63","Price for 1000 U":"126","Recognition Sequence":"GGC/GCC","Seq":"GGCGCC"},{"N":"27","Enzyme":"BaeGI","Size":"500","Price":"63","Price for 1000 U":"126","Recognition Sequence":"GKGCM/C","Seq":"GKGCMC"},{"N":"106","Enzyme":"CspCI","Size":"500","Price":"65","Price for 1000 U":"130","Recognition Sequence":"(11/13)CAANNNNNGTGG(12/10)","Seq":"CAANNNNNGTGG"},{"N":"206","Enzyme":"PluTI","Size":"500","Price":"65","Price for 1000 U":"130","Recognition Sequence":"GGCGC/C","Seq":"GGCGCC"},{"N":"150","Enzyme":"HpyCH4IV","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"A/CGT","Seq":"ACGT"},{"N":"238","Enzyme":"SpeI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"A/CTAGT","Seq":"ACTAGT"},{"N":"13","Enzyme":"AleI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"CACNN/NNGTG","Seq":"CACNNNNGTG"},{"N":"123","Enzyme":"EcoP15I","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"CAGCAG(25/27)","Seq":"CAGCAG"},{"N":"16","Enzyme":"AlwNI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"CAGNNN/CTG","Seq":"CAGNNNCTG"},{"N":"184","Enzyme":"NlaIII","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"CATG/","Seq":"CATG"},{"N":"258","Enzyme":"XmaI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"C/CCGGG","Seq":"CCCGGG"},{"N":"164","Enzyme":"MnlI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"CCTC(7/6)","Seq":"CCTC"},{"N":"52","Enzyme":"BpuEI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"CTTGAG(16/14)","Seq":"CTTGAG"},{"N":"236","Enzyme":"SmlI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"C/TYRAG","Seq":"CTYRAG"},{"N":"70","Enzyme":"BsmI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"GAATGC(1/-1)","Seq":"GAATGC"},{"N":"247","Enzyme":"TfiI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"G/AWTC","Seq":"GAWTC"},{"N":"100","Enzyme":"BtsI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"GCAGTG(2/0)","Seq":"GCAGTG"},{"N":"239","Enzyme":"SphI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"GCATG/C","Seq":"GCATGC"},{"N":"23","Enzyme":"AsiSI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"GCGAT/CGC","Seq":"GCGATCGC"},{"N":"85","Enzyme":"BssHII","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"G/CGCGC","Seq":"GCGCGC"},{"N":"15","Enzyme":"AlwI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"GGATC(4/5)","Seq":"GGATC"},{"N":"173","Enzyme":"NarI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"GG/CGCC","Seq":"GGCGCC"},{"N":"21","Enzyme":"AscI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"GG/CGCGCC","Seq":"GGCGCGCC"},{"N":"209","Enzyme":"PpuMI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"RG/GWCCY","Seq":"RGGWCCY"},{"N":"76","Enzyme":"BspHI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"T/CATGA","Seq":"TCATGA"},{"N":"146","Enzyme":"Hpy188III","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"TC/NNGA","Seq":"TCNNGA"},{"N":"132","Enzyme":"FspI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"TGC/GCA","Seq":"TGCGCA"},{"N":"166","Enzyme":"MseI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"T/TAA","Seq":"TTAA"},{"N":"53","Enzyme":"BsaAI","Size":"500","Price":"66","Price for 1000 U":"132","Recognition Sequence":"YAC/GTR","Seq":"YACGTR"},{"N":"47","Enzyme":"BmgBI","Size":"500","Price":"68","Price for 1000 U":"136","Recognition Sequence":"CACGTC(-3/-3)","Seq":"CACGTC"},{"N":"167","Enzyme":"MslI","Size":"500","Price":"68","Price for 1000 U":"136","Recognition Sequence":"CAYNN/NNRTG","Seq":"CAYNNNNRTG"},{"N":"168","Enzyme":"MspA1I","Size":"500","Price":"68","Price for 1000 U":"136","Recognition Sequence":"CMG/CKG","Seq":"CMGCKG"},{"N":"171","Enzyme":"MwoI","Size":"500","Price":"68","Price for 1000 U":"136","Recognition Sequence":"GCNNNNN/NNGC","Seq":"GCNNNNNNNGC"},{"N":"78","Enzyme":"BspQI","Size":"500","Price":"68","Price for 1000 U":"136","Recognition Sequence":"GCTCTTC(1/4)","Seq":"GCTCTTC"},{"N":"191","Enzyme":"Nt.AlwI","Size":"500","Price":"68","Price for 1000 U":"136","Recognition Sequence":"GGATC(4/-5)","Seq":"GGATC"},{"N":"193","Enzyme":"Nt.BsmAI","Size":"500","Price":"68","Price for 1000 U":"136","Recognition Sequence":"GTCTC(1/-5)","Seq":"GTCTC"},{"N":"153","Enzyme":"I-SceI","Size":"500","Price":"68","Price for 1000 U":"136","Recognition Sequence":"TAGGGATAACAGGGTAAT(-9/-13)","Seq":"TAGGGATAACAGGGTAAT"},{"N":"203","Enzyme":"PI-PspI","Size":"500","Price":"68","Price for 1000 U":"136","Recognition Sequence":"TGGCAAACAGCTATTATGGGTATTATGGGT(-13/-17)","Seq":"TGGCAAACAGCTATTATGGGTATTATGGGT"},{"N":"216","Enzyme":"PvuI","Size":"500","Price":"70","Price for 1000 U":"140","Recognition Sequence":"CGAT/CG","Seq":"CGATCG"},{"N":"159","Enzyme":"MfeI","Size":"500","Price":"71","Price for 1000 U":"142","Recognition Sequence":"C/AATTG","Seq":"CAATTG"},{"N":"226","Enzyme":"SbfI","Size":"500","Price":"71","Price for 1000 U":"142","Recognition Sequence":"CCTGCA/GG","Seq":"CCTGCAGG"},{"N":"219","Enzyme":"RsrII","Size":"500","Price":"71","Price for 1000 U":"142","Recognition Sequence":"CG/GWCCG","Seq":"CGGWCCG"},{"N":"41","Enzyme":"BfaI","Size":"500","Price":"71","Price for 1000 U":"142","Recognition Sequence":"C/TAG","Seq":"CTAG"},{"N":"157","Enzyme":"MboI","Size":"500","Price":"71","Price for 1000 U":"142","Recognition Sequence":"/GATC","Seq":"GATC"},{"N":"187","Enzyme":"NotI","Size":"500","Price":"71","Price for 1000 U":"142","Recognition Sequence":"GC/GGCCGC","Seq":"GCGGCCGC"},{"N":"46","Enzyme":"BlpI","Size":"500","Price":"71","Price for 1000 U":"142","Recognition Sequence":"GC/TNAGC","Seq":"GCTNAGC"},{"N":"207","Enzyme":"PmeI","Size":"500","Price":"71","Price for 1000 U":"142","Recognition Sequence":"GTTT/AAAC","Seq":"GTTTAAAC"},{"N":"152","Enzyme":"I-CeuI","Size":"500","Price":"71","Price for 1000 U":"142","Recognition Sequence":"TAACTATAACGGTCCTAAGGTAGCGAA(-9/-13)","Seq":"TAACTATAACGGTCCTAAGGTAGCGAA"},{"N":"254","Enzyme":"Tth111I","Size":"400","Price":"58","Price for 1000 U":"145","Recognition Sequence":"GACN/NNGTC","Seq":"GACNNNGTC"},{"N":"240","Enzyme":"SrfI","Size":"500","Price":"76","Price for 1000 U":"152","Recognition Sequence":"GCCC/GGGC","Seq":"GCCCGGGC"},{"N":"43","Enzyme":"BfuCI","Size":"400","Price":"63","Price for 1000 U":"158","Recognition Sequence":"/GATC","Seq":"GATC"},{"N":"7","Enzyme":"AcuI","Size":"300","Price":"63","Price for 1000 U":"210","Recognition Sequence":"CTGAAG(16/14)","Seq":"CTGAAG"},{"N":"6","Enzyme":"AclI","Size":"300","Price":"66","Price for 1000 U":"220","Recognition Sequence":"AA/CGTT","Seq":"AACGTT"},{"N":"65","Enzyme":"BsiWI","Size":"300","Price":"66","Price for 1000 U":"220","Recognition Sequence":"C/GTACG","Seq":"CGTACG"},{"N":"158","Enzyme":"MboII","Size":"300","Price":"66","Price for 1000 U":"220","Recognition Sequence":"GAAGA(8/7)","Seq":"GAAGA"},{"N":"32","Enzyme":"BbsI","Size":"300","Price":"66","Price for 1000 U":"220","Recognition Sequence":"GAAGAC(2/6)","Seq":"GAAGAC"},{"N":"115","Enzyme":"DrdI","Size":"300","Price":"66","Price for 1000 U":"220","Recognition Sequence":"GACNNNN/NNGTC","Seq":"GACNNNNNNGTC"},{"N":"34","Enzyme":"BbvI","Size":"300","Price":"66","Price for 1000 U":"220","Recognition Sequence":"GCAGC(8/12)","Seq":"GCAGC"},{"N":"49","Enzyme":"BmtI","Size":"300","Price":"66","Price for 1000 U":"220","Recognition Sequence":"GCTAG/C","Seq":"GCTAGC"},{"N":"11","Enzyme":"AgeI","Size":"300","Price":"70","Price for 1000 U":"233","Recognition Sequence":"A/CCGGT","Seq":"ACCGGT"},{"N":"42","Enzyme":"BfuAI","Size":"250","Price":"63","Price for 1000 U":"252","Recognition Sequence":"ACCTGC(4/8)","Seq":"ACCTGC"},{"N":"28","Enzyme":"BaeI","Size":"250","Price":"63","Price for 1000 U":"252","Recognition Sequence":"(10/15)ACNNNNGTAYC(12/7)","Seq":"ACNNNNGTAYC"},{"N":"149","Enzyme":"HpyCH4III","Size":"250","Price":"66","Price for 1000 U":"264","Recognition Sequence":"ACN/GT","Seq":"ACNGT"},{"N":"10","Enzyme":"AflIII","Size":"250","Price":"66","Price for 1000 U":"264","Recognition Sequence":"A/CRYGT","Seq":"ACRYGT"},{"N":"37","Enzyme":"BcgI","Size":"250","Price":"66","Price for 1000 U":"264","Recognition Sequence":"(10/12)CGANNNNNNTGC(12/10)","Seq":"CGANNNNNNTGC"},{"N":"223","Enzyme":"SapI","Size":"250","Price":"66","Price for 1000 U":"264","Recognition Sequence":"GCTCTTC(1/4)","Seq":"GCTCTTC"},{"N":"154","Enzyme":"KasI","Size":"250","Price":"66","Price for 1000 U":"264","Recognition Sequence":"G/GCGCC","Seq":"GGCGCC"},{"N":"190","Enzyme":"NspI","Size":"250","Price":"66","Price for 1000 U":"264","Recognition Sequence":"RCATG/Y","Seq":"RCATGY"},{"N":"197","Enzyme":"PacI","Size":"250","Price":"67","Price for 1000 U":"268","Recognition Sequence":"TTAAT/TAA","Seq":"TTAATTAA"},{"N":"204","Enzyme":"PI-SceI","Size":"250","Price":"68","Price for 1000 U":"272","Recognition Sequence":"ATCTATGTCGGGTGCGGAGAAAGAGGTAAT(-15/-19)","Seq":"ATCTATGTCGGGTGCGGAGAAAGAGGTAAT"},{"N":"186","Enzyme":"NmeAIII","Size":"250","Price":"68","Price for 1000 U":"272","Recognition Sequence":"GCCGAG(21/19)","Seq":"GCCGAG"},{"N":"19","Enzyme":"ApeKI","Size":"250","Price":"68","Price for 1000 U":"272","Recognition Sequence":"G/CWGC","Seq":"GCWGC"},{"N":"108","Enzyme":"CviKI-1","Size":"250","Price":"68","Price for 1000 U":"272","Recognition Sequence":"RG/CY","Seq":"RGCY"},{"N":"165","Enzyme":"MscI","Size":"250","Price":"68","Price for 1000 U":"272","Recognition Sequence":"TGG/CCA","Seq":"TGGCCA"},{"N":"58","Enzyme":"BsaWI","Size":"250","Price":"71","Price for 1000 U":"284","Recognition Sequence":"W/CCGGW","Seq":"WCCGGW"},{"N":"224","Enzyme":"Sau3AI","Size":"200","Price":"60","Price for 1000 U":"300","Recognition Sequence":"/GATC","Seq":"GATC"},{"N":"107","Enzyme":"CviAII","Size":"200","Price":"63","Price for 1000 U":"315","Recognition Sequence":"C/ATG","Seq":"CATG"},{"N":"243","Enzyme":"StyD4I","Size":"200","Price":"63","Price for 1000 U":"315","Recognition Sequence":"/CCNGG","Seq":"CCNGG"},{"N":"231","Enzyme":"SfcI","Size":"200","Price":"63","Price for 1000 U":"315","Recognition Sequence":"C/TRYAG","Seq":"CTRYAG"},{"N":"260","Enzyme":"ZraI","Size":"200","Price":"63","Price for 1000 U":"315","Recognition Sequence":"GAC/GTC","Seq":"GACGTC"},{"N":"80","Enzyme":"BsrDI","Size":"200","Price":"63","Price for 1000 U":"315","Recognition Sequence":"GCAATG(2/0)","Seq":"GCAATG"},{"N":"38","Enzyme":"BciVI","Size":"200","Price":"63","Price for 1000 U":"315","Recognition Sequence":"GTATCC(6/5)","Seq":"GTATCC"},{"N":"116","Enzyme":"EaeI","Size":"200","Price":"63","Price for 1000 U":"315","Recognition Sequence":"Y/GGCCR","Seq":"YGGCCR"},{"N":"229","Enzyme":"SexAI","Size":"200","Price":"66","Price for 1000 U":"330","Recognition Sequence":"A/CCWGGT","Seq":"ACCWGGT"},{"N":"5","Enzyme":"AciI","Size":"200","Price":"66","Price for 1000 U":"330","Recognition Sequence":"CCGC(-3/-1)","Seq":"CCGC"},{"N":"51","Enzyme":"Bpu10I","Size":"200","Price":"66","Price for 1000 U":"330","Recognition Sequence":"CCTNAGC(-5/-2)","Seq":"CCTNAGC"},{"N":"128","Enzyme":"Fnu4HI","Size":"200","Price":"66","Price for 1000 U":"330","Recognition Sequence":"GC/NGC","Seq":"GCNGC"},{"N":"185","Enzyme":"NlaIV","Size":"200","Price":"66","Price for 1000 U":"330","Recognition Sequence":"GGN/NCC","Seq":"GGNNCC"},{"N":"199","Enzyme":"PciI","Size":"200","Price":"68","Price for 1000 U":"340","Recognition Sequence":"A/CATGT","Seq":"ACATGT"},{"N":"8","Enzyme":"AfeI","Size":"200","Price":"68","Price for 1000 U":"340","Recognition Sequence":"AGC/GCT","Seq":"AGCGCT"},{"N":"127","Enzyme":"FauI","Size":"200","Price":"68","Price for 1000 U":"340","Recognition Sequence":"CCCGC(4/6)","Seq":"CCCGC"},{"N":"252","Enzyme":"TspMI","Size":"200","Price":"68","Price for 1000 U":"340","Recognition Sequence":"C/CCGGG","Seq":"CCCGGG"},{"N":"250","Enzyme":"Tsp45I","Size":"200","Price":"68","Price for 1000 U":"340","Recognition Sequence":"/GTSAC","Seq":"GTSAC"},{"N":"214","Enzyme":"PspXI","Size":"200","Price":"68","Price for 1000 U":"340","Recognition Sequence":"VC/TCGAGB","Seq":"VCTCGAGB"},{"N":"87","Enzyme":"BssSI","Size":"200","Price":"71","Price for 1000 U":"355","Recognition Sequence":"CACGAG(-5/-1)","Seq":"CACGAG"},{"N":"68","Enzyme":"BsmBI","Size":"200","Price":"71","Price for 1000 U":"355","Recognition Sequence":"CGTCTC(1/5)","Seq":"CGTCTC"},{"N":"60","Enzyme":"BseRI","Size":"200","Price":"71","Price for 1000 U":"355","Recognition Sequence":"GAGGAG(10/8)","Seq":"GAGGAG"},{"N":"230","Enzyme":"SfaNI","Size":"300","Price":"117","Price for 1000 U":"390","Recognition Sequence":"GCATC(5/9)","Seq":"GCATC"},{"N":"89","Enzyme":"BstAPI","Size":"200","Price":"90","Price for 1000 U":"450","Recognition Sequence":"GCANNNN/NTGC","Seq":"GCANNNNNTGC"},{"N":"131","Enzyme":"FspEI","Size":"200","Price":"106","Price for 1000 U":"530","Recognition Sequence":"CC(12/16)","Seq":"CC"},{"N":"156","Enzyme":"LpnPI","Size":"200","Price":"106","Price for 1000 U":"530","Recognition Sequence":"CCDG(10/14)","Seq":"CCDG"},{"N":"170","Enzyme":"MspJI","Size":"200","Price":"106","Price for 1000 U":"530","Recognition Sequence":"CNNR(9/13)","Seq":"CNNR"},{"N":"211","Enzyme":"PsiI","Size":"200","Price":"112","Price for 1000 U":"560","Recognition Sequence":"TTA/TAA","Seq":"TTATAA"},{"N":"33","Enzyme":"BbvCI","Size":"100","Price":"63","Price for 1000 U":"630","Recognition Sequence":"CCTCAGC(-5/-2)","Seq":"CCTCAGC"},{"N":"73","Enzyme":"BspCNI","Size":"100","Price":"63","Price for 1000 U":"630","Recognition Sequence":"CTCAG(9/7)","Seq":"CTCAG"},{"N":"119","Enzyme":"EciI","Size":"100","Price":"63","Price for 1000 U":"630","Recognition Sequence":"GGCGGA(11/9)","Seq":"GGCGGA"},{"N":"77","Enzyme":"BspMI","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"ACCTGC(4/8)","Seq":"ACCTGC"},{"N":"59","Enzyme":"BsaXI","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"(9/12)ACNNNNNCTCC(10/7)","Seq":"ACNNNNNCTCC"},{"N":"48","Enzyme":"BmrI","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"ACTGGG(5/4)","Seq":"ACTGGG"},{"N":"61","Enzyme":"BseYI","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"CCCAGC(-5/-1)","Seq":"CCCAGC"},{"N":"147","Enzyme":"Hpy99I","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"CGWCG/","Seq":"CGWCG"},{"N":"50","Enzyme":"BpmI","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"CTGGAG(16/14)","Seq":"CTGGAG"},{"N":"135","Enzyme":"HgaI","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"GACGC(5/10)","Seq":"GACGC"},{"N":"99","Enzyme":"BtgZI","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"GCGATG(10/14)","Seq":"GCGATG"},{"N":"163","Enzyme":"MmeI","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"TCCRAC(20/18)","Seq":"TCCRAC"},{"N":"151","Enzyme":"HpyCH4V","Size":"100","Price":"66","Price for 1000 U":"660","Recognition Sequence":"TG/CA","Seq":"TGCA"},{"N":"26","Enzyme":"AvrII","Size":"100","Price":"68","Price for 1000 U":"680","Recognition Sequence":"C/CTAGG","Seq":"CCTAGG"},{"N":"148","Enzyme":"HpyAV","Size":"100","Price":"68","Price for 1000 U":"680","Recognition Sequence":"CCTTC(6/5)","Seq":"CCTTC"},{"N":"69","Enzyme":"BsmFI","Size":"100","Price":"68","Price for 1000 U":"680","Recognition Sequence":"GGGAC(10/14)","Seq":"GGGAC"},{"N":"104","Enzyme":"Cac8I","Size":"100","Price":"71","Price for 1000 U":"710","Recognition Sequence":"GCN/NGC","Seq":"GCNNGC"},{"N":"130","Enzyme":"FseI","Size":"100","Price":"71","Price for 1000 U":"710","Recognition Sequence":"GGCCGG/CC","Seq":"GGCCGGCC"},{"N":"249","Enzyme":"TseI","Size":"75","Price":"63","Price for 1000 U":"840","Recognition Sequence":"G/CWGC","Seq":"GCWGC"},{"N":"103","Enzyme":"BtsIMutI","Size":"100","Price":"101","Price for 1000 U":"1010","Recognition Sequence":"CAGTG(2/0)","Seq":"CAGTG"},{"N":"36","Enzyme":"BceAI","Size":"50","Price":"63","Price for 1000 U":"1260","Recognition Sequence":"ACGGC(12/14)","Seq":"ACGGC"},{"N":"62","Enzyme":"BsgI","Size":"50","Price":"66","Price for 1000 U":"1320","Recognition Sequence":"GTGCAG(16/14)","Seq":"GTGCAG"},{"N":"126","Enzyme":"FatI","Size":"50","Price":"90","Price for 1000 U":"1800","Recognition Sequence":"/CATG","Seq":"CATG"}],
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
  		fetch("./pd_json.jsp?varietyid="+$( "#variety-select option:selected" ).val() )
  		.then((response) => response.json())
  		.then((data) => {
  			console.log(data);
			gridOptions.api.setRowData(data);
			gridOptions.api.sizeColumnsToFit();
  		})
  		
  		const resultGrid = new agGrid.Grid(document.getElementById('resultGrid'), gridOptions2);
  		
  		new agGrid.Grid(document.getElementById('Enzyme_Grid'), enzyme_gridOptions);
  	});

	/*** SET OR REMOVE EMAIL AS PINNED DEPENDING ON DEVICE SIZE ***/
	
  	document.addEventListener('click', function(event) {
  		if(event.composedPath()[0].classList.contains("nav-link")) {
  			$("html").animate({ scrollTop: $(document).height() }, 1000);
  		}
  	});
	
	$(window).on("resize", function() {
		gridOptions.api.sizeColumnsToFit();
	});
  
	//console.log(gridOptions);
	
