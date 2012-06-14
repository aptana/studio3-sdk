Browser = Class.create({
  /**
   * Render the items for the browser interactions
   */
  render : function() {
    // Get the div for the Open-View example
    projectSamplesDiv = $('browserInteractions');
    with (Elements.Builder) {
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

      projectSamplesDiv.appendChild(internalLink);
      projectSamplesDiv.appendChild(br());
      projectSamplesDiv.appendChild(externalLink);
      projectSamplesDiv.appendChild(br());
      projectSamplesDiv.appendChild(br());
      projectSamplesDiv.appendChild(configureLink);
      projectSamplesDiv.appendChild(br());
      projectSamplesDiv.appendChild(getConfiguredLink);

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
