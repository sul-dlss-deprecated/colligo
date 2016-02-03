// Tabs on homepage
$(document).on('click', '.nav-tabs li', function() {
  $(".nav-tabs li").removeClass("active");
  $(".tab-pane").removeClass("active");
  $(this).addClass("active");
  $("#main_search_field").val($(this).data("field"));
  $("#q" ).focus();
  var tab_ele = $(this).data('tab-id');
  if (tab_ele) {
    $("#"+tab_ele).addClass("active");
    $("#folio-title").html(tab_ele[0].toUpperCase() + tab_ele.slice(1));
  }
});

// nav on manuscript show
$(document).on('click', '.navbar-green .navbar-nav li', function() {
    $(".navbar-green .navbar-nav li").removeClass("active");
    $(this).addClass("active");
});

$(window).scroll(function() {
    if ($("#viewer").length > 0) {
        if ($(window).scrollTop() > 0) {
            $("#nav_top").css('display', 'block');
        } else {
            $("#nav_top").css('display', 'none');
        }

    }
});