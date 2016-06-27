$(function() {
    var viewer = $("#viewer");
    if (viewer.length == 0) {
        return;
    }

    // Initialize the mirador viewer
    var vc = $("#viewer_container");
    var manifest_uri = viewer.data("manifest-uri");
    var canvas_id = viewer.data("canvas-id");
    viewer.width(vc.width());
    // var display_ratio = 1/(1.618 * 2);
    viewer.height(viewer.width() * 0.5);
    Mirador({
        "id": "viewer",
        "mainMenuSettings" : {
            'show' : false
        },
        'showAddFromURLBox' : false,
        "saveSession": false,
        "data": [
            {
                "manifestUri": manifest_uri,
                "location": "Stanford University"}
        ],
        "windowObjects": [
            {
                "loadedManifest": manifest_uri,
                "canvasID" : canvas_id,
                "viewType" : "BookView",
                "displayLayout": false,
                "bottomPanel" : true,
                "bottomPanelVisible": true,
                "sidePanel" : false,
                "annotationLayer" : false
            }
        ]
    });
    viewer.css('position', 'relative');

    function handle() {
        // `e` is the event object passed to handle - don't care about it.
        var highlighted_pages = $("ul.panel-listing-thumbs li.highlight");
        var current_page = highlighted_pages.first();
        var current_panel = $(".folio-recto");
        var param_start = current_panel.data("start");
        if (highlighted_pages.length == 2) {
            current_page = highlighted_pages.eq(0);
            fill_folio(current_page, current_panel, param_start);
            current_page = highlighted_pages.eq(1);
            current_panel = $(".folio-verso");
            current_panel.css('display', 'block')
        } else {
            $(".folio-verso").css('display', 'none');
        }
        fill_folio(current_page, current_panel, param_start);
    }

    function fill_folio(current_page, current_panel, param_start) {
        var current_folio = current_page.find('div').text();
        // Folio thumbnail
        var img_ele = current_page.find('img').clone();
        if ( !img_ele.attr('src') ) {
            img_ele.attr('src', img_ele.attr('data'));
        }
        img_ele.removeClass('thumbnail-image highlight');
        current_panel.find(".folio-img").html(img_ele);
        // Folio title
        current_panel.find(".foliotitle").html(current_folio);
        // Get related content
        $.ajax({
            type: 'get',
            url: window.location.pathname + '/related_content',
            data: 'folio=' + current_folio,
            success: function(data) {
                // Annotations
                var cls = 'noresult-inverse';
                if (data['annotations'] > 0) {
                    cls = 'result-inverse';
                }
                ele = $('<a></a>');
                var url = window.location.pathname + '/folio/' + current_folio + '?view=annotations';
                if (param_start || param_start === 0) {
                    url = url + '&start=' + param_start;
                }
                ele.attr("href", url);
                ele.attr("class", "btn btn-sm " + cls);
                ele.html('<span class="glyphicon glyphicon-tag" aria-hidden="true"></span> Annotations');
                current_panel.find(".folio-annotations").html(ele);
                // Transcriptions
                cls = 'noresult-inverse';
                if (data['transcriptions'] > 0) {
                    cls = 'result-inverse';
                }
                ele = $('<a></a>');
                url = window.location.pathname + '/folio/' + current_folio + '?view=transcriptions';
                if (param_start || param_start === 0) {
                    url = url + '&start=' + param_start;
                }
                ele.attr("href", url);
                ele.attr("class", "btn btn-sm " + cls);
                ele.html('<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Transcriptions');
                current_panel.find(".folio-transcriptions").html(ele);
                // First transcription
                if (data['first_transcription']) {
                    var ele = $('<p></p>');
                    ele.html('"'+data['first_transcription']+'"');
                    current_panel.find(".folio-first-transcription").html(ele)
                }
            }
        });
    }

    // update the current page thumbnail each time the focus changes
    $.subscribe('focusUpdated', handle);

    // Set width and data-offset-top on navbar for affixing to top
    function affixWidth() {
        // ensure the affix element maintains it width
        var affix = $('.navbar-green');
        var width = affix.width();
        var top_pos = $('#manuscript-description').position().top - 50;
        affix.attr('data-offset-top', top_pos);
        affix.width(width);
    }
    affixWidth();

  $(window).on("resize", function(){
    affixWidth();
  })

});
