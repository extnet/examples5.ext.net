<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>LoadMask during Page_Load - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Configure LoadMask for AutoLoad</h1>

        <p>Demonstrates how to configure a LoadMask to render while an external page is loading.</p>

        <ext:Window
            ID="Window1"
            runat="server"
            Width="500"
            Height="470"
            Title="Example">
            <Loader
                runat="server"
                Url="https://ext.net/"
                Mode="Frame">
                <LoadMask ShowMask="true" Msg="Custom Loading Message..." />
            </Loader>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill />
                        <ext:Button runat="server" Text="Load Ext.NET forums" IconCls="x-md md-icon-open-in-new">
                            <Listeners>
                                <Click Handler="#{Window1}.load('https://forums.ext.net/');" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button runat="server" Text="Refresh" IconCls="x-md md-icon-rotate-right">
                            <Listeners>
                                <Click Handler="#{Window1}.reload();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:Window>
    </form>
</body>
</html>