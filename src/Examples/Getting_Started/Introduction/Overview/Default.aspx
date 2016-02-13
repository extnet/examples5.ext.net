<%@ Page Language="C#" %>
<!DOCTYPE html>

<html>
<head runat="server">
    <title>Getting Started - Ext.NET Examples</title>
    <link href="/resources/css/examples.css"  rel="stylesheet" />
    <base target="_blank" />
</head>
<body>
    <h1>Welcome to the Ext.NET Examples Explorer</h1>

    <h2>Overview</h2>

    <p>Ext.NET is an advanced ASP.NET (WebForms + MVC) component framework integrating the cross-browser Sencha Ext JS JavaScript Library.</p>

    <p>Ext.NET is built for developers, by developers. We provide hundreds of demos with full code samples in the <a href="http://examples.ext.net/">Examples Explorer</a>. Need a little help? Check out our Premium Technical <a href="http://ext.net/store#premium">Support Subscription</a>.</p>

    <p>Direct access to the latest Ext.NET source code, via read-only SVN access, is available to all Ext.NET Pro
        license holders with a valid <a href="http://ext.net/store#premium">Premium Support</a> Subscription.</p>

    <h2>System Requirements</h2>

    <ol>
        <li><a href="http://microsoft.com/visualstudio/eng/products/visual-studio-overview">Visual Studio</a> 2010, 2012 and 2013, or</li>
        <li><a href="http://microsoft.com/visualstudio/eng/products/visual-studio-express-products">Visual Studio Express</a> 2010, 2012 and 2013</li>
        <li>.NET Framework 3.5, 4.0* or 4.5</li>
    </ol>

    <p>*minimum required for Ext.NET MVC</products>

    <h2>Getting Started (NuGet)</h2>

    <p>The easiest and quickest way to install Ext.NET is using <a href="http://nuget.org/packages/Ext.NET">NuGet</a>. Run the following command in Visual Studio Package Manager Console,
    or seach for "Ext.NET" in NuGet Package Manager.</p>

    <p><code>Install-Package Ext.NET</code></p>

    <h2>Getting Started (Manual)</h2>

    <ol>
        <li>First ensure you have Visual Studio or Visual Web Developer Express installed on your computer.
            <div class="information"><p>If you do not have a copy of Visual Studio already installed, the <a href="http://microsoft.com/visualstudio/eng/products/visual-studio-express-products/">Visual Studio Express</a> is free to use and
            is a great way to get started with ASP.NET and Ext.NET. The Ext.NET Components work exactly the same in both environments.</p></div></li>

        <li>A Manual installation package (.zip) is available for download at <a href="http://ext.net/download/">http://ext.net/download/</a>.</li>

        <li>Create your first "Web Site" Project.
            <ol style="list-style-type: lower-roman;">
                <li>Open Visual Studio (or Visual Web Developer) and create a new "Web Site" project. From the File Menu, select New > Web Site.</li>
                <li>The "New Web Site" dialog will open, ensure "ASP.NET Web Site" is selected from the list of Templates.</li>
                <li>For your first project, the "Location" option of "File System" and default file path should be fine, or modify to fit your preference.</li>
                <li>Please select your "Language" preference. Whether you choose "Visual C#" or "Visual Basic" is ultimately just dependent on personal coding preferences.
                    Ext.NET is written in C#, but can be used in any .NET language, including Visual Basic, C# and even ASP.NET MVC Razor.</li>
                <li>Click "OK".</li>
            </ol>
        </li>

        <li>Detailed manual installation steps are detailed at <a href="http://forums.ext.net/showthread.php?11027-Install-and-Setup-Guide-for-Visual-Studio">Install and Setup Guide for Visual Studio</a></li>
    </ol>

    <h2>Sample Web.config (WebForms and MVC)</h2>

