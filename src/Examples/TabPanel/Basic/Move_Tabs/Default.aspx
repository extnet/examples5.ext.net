<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Moving Tab between TabPanels - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var moveTab = function (source, destination) {
            var tab = source.getActiveTab();
            source.remove(tab, false);
            destination.add(tab);

            if (destination.items.length == 1) {
                destination.setActiveTab(0);
                //workraround for strange ExtJS bug
                tab.el.dom.style.display = "";
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Moving Tab between TabPanels</h1>

        <ext:Window
            ID="Window1"
            runat="server"
            Layout="BorderLayout"
            Width="600"
            Height="250"
            Icon="Tab"
            Title="Moving tabs"
            X="100"
            Y="100">
            <Items>
                <ext:TabPanel
                    ID="TabPanel1"
                    runat="server"
                    Region="West"
                    Width="200"
                    MarginSpec="5 0 5 5">
                    <Items>
                        <ext:Panel ID="Tab1" runat="server" Title="Tab1" Html="Tab1" BodyPadding="5" />
                        <ext:Panel ID="Tab2" runat="server" Title="Tab2" Html="Tab2" BodyPadding="5" />
                        <ext:Panel ID="Tab3" runat="server" Title="Tab3" Html="Tab3" BodyPadding="5" />
                    </Items>
                </ext:TabPanel>
                <ext:Panel runat="server" Region="Center" MarginSpec="5 5 5 5">
                    <TopBar>
                        <ext:Toolbar runat="server">
                            <Items>
                                <ext:Button runat="server" Icon="ArrowRight">
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Move Tab" Html="West To East" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="moveTab(#{TabPanel1}, #{TabPanel2});" />
                                    </Listeners>
                                </ext:Button>

                                <ext:ToolbarFill />

                                <ext:Button runat="server" Icon="ArrowLeft">
                                    <ToolTips>
                                        <ext:ToolTip runat="server" Title="Move Tab" Html="East to West" />
                                    </ToolTips>
                                    <Listeners>
                                        <Click Handler="moveTab(#{TabPanel2}, #{TabPanel1});" />
                                    </Listeners>
                                </ext:Button>
                            </Items>
                        </ext:Toolbar>
                    </TopBar>
                </ext:Panel>
                <ext:TabPanel
                    ID="TabPanel2"
                    Region="East"
                    runat="server"
                    Width="200"
                    MarginSpec="5 5 5 0">
                    <Items>
                        <ext:Panel ID="Tab4" runat="server" Title="Tab4" Html="Tab4" BodyPadding="5" />
                        <ext:Panel ID="Tab5" runat="server" Title="Tab5" Html="Tab5" BodyPadding="5" />
                        <ext:Panel ID="Tab6" runat="server" Title="Tab6" Html="Tab6" BodyPadding="5" />
                    </Items>
                </ext:TabPanel>
            </Items>
        </ext:Window>
    </form>
</body>
</html>
