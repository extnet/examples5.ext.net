<%@ Page Language="C#" %>

<script runat="server">
    protected void ServerHandler(object sender, DirectEventArgs e)
    {
        X.Msg.Alert("Response", "Server response for window with title '"+e.ExtraParams["title"]+"'").Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Template Widget Cache - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Template Widget Cache</h1>
        <p>See window title with timestamp to understand new or cached instance of window is opened</p>

        <ext:Button
            runat="server"
            Text="Open window with caching"
            Width="200"
            Handler="App.getMessageWindow({title : new Date().toString()}, true).show();"
            />

        <ext:Button
            runat="server"
            Text="Clear cache and open new window"
            Width="200"
            Handler="App.getMessageWindow({title : new Date().toString()}).show();"
            />

        <ext:Window
            ID="MessageWindow"
            runat="server"
            Title="Compose message"
            Width="360"
            Height="180"
            Modal="true"
            TemplateWidget="true">
            <Buttons>
                <ext:Button runat="server" Text="Server response">
                    <DirectEvents>
                        <Click OnEvent="ServerHandler">
                            <ExtraParams>
                                <ext:Parameter Name="title" Value="this.up('window').title" Mode="Raw" />
                            </ExtraParams>
                        </Click>
                    </DirectEvents>
                </ext:Button>
            </Buttons>
        </ext:Window>
    </form>
</body>
</html>
