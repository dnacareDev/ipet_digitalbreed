	var $budgetStrokeColor2 = '#dcdae3';
	var $goalStrokeColor2 = '#51e5a8';
	var $strokeColor = '#ebe9f1';
	var $textHeadingColor = '#5e5873';
	
	var $primary = '#7367F0',
	    $success = '#28C76F',
	    $danger = '#EA5455',
	    $warning = '#FF9F43',
	    $info = '#00cfe8',
	    $label_color_light = '#dae1e7';
	
	var themeColors = [$primary, $success, $danger, $warning, $info];
	
	var chartColors = {
	      		column: {
		      		series1: '#826af9',
		      		series2: '#d2b0ff',
		      		bg: 'transparent'
			    }
	}
	
	function goalOverviewChart() {
		const $goalOverviewChart = document.querySelector('#goal-overview-radial-bar-chart');  
		//------------ Goal Overview Chart ------------
		//---------------------------------------------
		goalOverviewChartOptions = {
				chart: {
					height: 245,
					type: 'radialBar',
					sparkline: {
				        enabled: true
				    },
				    dropShadow: {		// 그림자 설정
				        enabled: true,	
				        blur: 3,
				        left: 1,
				        top: 1,
				        opacity: 0.2
				    }
				},
				colors: [$goalStrokeColor2],
				plotOptions: {
					radialBar: {
				        offsetY: -10,
				        startAngle: -150,
				        endAngle: 150,
				        hollow: {
				          size: '77%'
				        },
				        track: {
				          background: $strokeColor,
				          strokeWidth: '50%'
				        },
				        dataLabels: {
				        	name: {
				        		show: false
				        	},
				        	value: {
				        		color: $textHeadingColor,
				        		//fontSize: '2.86rem',
				        		fontSize: '20px',
				        		fontWeight: '600'
				        	}
				        }
					}
			    },
			    fill: {
			    	type: 'gradient',
			    	gradient: {
				        shade: 'dark',
				        type: 'horizontal',
				        shadeIntensity: 0.5,
				        //gradientToColors: [window.colors.solid.success],
				        inverseColors: true,
				        opacityFrom: 1,
				        opacityTo: 1,
				        stops: [0, 100]
				    }
			    },
			    series: [percentSize],
			    stroke: {
			      lineCap: 'round'
			    },
			    grid: {
			    	padding: {
			    		bottom: 30
			    	}
			    }
			};
		const goalOverviewChart = new ApexCharts($goalOverviewChart, goalOverviewChartOptions);
		goalOverviewChart.render();
	}
	
	async function barChart() {
		
		// Column Chart
		// --------------------------------------------------------------------
		const columnChartEl = document.querySelector('#column-chart');
		const columnChartConfig = {
				chart: {
			        height: 345,
			        type: 'bar',
			        stacked: true,
			        parentHeightOffset: 0,
			        toolbar: {
			          show: false
			        }
			    },
			    plotOptions: {
			    	bar: {
			    		columnWidth: '15%',
			    		colors: {
			    			backgroundBarColors: [
			    				chartColors.column.bg,
			    				chartColors.column.bg,
			    				chartColors.column.bg,
			    				chartColors.column.bg,
			    				chartColors.column.bg
				            ],
				            backgroundBarRadius: 10
			    		},
			    		borderRadius: 5
			        }
			    },
			    dataLabels: {
			    	enabled: false
			    },
			    legend: {
			    	show: true,
			        position: 'top',
			        horizontalAlign: 'start'
			    },
			    colors: [chartColors.column.series1, chartColors.column.series2],
			    stroke: {
			    	show: true,
			        colors: ['transparent']
			    },
			    grid: {
			    	xaxis: {
				        lines: {
				        	show: true
				        }
				    }
			    },
			    series: [],
		    	xaxis: {
		    		categories: ['GWAS', 'GS', 'Genotype Process', 'Genotype Analysis', 'Phetnotype Analysis']
		    	},
		    	fill: {
		    		opacity: 1
		    	},
			};
		
			const chartData = await getBarChartData();
			
			columnChartConfig.series = chartData;
		
		    const columnChart = new ApexCharts(columnChartEl, columnChartConfig);
		    
		    try {
		    	columnChart.destroy();
		    } catch (error) {
		    	//console.error(error);
		    }
		    
		    columnChart.render();
	}

	
	function getBarChartData() {
		const variety_id = $( "#variety-select option:selected" ).val();
		const year = $( "#analysisYear option:selected" ).val();
		const month = $("#analysisMonth option:selected").val();
		
		const inputData = {
				'variety_id': variety_id,
				'year': year,
				'month': month
		}
		
		//console.log(year);
		//console.log(month);
		
		const chartData = [];
		
		$.ajax({
			url: 'statistics_getCompleteCount.jsp',
			method: 'POST',
			async: false,
			dataType : "json",
			data: inputData,
			success: function(complete){
				chartData.push({
		    		name: 'Complete',
		    		data: complete
		        });
			}
		})
		
		
		$.ajax({
			url: 'statistics_getOnProgressCount.jsp',
			method: 'POST',
			async: false,
			dataType : "json",
			data: inputData,
			success: function(incomplete){
				chartData.push({
		    		name: 'On Progress',
		    		data: incomplete
		        });
			}
		})
		
		return chartData;
	}
	
	async function getLineAreaChart() {
		  // Line Area Chart
		  // ----------------------------------
		  var lineAreaOptions = {
		    chart: {
		      height: 245,
		      type: 'area',
		      //stacked: true,
		    },
		    colors: themeColors,
		    dataLabels: {
		      enabled: false
		    },
		    stroke: {
		      curve: 'straight'
		    },
		    series: [],
		    legend: {
		      offsetY: -10
		    },
		    xaxis: {
		    	categories: ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'],
		    },
		    yaxis: [
			    {
			    	title: {
			    		text: 'Phenotype'
			    	}	
			    },
			    {
			    	opposite: true,
			    	title: {
			    		text: 'Genotype'
			    	}
			    }
		    ],
		    tooltip: {
		      x: {
		        format: 'dd/MM/yy HH:mm'
		      },
		    }
		  }
		  
		  
		  const data = await getDatabaseCount();
		  lineAreaOptions.series = data;
		  
		  
		  
		  var lineAreaChart = new ApexCharts(document.querySelector("#line-area-chart"), lineAreaOptions);

		  try {
			  lineAreaChart.destroy();
		  } catch (error) {
			  //console.error(error);
		  }
		  
		  lineAreaChart.render();
		
	}
	
	function getDatabaseCount() {
		const now = new Date();
		const currentYear = now.getFullYear();
		const variety_id = $( "#variety-select option:selected" ).val();
		
		console.log(currentYear);
		
		const inputData = {
				'variety_id': variety_id,
				'currentYear': currentYear,
		}
		
		//console.log(year);
		//console.log(month);
		
		const chartData = [];
		
		$.ajax({
			url: 'statistics_getPhenotypeCount.jsp',
			method: 'POST',
			async: false,
			dataType : "json",
			data: inputData,
			success: function(result){
				chartData.push({
		    		name: 'Phenotype',
		    		data: result
		        });
			}
		})
		
		
		$.ajax({
			url: 'statistics_getGenotypeCount.jsp',
			method: 'POST',
			async: false,
			dataType : "json",
			data: inputData,
			success: function(result){
				chartData.push({
		    		name: 'Genotype',
		    		data: result
		        });
			}
		})
		
		//console.log(chartData);
		
		return chartData;
		
		
	}
	
	