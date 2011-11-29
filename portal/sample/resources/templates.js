Templates = Class.create({
	/**
	 * Render the items that will import a sample project.
	 */
	render : function() {
		// Get the div for the Open-View example
		projectTemplatesDiv = $('projectTemplates');
		with(Elements.Builder) {
			var typeList = [];
			
			if( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
				console.log("Dispatching the 'getTemplateTypes' action on the 'portal.project.templates' controller...");
				typeList = dispatch($H({
					controller : 'portal.project.templates',
					action : "getTemplateTypes"
				}).toJSON()).evalJSON();
			}
			
			var typeString = "";
			for (var i = 0; i < typeList.length; i++) {
				typeString = typeString + '"' + typeList[i] + '",';
			}
			
			if (typeString !== "") {
			    typeString = typeString.substr(0, typeString.length - 1);
			}
			
			typeString = "[" + typeString + "]";
			
			projectTemplatesDiv.appendChild(p("getTemplateTypes: " + typeString));
			
			var templateList = [];
			if( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
				console.log("Dispatching the 'getTemplates' action on the 'portal.project.templates' controller...");
				templateList = dispatch($H({
					controller : 'portal.project.templates',
					action : "getTemplates",
					args : typeString
				}).toJSON()).evalJSON();
			}
			templateTable = table({
				"border" : "1",
				"style" : "border-collapse:collapse"
			}, tableBody = tbody(tr(th("Name"), th("ID"), th("Description"), th("Type"))));
			// Create the rows in the template-table.
			// Each template in the samples list contains these attributes:
			// 1. name
			// 2. id
			// 3. description
			// 4. type
			for(var i = 0; i < templateList.length; i++) {
				templateItem = templateList[i];
				row = tr(td(templateItem["name"]), td(templateItem["id"]), td(templateItem["description"]), td(templateItem["type"]));
				tableBody.appendChild(row);
			}
			projectTemplatesDiv.appendChild(templateTable);
			
			projectTemplatesDiv.appendChild(div(b("Launch project wizard   wizardId: "), wizardId = input({'type' : 'text', 'name' : 'wizardId', 'value' : 'com.aptana.ui.wizards.NewWebProject', 'size' : '50'}), b("Project template: "), projectTemplateId = input({'type' : 'text', 'name' : 'projectTemplateId', 'value' : "com.aptana.project.template.web.basic", 'size' : '50'}), launchButton = button({'type' : 'button'}, "launch wizard")));
			launchButton.observe('click', function(e) {
                inputElement = e.element();
                if (typeof(console) !== 'undefined' && typeof(dispatch) !== 'undefined') {
                    console.log("Dispatching the 'execute' action on the 'portal.commands' controller...");
					dispatch($H({
                        controller : 'portal.commands',
                        action : "execute",
                        args : ["com.aptana.portal.ui.command.newProjectFromTemplate", {"newWizardId" : wizardId.value, "projectTemplateId" : projectTemplateId.value}].toJSON()
                    }).toJSON());
                }
                return false;
            });
		}
	},
  
  // Accepts an update that was triggered by a browser-notification when a project-template
  // was loaded (added) or unloaded (deleted).
  // The event holds the given information for the nature of the notification (added/deleted), 
  // and hold the Template-Info in its 'data' mapping.
  // The Template in the 'data' will hold these attributes:
	// 1. name
	// 2. id
	// 3. description
	// 4. type
  update : function(e) {
  	if( typeof (console) !== 'undefined') {
  		console.log("A Template was " + e.eventType);
  	}
  }
});