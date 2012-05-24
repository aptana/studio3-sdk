Themes = Class.create({
  /**
   * Render the items that will display Theme information and control.
   */
  render : function() {
    var themeDiv = $('themes');
    with (Elements.Builder) {
      if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
        console.log("Dispatching the 'getThemes' action on the 'portal.themes' controller...");
        var allThemes = dispatch($H({
          controller : 'portal.themes',
          action : "getThemes"
        }).toJSON()).evalJSON();
        console.log("Dispatching the 'getActiveTheme' action on the 'portal.themes' controller...");
        var activeTheme = dispatch($H({
          controller : 'portal.themes',
          action : "getActiveTheme"
        }).toJSON()).evalJSON();
        themeSelectElement = select();
        for (var i = 0; i < allThemes.length; i++) {
          var op = option(allThemes[i]);
          if (activeTheme == allThemes[i]) {
            op.selected = true;
          }
          themeSelectElement.appendChild(op);
        }
        themeDiv.appendChild(span("Installed Themes: "));
        themeDiv.appendChild(themeSelectElement);

        // Add a button to trigger a Theme change
        var changeBt = button({
          'type' : 'button'
        }, "Change");
        themeDiv.appendChild(changeBt);
        changeBt.observe('click', function(e) {
          var item = themeSelectElement.options[themeSelectElement.selectedIndex].text;
          console.log("Dispatching the 'setActiveTheme' action on the 'portal.themes' controller with the value of " + item + "...");
          dispatch($H({
            controller : 'portal.themes',
            action : "setActiveTheme",
            args : '["' + item + '"]'
          }).toJSON()).evalJSON();
          return false;
        });
      }
    }
  }
});
