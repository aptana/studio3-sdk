Launch = Class.create({
  /**
   * Render the items that will display Theme information and control.
   */
  render : function() {
    var launchDiv = $('launch');
    with (Elements.Builder) {
      if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
        console.log("Dispatching the 'getProjects' action on the 'portal.resources' controller...");
        // Project selection
        var projectSelect = select({
          "id" : "projectNameSelect"
        });
        var allProjects = dispatch($H({
          controller : 'portal.resources',
          action : "getProjects"
        }).toJSON()).evalJSON();
        for (var i = 0; i < allProjects.length; i++) {
          projectSelect.appendChild(option(allProjects[i]));
        }
        launchDiv.appendChild(span("Project: "));
        launchDiv.appendChild(projectSelect);

        // Mode selection
        var modeSelect = select({
          "id" : "modeSelect"
        }, option("run"), option("debug"), option("profile"));
        launchDiv.appendChild(span("Mode: "));
        launchDiv.appendChild(modeSelect);

        // Launch types
        var typeSelect = select({
          "id" : "launchTypeSelect"
        });
        launchDiv.appendChild(span("Launch Project As: "));
        launchDiv.appendChild(typeSelect);

        // Load the modes
        this.loadModes();

        // Add a button to trigger a Theme change
        var launchBt = button({
          'type' : 'button'
        }, "Launch");
        launchDiv.appendChild(launchBt);
        launchBt.observe('click', function(e) {
          var projectName = $('projectNameSelect');
          projectName = projectName.options[projectName.selectedIndex].text;
          var mode = $('modeSelect');
          mode = mode.options[mode.selectedIndex].text;
          var typeId = $('launchTypeSelect');
          if (typeId.selectedIndex < 0) {
            return false;
          }
          typeId = typeId.options[typeId.selectedIndex].getAttribute("typeId");
          dispatch($H({
            controller : 'portal.launch',
            action : "launch",
            args : {
              "project" : projectName,
              "mode" : mode,
              "type" : typeId
            }
          }).toJSON())
          return false;
        });

        projectSelect.observe('change', this.loadModes);
        modeSelect.observe('change', this.loadModes);
      }
    }
  },

  loadModes : function() {
    var projectName = $('projectNameSelect');
    projectName = projectName.options[projectName.selectedIndex].text;

    var mode = $('modeSelect');
    mode = mode.options[mode.selectedIndex].text;

    console.log("Dispatching the 'getLaunchTypes' action on the 'portal.launch' controller...");
    var launchTypes = dispatch($H({
      controller : 'portal.launch',
      action : "getLaunchTypes",
      args : {
        "project" : projectName,
        "mode" : mode
      }
    }).toJSON()).evalJSON();
    var prevTypeSelectElement = $('launchTypeSelect');
    with (Elements.Builder) {
      var typeSelect = select({
        "id" : "launchTypeSelect"
      });
      for (var typeId in launchTypes) {
        typeSelect.appendChild(option({
          "typeId" : typeId
        }, launchTypes[typeId]));
      }
      $('launch').replaceChild(typeSelect, prevTypeSelectElement);
    }
  }
});
