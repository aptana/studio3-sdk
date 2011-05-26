RecentFiles = Class.create({
  /**
   * Render the items that will trigger a studio's recent-files display and open.
   */
  render: function() {
    // Get the div for the recent-files table.
    recentFilesDiv = $('recentFiles');
    // Make sure that the Studio dispatch call is available
    if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
    	  console.log("Dispatching the 'getRecentFiles' action on the 'portal.recentFiles' controller...");
        var recentFiles = dispatch($H({controller:"portal.recentFiles", action:"getRecentFiles"}).toJSON());
        if (recentFiles) {
            var filesJSON = recentFiles.evalJSON();
            var fileNames = $H(filesJSON).keys();
            var filePaths = $H(filesJSON).values();
            var filesCount = fileNames.size();
            var items;
            with(Elements.Builder) {
                // We have to wrap the rows in a tbody, otherwise, the internal browser
                // fails to display the rows.
                var tbodyItem;
                items = table({'id' : 'recentFilesTable'}, tbodyItem = tbody());
                for( var i = 0; i < filesCount; i++ ) {
                    var openFileLink;
                    var itemRow = tr(td(openFileLink = a({'href' : '#','file' : filePaths[i]}, fileNames[i])));
                    // make a call to open the file in the editor
                    openFileLink.observe('click', function(event) {
                        var fileToOpen = event.element().getAttribute('file');
                        // make sure to nest the fileToOpen string as a JSON.
                        // Another option is to pass it in an array just like that:
                        // {controller:"portal.recentFiles", action:"openRecentFiles", args:[fileToOpen].toJSON()}
                        console.log("Dispatching the 'openRecentFiles' action on the 'portal.recentFiles' controller...");
                        dispatch($H({
                            controller:"portal.recentFiles",
                            action:"openRecentFiles",
                            args:fileToOpen.toJSON()
                        }).toJSON());
                        // Stop the event, otherwise we loose the eclipse BroswerFunctions!
                        event.stop();
                    });
                    tbodyItem.appendChild(itemRow);
                }
            }
            var oldTable = $('recentFilesTable');
            if (oldTable) {
                recentFilesDiv.replaceChild(items, oldTable);
            } else {
                recentFilesDiv.appendChild(items);
            }
        } else {
            _clearDescendants(recentFilesDiv);
            recentFilesDiv.appendChild(Elements.Builder.div('No Recent Files'));
        }
    } else {
    	recentFilesDiv.appendChild(_studioOnlyContent());
	    return;
    }
  }
});
