Browser = Class.create({
  /**
   * Render the items for the browser interactions
   */
  render : function() {

    // Render the Controller-Actions available for the "portal.browser" controller.
    var browserActionsDiv = $('browserActions');

    if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
      console.log("Dispatching the 'listActions' action on the 'portal.browser' controller...");
      var availableActions = dispatch($H({
        controller : 'portal.browser',
        action : "listActions"
      }).toJSON()).evalJSON();
      with (Elements.Builder) {
        var actionsTable = table( actionsBody = tbody());
        for (var i = 0; i < availableActions.length; i++) {
          actionsBody.appendChild(tr(td(availableActions[i])));
        }
        browserActionsDiv.appendChild(actionsTable);
      }
    }
    // Get the div for the Open-View example
    var browserInteractionsDiv = $('browserInteractions');
    with (Elements.Builder) {
      var defaultBrowserLink = a({
        'href' : '#'
      }, "Open a link in the default Studio browser");
      var internalLink = a({
        'href' : '#'
      }, "Open a link internally");
      var externalLink = a({
        'href' : '#'
      }, "Open a link externally");
      var configureLink = a({
        'href' : '#'
      }, "Configure Browsers");
      var getConfiguredLink = a({
        'href' : '#'
      }, "Show Currently Configured Browsers");

      browserInteractionsDiv.appendChild(defaultBrowserLink);
      browserInteractionsDiv.appendChild(br());
      browserInteractionsDiv.appendChild(internalLink);
      browserInteractionsDiv.appendChild(br());
      browserInteractionsDiv.appendChild(externalLink);
      browserInteractionsDiv.appendChild(br());
      browserInteractionsDiv.appendChild(br());
      browserInteractionsDiv.appendChild(configureLink);
      browserInteractionsDiv.appendChild(br());
      browserInteractionsDiv.appendChild(getConfiguredLink);

      // listen to clicks
      defaultBrowserLink.observe('click', function(e) {
        inputElement = e.element();
        if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
          console.log("Dispatching the 'openURL' action on the 'portal.browser' controller...");
          dispatch($H({
            controller : 'portal.browser',
            action : "openURL",
            args : ["http://www.appcelerator.com"].toJSON()
          }).toJSON());
        }
        return false;
      });

      // listen to clicks
      internalLink.observe('click', function(e) {
        inputElement = e.element();
        if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
          console.log("Dispatching the 'internalOpen' action on the 'portal.browser' controller...");
          dispatch($H({
            controller : 'portal.browser',
            action : "internalOpen",
            args : ["http://www.appcelerator.com"].toJSON()
          }).toJSON());
        }
        return false;
      });

      // listen to clicks
      externalLink.observe('click', function(e) {
        inputElement = e.element();
        if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
          console.log("Dispatching the 'externalOpen' action on the 'portal.browser' controller...");
          dispatch($H({
            controller : 'portal.browser',
            action : "externalOpen",
            args : ["http://www.appcelerator.com"].toJSON()
          }).toJSON());
        }
        return false;
      });

      // Configure browsers
      configureLink.observe('click', function(e) {
        if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
          console.log("Dispatching the 'configureBrowsers' action on the 'portal.browser' controller...");
          var addedBrowsers = dispatch($H({
            controller : 'portal.browser',
            action : "configureBrowsers"
          }).toJSON());
          alert(addedBrowsers);
        }
        return false;
      });

      // Get currently configured browsers
      getConfiguredLink.observe('click', function(e) {
        if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
          console.log("Dispatching the 'getConfiguredBrowsers' action on the 'portal.browser' controller...");
          var configured = dispatch($H({
            controller : 'portal.browser',
            action : "getConfiguredBrowsers"
          }).toJSON());
          alert(configured);
        }
        return false;
      });
    }
  }
});
