Modules = Class.create({
  /**
   * Render the items that will display the Titanium-User information
   */
  render : function() {
    modulesDiv = $('modules');
    with(Elements.Builder) {
      if( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
        console.log("Dispatching the 'getMobileModules' action on the 'portal.titanium.modules' controller...");
        mobileModules = dispatch($H({
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
        mobileGlobalModulesTable = table({
          "border" : "1",
          "style" : "border-collapse:collapse"
        }, modulesTBody = tbody(tr(th("Name"), th("Platforms"), th("Versions"), th("Type"))));
        var globalModules = mobileModules["global_modules"];
        for(var i = 0; i < globalModules.length; i++) {
          var module = globalModules[i];
          modulesTBody.appendChild(tr(td(module["name"]), td(this.asCommaSeparatedList(module["platforms"])), td(this.asCommaSeparatedList(module["versions"])), td(module["type"])));
        }
        modulesDiv.appendChild(div("Global Mobile Modules"));
        modulesDiv.appendChild(mobileGlobalModulesTable);
        modulesDiv.appendChild(br());

        // Fill the PROJECT's modules table
        mobileProjectModulesTable = table({
          "border" : "1",
          "style" : "border-collapse:collapse"
        }, modulesTBody = tbody(tr(th("Project"), th("Module Name"), th("Platforms"), th("Versions"), th("Type"))));
        var projectModules = mobileModules["project_modules"];
        for(var v in projectModules) {
          var modules = projectModules[v];
          for(var i = 0; i < modules.length; i++) {
            var module = modules[i];
            modulesTBody.appendChild(tr(td(v), td(module["name"]), td(this.asCommaSeparatedList(module["platforms"])), td(this.asCommaSeparatedList(module["versions"])), td(module["type"])));
          }
        }
        modulesDiv.appendChild(div("Project's Mobile Modules"));
        modulesDiv.appendChild(mobileProjectModulesTable);
        modulesDiv.appendChild(br());

        console.log("Dispatching the 'getDesktopModules' action on the 'portal.titanium.modules' controller...");
        desktopModules = dispatch($H({
          controller : 'portal.titanium.modules',
          action : "getDesktopModules"
        }).toJSON()).evalJSON();
        // Fill the DESKTOP's modules table
        desktopModulesTable = table({
          "border" : "1",
          "style" : "border-collapse:collapse"
        }, modulesTBody = tbody(tr(th("Version"), th("Modules"))));
        for(var v in desktopModules) {
          var modules = desktopModules[v];
          modulesTBody.appendChild(tr(td(v), td(this.asCommaSeparatedList(modules))));
        }
        modulesDiv.appendChild(div("Desktop Modules"));
        modulesDiv.appendChild(desktopModulesTable);
      }
    }
  },
  asCommaSeparatedList : function(obj) {
    var n, v, json = [];
    for(n in obj) {
      v = obj[n];
      t = typeof (v);
      if(t == "string") {
        v = '"' + v + '"';
        json.push(String(v));
      }
    }
    return ("[" + String(json) + "]" );
  }
});
