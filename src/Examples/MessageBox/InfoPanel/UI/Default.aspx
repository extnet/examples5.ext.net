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
        Icon="Application"
        Width="100"
        Handler="Ext.Msg.info({ui: 'primary', title: 'UI', html: 'Primary', iconCls: '#Application'});" 
        />
    
    <br />
    
    <ext:Button 
        runat="server" 
        Text="Info"
        Icon="Information" 
        Width="100"
        Handler="Ext.Msg.info({ui: 'info', title: 'UI', html: 'Info', iconCls: '#Information'});" 
        />
    
    <br />
    
    <ext:Button 
        runat="server" 
        Text="Success"
        Icon="Accept"
        Width="100"
        Handler="Ext.Msg.info({ui: 'success', title: 'UI', html: 'Success', iconCls: '#Accept'});" 
        />
    
    <br />
    
    <ext:Button 
        runat="server" 
        Text="Danger"
        Icon="Exclamation" 
        Width="100"
        Handler="Ext.Msg.info({ui: 'danger', title: 'UI', html: 'Danger', iconCls: '#Exclamation'});" 
        />

    <br />
    
    <ext:Button 
        runat="server" 
        Text="Warning"
        Icon="Error"
        Width="100"
        Handler="Ext.Msg.info({ui:'warning', title: 'UI', html: 'Warning', iconCls: '#Error'});" 
        />
</body>
</html>