$(document).ready(function(){
	$('input[type=checkbox],input[type=radio],input[type=file]').uniform();
	$('select[class!="noSelect2"]').select2({
		width: '200px;'
	});
	$('.colorpicker').colorpicker();
    $('.datepicker').datepicker();
    $('select').select2();
});
