var TARGETS = {
  GLOBAL_MODULES : 'global_modules',
  PROJECT_MODULES : 'project_modules'
};

Modules = Class.create({
  /**
   * Render the items that will display the Titanium-User information
   */
  render : function() {
    var modulesDiv = $('modules');
    with (Elements.Builder) {
      if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
        console.log("Dispatching the 'getMobileModules' action on the 'portal.titanium.modules' controller...");
        var mobileModules = dispatch($H({
          controller : 'portal.titanium.modules',
          action : "getMobileModules"
        }).toJSON()).evalJSON();
        /*
        * The returned JSON contains two root items: 'global_modules' and 'project_modules'.<br>
        * The 'global' root holds an array of module maps. Each map holds the ti-module information:
        * -- name : module name
        * -- versions : an array of installed versions
        * -- platforms : an array of supported platforms
        * -- type : the type of the module (in this case, always 'global')
        *
        * The 'project' root holds a map of project-names to an array of modules that exist in those projects. The same
        * ti-module information is passed in those arrays, accept for the 'type' field, which hold 'project' in this case.
        */

        // Fill the GLOBAL modules table
        var mobileGlobalModulesTable = table({
          "border" : "1",
          "style" : "border-collapse:collapse"
        }, modulesTBody = tbody(tr(th("Name"), th("ID"), th("Platforms"), th("Versions"), th("Type"), th("GUID"))));
        var globalModules = mobileModules["global_modules"];
        for (var i = 0; i < globalModules.length; i++) {
          var module = globalModules[i];
          modulesTBody.appendChild(tr(td(module["name"]), td(module["id"]), td(this.asCommaSeparatedList(module["platforms"])), td(this.asCommaSeparatedList(module["versions"])), td(module["type"]), td(this.asCommaSeparatedList(module["guids"]))));
        }
        modulesDiv.appendChild(div("Global Mobile Modules"));
        modulesDiv.appendChild(mobileGlobalModulesTable);
        modulesDiv.appendChild(br());

        // Fill the PROJECT's modules table
        var mobileProjectModulesTable = table({
          "border" : "1",
          "style" : "border-collapse:collapse"
        }, modulesTBody = tbody(tr(th("Project"), th("Module Name"), th("Module ID"), th("Platforms"), th("Versions"), th("Type"), th("GUID"))));
        var projectModules = mobileModules["project_modules"];
        for (var v in projectModules) {
          var modules = projectModules[v];
          for (var i = 0; i < modules.length; i++) {
            var module = modules[i];
            modulesTBody.appendChild(tr(td(v), td(module["name"]), td(module["id"]), td(this.asCommaSeparatedList(module["platforms"])), td(this.asCommaSeparatedList(module["versions"])), td(module["type"]), td(this.asCommaSeparatedList(module["guids"]))));
          }
        }
        modulesDiv.appendChild(div("Project's Mobile Modules"));
        modulesDiv.appendChild(mobileProjectModulesTable);
        modulesDiv.appendChild(br());

        console.log("Dispatching the 'getDesktopModules' action on the 'portal.titanium.modules' controller...");
        var desktopModules = dispatch($H({
          controller : 'portal.titanium.modules',
          action : "getDesktopModules"
        }).toJSON()).evalJSON();
        // Fill the DESKTOP's modules table
        var desktopModulesTable = table({
          "border" : "1",
          "style" : "border-collapse:collapse"
        }, modulesTBody = tbody(tr(th("Version"), th("Modules"))));
        for (var v in desktopModules) {
          var modules = desktopModules[v];
          modulesTBody.appendChild(tr(td(v), td(this.asCommaSeparatedList(modules))));
        }
        modulesDiv.appendChild(div("Desktop Modules"));
        modulesDiv.appendChild(desktopModulesTable);

        // Module installation
        var targetSelect = select({
          "id" : "targetSelect"
        }, option("----"), option(TARGETS.GLOBAL_MODULES), option(TARGETS.PROJECT_MODULES));
        var projectTargetSelect = select({
          "id" : "projectTargetSelect"
        });
        var allProjects = dispatch($H({
          controller : 'portal.resources',
          action : "getProjects"
        }).toJSON()).evalJSON();
        for (var i = 0; i < allProjects.length; i++) {
          projectTargetSelect.appendChild(option(allProjects[i]));
        }
        modulesDiv.appendChild(br());
        modulesDiv.appendChild(div(b("Target: "), targetSelect, b(" Project: "), projectTargetSelect, b(" Install/Update module from url: "), moduleURL = input({
          'type' : 'text',
          'name' : 'moduleUrl',
          'value' : '',
          'size' : '50'
        }), moduleInstallButton = button({
          'type' : 'button'
        }, "Install!")));
        moduleInstallButton.observe('click', function(e) {
          if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
            console.log("Dispatching the 'installModule' action on the 'portal.titanium.modules' controller with arg " + moduleURL.value + "...");
            // prepare the arguments according to the target selections.
            var arguments = '["' + moduleURL.value.split(',');
            var targetSelectionValue = targetSelect.options[targetSelect.selectedIndex].text;
            if (targetSelectionValue == TARGETS.GLOBAL_MODULES) {
              arguments += "\", \"" + TARGETS.GLOBAL_MODULES + "\"]";
            } else if (targetSelectionValue == TARGETS.PROJECT_MODULES) {
              arguments += "\", \"" + TARGETS.PROJECT_MODULES + "\", \"" + projectTargetSelect.options[projectTargetSelect.selectedIndex].text + "\"]";
            } else {
              arguments += '"]';
            }
            var response = dispatch($H({
              controller : 'portal.titanium.modules',
              action : "installModule",
              args : arguments
            }).toJSON());

            console.log("Response from the 'installModule' action: " + response);
          }
          return false;
        });
      }
    }
  },
  asCommaSeparatedList : function(obj) {
    var n, v, json = [];
    for (n in obj) {
      v = obj[n];
      t = typeof (v);
      if (t == "string") {
        v = '"' + v + '"';
        json.push(String(v));
      }
    }
    return ("[" + String(json) + "]" );
  },
  // Accepts an update that was triggered by a browser-notification when the modules were changed.
  // In this case, we redraw the modules list.
  update : function(e) {
    if ( typeof (console) !== 'undefined') {
      console.log("The modules were changed. Redrawing the modules list...");
      var node = $('modules');
      while (node.hasChildNodes()) {
        node.removeChild(node.lastChild);
      }
      this.render();
    }
  }
});
