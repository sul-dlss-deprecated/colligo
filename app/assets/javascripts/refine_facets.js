$(function() {
    var refine_tabs = $("#myTabs");
    if (refine_tabs.length == 0) {
        return;
    }

    // refine width
    var refine_width = $('.refine').parent().width() - $('.refine').outerWidth(true) - 5;
    $('.summary').width(refine_width);


    var first_tab = refine_tabs.find('.nav-tabs li').first().data('tab-id');
    $('#'+first_tab).addClass('active');
    lookup_init(first_tab);

    refine_tabs.on('click', '.nav-tabs li', function () {
        $(this).closest('.dropdown').addClass('dontClose');
        var activeTab = $(this).data('tab-id');
        lookup_init(activeTab);
        $(".nav-tabs li").removeClass("active");
        $(".tab-pane").removeClass("active");
        $(this).addClass("active");
        $("#"+activeTab).addClass("active");
    });

    refine_tabs.on('click', '.lookup-widget input', function () {
        $(this).closest('.dropdown').addClass('dontClose');
    });

    $('#myDropDown').on('hide.bs.dropdown', function (e) {
        if ($(this).hasClass('dontClose')) {
            e.preventDefault();
        }
        $(this).removeClass('dontClose');
    });

    $(".tablesorter").tablesorter({});
});

function lookup_init(activeTab) {
    var possibleValues = [];
    $("#" + activeTab + " tbody tr").each(function(){
        var a_ele = $(this).find("td:first a");
        if (!a_ele.hasClass("remove")) {
            possibleValues.push({value: a_ele.attr("href"), label: a_ele.text()}); //put elements into array
        }
    });
    $( "#" + activeTab + "-lookup" ).autocomplete({
        source: possibleValues,
        appendTo: "#" + activeTab + "-popover-div",
        messages: {
            noResults: '',
            results: function() {}
        },
        select: function( event, ui ) {
            window.location.href = ui.item.value;
        }
    })
}