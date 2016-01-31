<%@ Page Language="C#" %>

<%@ Register Assembly="Ext.Net.Examples" Namespace="Ext.Net.Examples" TagPrefix="ext" %>

<%@ Import Namespace="Microsoft.AspNet.SignalR" %>
<%@ Import Namespace="System.Web.Routing" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>SignalR Stock Ticker example using Ext.NET - Ext.Net.Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />
    <link href="resources/SignalR.StockTicker.css" rel="stylesheet" />

    <script src="resources/jquery-2.0.3.js"></script>
    <script src="resources/jquery.signalR-2.0.1.js"></script>
    <script src="/signalr/hubs"></script>
    <script src="resources/SignalR.StockTicker.js"></script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>SignalR Stock Ticker example using Ext.NET by <a href="http://forums.ext.net/member.php?562-anup" target="_blank">Anup<a></h1>

    <p><a href="http://www.asp.net/signalr" target="_blank">SignalR</a> is an ASP.NET library making it easier to create real time web applications.</p>

    <p>See the <a href="http://ext.net/signalr-with-ext-net" target="_blank">blog post</a> for more details.</p>

    <ext:Window 
        runat="server" 
        Layout="FitLayout" 
        Icon="Table" 
        Title="SignalR Stock Ticker with Ext.NET" 
        Closable="false" 
        Width="675" 
        Height="300" 
        Border="false">
        <Items>
            <ext:SignalRGridPanel ID="GridPanel1" runat="server" />
        </Items>
    </ext:Window>
</body>
</html>