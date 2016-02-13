<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreePanel with ajax proxy using HttpHandler - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>TreePanel with ajax proxy using HttpHandler</h1>

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Title="Tree"
            Height="500"
            Width="200"
            Border="false">
            <Store>
                <ext:TreeStore runat="server">
                    <Proxy>
                        <ext:AjaxProxy Url="TreeLoader.ashx" />
                    </Proxy>
                </ext:TreeStore>
            </Store>
            <Root>
                <ext:Node NodeID="0" Text="Root" />
            </Root>
            <ViewConfig LoadMask="false" />
        </ext:TreePanel>
    </form>
</body>
</html>