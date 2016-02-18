// Tabs on homepage
$(document).on('click', '.search-tabs li', function() {
    $(".search-tabs li").removeClass("active");
    $(this).addClass("active");
    $("#main_search_field").val($(this).data("field"));
    $("#q" ).focus();
});

// Tabs on folio page
$(document).on('click', '.folio-tabs li', function() {
    $(".folio-tabs li").removeClass("active");
    $(".tab-pane").removeClass("active");
    $(this).addClass("active");
    var tab_ele = $(this).data('tab-id');
    $("#"+tab_ele).addClass("active");
    $("#folio-title").html(tab_ele[0].toUpperCase() + tab_ele.slice(1));
});


// nav on manuscript show
$(document).on('click', '.navbar-green li', function() {
    $(".navbar-green li").removeClass("active");
    $(this).addClass("active");
});

// enable top on scroll
$(window).scroll(function() {
    if ($(window).scrollTop() > 0) {
        $("#nav_top").css('display', 'block');
    } else {
        $("#nav_top").css('display', 'none');
    }
});
