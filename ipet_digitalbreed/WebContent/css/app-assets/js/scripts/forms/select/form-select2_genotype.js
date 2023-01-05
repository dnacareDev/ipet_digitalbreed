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
	
	$("#refGenomeSelect").select2({
		width: '100%',
		placeholder: ' Select Reference',
	})
	

    // Color Options

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

    $('select[data-text-color]').each(function(i, obj) {
      var text = $(this).data('text-color'),textVariation;
      textVariation = $(this).data('text-variation');
      if(textVariation !== ""){
        textVariation = " "+textVariation;
      }
      $(this).next(".select2").find(".select2-selection__rendered").addClass(text+textVariation);
    });

})(window, document, jQuery);
