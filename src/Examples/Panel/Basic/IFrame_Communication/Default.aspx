<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>IFrame Communication - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>IFrame Communication</h1>

        <ext:Window
            runat="server"
            Title="Parent"
            Width="480"
            Height="180">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <Items>
                <ext:Panel
                    ID="Panel1"
                    runat="server"
                    Title="A"
                    BodyPadding="18"
                    Flex="1">
                    <Loader
                        runat="server"
                        Url="A.aspx"
                        Mode="Frame">
                        <LoadMask ShowMask="true" />
                    </Loader>
                </ext:Panel>
                <ext:Panel
                    ID="Panel2"
                    runat="server"
                    Title="B"
                    BodyPadding="18"
                    Flex="1">
                    <Loader
                        runat="server"
                        Url="B.aspx"
                        Mode="Frame">
                        <LoadMask ShowMask="true" />
                    </Loader>
                </ext:Panel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
