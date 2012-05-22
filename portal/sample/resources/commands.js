Commands = Class.create({
    /**
     * Render the items that will trigger a studio's command.
     */
    render: function() {
        // Get the div for the command-example.
        viewExampleDiv = $('executeCommandId');
        with (Elements.Builder) {
        	  commands = table(
        	  	tbody(
        	  		tr(td(elm1 = a({'href' : '#'}, "Command #1 - Open the About dialog"))),
        	  		tr(td(elm2 = a({'href' : '#'}, "Command #2 - Open the Search dialog"))),
        	  		tr(td(elm3 = a({'href' : '#'}, "Command #3 - Command With Parameters - Open the BreakPoints View"))),
        	  		tr(td(elm4 = a({'href' : '#'}, "Command #4 - Open a 'New Web Project' wizard"))),
					tr(td(elm5 = a({'href' : '#'}, "Command #5 - Open a 'New Titanium Desktop Project' wizard"))),
					tr(td(elm6 = a({'href' : '#'}, "Command #6 - Open a 'New Titanium Mobile Project' wizard"))),
					tr(td(elm7 = a({'href' : '#'}, "Command #7 - Open a 'New Titanium Mobile Project from 'Geolocation mobile client' template' wizard"))),
					tr(td(elm8 = a({'href' : '#'}, "Command #8 - Open a 'New Web Project from 'Basic Web Template' template' wizard"))),
					tr(td(elm9 = a({'href' : '#'}, "Command #9 - Open a preference page"))),
					tr(td(elm10 = a({'href' : '#'}, "Command #10 - Open the debug perspective")))
        	  ));
            viewExampleDiv.appendChild(commands);
            // Observe and report selection changes for this item
            elm1.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["org.eclipse.ui.help.aboutAction"].toJSON()
                    }).toJSON());
                }
                return false;
            });
            // Observe and report selection changes for this item
            elm2.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["org.eclipse.search.ui.openSearchDialog"].toJSON()
                    }).toJSON());
                }
                return false;
            });
            // Observe and report selection changes for this item
            // NOTE: This one is a command with parameters
            elm3.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action (with parameters) on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["org.eclipse.ui.views.showView", {"org.eclipse.ui.views.showView.viewId" : "org.eclipse.debug.ui.BreakpointView"}].toJSON()
                    }).toJSON());
                }
                return false;
            });
            // Observe and report selection changes for this item
            // NOTES: 
            // -- This one is a command with parameters
            // -- "com.appcelerator.titanium.desktop.project_wizard" - Titanium Studio Desktop project wizard ID
            // -- "com.appcelerator.titanium.mobile.project_wizard" - Titanium Studio Mobile project wizard ID
            elm4.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action (with parameters) on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["org.eclipse.ui.newWizard", {"newWizardId" : "com.aptana.ui.wizards.NewWebProject"}].toJSON()
                    }).toJSON());
                }
                return false;
            });
            // Observe and report selection changes for this item
            // NOTES: 
            // -- This one is a command with parameters
            // -- "com.appcelerator.titanium.desktop.project_wizard" - Titanium Studio Desktop project wizard ID
            // -- "com.appcelerator.titanium.mobile.project_wizard" - Titanium Studio Mobile project wizard ID
            elm5.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action (with parameters) on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["org.eclipse.ui.newWizard", {"newWizardId" : "com.appcelerator.titanium.desktop.project_wizard"}].toJSON()
                    }).toJSON());
                }
                return false;
            });
            // Observe and report selection changes for this item
            // NOTES: 
            // -- This one is a command with parameters
            // -- "com.appcelerator.titanium.desktop.project_wizard" - Titanium Studio Desktop project wizard ID
            // -- "com.appcelerator.titanium.mobile.project_wizard" - Titanium Studio Mobile project wizard ID
            elm6.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action (with parameters) on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["org.eclipse.ui.newWizard", {"newWizardId" : "com.appcelerator.titanium.mobile.project_wizard"}].toJSON()
                    }).toJSON());
                }
                return false;
            });
        
            // Observe and report selection changes for this item
            // NOTES: 
            // -- This one is a command with parameters
            // -- "com.appcelerator.titanium.mobile.project_wizard" - Titanium Studio Mobile project wizard ID
            // -- "com.aptana.project.templates.mobile.geos" - Built in template for mobile projects
            // -- The dispatch is being called with a Events.PROJECT event ID that will be used by the framework to notify
            //    the portal after the project is created. The notification will provide a project name.
            elm7.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action (with parameters) on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["com.aptana.portal.ui.command.newProjectFromTemplate", {"newWizardId" : "com.appcelerator.titanium.mobile.project_wizard", "projectTemplateId" : "com.appcelerator.titanium.project.template.mobile.geo"}, Events.PROJECT].toJSON()
                    }).toJSON());
                }
                return false;
            });
            
            // Observe and report selection changes for this item
            // NOTES: 
            // -- This one is a command with parameters
            // -- "com.appcelerator.titanium.mobile.project_wizard" - Titanium Studio Mobile project wizard ID
            // -- "com.aptana.project.templates.html.basic" - Built in template for mobile projects
            // -- The dispatch is being called with a Events.PROJECT event ID that will be used by the framework to notify
            //    the portal after the project is created. The notification will provide a project name.
            elm8.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action (with parameters) on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["com.aptana.portal.ui.command.newProjectFromTemplate", {"newWizardId" : "com.aptana.ui.wizards.NewWebProject", "projectTemplateId" : "com.aptana.project.template.web.basic"}, Events.PROJECT].toJSON()
                    }).toJSON());
                }
                return false;
            });
            
            // Open a Preference page
            elm9.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action (with parameters) on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["org.eclipse.ui.window.preferences", {"preferencePageId" : "org.eclipse.ui.browser.preferencePage"}].toJSON()
                    }).toJSON());
                }
                return false;
            });

            // Open a perspective
            elm10.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action (with parameters) on the 'portal.commands' controller...");
                    dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["org.eclipse.ui.perspectives.showPerspective", {"org.eclipse.ui.perspectives.showPerspective.perspectiveId" : "org.eclipse.debug.ui.DebugPerspective"}].toJSON()
                    }).toJSON());
                }
                return false;
            });
        }
    }, 
    
    projectChange : function(e) {
      alert("Project: " + $H(e).inspect());
    }
});