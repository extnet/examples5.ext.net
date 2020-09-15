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
        Height="180"
        Width="360"
        Layout="Accordion"
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
        Height="180"
        Width="500"
        Layout="Fit"
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
            <ext:Button runat="server" Text="Load" IconCls="x-md md-icon-extension">
                <Listeners>
                    <Click Handler="this.up('panel').load();this.disable();" />
                </Listeners>
            </ext:Button>
        </Buttons>
    </ext:Panel>
</body>
</html>