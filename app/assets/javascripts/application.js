// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require rails-ujs
//= require moment
//= require bootstrap-datetimepicker
//= require turbolinks
//= require_tree .


// for #185. datepicker



$(document).ready(function(){
  $('#datetimepicker1').datetimepicker({
    format: 'DD/MM/YYYY'
  });
  $('#datetimepicker2').datetimepicker({
    format: 'DD/MM/YYYY'
  });
});


// listing#index roomtype search 
$(document).ready(function(){
	$('#roomtype').click(function(e){
		// var clickedBtn =  e.currentTarget 
		// $(clickedBtn).fadeOut('fast');
		// $(clickedBtn).append( '<p> why ruby interporation ++ does not work?+</p>')
    $(".radio_buttons").css("display","block");
	});

});


