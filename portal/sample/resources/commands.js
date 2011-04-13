Commands = Class.create({
    /**
     * Render the items that will trigger a studio's command.
     */
    render: function() {
        // Get the div for the command-example.
        viewExampleDiv = $('executeCommandId');
        with (Elements.Builder) {
            elm = div(a({
                'href' : '#'
            }, "Command #1 - Open the About dialog"), 
            br(), 
            elm2 = a({
                'href' : '#'
            }, "Command #2 - Open the Search dialog"));
            viewExampleDiv.appendChild(elm);
            // Observe and report selection changes for this item
            elm.observe('click', function(e) {
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
            viewExampleDiv.appendChild(elm2);
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
        }
    }
});