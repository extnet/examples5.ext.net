<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Basic Toolbar - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
        </LayoutConfig>
        <Items>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:SplitButton runat="server" Text="Menu Button" IconCls="x-md md-icon-apps">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem Text="Menu Button 1" />
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:SplitButton>
                    <ext:ToolbarSeparator runat="server" />
                    <ext:SplitButton runat="server" Text="Cut" IconCls="x-md md-icon-content-cut">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem Text="Cut Menu Item" />
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:SplitButton>
                    <ext:Button runat="server" Text="Copy" IconCls="x-md md-icon-content-copy" />
                    <ext:Button runat="server" Text="Paste" IconCls="x-md md-icon-content-paste">
                        <Menu>
                            <ext:Menu runat="server">
                                <Items>
                                    <ext:MenuItem Text="Paste Menu Item" />
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:Button>
                    <ext:ToolbarSeparator runat="server" />
                    <ext:Button runat="server" Text="Format" IconCls="x-md md-icon-edit" />
                </Items>
            </ext:Toolbar>
        </Items>
    </ext:Viewport>
</body>
</html>