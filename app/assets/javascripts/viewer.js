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
        if (highlighted_pages.length == 2) {
            current_page = highlighted_pages.eq(1);
        }
        var current_folio = current_page.find('div').text();
        // Folio thumbnail
        var img_ele = current_page.find('img').clone();
        if ( !img_ele.attr('src') ) {
          img_ele.attr('src', img_ele.attr('data'));
        }
        img_ele.removeClass('thumbnail-image highlight');
        $(".folio-img").html(img_ele);
        // Folio title
        $(".foliotitle").html(current_folio);
        // Get related content
        $.ajax({
            type: 'get',
            url: window.location.pathname + '/related_content',
            data: 'folio=' + current_folio,
            success: function(data) {
                console.log("Got related content");
                console.log(data);
                // Annotations
                var cls = 'noresult-inverse';
                if (data['annotations'] > 0) {
                    cls = 'result-inverse';
                }
                var ele = $('<a></a>');
                ele.attr("href", window.location.pathname + '/folio/' + current_folio);
                ele.attr("class", "btn btn-sm " + cls);
                ele.html('<span class="glyphicon glyphicon-tag" aria-hidden="true"></span> Annotations');
                $(".folio-annotations").html(ele);
                // Transcriptions
                var cls = 'noresult-inverse';
                if (data['transcriptions'] > 0) {
                    cls = 'result-inverse';
                }
                var ele = $('<a></a>');
                ele.attr("href", window.location.pathname + '/folio/' + current_folio);
                ele.attr("class", "btn btn-sm " + cls);
                ele.html('<span class="glyphicon glyphicon-pencil" aria-hidden="true"></span> Transcriptions');
                $(".folio-transcriptions").html(ele);
                // First transcription
                if (data['first_transcription']) {
                    var ele = $('<p></p>');
                    ele.html('"'+data['first_transcription']+'"');
                    $(".folio-first-transcription").html(ele)
                }
            }
        });
    }

    // update the current page thumbnail each time the focus changes
    $.subscribe('focusUpdated', handle);

});