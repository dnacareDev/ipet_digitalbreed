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
		width: '95%',
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
		//console.log(e.params.data.id);
		
		const model_name = $('#model_name').val();
		const value = e.params.data.id;
		
		if( !(model_name == 'Multi' || model_name == 'QQ') ) {
			showPlot(value);
			showGrid(value);
		} 
	})
	
	/*
	// select2에 해당하는 changeEvent만 이쪽에 작성
	document.addEventListener('click', function(event) {
		if(event.target.id.includes('gwas_')) {
			$("#param_phenotype").val('-1').trigger('change');
			$("#QQ_model").val('-1');
		}
	});
	*/
	
	$("#isQQ").on('select2:select', function(e) {
		const value = event.target.value;
		const isQQ = document.getElementById('isQQ').value;
		const param_phenotype = document.getElementById('param_phenotype').value;
		
		console.log(value);
		console.log(isQQ);
		console.log(param_phenotype);
		
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
		const param_phenotype = document.getElementById('param_phenotype').value;
		
		console.log("model_name : ", model_name);
		console.log("param_phenotype : ", param_phenotype);
		
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
