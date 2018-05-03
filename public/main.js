$(document).ready(function(){

    $('#search_type').on('change', function() {
      $('#result_type').val($('#search_type').val());
    });

});

// nav bar mobile-responsive function
document.addEventListener('DOMContentLoaded' function() {
     var elems = document.querySelectorAll('.sidenav');
     var instances = M.Sidenav.init(elems, options);
});

// selector function
document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('select');
    var instances = M.FormSelect.init(elems, options);
});

// collapsible function
document.addEventListener('DOMContentLoaded', function() {
    var elems = document.querySelectorAll('.collapsible');
    var instances = M.Collapsible.init(elems, options);
});
