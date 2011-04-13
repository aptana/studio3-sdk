Views = Class.create({
    /**
     * Render the items that will open a studio's view.
     */
    render: function() {
        // Get the div for the Open-View example
        viewExampleDiv = $('openViewId');
        with (Elements.Builder) {
            elm = a({'href' : '#'}, "Open Bookmarks View");
            viewExampleDiv.appendChild(elm);
            // Observe and report selection changes for this item
            elm.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'openView' action on the 'portal.views' controller...");
                    dispatch($H({
                        controller : 'portal.views',
                        action : "openView",
                        args : ["org.eclipse.ui.views.BookmarkView"].toJSON()
                    }).toJSON());
                }
                return false;
            });
        }
    }
});