<pre class="code">
&lt;?xml version="1.0"?>
&lt;configuration>
  &lt;configSections>
    &lt;section name="extnet" type="Ext.Net.GlobalConfig" requirePermission="false" />
  &lt;/configSections>

  &lt;extnet theme="Crisp" licenseKey="** Ext.NET LICENSE KEY HERE **" initScriptMode="Linked" />

  &lt;system.web>
    &lt;httpHandlers>
      &lt;add path="*/ext.axd" verb="*" type="Ext.Net.ResourceHandler" validate="false" />
    &lt;/httpHandlers>

    &lt;httpModules>
      &lt;add name="DirectRequestModule" type="Ext.Net.DirectRequestModule, Ext.Net" />
    &lt;/httpModules>

    &lt;pages>
      &lt;controls>
        &lt;add assembly="Ext.Net" namespace="Ext.Net" tagPrefix="ext" />
      &lt;/controls>
    &lt;/pages>
  &lt;/system.web>

  &lt;system.webServer>
    &lt;validation validateIntegratedModeConfiguration="false" />

    &lt;modules>
      &lt;add name="DirectRequestModule" preCondition="managedHandler" type="Ext.Net.DirectRequestModule, Ext.Net" />
    &lt;/modules>

    &lt;handlers>
      &lt;add name="DirectRequestHandler" verb="*" path="*/ext.axd" preCondition="integratedMode" type="Ext.Net.ResourceHandler" />
    &lt;/handlers>
  &lt;/system.webServer>

  &lt;runtime>
    &lt;assemblyBinding xmlns="urn:schemas-microsoft-com:asm.v1">
      &lt;dependentAssembly>
        &lt;assemblyIdentity name="Newtonsoft.Json" publicKeyToken="30ad4fe6b2a6aeed" />
        &lt;bindingRedirect oldVersion="0.0.0.0-8.0.0.0" newVersion="8.0.0.0" />
      &lt;/dependentAssembly>
      &lt;dependentAssembly>
        &lt;assemblyIdentity name="Ext.Net.Utilities" publicKeyToken="2c34ac34702a3c23" />
        &lt;bindingRedirect oldVersion="0.0.0.0-2.5.0" newVersion="2.5.0" />
      &lt;/dependentAssembly>
      &lt;dependentAssembly>
        &lt;assemblyIdentity name="Transformer.NET" publicKeyToken="e274d618e7c603a7" />
        &lt;bindingRedirect oldVersion="0.0.0.0-2.1.1" newVersion="2.1.1" />
      &lt;/dependentAssembly>

      &lt;!--MVC 4-->
      &lt;!--
      &lt;dependentAssembly>
        &lt;assemblyIdentity name="System.Web.Mvc" publicKeyToken="31bf3856ad364e35" />
        &lt;bindingRedirect oldVersion="1.0.0.0-5.0.0.0" newVersion="4.0.0.0" />
      &lt;/dependentAssembly>
      &lt;dependentAssembly>
        &lt;assemblyIdentity name="System.Web.Helpers" publicKeyToken="31bf3856ad364e35" />
        &lt;bindingRedirect oldVersion="1.0.0.0-2.0.0.0" newVersion="2.0.0.0" />
      &lt;/dependentAssembly>
      &lt;dependentAssembly>
        &lt;assemblyIdentity name="System.Web.WebPages" publicKeyToken="31bf3856ad364e35" />
        &lt;bindingRedirect oldVersion="1.0.0.0-2.0.0.0" newVersion="2.0.0.0" />
      &lt;/dependentAssembly>
      -->

      &lt;!--MVC 5-->
      &lt;!--
      &lt;dependentAssembly>
        &lt;assemblyIdentity name="System.Web.Helpers" publicKeyToken="31bf3856ad364e35"/>
        &lt;bindingRedirect oldVersion="1.0.0.0-3.0.0.0" newVersion="3.0.0.0"/>
      &lt;/dependentAssembly>
      &lt;dependentAssembly>
        &lt;assemblyIdentity name="System.Web.WebPages" publicKeyToken="31bf3856ad364e35"/>
        &lt;bindingRedirect oldVersion="1.0.0.0-3.0.0.0" newVersion="3.0.0.0"/>
      &lt;/dependentAssembly>
      &lt;dependentAssembly>
        &lt;assemblyIdentity name="System.Web.Mvc" publicKeyToken="31bf3856ad364e35"/>
        &lt;bindingRedirect oldVersion="1.0.0.0-5.2.2.0" newVersion="5.2.2.0"/>
      &lt;/dependentAssembly>
      -->
    &lt;/assemblyBinding>
  &lt;/runtime>
&lt;/configuration>
</pre>

    <h2>Web.config &lt;extnet> Global Configuration Properties</h2>

