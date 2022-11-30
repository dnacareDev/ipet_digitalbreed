//$(document).ready(function () {
	
	const $barColor = '#f3f3f3';
	const $trackBgColor = '#EBEBEB';
	const $textMutedColor = '#b9b9c3';
	const $budgetStrokeColor2 = '#dcdae3';
	const $goalStrokeColor2 = '#51e5a8';
	const $strokeColor = '#ebe9f1';
	const $textHeadingColor = '#5e5873';
	const $earningsStrokeColor2 = '#28c76f66';
	const $earningsStrokeColor3 = '#28c76f33';
	  
	const isRtl = $('html').attr('data-textdirection') === 'rtl';
	  
	const chartColors = {
		      		column: {
		      		series1: '#826af9',
		      		series2: '#d2b0ff',
		      		bg: '#f8d3ff'
		        },
		        success: {
		        	shade_100: '#7eefc7',
		        	shade_200: '#06774f'
		        },
		        donut: {
		        	series1: '#ffe700',
		        	series2: '#00d4bd',
		        	series3: '#826bf8',
		        	series4: '#2b9bf4',
		        	series5: '#FFA1A1'
		        },
		        area: {
		          series3: '#a4f8cd',
		          series2: '#60f2ca',
		          series1: '#2bdac7'
		        }
		      };
	
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
			        		fontSize: '2.86rem',
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
		    series: [70],
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
		
	
	// Column Chart
	// --------------------------------------------------------------------
	const columnChartEl = document.querySelector('#column-chart');
	const columnChartConfig = {
			chart: {
		        height: 400,
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
		    series: [
		    	{
		    		name: 'Apple',
		    		data: [90, 120, 55, 100, 80, 125]
		        },
		        {
		        	name: 'Samsung',
		        	data: [85, 100, 30, 40, 95, 90]
		        }
		      ],
		      xaxis: {
		        categories: ['GWAS', 'GS', 'Primer\nDesign', 'Genotype\nProcess', 'Genotype\nAnalysis', 'Phetnotype\nAnalysis']
		      },
		      fill: {
		        opacity: 1
		      },
		      yaxis: {
		        opposite: isRtl
		      }
		    };
	  
	    const columnChart = new ApexCharts(columnChartEl, columnChartConfig);
	    columnChart.render();
//});