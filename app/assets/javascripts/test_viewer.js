$(function() {
    var viewer = $("#test_viewer");
    if (viewer.length == 0) {
        return;
    }

    // Initialize the mirador viewer
    var vc = $("#viewer_container");
    var manifest_uri = viewer.data("manifest-uri");
    var canvas_id = viewer.data("canvas-id");
    viewer.width(vc.width());
    // var display_ratio = 1/(1.618 * 2);
    viewer.height(viewer.width() * 1.25);
    Mirador({
        "id": "test_viewer",
        "layout": "1x1",
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
                "viewType" : "ImageView",
                "displayLayout": false,
                "bottomPanel" : false,
                "sidePanel" : false,
                "annotationLayer" : true,
                "annotationState": 'annoOnCreateOff'
            }
        ]
    });
    viewer.css('position', 'relative');
    var viewer_text = $("#viewer_text");
    viewer_text.height(viewer.height());
    viewer_text.css('overflow', 'auto');
    var text_class = 'transcription_text';
    if ($('.folio-tabs li.active').data('tab-id') == 'annotations') {
        text_class = 'annotation_text';
    }
    var viewer_top = viewer.offset().top;
    var viewer_bottom = viewer_top + viewer.outerHeight(true);
    var viewer_left = viewer.offset().left;
    var viewer_right = viewer_left + viewer.outerWidth();
    //console.log(viewer_top);
    //console.log(viewer_bottom);
    //console.log(viewer_left);
    //console.log(viewer_right);
    var anno_check_count = 0;
    $.subscribe('imageRectangleUpdated', image_rect_updated_handle);
    $.subscribe('focusUpdated', focus_updated_handle);

    function image_rect_updated_handle(event, data) {
        var win_id = data['id'];
        anno_check_count += 1;
        var annos = $(".annotation");
        var texts = $("." + text_class);
        if (annos.length == 0 &&  anno_check_count < 5) {
            setTimeout(image_rect_updated_handle, 1, event, data);
        } else {
            // console.log(annos.length);
            // console.log(texts.length);
            $.publish('disableTooltips.' + win_id);
            var index = 0;
            var display_count = 0;
            annos.each(function(){
                var p = $(this).offset();
                if (texts.length > index) {
                    if (p.top > viewer_top && p.top < viewer_bottom && p.left > viewer_left && p.left < viewer_right) {
                        $(texts[index]).css('display', 'block');
                        display_count += 1;
                    } else {
                        $(texts[index]).css('display', 'none');
                    }
                    index = index + 1;
                }
            });
            var ele_ht = Math.floor((viewer_text.prop('offsetHeight') - 10) / display_count);
            if (ele_ht > 23) {
                texts.css('height', ele_ht - 3);
            } else {
                texts.css('height', 'auto');
            }
            // $.publish('disableRectTool.' + win_id);
        }
    }

    function focus_updated_handle() {
        anno_check_count = 0;
    }
});