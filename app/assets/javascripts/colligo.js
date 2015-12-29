// Tabs on homepage
$(document).on('click', '.nav-tabs li', function() {
  $(".nav-tabs li").removeClass("active");
  $(this).addClass("active");
  $("#main_search_field").val($(this).data("field"));
  $("#q" ).focus();
});

// nav on manuscript show
$(document).on('click', '.navbar-green .navbar-nav li', function() {
    $(".navbar-green .navbar-nav li").removeClass("active");
    $(this).addClass("active");
});