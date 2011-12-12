SDKUpdates = Class.create({
	/**
	 * Render the items that will display the Titanium SDK status.
	 * In case an update is needed, a link will appear to allow installing the SDK.
	 * Note that all the calls for the Titanium update controllers are asynchronous.
	 */
	render : function() {
		// Prepare the link that will trigger an asynchronous check for the update.
		// The 'update' method will be the one to render the results as they arrive from the Studio side.
		var updatesDiv = $('sdkUpdates');
		var checkLink;
		with(Elements.Builder) {
			// Create three spans under the 'updates div'.
			// The first span will hold the check link, the second will hold the check result,
			// and the third will hold an install link that will be displayed when an update is needed.
			updatesDiv.appendChild(span( checkLink = a({
				"href" : "#"
			}, "Check for updates")));
			updatesDiv.appendChild(span({
				"id" : "sdk-update-status",
				"style" : "padding-left:15px; color:green"
			}));
			updatesDiv.appendChild(span({
				"id" : "install-sdk",
				"style" : "padding-left:15px; color:red"
			}));
			updatesDiv.appendChild(br());
			updatesDiv.appendChild(div(b("Install SDK from url: "), urlInput = input({'type' : 'text', 'name' : 'sdkUrl', 'value' : '', 'size' : '50'}), launchButton = button({'type' : 'button'}, "Install!")));
			
			launchButton.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
					console.log("Dispatching the 'installSDK' action on the 'portal.titanium.sdk.update' controller with arg " + urlInput.value + "...");
					var response = dispatch($H({
						controller : 'portal.titanium.sdk.update',
						action : "installSDK",
						args : '["' + urlInput.value + '"]'
					}).toJSON());
					
					console.log("Response from the 'installSDK' action: " + response);
                }
                return false;
            });
		}
		// Listen to the 'Check for updates' and trigger the controller-action that does that.
		checkLink.observe('click', this.checkForUpdates);
		// do an immediate update.
		this.checkForUpdates();
	},
	/**
	 * Render the results as they arrive from the Studio. The 'status' argument holds the result of the previously called action.
	 * The event that the Studio fires when a 'checkForUpdate' request is sent contains the following fields under the 'data' map attribute:
	 *  - installedMobileSDK (a version string, or an empty value)
	 *  - installedDesktopSDK (a version string, or an empty value)
	 *  - updateAvailable ('true' or 'false')
	 * The events that the Studio fires when an 'installUpdate' request is sent contains in its 'data' part a 'status' field.
	 * The 'status' may be one of the following values:
	 *  - processing
	 *  - ok
	 *  - error
	 *  - incomplete
	 *  - unknown
	 */
	update : function(status) {
		if( typeof (status.data) !== 'undefined') {
			// If the data does not contain a defined 'installedMobileSDK', we can handle this
			// 'update' as a result of an 'installUpdate' request.
			if( typeof (status.data.installedMobileSDK) === 'undefined') {
				this.updateInstallProgress(status.data.status);
			} else {
				// Render the results.
				installedMobile = status.data.installedMobileSDK;
				installedDesktop = status.data.installedDesktopSDK;
				statusSpan = $('sdk-update-status');
				statusSpan.innerHTML = "Mobile: [" + installedMobile + "], Desktop: [" + installedDesktop + "]";

				// if an update is needed, inject a link and listen to 'update' click.
				var installSpan = $('install-sdk');
				installSpan.innerHTML = "Upadate Available: " + status.data.updateAvailable;
				if(status.data.updateAvailable) {
					// Render a link inside the span
					with(Elements.Builder) {
						updateLink = $('update-sdk-link');
						if(updateLink) {
							installSpan.replaceChild( newLink = a({
								"href" : "#",
								"id" : "update-sdk-link",
								"style" : "padding-left:15px;"
							}, "Update!"), updateLink);
							updateLink = newLink;
						} else {
							installSpan.appendChild( updateLink = a({
								"href" : "#",
								"id" : "update-sdk-link",
								"style" : "padding-left:15px;"
							}, "Update!"));
						}
						// Listen to update clicks
						updateLink.observe('click', function(e) {
							if( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
								console.log("Dispatching the 'installUpdate' action on the 'portal.titanium.sdk.update' controller...");
								dispatch($H({
									controller : 'portal.titanium.sdk.update',
									action : "installUpdate"
								}).toJSON());
							}
							return false;
						});
					}
				}
			}
		}
	},
	/**
	 * Update the installation progress presentation.
	 * The given status may be one of the following values:
	 *  - processing
	 *  - ok
	 *  - error
	 *  - incomplete
	 *  - unknown
	 */
	updateInstallProgress : function(status) {
		var installSpan = $('install-sdk');
		var updateLink = $('update-sdk-link');
		switch(status) {
			case 'ok':
				// remove the update link and call for another check
				installSpan.removeChild(updateLink);
				this.checkForUpdates();
				break;
			case 'processing':
				with(Elements.Builder) {
					installSpan.replaceChild(span({
						"id" : "update-sdk-link",
						"style" : "padding-left:15px;"
					}, "Installing..."), updateLink);
				}
				break;
			default:
				alert("A problem when installing the Titanium SDKs [return value: " + status + "]")
		}
	},
	/**
	 * Call request that asks the Studio to check for updates.
	 */
	checkForUpdates : function(e) {
		if( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
			console.log("Dispatching the 'checkForUpdate' action on the 'portal.titanium.sdk.update' controller...");
			dispatch($H({
				controller : 'portal.titanium.sdk.update',
				action : "checkForUpdate"
			}).toJSON());
		}
		return false;
	}
});
