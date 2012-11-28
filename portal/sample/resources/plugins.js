Plugins = Class.create({
	/**
	 * Render the plugin linkes
	 */
	render : function() {
		// Get the div for the command-example.
		var pluginsDiv = $('plugins');
		with (Elements.Builder) {
			var linkes = table(tbody(tr(td( elm1 = a({
				'href' : '#'
			}, "Install Node.ACS")))));
			pluginsDiv.appendChild(linkes);

			// Observe and report selection changes for this item
			elm1.observe('click', function(e) {
				if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
					console.log("Dispatching the 'openPluginsDialog' action on the 'portal.plugins' controller...");
					dispatch($H({
						controller : 'portal.plugins',
						action : "openPluginsDialog",
						args : [["http://preview.appcelerator.com/appcelerator/studio/acs/update/rc"], {
							"feature_id" : "com.appcelerator.titanium.acs.feature"
						}].toJSON()
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
