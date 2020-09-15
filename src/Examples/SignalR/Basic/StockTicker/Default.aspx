<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net.Examples" Namespace="Ext.Net.Examples" TagPrefix="ext" %>

<%@ Import Namespace="Microsoft.AspNet.SignalR" %>
<%@ Import Namespace="Microsoft.AspNet.SignalR.Transports" %>
<%@ Import Namespace="Owin" %>
<%@ Import Namespace="System.Web.Routing" %>
<%@ Import Namespace="System.IO" %>
<!DOCTYPE html>

<script runat="server">
    public string jQueryPath;
    public string jQuerySignalRPath;
    
    public void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            var transportManager = GlobalHost.DependencyResolver.Resolve<ITransportManager>() as TransportManager;
            transportManager.Remove("webSockets");

            #region jQuery NuGet package support
            
            var debugExt = ".min";
            if (ResourceManager.GetInstance().ScriptMode == Ext.Net.ScriptMode.Debug) {
                debugExt = "";
            }

            var jsPath = Server.MapPath("/Scripts");
            if (Directory.Exists(jsPath))
            {
                foreach (var file in Directory.GetFiles(jsPath))
                {
                    var fileName = Path.GetFileName(file);
                    if (Regex.Match(fileName, "^jquery-[0-9]{1,}\\.[0-9]{1,}\\.[0-9]{1,}" + debugExt + "\\.js$").Success)
                    {
                        jQueryPath = "/Scripts/" + fileName;
                    }

                    if (Regex.Match(fileName, "^jquery\\.signalR-[0-9]{1,}\\.[0-9]{1,}\\.[0-9]{1,}" + debugExt + "\\.js$").Success)
                    {
                        jQuerySignalRPath = "/Scripts/" + fileName;
                    }
                }
            }
            
            if (string.IsNullOrWhiteSpace(jQueryPath))
            {
                throw new FileNotFoundException("Unable to find jQuery file matching 'jquery-N.N.N" + debugExt + ".js'. Please ensure you have a correct jQuery installation in the project and that its files are under '/Scripts' in the website.");
            }

            if (string.IsNullOrWhiteSpace(jQuerySignalRPath))
            {
                throw new FileNotFoundException("Unable to find jQuery-SignalR file matching 'jquery.signalR-N.N.N" + debugExt + ".js'. Please ensure you have a correct jQuery-SignalR installation in the project and that its files are under '/Scripts' in the website.");
            }
            
            #endregion jQuery NuGet package support
        }
    }
</script>

<html>
<head runat="server">
    <title>SignalR Stock Ticker example using Ext.NET - Ext.Net.Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="resources/SignalR.StockTicker.css" rel="stylesheet" />

    <script src="<%= jQueryPath %>"></script>
    <script src="<%= jQuerySignalRPath %>"></script>
    <script src="/signalr/hubs"></script>
    <script src="resources/SignalR.StockTicker.js"></script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>SignalR Stock Ticker example using Ext.NET by <a href="https://forums.ext.net/member.php?562-anup" target="_blank">Anup</a></h1>

    <p><a href="http://www.asp.net/signalr" target="_blank">SignalR</a> is an ASP.NET library making it easier to create real time web applications.</p>

    <p>See the <a href="https://ext.net/signalr-with-ext-net" target="_blank">blog post</a> for more details.</p>

    <ext:Window
        runat="server"
        Layout="Fit"
        IconCls="x-md md-icon-grid-on"
        Title="SignalR Stock Ticker with Ext.NET"
        Closable="false"
        Width="675"
        Height="480"
        Border="false">
        <Items>
            <ext:SignalRGridPanel ID="GridPanel1" runat="server" />
        </Items>
    </ext:Window>
</body>
</html>