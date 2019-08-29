<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Toolbar Overflow - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .add32 {
            background-image : url(images/add32.gif) !important;
        }
        .add16 {
            background-image : url(images/add16.gif) !important;
        }
        .add24 {
            background-image : url(images/add24.gif) !important;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            runat="server"
            Title="Standard"
            Closable="false"
            Height="250"
            Width="500"
            BodyPadding="10"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server" EnableOverflow="true">
                    <Items>
                        <ext:SplitButton runat="server" Text="Menu Button" IconCls="add16">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Menu Item 1" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:SplitButton>

                        <ext:ToolbarSeparator />

                        <ext:SplitButton runat="server" Text="Cut" IconCls="add16">
                             <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Cut menu" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:SplitButton>

                        <ext:Button runat="server" Text="Copy" IconCls="add16" />

                        <ext:Button runat="server" Text="Paste" IconCls="add16">
                            <Menu>
                                <ext:Menu runat="server">
                                    <Items>
                                        <ext:MenuItem runat="server" Text="Paste menu" />
                                    </Items>
                                </ext:Menu>
                            </Menu>
                        </ext:Button>

                        <ext:ToolbarSeparator />

                        <ext:Button runat="server" Text="Format" IconCls="add16" />

                        <ext:ToolbarFill />

                        <ext:Button runat="server" Text="Right" IconCls="add16" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Content>
                <p>Resize this Window narrower to see the Toolbar overflow menu in action --></p>
            </Content>
        </ext:Window>
    </form>
</body>
</html>
