$(function() {
    var vc = $("#viewer_container");
    // var display_ratio = 1/(1.618 * 2);
    var viewer = $("#viewer");
    var manifest_uri = viewer.data("manifest-uri");
    var canvas_id = viewer.data("canvas-id");
    viewer.width(vc.width());
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

    //use Mirador event bottomPanelSet.[WindowID] ??
    // var current_page = $("ul.panel-listing-thumbs li img.thumbnail-image");
    //$(".panel-listing-thumbs").on("click", '.thumbnail-image', function() {
    //    console.log('Its changed');
    //    //var imgele = $(this).clone();
    //    //imgele.css('class', '');
    //    //imgele.appendTo( ".folio-img" );
    //});
});