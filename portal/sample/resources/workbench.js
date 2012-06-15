Workbench = Class.create({
  /**
   * Render the workbench-related items.
   */
  render : function() {
    with (Elements.Builder) {
      if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
        console.log("Dispatching the 'getActivePerspective' action on the 'portal.workbench' controller...");
        var activePerspective = dispatch($H({
          controller : 'portal.workbench',
          action : "getActivePerspective"
        }).toJSON()).evalJSON();

        // Get the div for the Open-View example
        var workbenchDiv = $('workbench');
        var activePerspectiveTable = table({
          "border" : "1",
          "style" : "border-collapse:collapse"
        }, tbody(tr(th("Label"), th("Description"), th("ID")), tr(td(activePerspective["label"]), td(activePerspective["description"]), td(activePerspective["id"]))));

        workbenchDiv.appendChild(div("Active Perspective:"));
        workbenchDiv.appendChild(activePerspectiveTable);
      }
    }
  }
});
