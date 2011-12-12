TiStudioUpdates = Class.create({
  /**
   * Render the items that will display the Titanium Studio update-status.
   * In case an update is needed, a link will appear to allow installing the it.
   * Note that all the calls for the Titanium Studio update controllers are asynchronous.
   */
  render : function() {
    // Prepare the link that will trigger an asynchronous check for the update.
    // The 'update' method will be the one to render the results as they arrive from the Studio side.
    var updatesDiv = $('tiStudioUpdates');
    var checkLink;
    with(Elements.Builder) {
      // Create three spans under the 'updates div'.
      // The first span will hold the check link, the second will hold the check result,
      // and the third will hold an install link that will be displayed when an update is needed.
      updatesDiv.appendChild(span( checkLink = a({
        "href" : "#"
      }, "Check for updates")));
      updatesDiv.appendChild(span({
        "id" : "studio-update-status",
        "style" : "padding-left:15px; color:green"
      }, "checking.."));
      updatesDiv.appendChild(span({
        "id" : "studio-install",
        "style" : "padding-left:15px; color:red"
      }, "checking.."));
      updatesDiv.appendChild(br());
    }
    // Listen to the 'Check for updates' and trigger the controller-action that does that.
    checkLink.observe('click', this.checkForUpdates);
    // do an immediate update.
    this.checkForUpdates();
  },
  /**
   * Render the results as they arrive from the Studio. The 'status' argument holds the result of the previously called action.
   * The event that the Studio fires when a 'checkForUpdate' request is sent contains the following fields under the 'data' map attribute:
   *  - installedVersion (a version string, or an empty value)
   *  - needsUpdate ('true' or 'false')
   *  - availableUpdateVersion (a version string, or an empty value)
   * The events that the Studio fires when an 'installUpdate' request is sent contains in its 'data' part a 'status' field.
   * The 'status' may be one of the following values:
   *  - processing
   *  - ok
   *  - error
   *  - incomplete
   *  - unknown
   */
  update : function(status) {
    if( typeof (status.data) !== 'undefined') {
      // If the data does not contain a defined 'installedVersion', we can handle this
      // 'update' as a result of an 'installUpdate' request.
      if( typeof (status.data.installedVersion) === 'undefined') {
        this.updateInstallProgress(status.data.status);
      } else {
        // Render the results.
        installedVersion = status.data.installedVersion;
        var statusSpan = $('studio-update-status');
        statusSpan.innerHTML = "Titanium Studio Version: [" + installedVersion + "]";

        // if an update is needed, inject a link and listen to 'update' click.
        var installSpan = $('studio-install');
        if(status.data.needsUpdate) {
          installSpan.innerHTML = "A Titanium Studio Update is available: (version " + status.data.availableUpdateVersion + ")";
        } else {
          installSpan.innerHTML = "You have the latest version of Titanium Studio";
        }
       
        console.log("Got a Titanium Studio Update status. Installed version - " + installedVersion + ", Update available - " 
          + status.data.needsUpdate + ", Update Versio - " + status.data.availableUpdateVersion);

        if(status.data.needsUpdate) {
          // Render a link inside the span
          with(Elements.Builder) {
            installSpan.appendChild( updateLink = a({
              "href" : "#",
              "id" : "studio-update-link",
              "style" : "padding-left:15px;"
            }, "Update!"));
            // Listen to update clicks
            updateLink.observe('click', function(e) {
              if( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
                console.log("Dispatching the 'installUpdate' action on the 'portal.titanium.studio.update' controller...");
                dispatch($H({
                  controller : 'portal.titanium.studio.update',
                  action : "installUpdate"
                }).toJSON());
              }
              return false;
            });
          }
        }
      }
    }
  },
  /**
   * Update the installation progress presentation.
   * The given status may be one of the following values:
   *  - processing
   *  - ok
   *  - error
   *  - incomplete
   *  - unknown
   */
  updateInstallProgress : function(status) {
    var installSpan = $('studio-install');
    switch(status) {
      case 'ok':
        // remove the update link and call for another check
        installSpan.removeChild(updateLink);
        this.checkForUpdates();
        break;
      case 'processing':
        with(Elements.Builder) {
          installSpan.replaceChild(span({
            "id" : "studio-update-link",
            "style" : "padding-left:15px;"
          }, "Installing..."));
        }
        break;
      default:
        alert("A problem when installing the Titanium Studio Update [return value: " + status + "]")
    }
  },
  /**
   * Call request that asks the Studio to check for updates.
   */
  checkForUpdates : function(e) {
    if( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
      console.log("Dispatching the 'checkForUpdate' action on the 'portal.titanium.studio.update' controller...");
      dispatch($H({
        controller : 'portal.titanium.studio.update',
        action : "checkForUpdate"
      }).toJSON());
    }
    return false;
  }
});
