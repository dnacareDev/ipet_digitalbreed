/*=========================================================================================
    File Name: form-select2.js
    Description: Select2 is a jQuery-based replacement for select boxes.
    It supports searching, remote data sets, and pagination of results.
    ----------------------------------------------------------------------------------------
    Item Name: Vuexy  - Vuejs, HTML & Laravel Admin Dashboard Template
    Author: Pixinvent
    Author URL: hhttp://www.themeforest.net/user/pixinvent
==========================================================================================*/
(function(window, document, $) {
	'use strict';

	// Basic Select2 select
	$(".select2").select2({
		// the following code is used to disable x-scrollbar when click in select input and
		// take 100% width in responsive also
		dropdownAutoWidth: true,
		width: '100%'
	});
	
	$("#VcfSelect").select2({
		width: '93%',
		placeholder: ' Select VCF File'
	})
	
	// Limiting the number of selections
	$(".max-length").select2({
		dropdownAutoWidth: true,
		width: '100%',
		maximumSelectionLength: 3,
		placeholder: " (Required) Select Phenotype",
	});

	// Background Color
	$('.select2-bg').each(function(i, obj) {
		var variation = "",
		textVariation = "",
		textColor = "";
		var color = $(this).data('bgcolor');
		variation = $(this).data('bgcolor-variation');
		textVariation = $(this).data('text-variation');
		textColor = $(this).data('text-color');
		if(textVariation !== ""){
			textVariation = " "+textVariation;
		}
		if(variation !== ""){
			variation = " bg-"+variation;
		}
		var className = "bg-"+color + variation + " " + textColor + textVariation + " border-"+color + ' border-darken-2 ';
		
		$(this).select2({
			dropdownAutoWidth: true,
			width: '100%',
			containerCssClass: className
		});
	});
	
	// Color Options
	$('select[data-text-color]').each(function(i, obj) {
	      var text = $(this).data('text-color'),textVariation;
	      textVariation = $(this).data('text-variation');
	      if(textVariation !== ""){
	    	  textVariation = " "+textVariation;
	      }
	      $(this).next(".select2").find(".select2-selection__rendered").addClass(text+textVariation);
	});

	
	$("#param_phenotype").on('select2:select', function(e) {
		const model_name = $('#model_name').val();
		const value = e.params.data.id.trim();
		const resultpath = $('#resultpath').val();
		const jobid_param = $('#jobid_param').val();
		
		if( (model_name == 'Multi' || model_name == 'QQ') ) {				// Multiple Model | QQ Plot일때는 작동하지 않음
			return;
		}
		
		if( $("#status404") ) {
			$("#status404").remove();						// '표현형과의 유사성을 찾을 수 없습니다' 안내문 제거
		}
		
		if( !ifFileExists(model_name, value, jobid_param) ) {
			$(`iframe#${model_name}`).attr('src', '');		// empty plot
			try {
				gridOptions2.api.destroy();					// empty grid
			} catch (error) {
				console.error(error);
			}
			
			const htmlElement = `
								<div id="status404">
									<div class="row mt-5">
										<div class="col-xl-6"></div>
										<div class="col-12 col-xl-6 d-flex justify-content-center">
											<svg xmlns="http://www.w3.org/2000/svg" width="120" height="120" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
												<path d="M10.29 3.86L1.82 18a2 2 0 0 0 1.71 3h16.94a2 2 0 0 0 1.71-3L13.71 3.86a2 2 0 0 0-3.42 0z"></path>
												<line x1="12" y1="9" x2="12" y2="13"></line>
												<line x1="12" y1="17" x2="12.01" y2="17"></line>
											</svg>
										</div>
									</div>
									<div class="row mt-1 mb-5">
										<div class="col-xl-6"></div>
										<div class="col-12 col-xl-6 d-flex justify-content-center" style="font-size:20px; font-weight: 600px;">
											표현형과의 유사성을 찾을 수 없습니다.
										</div>
									</div>
								</div>
								`;
			
			$(`#panel_${model_name}`).children().children().first().prepend(htmlElement);
			$(`#${model_name}`).height(0);
			return;
		} else {
			$(`#${model_name}`).height("500px");					// iframe 높이 정상
		}
		
		//if( !(model_name == 'Multi' || model_name == 'QQ') ) {
		showPlot(value);
		showGrid(value);
		//} 
	})
	
	$("#isQQ").on('select2:select', function(e) {
		const value = event.target.value;
		const isQQ = document.getElementById('isQQ').value;
		const param_phenotype = document.getElementById('param_phenotype').value.trim();
		
		//console.log(value);
		//console.log(isQQ);
		//console.log(param_phenotype);
		
		if(param_phenotype == "-1") {
			alert("특성을 선택해주세요");
			//$("#QQ_model").val("-1").trigger('change');
			document.getElementById('isQQ').value = '-1';
			document.getElementById('isQQ').dispatchEvent(new Event('change'));
		} else {
			//$("#QQ_model").val("-1").trigger('change');
			document.getElementById('isQQ').value = isQQ;
			document.getElementById('isQQ').dispatchEvent(new Event('change'));
		}
		
	}); 
	
	
	$("#QQ_model").on('select2:select', function(e) {
		const model_name = document.getElementById('QQ_model').value;
		const param_phenotype = document.getElementById('param_phenotype').value.trim();
		
		//console.log("model_name : ", model_name);
		//console.log("param_phenotype : ", param_phenotype);
		
		if(param_phenotype == "-1") {
			alert("특성을 선택해주세요");
			//$("#QQ_model").val("-1").trigger('change');
			document.getElementById('QQ_model').value = '-1';
			document.getElementById('QQ_model').dispatchEvent(new Event('change'));
		} else {
			//$("#iframeLoading").modal('show');
			//$('iframe#QQ').attr('src', params.data.resultpath+params.data.jobid+"/"+`QQ_${model_name}_${param_phenotype}.html`);
			//$("#QQ_model").val("-1").trigger('change');
			document.getElementById('QQ_model').value = model_name;
			document.getElementById('QQ_model').dispatchEvent(new Event('change'));
		}
	});
	

	
	

	
	
})(window, document, jQuery);
