/**
 * This script manages the portal observer-observable event mechanism.
 */
// Constants
var Events = {RECENT_FILES : 'recentFiles', MOBILE_SDK : 'mobileSDK', TITANIUM_SDK : 'titaniumSDK', 
              SAMPLES : 'samples', TEMPLATES : 'templates'};
// Creates the eventsDispatcher which contains the notify() function.
// IMPORTANT! The Studio expects the observable to be called 'eventsDispatcher', and 
// expects the eventsDispatcher function to be called 'notify()'. Do not change these names.
var eventsDispatcher = new Observable();

/**
 * The Portal class
 */
var Portal = Class.create({
  initialize: function() {
		// Create the UI parts and render them
    this.preferences  = new Preferences();
    this.views = new Views();
    this.commands = new Commands();
    this.templates = new Templates();
    this.browserInteractions = new Browser();
    this.recentFiles = new RecentFiles();
    this.samples = new Samples();
    this.user = new User();
    this.updates = new Updates();
    this.configurations = new Configurations();
    this.sdks = new MobileSDK();
    this.modules = new Modules();
    
    this.preferences.render();
    this.views.render();
    this.commands.render();
    this.templates.render();
    this.browserInteractions.render();
    this.recentFiles.render();
    this.samples.render();
    this.user.render();
    this.updates.render();
    this.configurations.render();
    this.sdks.render();
    this.modules.render();
    
    // Add a recent-files observer to the dispatcher. Render the recent files list on a 'recentFiles' events.
    eventsDispatcher.addObserver(Events.RECENT_FILES, function(e) { portal.recentFiles.render(); });
    // Add a Mobile SDKs observer to the dispatcher. Render the Mobile SDK table on a 'mobileSDK' events.
    eventsDispatcher.addObserver(Events.MOBILE_SDK, function(e) { portal.sdks.update(e); });
    // Add a Titanium SDKs observer to the dispatcher. Render the Titanium SDK update status on a 'mobileSDK' events.
    eventsDispatcher.addObserver(Events.TITANIUM_SDK, function(e) { portal.updates.update(e); });
    // Add a Samples observer to the dispatcher. Can be used to render the Samples as they are added/removed.
    eventsDispatcher.addObserver(Events.SAMPLES, function(e) { portal.samples.update(e); });
    // Add a Templates observer to the dispatcher. Can be used to render the Templates as they are added/removed.
    eventsDispatcher.addObserver(Events.TEMPLATES, function(e) { portal.templates.update(e); });
  }
});

var portal;

function loadPortal() {
  if (typeof(portal) === 'undefined') {
    portal = new Portal();
  }
}

// Returns an element that contains informative text about running this portal outside the studio
function _studioOnlyContent() {
	var resultDiv;
	with(Elements.Builder) {
	   var showInfo;
	   resultDiv = div(
	     div({'class' : 'unavailable'}, 'Content Unavailable'),
	     div(showInfo = a({'href' : '#'}, 'about'))
	   );
	   showInfo.observe('click', function(event) {
	     DialogHelper.createInfoBox("Content Unavailable", "This portal element interacts with Aptana Studio and only available when running within the Studio", "back to portal");
	     event.stop();
	   });
	}
	return resultDiv;
}

// Remove all the descendants from the parent element
function _clearDescendants(parentElement) {
	if (parentElement) {
		var descendants = parentElement.descendants();
		var items_count = descendants.size();
        for( var i = 0; i < items_count; i++ ) {
			descendants[i].remove();
		}
	}
}
function _isErrorStatus(jsonContent) {
	return jsonContent.event == Events.ERROR;
}

/**
 * Returns a DIV with an error details. 
 * The error details will appear only if the jsonError contains an errorDetails in its data hash.
 */
function _errorStatus(jsonError) {
	var d;
	with(Elements.Builder) {
		d = div({'class' : 'errorStatus'}, div({'class' : 'errorTitle'}, 'An error occured'));
		if (jsonError.data.errorDetails) {
			d.appendChild(div({'class' : 'errorDetails'}, jsonError.data.errorDetails));
		}
	}
	return d;
}
 