<pre class="code">
    ajaxTimeout : int
        Sets the default Timeout in milliseconds for all AJAX operations: DirectEvents, DirectMethods, loading data to Stores via AJAX (PageProxy, AjaxProxy), etc.
        Default is 30000.

    ajaxViewStateMode : ViewStateMode
        Specifies whether the ViewState should be returned and updated on the client during an DirectEvent.
        The Default value is to Exclude the ViewState from the Response.
        Default is 'Default'. Options include [Default|Exclude|Include]

    cleanResourceUrl : bool
        The Ext.NET controls can clean up the autogenerated WebResource URL so they look presentable.
        Default is 'true'. Options include [true|false]

    dateTimeZoneHandling : DateTimeZoneHandling
        Specifies how to treat the time value when converting between string and DateTime.
        It is a Json.NET setting. More details: http://james.newtonking.com/json/help/index.html?topic=html/SerializeDateTimeZoneHandling.htm

    disableViewState : bool
        Specifies whether remove ViewState from page's rendering or not. Defaults to true (remove).

    directEventUrl : string
        The url to request for all DirectEvents.
        Default is "".

    directMethodProxy : ClientProxy
        Specifies whether server-side Methods marked with the [DirectMethod] attribute will output configuration script to the client.
        If not, the DirectMethods can still be called, but the DirectMethod proxies are not automatically generated.
        Default is 'Default' (it creates the proxy for each DirectMethod). Options include [Default|Include|Ignore]

    directMethodNamespace : string
        Specifies a custom namespace prefix to use for the DirectMethods.
        Defaults to App.direct.

    glyphFontFamily : string
        Sets the default font-family to use for components that support a glyph config.
        Default is "".

    gzip : bool
        Whether to automatically render scripts with gzip compression.
        Only works when renderScripts="Embedded" and/or renderStyles="Embedded".
        Default is true. Options include [true|false]

    idMode : IDMode
        Manages how a control's id is rendered to the client.
        Default is 'Explicit'. Options include [Client|Explicit|Ignore|Inherit|Legacy|Parent|Predictable|Static]

    initScriptMode : InitScriptMode
        Specifies how to render the Ext.NET initialization script. The options are self-explanatory.
        Default is 'Inline'. Options include [Inline|Linked]

    licenseKey : string
        The Ext.NET Pro License key.

    locale : string
        Specifies the language of the Ext.NET localization resources to use. For example, "en-GB", "fr-CA", "ru".
        Default is English.

    namespace : string
        The application's JavaScript namespace.
        Default is "App".

    renderScripts : ResourceLocationType
        Whether to have the Ext.NET controls output the required JavaScript includes or not.
        Gives a developer the option of manually including the required <script> files.
        Default is Embedded. Options include [Embedded|File|CDN|None]

    renderStyles : ResourceLocationType
        Whether to have the Ext.NET controls output the required StyleSheet includes or not.
        Provides a developer with the option to include the required <script> files manually.
        Default is Embedded. Options include [Embedded|File|CDN|None]

    resourcePath : string
        Specifies the prefix of the URL path to the base ~/Ext.Net/ folder containing the resources files for this project.
        The path can be Absolute or Relative.

    resourcesStrategyType : string
        The class name with the logic to map Ext.NET resources to arbitrary URLs, i.e. to provide custom functionality for registering of resources (JavaScript, CSS).
        Returning "null" for a specific resource means the default URL. Returning an empty string means to prevent registering of a specific resource at all.
        The default strategy is in this file: Ext.Net\Core\ResourcesStrategy.cs.

    resetStyles : bool
        True to reset default browser styles.
        Default is false. Options include [true|false]

    rethrowAjaxExceptions : bool
        Rethrow AJAX exceptions from catch sections.
        Default is false. Options include [true|false]

    rtl : bool
        True to layout the page in "rtl" (right-to-left) mode.
        Default is false. Options include [true|false]

    scriptMode : ScriptMode
        Specifies whether the Scripts should be rendered in Release (minified), Debug (non-minified) or Development (non-minified with additional debug information) mode.
        Default is "Release". Options include [Release|Debug|Development]

    separateUIStyles: bool
        True to separate the CSS files required for each UI style into individual files. Each UI CSS file will be rendered to the Page as a separate include. So, if some UI pattern is not used, its CSS styles are not loaded.
        If false, all the UI styles are combined into the only .css file. So, the styles for all UI patterns are loaded regadless it is actually used or not.
        Default is true. Options include [true|false]

    showWarningOnAjaxFailure : bool
        Show a warning dialog on ajax event failure or not.
        Default is 'true'. Options include [true|false]

    sourceFormatting : bool
        Specifies whether the Ext.NET initializaztion script rendered to the page should be formatted. 'True' = formatted/non-minified, 'False' = minified/compressed.
        Default is 'false'. Options include [true|false]

    stateProvider : StateProvider
        Specifies the current state provider to maintain the controls' state.
        Default is 'PostBack'. Options include [PostBack|Cookie|None]

    submitDisabled : bool
        If false then disabled fields will not be submitted.
        Default is 'false'. Options include [true|false]

    theme : Theme
        Specifies the embedded theme to use.
        Default is "Default" (blue theme). Options include [Default|Access|Gray|Neptune]

    themePath : string
        Configure the path to the custom theme .css and .js (if required) file globally across the entire application. This will override any .Theme setting.
        You can specify several files by delimiting them with "|". For example, "some.css|another.css|some.js|another.js".
        Regularly, you will need to specify the only .css file, for example, "some.css" or two files - one .css and one .js - "some.js|some.css".
        Default is "".

    quickTips : bool
        Specifies whether to render the QuickTips. Provides attractive and customizable tooltips for any element.
        Default is 'true'. Options include [true|false]
</pre>
  </body>
</html>
