$(document).ready(function(){
    $(".button-collapse").sideNav();
    $('.collapsible').collapsible();
    $('select').formSelect();
    $('#search_type').on('change', function() {
      $('#result_type').val($('#search_type').val());
    });
});
