<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Menu Layout - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .white-menu .x-menu-body {
            background : white !important;
        }
    </style>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Menu layout</h1>

        <ext:Toolbar runat="server">
            <Items>
                <ext:Button runat="server" Text="Home" />

                <ext:Button runat="server" Text="Products">
                    <Menu>
                        <ext:Menu runat="server" ShowSeparator="false">
                            <Items>
                                <ext:Container runat="server" Width="960" Layout="HBox">
                                    <Defaults>
                                        <ext:Parameter Name="Height" Value="230" Mode="Raw" />
                                        <ext:Parameter Name="Flex" Value="1" Mode="Raw" />
                                        <ext:Parameter Name="Cls" Value="white-menu" Mode="Value" />
                                        <ext:Parameter Name="Margin" Value="1" Mode="Raw" />
                                    </Defaults>
                                    <Items>
                                        <ext:MenuPanel runat="server" Title="Desktop">
                                            <Menu runat="server" ShowSeparator="false">
                                                <Items>
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                </Items>
                                            </Menu>
                                        </ext:MenuPanel>

                                        <ext:MenuPanel runat="server" Title="Laptop">
                                            <Menu runat="server" ShowSeparator="false">
                                                <Items>
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                </Items>
                                            </Menu>
                                        </ext:MenuPanel>

                                        <ext:MenuPanel runat="server" Title="Accessories">
                                            <Menu runat="server" ShowSeparator="false">
                                                <Items>
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                </Items>
                                            </Menu>
                                        </ext:MenuPanel>

                                        <ext:MenuPanel runat="server" Title="Accessories">
                                            <Menu runat="server" ShowSeparator="false">
                                                <Items>
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                    <ext:MenuItem runat="server" Text="Navigation Link" />
                                                </Items>
                                            </Menu>
                                        </ext:MenuPanel>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:Menu>
                    </Menu>
                </ext:Button>

                <ext:Button runat="server" Text="Sales Items">
                    <Menu>
                        <ext:Menu runat="server" ShowSeparator="false">
                            <Items>
                                <ext:Container runat="server" Width="400" Height="470" Layout="VBox">
                                    <LayoutConfig>
                                        <ext:VBoxLayoutConfig Align="Stretch" />
                                    </LayoutConfig>
                                    <Items>
                                        <ext:Container runat="server" Flex="1" Layout="Hbox" MarginSpec="0 0 5 0">
                                            <Defaults>
                                                <ext:Parameter Name="Height" Value="230" Mode="Raw" />
                                                <ext:Parameter Name="Flex" Value="1" Mode="Raw" />
                                                <ext:Parameter Name="Cls" Value="white-menu" Mode="Value" />
                                                <ext:Parameter Name="Margin" Value="1" Mode="Raw" />
                                            </Defaults>
                                            <Items>
                                                <ext:MenuPanel runat="server" Title="Deal of the week">
                                                    <Menu runat="server" ShowSeparator="false">
                                                        <Items>
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                        </Items>
                                                    </Menu>
                                                </ext:MenuPanel>

                                                <ext:MenuPanel runat="server" Title="Clearance items">
                                                    <Menu runat="server" ShowSeparator="false">
                                                        <Items>
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                        </Items>
                                                    </Menu>
                                                </ext:MenuPanel>
                                            </Items>
                                        </ext:Container>

                                        <ext:Container runat="server" Flex="1" Layout="Hbox">
                                            <Defaults>
                                                <ext:Parameter Name="Height" Value="230" Mode="Raw" />
                                                <ext:Parameter Name="Flex" Value="1" Mode="Raw" />
                                                <ext:Parameter Name="Cls" Value="white-menu" Mode="Value" />
                                                <ext:Parameter Name="Margin" Value="1" Mode="Raw" />
                                            </Defaults>
                                            <Items>
                                                <ext:MenuPanel runat="server" Title="Deal of the week">
                                                    <Menu runat="server" ShowSeparator="false">
                                                        <Items>
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                        </Items>
                                                    </Menu>
                                                </ext:MenuPanel>

                                                <ext:MenuPanel runat="server" Title="Clearance items">
                                                    <Menu runat="server" ShowSeparator="false">
                                                        <Items>
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                        </Items>
                                                    </Menu>
                                                </ext:MenuPanel>

                                                <ext:MenuPanel runat="server" Title="Open Box Items">
                                                    <Menu runat="server" ShowSeparator="false">
                                                        <Items>
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                            <ext:MenuItem runat="server" Text="Navigation Link" />
                                                        </Items>
                                                    </Menu>
                                                </ext:MenuPanel>
                                            </Items>
                                        </ext:Container>
                                    </Items>
                                </ext:Container>
                            </Items>
                        </ext:Menu>
                    </Menu>
                </ext:Button>
            </Items>
        </ext:Toolbar>
    </form>
</body>
</html>
