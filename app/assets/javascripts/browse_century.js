window.onload = function () {
  if ($("#century").length == 0) {
    return;
  }
  // Vertical slider
  var century_slider = $("#century_slider");
  var boundaries = century_slider.data('boundaries');
  // var slider_ticks = century_slider.data('ticks');
  var min = boundaries[0];
  var max = boundaries[1];
  //*******Century HORIZONTAL BAR CHART
  //http://www.jqueryflottutorial.com/how-to-make-jquery-flot-horizontal-bar-chart.html
  var century_panel = $('#century_panel');
  var rawData = century_panel.data('rawdata');
  var ticks = century_panel.data('ticks');
  var pointer_lookup = century_panel.data('pointerlookup');
  // var display_ratio = 1/(1.618 * 2);
  century_panel.height( century_panel.width() * 2 );
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
    //  noColumns: 0,
    //  labelBoxBorderColor: "#858585",
    //  position: "ne"
    //},
    grid: {
      hoverable: true,
      borderWidth: 0,
      backgroundColor: { colors: ["#ffffff", "#ffffff"] },
      autoHighlight: true,
      clickable: true
    }
  };
  //******Plot the graph, draw the slider, and define event handlers
  $(document).ready(function () {
    var plot;
    var browse_century = $("#browse_century");
    var form = $("#century").find("form.range_limit");
    var begin_el = form.find("input.range_begin");
    var end_el = form.find("input.range_end");
    // Plot the graph
    plot = $.plot(browse_century, dataSet, options);
    var find_segment_for = function_for_find_segment(pointer_lookup);
    var last_segment = null;
    // plothover event
    browse_century.bind("plothover", function (event, pos, item) {
      if (item) {
        var segment = find_segment_for(pos.y);
        var msg = segment.label  + ' (' + segment.count + ')';
        if (segment == last_segment) {
          $("#tooltip").remove();
          last_segment = null;
        } else {
          $("#tooltip").remove();
          showTooltip(item.pageX, item.pageY, '#000000', msg);
          last_segment = segment;
        }
      }
    });
    // define the slider
    var placeholder_input = $('<input type="text" data-slider-placeholder="true">').appendTo(century_slider);
    if (placeholder_input.slider !== undefined) {
      placeholder_input.slider({
        min: min,
        max: max,
        value: [min, max],
        tooltip_position: "left",
        orientation: 'vertical',
        reversed: true,
        //step: 100,
        //ticks: slider_ticks,
        handle: 'custom'
      });
    }
    // Match slider height to plot
    var slider_body = $(".slider.slider-vertical");
    slider_body.height( plot.height()-35 );
    slider_body.css('margin-top',"25px");
    // set values of form elements to min and max
    begin_el.val(min);
    end_el.val(max);
    // on plot click
    browse_century.bind("plotclick", function (event, pos, item) {
      if ( plot.getSelection() == null) {
        var segment = find_segment_for(pos.y);
        plot.setSelection( normalized_selection(segment.from, segment.to));
        begin_el.val(segment.from);
        end_el.val(segment.to);
        var slider_placeholder = century_slider.find("[data-slider-placeholder]");
        if (slider_placeholder) {
		  slider_placeholder.slider("setValue", [segment.from, segment.to]);
        }
      }
    });
    // on plot select
    browse_century.bind("plotselected plotselecting", function(event, ranges) {
      if (ranges != null ) {
        var from = Math.floor(ranges.yaxis.from);
        var to = Math.floor(ranges.yaxis.to);
        begin_el.val(from);
        end_el.val(to);
        var slider_placeholder = century_slider.find("[data-slider-placeholder]");
        if (slider_placeholder) {
		  slider_placeholder.slider("setValue", [from, to+1]);
        }
      }
    });
    // on form input fields value change
    form.find("input.range_begin, input.range_end").change(function () {
      plot.setSelection( form_selection(form, min, max) , true );
    });
    begin_el.change( function() {
      var val = BlacklightRangeLimit.parseNum($(this).val());
      if ( isNaN(val)  || val < min) {
        //for weird data, set slider at min
        val = min;
      }
      var values = placeholder_input.data("slider").getValue();
      values[0] = val;
      placeholder_input.slider("setValue", values);
    });
    end_el.change( function() {
      var val = BlacklightRangeLimit.parseNum($(this).val());
      if ( isNaN(val) || val > max ) {
        //weird entry, set slider to max
        val = max;
      }
      var values = placeholder_input.data("slider").getValue();
      values[1] = val;
      placeholder_input.slider("setValue", values);
    });
    // on slider value change
    var slider_placeholder = century_slider.find("[data-slider-placeholder]");
    slider_placeholder.on("change", function(event) {
      var values = $(event.target).data("slider").getValue();
      begin_el.val(values[0]);
      end_el.val(values[1]);
      plot.setSelection( normalized_selection(values[0], Math.max(values[0], values[1]-1)), true);
    });
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
        if (y_coord >= hash.from) {
            return hash;
        }
      }
      return pointer_lookup_arr[0];
    };
  }

  function normalized_selection(min, max) {
    max += 0.99999;
    return {xaxis: { 'from':min, 'to':max}}
  }

  /*
  function isInt(n) {
    return n % 1 === 0;
  }
  */
};
