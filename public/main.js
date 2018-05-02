$(document).ready(function(){
    //$(".button-collapse").sideNav();
    $('.collapsible').collapsible();
    $('select').formSelect();
    $('#search_type').on('change', function() {
      $('#result_type').val($('#search_type').val());
    });
    document.addEventListener('DOMContentLoaded' function() {
        var elems = document.querySelectorAll('.sidenav');
        var instances = M.Sidenav.init(elems, options);
    });
 });
