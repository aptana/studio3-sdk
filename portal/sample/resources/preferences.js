Preferences = Class.create({
  /**
   * Render the items that are attached to the studio preferences.
   */
  render: function() {
    // Get the items that should be controlling/diaplaying the preference item.
    controls = [$('toolboxPref')];
    // For each control, get the 
    with (Elements.Builder) {
      controls.each(function (control) {
        if (control) {
          if (navigator.appName == "Microsoft Internet Explorer") {
            clazz = control.getAttribute('className');
          } else {
            clazz = control.getAttribute('class');
          }
          if (clazz && clazz.match('preference')) {
            // TODO - For now we support only 'input' (checkbox) types.
            // We should add more as needed.
            if (clazz.match('checkbox')) {
              elm = input({'type' : 'checkbox', 'key' : control.getAttribute('key')});
              control.appendChild(elm);
              control.appendChild(span(control.getAttribute('text')));
              
              // Get the current preference value for this item
              if (typeof(console) !== 'undefined') {
                console.log("Dispatching the 'getPreferenceValue' action on the 'portal.preferences' controller...");
              }
              value = 'false';
              // Check that we have the dispatch browser function
              if (typeof(dispatch) !== 'undefined') {
                value = dispatch($H({controller : 'portal.preferences', action:"getPreferenceValue", args : {key : control.getAttribute('key')}}).toJSON());
              }
              // We expect true/false for checkboxes
              if (value == 'true') {
                elm.setAttribute("checked", "checked");
              }
              
              // Observe and report selection changes for this item
              elm.observe('click', function(e) {
                inputElement = e.element();
                if (inputElement) {
                  prefKey = inputElement.getAttribute('key');
                  // set the pref value
                  val = (inputElement.getValue() == 'on') ? 'true' : 'false';
                  if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'setPreferenceValue' action on the 'portal.preferences' controller...");
                    dispatch($H({controller : 'portal.preferences', action:"setPreferenceValue", args : {key :prefKey, value : val}}).toJSON());
                  }
                  return false;
                }
              });
            }
          }
        }
      });
    }
  }
});