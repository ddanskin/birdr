$(document).ready(function(){
    $(".sidenav").sidenav();
    $('.collapsible').collapsible();
    $('select').formSelect();
    $('#search_type').on('change', function() {
      $('#result_type').val($('#search_type').val());
    });
});
