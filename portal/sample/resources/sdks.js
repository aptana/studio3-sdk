MobileSDK = Class.create({
  /**
   * Render the items that will trigger a studio's command.
   */
  render : function() {
    // These calls will trigger an asynchronous operation on the Studio side.
    // Once the studio is done, the 'update' function will be called from the Portal's
    // event handling code, and the SDK table will be rendered / re-rendered.
    this.getVersionInfo("iOS");
    this.getVersionInfo("Android");
    this.getVersionInfo("MobileWeb");
  },

  update : function(sdkEvent) {
    if (sdkEvent["eventType"] == "response") {
      eventData = sdkEvent["data"];
      sdkName = eventData["sdkName"];
      sdkInfo = eventData["sdkInfo"];
      if ( typeof (console) !== 'undefined') {
        console.log("Got an update for the " + sdkName + " SDK info.");
        console.log($H(sdkInfo).inspect());
      }
      if (sdkName == "ios") {
        this.renderIOS(sdkInfo);
      } else if (sdkName == "android") {
        this.renderAndroid(sdkInfo);
      } else if (sdkName == "mobileweb") {
        this.renderMobileWebBrowsers(sdkInfo);
      }
    }
  },

  /**
   * Render the iOS SDK table, potentially replacing the previous content with an updated one.
   */
  renderIOS : function(iOSVersionInfo) {
    var mobileSDKDiv = $('mobileSDKs');
    with (Elements.Builder) {
      var iosTable = table({
        "border" : "1",
        "style" : "border-collapse:collapse"
      }, tbody(tr(td("Installed iOS Version: "), td(iOSVersionInfo["installedPlatforms"])), tr(td("Minimum Required Version: "), td(iOSVersionInfo["requiredPlatforms"])), tr(td("Needs Update: "), td(iOSVersionInfo["shouldUpdatePlatforms"]))));
      // Create a div that wraps all of it, so we can easily replace the children on
      // render calls that were made as a result of an event handling.
      var wrapperDiv = div({
        'id' : 'iosSDKDiv'
      });
      wrapperDiv.appendChild(div({
        "style" : "color:red"
      }, "=== iOS ==="));
      wrapperDiv.appendChild(iosTable);
      var prevContent = $('iosSDKDiv');
      if (prevContent) {
        mobileSDKDiv.replaceChild(wrapperDiv, prevContent);
      } else {
        mobileSDKDiv.appendChild(wrapperDiv);
      }
    }
  },

  /**
   * Render the Android SDK table, potentially replacing the previous content with an updated one.
   */
  renderAndroid : function(androidVersionInfo) {
    var mobileSDKDiv = $('mobileSDKs');
    with (Elements.Builder) {
      var androidTable = table({
        "border" : "1",
        "style" : "border-collapse:collapse"
      }, tbody(tr(td("Installed Platforms: "), td(androidVersionInfo["installedPlatforms"])), tr(td("Required Platforms: "), td(androidVersionInfo["requiredPlatforms"])), tr(td("Needs Platforms Update: "), td(androidVersionInfo["shouldUpdatePlatforms"])), tr(td("Installed Platform-Tools: "), td(androidVersionInfo["installedPlatformTools"])), tr(td("Required Platform-Tools: "), td(androidVersionInfo["requiredPlatformTools"])), tr(td("Needs Platform-Tools Update: "), td(androidVersionInfo["shouldUpdatePlatformTools"])), tr(td("Installed SDK-Tools: "), td(androidVersionInfo["installedSDKTools"])), tr(td("Required SDK-Tools: "), td(androidVersionInfo["requiredSDKTools"])), tr(td("Needs SDK-Tools Update: "), td(androidVersionInfo["shouldUpdateSDKTools"])), tr(td("Installed Add-Ons: "), td(androidVersionInfo["installedAddOns"])), tr(td("Required Add-Ons: "), td(androidVersionInfo["requiredAddOns"])), tr(td("Needs Add-Ons Update: "), td(androidVersionInfo["shouldUpdateAddOns"])), tr(td("Installed API-Levels: "), td(androidVersionInfo["installedAPILevels"])), tr(td("Required API-Levels: "), td(androidVersionInfo["requiredAPILevels"])), tr(td("Needs API-Levels Update: "), td(androidVersionInfo["shouldUpdateAPILevels"])), tr(td("SDK-Tools URL: "), td(androidVersionInfo["sdkURL"])), tr(td("Has JAVA_HOME Setting: "), td(androidVersionInfo["hasJavaHome"])), tr(td("Has JDK: "), td(androidVersionInfo["hasJDK"])), tr(td("JDK URL: "), td(androidVersionInfo["jdkURL"]))));
      // Create a div that wraps all of it, so we can easily replace the children on
      // render calls that were made as a result of an event handling.
      var wrapperDiv = div({
        'id' : 'androidSDKDiv'
      });
      wrapperDiv.appendChild(div({
        "style" : "color:red"
      }, "=== Android ==="));
      wrapperDiv.appendChild(androidTable);

      // An install/update Android link.
      // Note that for iOS we should just show install instructions.
      wrapperDiv.appendChild(div({
        "style" : "color:red"
      }, "=== Android Install/Update ==="));
      installOrUpdate = table(tbody(tr(td(a({
        'href' : '#'
      }, "Install/Update Android")))));
      wrapperDiv.appendChild(installOrUpdate);

      var prevContent = $('androidSDKDiv');
      if (prevContent) {
        mobileSDKDiv.replaceChild(wrapperDiv, prevContent);
      } else {
        mobileSDKDiv.appendChild(wrapperDiv);
      }
      installOrUpdate.observe('click', function(e) {
        if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
          console.log("Dispatching the 'execute' action on the 'portal.mobileSDK' controller...");
          dispatch($H({
            controller : 'portal.mobileSDK',
            action : "installOrUpdateSDK",
            args : ["Android"].toJSON()
            // args : ["Android", true].toJSON() --> To force the Android installer UI
          }).toJSON());
        }
        return false;
      });
    }
  },

  /**
   * Render the MobileWeb Browsers table, potentially calling to search and update the Studio
   * settings with the system's detected browsers.
   */
  renderMobileWebBrowsers : function(browsersVersionInfo) {
    var mobileSDKDiv = $('mobileSDKs');
    with (Elements.Builder) {
      var browsersTable = table({
        "border" : "1",
        "style" : "border-collapse:collapse"
      }, tbody(tr(td("Installed Browsers Versions: "), td($H(browsersVersionInfo["installedBrowsers"]).inspect())), tr(td("Minimum Required Versions: "), td($H(browsersVersionInfo["requiredBrowsers"]).inspect())), tr(td("Needs Update: "), td(browsersVersionInfo["shouldUpdateBrowsers"]))));
      // Create a div that wraps all of it, so we can easily replace the children on
      // render calls that were made as a result of an event handling.
      var wrapperDiv = div({
        'id' : 'mobilewebBrowsersDiv'
      });
      wrapperDiv.appendChild(div({
        "style" : "color:red"
      }, "=== MobileWeb Supported Browsers ==="));
      wrapperDiv.appendChild(browsersTable);
      var prevContent = $('mobilewebBrowsersDiv');
      if (prevContent) {
        mobileSDKDiv.replaceChild(wrapperDiv, prevContent);
      } else {
        mobileSDKDiv.appendChild(wrapperDiv);
      }
    }
  },

  /**
   * Returns the version information for a requested SDK type (e.g. 'Android', 'iOS' and 'BlackBerry').
   * The version info we get back is a hash that holds the following fields:
   *   {
   *     installedPlatforms:<installed 'platform' versions>,
   *     requiredPlatforms : <the required 'platform' versions>,
   *     shouldUpdatePlatforms : <boolean value indicating that the platforms should be updated>,
   *     installedPlatformTools : <latest installed platform-tools revision>,
   *     requiredPlatformTools : <the required platform-tools revision>,
   *     shouldUpdatePlatformTools : <boolean value indicating that the platform-tools should be updated>,
   *     installedSDKTools : <latest installed SDK tools revision>,
   *     requiredSDKTools : <the required SDK tools revision>,
   *     shouldUpdateSDKTools : <boolean value indicating that the SDK tools should be updated>,
   *     installedAddOns : &lt;latest installed add-ons&gt;,
   *     requiredAddOns : &lt;the required add-ons&gt;,
   *     shouldUpdateAddOns : &lt;boolean value indicating that the add-ons should be updated&gt;,
   *     sdkToolsURL : <SDK Tools URL for an installation/update>
   *     hasJavaHome : <boolean value indicating that the JAVA_HOME was set>
   *     hasJDK : <boolean value indicating that a JDK was detected>
   *     jdkURL : <JDK installer URL>
   *   }
   * </pre>
   *
   * <b>NOTE:</b> For iOS and Blackberry, the returned JSON only holds the 'installedPlatform', 'requiredPlatform' and
   * 'shouldUpdatePlatform' fields.
   *
   */
  getVersionInfo : function(sdk) {

    if ( typeof (console) !== 'undefined' && typeof (dispatch) !== 'undefined') {
      console.log("Dispatching an async call to 'getSDKInfo' action on the 'portal.mobileSDK' controller...");
      return dispatch($H({
        controller : 'portal.mobileSDK',
        action : "getSDKInfo",
        args : [sdk].toJSON()
      }).toJSON());
    }
    return null;
  }
});
