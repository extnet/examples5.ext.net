<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>MenuPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var menuItemClick = function (menu, item) {
            if (item) {
                App.PnlCenter.body.update(Ext.String.format("Clicked: {0}", item.text)).highlight();
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>MenuPanel Example</h1>

        <ext:Window
            runat="server"
            Title="MenuPanel"
            Closable="false"
            Width="600"
            Height="370"
            Layout="BorderLayout">
            <Items>
                <ext:Panel
                    runat="server"
                    Width="350"
                    Layout="Accordion"
                    Split="true"
                    Region="West"
                    MarginSpec="5 0 5 5"
                    Border="false">
                    <Items>
                        <ext:MenuPanel
                            runat="server"
                            Title="MenuPanel with Selection Saving"
                            Icon="ArrowSwitch">
                            <Menu runat="server">
                                <Items>
                                    <ext:MenuItem runat="server" Text="Item 1" Icon="ArrowRight" />
                                    <ext:MenuItem runat="server" Text="Item 2" Icon="ArrowRight" />
                                    <ext:MenuItem runat="server" Text="Item 3" Icon="ArrowRight" />
                                </Items>
                                <Listeners>
                                    <Click Fn="menuItemClick" />
                                </Listeners>
                            </Menu>
                        </ext:MenuPanel>
                        <ext:MenuPanel
                            runat="server"
                            Title="MenuPanel without Selection Saving"
                            SaveSelection="false"
                            Icon="ArrowSwitch">
                            <Menu runat="server">
                                <Items>
                                    <ext:MenuItem runat="server" Text="Item 1" Icon="ArrowRight" />
                                    <ext:MenuItem runat="server" Text="Item 2" Icon="ArrowRight" />
                                    <ext:MenuItem runat="server" Text="Item 3" Icon="ArrowRight" />
                                </Items>
                                <Listeners>
                                    <Click Fn="menuItemClick" />
                                </Listeners>
                            </Menu>
                        </ext:MenuPanel>
                        <ext:MenuPanel
                            runat="server"
                            Title="Menu with Predefined Selection"
                            SelectedIndex="1"
                            Icon="ArrowSwitch">
                            <Menu runat="server">
                                <Items>
                                    <ext:MenuItem runat="server" Text="Item 1" Icon="ArrowRight" />
                                    <ext:MenuItem runat="server" Text="Item 2" Icon="ArrowRight" />
                                    <ext:MenuItem runat="server" Text="Item 3" Icon="ArrowRight" />
                                </Items>
                                <Listeners>
                                    <Click Fn="menuItemClick" />
                                </Listeners>
                            </Menu>
                        </ext:MenuPanel>
                    </Items>
                </ext:Panel>
                <ext:Panel
                    ID="PnlCenter"
                    runat="server"
                    Title="Selected Item"
                    BodyPadding="5"
                    Region="Center"
                    MarginSpec="5 5 5 0" />
            </Items>
        </ext:Window>
    </form>
</body>
</html>
