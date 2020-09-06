<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Loader - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <h1>Component Loader (Http Handler)</h1>

    <ext:ResourceManager runat="server" />

    <ext:Panel
        runat="server"
        Height="180"
        Width="360"
        Layout="Accordion"
        Title="Load Items from Http Handler (automatic loading)">
        <Loader
            runat="server"
            Url="ComponentHandler.ashx"
            Mode="Component">
            <LoadMask ShowMask="true" />
        </Loader>
    </ext:Panel>

    <br />
    <br />

    <ext:Panel
        runat="server"
        Height="180"
        Width="500"
        Layout="Fit"
        Title="Load UserControl from Http Handler (manual loading)">
        <Loader
            runat="server"
            AutoLoad="false"
            Url="ComponentHandler.ashx?mode=uc"
            Mode="Component">
            <LoadMask ShowMask="true" />
        </Loader>
        <Buttons>
            <ext:Button runat="server" Text="Load" Icon="PluginGo">
                <Listeners>
                    <Click Handler="this.up('panel').load();this.disable();" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Panel>
</body>
</html>