<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Loader - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <h1>Component Loader (JSON WebService)</h1>

    <ext:ResourceManager runat="server" />

    <ext:Panel
        runat="server"
        Height="200"
        Width="350"
        Layout="AccordionLayout"
        Title="Load items from JSON WebService (automatic loading)">
        <Loader
            runat="server"
            Url="ComponentService.asmx/Items"
            Mode="Component">
            <AjaxOptions Json="true" />
            <LoadMask ShowMask="true" />
        </Loader>
    </ext:Panel>

    <br />
    <br />

    <ext:Panel
        runat="server"
        Height="200"
        Width="500"
        Layout="FitLayout"
        Title="Load user control from JSON WebService (manual loading)">
        <Loader
            runat="server"
            AutoLoad="false"
            Url="ComponentService.asmx/UserControl"
            Mode="Component">
            <AjaxOptions Json="true" />
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