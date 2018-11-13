$('.show').click(function(){
  $('#example').removeClass().addClass('animated ' + $(this).data('fx'));
});

$('.hide').click(function(){
  $('#example').removeClass().addClass('animated ' + $(this).data('fx'));
});