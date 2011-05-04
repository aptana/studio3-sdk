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
        	  		tr(td(elm3 = a({'href' : '#'}, "Command #3 - Command With Parameters - Open the BreakPoints View")))
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
        }
    }
});