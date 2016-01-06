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
        // Folio thumbnail
        var folio_img = $(".folio-img");
        var img_ele = current_page.find('img').clone();
        if ( !img_ele.attr('src') ) {
          img_ele.attr('src', img_ele.attr('data'));
        }
        img_ele.removeClass('thumbnail-image highlight');
        folio_img.html(img_ele);
        // Folio title
        var folio_title = $(".foliotitle");
        folio_title.html(current_page.find('div').text());
    }

    // update the current page thumbnail each time the focus changes
    $.subscribe('focusUpdated', handle);

});