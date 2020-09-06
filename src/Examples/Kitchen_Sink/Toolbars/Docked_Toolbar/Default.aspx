<%@ Page Language="C#" %>

<script runat="server">
    public static string TEST_HTML = "Lorem ipsum dolor sit amet, consectetur adipiscing elit.";
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Docked Toolbar - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:Viewport runat="server">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
        </LayoutConfig>
        <Items>
            <ext:Container
                runat="server"
                MarginSpec="0 0 10 0"
                StyleSpec="background: transparent;">
                <LayoutConfig>
                    <ext:HBoxLayoutConfig Align="Middle" Pack="Center" />
                </LayoutConfig>
                <Items>
                    <ext:Panel
                        runat="server"
                        Title="Top"
                        Width="200"
                        Height="180"
                        BodyPadding="18"
                        Margin="10"
                        Html="<%# TEST_HTML %>"
                        AutoDataBind="true">
                        <DockedItems>
                            <ext:Toolbar runat="server" Dock="Top">
                                <Items>
                                    <ext:Button runat="server" Icon="ApplicationViewList" />
                                    <ext:ToolbarSeparator runat="server" />
                                    <ext:Button runat="server" Icon="Cross" />
                                    <ext:Button runat="server" Icon="PastePlain" />
                                    <ext:ToolbarSeparator runat="server" />
                                    <ext:Button runat="server" Icon="ApplicationEdit" />
                                </Items>
                            </ext:Toolbar>
                        </DockedItems>
                    </ext:Panel>

                    <ext:Panel
                        runat="server"
                        Title="Right"
                        Width="200"
                        Height="180"
                        BodyPadding="18"
                        Margin="10"
                        Html="<%# TEST_HTML %>"
                        AutoDataBind="true">
                        <DockedItems>
                            <ext:Toolbar runat="server" Dock="Right">
                                <Items>
                                    <ext:Button runat="server" Icon="ApplicationViewList" />
                                    <ext:ToolbarSeparator runat="server" />
                                    <ext:Button runat="server" Icon="Cross" />
                                    <ext:Button runat="server" Icon="PastePlain" />
                                    <ext:ToolbarSeparator runat="server" />
                                    <ext:Button runat="server" Icon="ApplicationEdit" />
                                </Items>
                            </ext:Toolbar>
                        </DockedItems>
                    </ext:Panel>
                </Items>
            </ext:Container>

            <ext:Container
                runat="server"
                MarginSpec="0 0 10 0"
                StyleSpec="background: transparent;">
                <LayoutConfig>
                    <ext:HBoxLayoutConfig Align="Middle" Pack="Center" />
                </LayoutConfig>
                <Items>
                    <ext:Panel
                        runat="server"
                        Title="Left"
                        Width="200"
                        Height="180"
                        BodyPadding="18"
                        Margin="10"
                        Html="<%# TEST_HTML %>"
                        AutoDataBind="true">
                        <DockedItems>
                            <ext:Toolbar runat="server" Dock="Left">
                                <Items>
                                    <ext:Button runat="server" Icon="ApplicationViewList" />
                                    <ext:ToolbarSeparator runat="server" />
                                    <ext:Button runat="server" Icon="Cross" />
                                    <ext:Button runat="server" Icon="PastePlain" />
                                    <ext:ToolbarSeparator runat="server" />
                                    <ext:Button runat="server" Icon="ApplicationEdit" />
                                </Items>
                            </ext:Toolbar>
                        </DockedItems>
                    </ext:Panel>

                    <ext:Panel
                        runat="server"
                        Title="Bottom"
                        Width="200"
                        Height="180"
                        BodyPadding="18"
                        Margin="10"
                        Html="<%# TEST_HTML %>"
                        AutoDataBind="true">
                        <DockedItems>
                            <ext:Toolbar runat="server" Dock="Bottom">
                                <Items>
                                    <ext:Button runat="server" Icon="ApplicationViewList" />
                                    <ext:ToolbarSeparator runat="server" />
                                    <ext:Button runat="server" Icon="Cross" />
                                    <ext:Button runat="server" Icon="PastePlain" />
                                    <ext:ToolbarSeparator runat="server" />
                                    <ext:Button runat="server" Icon="ApplicationEdit" />
                                </Items>
                            </ext:Toolbar>
                        </DockedItems>
                    </ext:Panel>
                </Items>
            </ext:Container>
        </Items>
    </ext:Viewport>
</body>
</html>