/* A JQuery plugin (should this be implemented as a widget instead? not sure)
   that will convert a "toggle" form, with single submit button to add/remove
   something, like used for Bookmarks, into an AJAXy submit. 
   
   Apply to a form. Does require certain assumption about the form:
    1) The same form 'action' href must be used for both ADD and REMOVE
       actions, with the different being the hidden input name="_method"
       being set to "put" or "delete" -- that's the Rails method to pretend
       to be doing a certain HTTP verb. So same URL, PUT to add, DELETE
       to remove. This plugin assumes that. 
       
       Plus, the form this is applied to should provide a data-doc-id 
       attribute (HTML5-style doc-*) that contains the id/primary key
       of the object in question -- used by plugin for a unique value for
       DOM id's. 
*/
(function($) {
    $.fn.bookmark_submit = function(arg_opts) {              
      
      this.each(function() {
        var options = $.extend({}, $.fn.bookmark_submit.defaults, arg_opts);
                                  
          
        var form = $(this);
        //form.children().hide();
        //We're going to use the existing form to actually send our add/removes
        //This works conveneintly because the exact same action href is used
        //for both bookmarks/$doc_id.  But let's take out the irrelevant parts
        //of the form to avoid any future confusion. 
        //form.find("input[type=submit]").remove();
        form.addClass('form-horizontal');
        
        //View needs to set data-doc-id so we know a unique value
        //for making DOM id
        var unique_id = form.attr("data-doc-id") || Math.random();
        // if form is currently using method delete to change state, 
        // then it is currently checked (bookmarked)
        var checked = (form.find("input[name=_method][value=delete]").size() != 0);
        var button = form.find("input[type=submit]");
        // var span = form.find("span");
        function update_state_for(state) {
            if (state) {    
               //Set the Rails hidden field that fakes an HTTP verb
               //properly for current state action. 
               form.find("input[name=_method]").val("delete");
               // span.text(form.attr('data-present'));
               
            } else {
               form.find("input[name=_method]").val("put");
               // span.text(form.attr('data-absent'));
            }
          }
        
        update_state_for(checked);
        
        button.click(function() {
            // span.text(form.attr('data-inprogress'));
            button.attr("disabled", "disabled");
                            
            $.ajax({
                url: form.attr("action"),
                dataType: 'json',
                type: form.attr("method").toUpperCase(),
                data: form.serialize(),
                error: function() {
                   alert("Error");
                   update_state_for(checked);
                   button.removeAttr("disabled");
                },
                success: function(data, status, xhr) {
                  //if app isn't running at all, xhr annoyingly
                  //reports success with status 0. 
                  if (xhr.status != 0) {
                    checked = ! checked;
                    update_state_for(checked);
                    button.removeAttr("disabled");
                    options.success.call(form, checked, xhr.responseJSON);
                  } else {
                    alert("Error");
                    update_state_for(checked);
                    button.removeAttr("disabled");
                  }
                }
            });
            
            return false;
        }); //button.click
        
        
      }); //this.each      
      return this;
    };
	
  $.fn.bookmark_submit.defaults =  {
            //css_class is added to elements added, plus used for id base
            css_class: "bookmark_submit",
            success: function() {} //callback
  };
})(jQuery);
