window.onload = function () {
    /*
    // Vertical slider
    var boundaries = $("#century_slider").data('boundaries');
    var slider_ticks = $("#century_slider").data('ticks');
    var slider_labels = $("#century_slider").data('labels');
    var min = boundaries[0];
    var max = boundaries[1];
*/

        //*******Century HORIZONTAL BAR CHART
        //http://www.jqueryflottutorial.com/how-to-make-jquery-flot-horizontal-bar-chart.html
        //console.log($("#century_panel").data());
        var rawData = $('#century_panel').data('rawdata');
        var ticks = $('#century_panel').data('ticks');
        var pointer_lookup = $('#century_panel').data('pointerlookup');
        var display_ratio = 1/(1.618 * 2);
        $("#century_panel").height( $("#century_panel").width() * 2 );
        
        
        var dataSet = [{ label: "", data: rawData, color: "#009933" }];        
 
        var options = {
            series: {
                bars: {
                    show: true
                }
            },
            bars: {
                align: "center",
                barWidth: 80,
                horizontal: true,
                fillColor: { colors: [{ opacity: 0.5 }, { opacity: 1}] },
                lineWidth: 1
            },
            yaxis: {
                //axisLabel: "Precious Metals",
                //axisLabelUseCanvas: true,
                //axisLabelFontSizePixels: 12,
                //axisLabelFontFamily: 'Verdana, Arial',
                //axisLabelPadding: 3,
                //tickColor: "#5E5E5E",
                ticks: ticks,
                color: "white",
                tickDecimals: 0
            },
            //legend: {
            //   noColumns: 0,
            //    labelBoxBorderColor: "#858585",
            //    position: "ne"
            //},
            grid: {
                hoverable: true,
                borderWidth: 0,
                backgroundColor: { colors: ["#ffffff", "#ffffff"] },
                autoHighlight: true,
                clickable: true
            }
        };
 
        $(document).ready(function () {
            var plot;
            plot = $.plot($("#browse_century"), dataSet, options);
            find_segment_for = function_for_find_segment(pointer_lookup);
            var last_segment = null;
            $("#browse_century").bind("plothover", function (event, pos, item) {
              //console.log(item);
              if (item) {
                segment = find_segment_for(pos.y);
                var msg = segment.label  + ' (' + segment.count + ')';
                if(segment != last_segment) {
                  $("#tooltip").remove();
                  showTooltip(item.pageX, item.pageY, '#000000', msg);
                  last_segment  = segment;
                } else {
                    $("#tooltip").remove();
                    last_segment = null;
                }
              } 
            });
            
            $("#browse_century").bind("plotclick", function (event, pos, item) {
              if ( plot.getSelection() == null) {
                segment = find_segment_for(pos.y);
                plot.setSelection( normalized_selection(segment.from, segment.to));
                var form = $("#century").find("form.range_limit");
                form.find("input.range_begin").val(segment.from);
                form.find("input.range_end").val(segment.to);
              }
            });

            $("#browse_century").bind("plotselected plotselecting", function(event, ranges) {          
                if (ranges != null ) {
                  var from = Math.floor(ranges.yaxis.from);
                  var to = Math.floor(ranges.yaxis.to);

                  var form = $("#century").find("form.range_limit");
                  console.log(form);
                  form.find("input.range_begin").val(from);
                  form.find("input.range_end").val(to);
              
                  var slider_placeholder = $("#century_slider").find("[data-slider-placeholder]");
                  if (slider_placeholder) {
							  slider_placeholder.slider("setValue", [from, to+1]);
                  }								
                }
            });

            var form = $("#browse_century").find("form.range_limit");
            form.find("input.range_begin, input.range_end").change(function () {
              plot.setSelection( form_selection(form, min, max) , true );
            });
            $("#century_slider").find(".profile .range").on("slide", function(event, ui) {
              var values = $(event.target).data("slider").getValue();
              form.find("input.range_begin").val(values[0]);
              form.find("input.range_end").val(values[1]);
              plot.setSelection( normalized_selection(values[0], Math.max(values[0], values[1]-1)), true);
            });
            
      /*
      $("#century_slider").height( $("#century_panel").height() );
      if (isInt(min) && isInt(max)) {
     //$("#century").contents().wrapAll('<div style="display:none" />');
     
     var range_element = $("#century_slider");
     var form = $("#century").find("form.range_limit");
     var begin_el = form.find("input.range_begin");
     var end_el = form.find("input.range_end");

     var placeholder_input = $('<input type="text" data-slider-placeholder="true">').appendTo(range_element);
     
     // make sure slider is loaded
     if (placeholder_input.slider !== undefined) {
       placeholder_input.slider({
         //min: min,
         //max: max+1,
         step: 100,
         value: [min, max+1],
         tooltip: "hide",
         orientation: 'vertical',
         ticks: slider_ticks,
         ticks_snap_bounds: 50,
         ticks_positions: [0, 5, 10, 15, 20, 25, 30, 35, 40, 45, 50, 55, 60, 65, 70, 75, 80, 85, 90, 95, 100],
         ticks_labels: slider_labels,
         handle: 'custom'
       });
     }
   }
   begin_el.val(min);
            end_el.val(max); 
            
*/            
        });

        function showTooltip(x, y, color, contents) {
            $('<div id="tooltip">' + contents + '</div>').css({
                position: 'absolute',
                display: 'none',
                top: y - 10,
                left: x + 10,
                border: '2px solid ' + color,
                padding: '3px',
                'font-size': '12px',
                'border-radius': '5px',
                'background-color': '#fff',
                'font-family': 'Verdana, Arial, Helvetica, Tahoma, sans-serif',
                opacity: 0.9
            }).appendTo("body").fadeIn(200);
        }
        
    function function_for_find_segment(pointer_lookup_arr) {
      return function(y_coord) {
        for (var i = pointer_lookup_arr.length-1 ; i >= 0 ; i--) {
          var hash = pointer_lookup_arr[i];
          if (y_coord >= hash.from)
            return hash;
        }
        return pointer_lookup_arr[0];
      };
    }
    
    function normalized_selection(min, max) {
      max += 0.99999;

      return {xaxis: { 'from':min, 'to':max}}
    }
  
  
  function isInt(n) {
  return n % 1 === 0;
}        
};