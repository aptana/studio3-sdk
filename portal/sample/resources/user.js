User = Class.create({
	/**
	 * Render the items that will display the Titanium-User information
	 */
	render : function() {
		userDiv = $('user');
		with(Elements.Builder) {
			if( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
				console.log("Dispatching the 'getUser' action on the 'portal.user' controller...");
				userInfo = dispatch($H({
					controller : 'portal.user',
					action : "getUser"
				}).toJSON()).evalJSON();
				userTable = table({
					"border" : "1",
					"style" : "border-collapse:collapse"
				}, tbody(
					tr(
						th("ID"), 
						th("GUID"), 
						th("Name"), 
						th("Email"), 
						th("Image")), 
					tr(
						td(userInfo["id"]), 
						td(userInfo["guid"]), 
						td(userInfo["name"]), 
						td(userInfo["email"]), 
						td(img({"src" : "http://www.gravatar.com/avatar/" + userInfo["hash"]}))
					)
				));
				userDiv.appendChild(userTable);
			}
		}
	}
});
