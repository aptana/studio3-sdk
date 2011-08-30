Configurations = Class.create({
    /**
     * Render the items that will trigger a studio's configuation items.
     */
    render: function() {
        // Get the div for the configuration examples.
        configurationsDiv = $('configurations');
        with (Elements.Builder) {
        	  commands = table(
        	  	tbody(
        	  		tr(td(rubyCheck = a({'href' : '#'}, "Ruby Check"))),
        	  		tr(td(jsLibInstall = a({'href' : '#'}, "Install JS Library")))
        	  ));
            configurationsDiv.appendChild(commands);
            // Observe and report selection changes for this item
            rubyCheck.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'synchronousComputeInstalledVersions' action on the 'portal.system.versions' controller...");
                    result = dispatch($H({
                        controller : 'portal.system.versions',
                        action : "synchronousComputeInstalledVersions",
                        args : [["ruby", "1.9", "http://rubyInstallationURL/not_used_here"]].toJSON()
                    }).toJSON());
                    alert(result);
                }
                return false;
            });
            // Observe and report selection changes for this item
            jsLibInstall.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'install' action on the 'portal.js_library.installer' controller...");
                    dispatch($H({
                        controller : 'portal.js_library.installer',
                        action : "install",
                        // Provide an array of URLs to be downloaded into the workspace, and provide 
                        // a map with a single 'name' attribute for the JS library name.
                        args : [['http://prototypejs.org/assets/2009/8/31/prototype.js'], {name : 'Prototype'}].toJSON()
                    }).toJSON());
                }
                return false;
            });
        }
    }
});