Browser = Class.create({
    /**
     * Render the items for the browser interactions
     */
    render: function() {
        // Get the div for the Open-View example
        projectSamplesDiv = $('browserInteractions');
        with (Elements.Builder) {
            internalLink = a({'href' : '#'}, "Open a link internally");
            externalLink = a({'href' : '#'}, "Open a link externally");
            projectSamplesDiv.appendChild(internalLink);
            projectSamplesDiv.appendChild(br());
            projectSamplesDiv.appendChild(externalLink);

            // listen to clicks
            internalLink.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
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
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'externalOpen' action on the 'portal.browser' controller...");
                    dispatch($H({
                        controller : 'portal.browser',
                        action : "externalOpen",
                        args : ["http://www.appcelerator.com"].toJSON()
                    }).toJSON());
                }
                return false;
            });
        }
    }
});