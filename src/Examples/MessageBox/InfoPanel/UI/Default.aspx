<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Info UI - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Button
        runat="server"
        Text="Primary"
        IconCls="x-md md-icon-open-in-new"
        Width="100"
        Handler="Ext.Msg.info({ui: 'primary', title: 'UI', html: 'Primary', iconCls: '#Application'});"
        />

    <br />

    <ext:Button
        runat="server"
        Text="Info"
        IconCls="x-md md-icon-info"
        Width="100"
        Handler="Ext.Msg.info({ui: 'info', title: 'UI', html: 'Info', iconCls: '#Information'});"
        />

    <br />

    <ext:Button
        runat="server"
        Text="Success"
        IconCls="x-md md-icon-check-circle-outline"
        Width="100"
        Handler="Ext.Msg.info({ui: 'success', title: 'UI', html: 'Success', iconCls: '#Accept'});"
        />

    <br />

    <ext:Button
        runat="server"
        Text="Danger"
        IconCls="x-md md-icon-error"
        Width="100"
        Handler="Ext.Msg.info({ui: 'danger', title: 'UI', html: 'Danger', iconCls: '#Exclamation'});"
        />

    <br />

    <ext:Button
        runat="server"
        Text="Warning"
        IconCls="x-md md-icon-error-outline"
        Width="100"
        Handler="Ext.Msg.info({ui:'warning', title: 'UI', html: 'Warning', iconCls: '#Error'});"
        />
</body>
</html>