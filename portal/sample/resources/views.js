Views = Class.create({
    /**
     * Render the items that will open a studio's view.
     */
    render: function() {
        // Get the div for the Open-View example
        viewExampleDiv = $('openViewId');
        with (Elements.Builder) {
            bookmarksLink = a({'href' : '#'}, "Open Bookmarks View");
            samplesLink = a({'href' : '#'}, "Open Samples View");
            viewExampleDiv.appendChild(bookmarksLink);
            viewExampleDiv.appendChild(br());
            viewExampleDiv.appendChild(samplesLink);
            
            // Observe and report selection changes for the bookmarks-view item
            bookmarksLink.observe('click', function(e) {
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
            // Observe and report selection changes for the samples-view item
            samplesLink.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'openView' action on the 'portal.views' controller...");
                    dispatch($H({
                        controller : 'portal.views',
                        action : "openView",
                        args : ["com.aptana.samples.ui.SamplesView"].toJSON()
                    }).toJSON());
                }
                return false;
            });
        }
    }
});