<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Show and Hide Tabs - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Show and Hide Tabs</h1>

        <ext:TabPanel ID="TabPanel1" runat="server" Width="960" Height="480">
            <Items>
                <ext:Panel ID="Tab1" Title="Tab1" runat="server" Closable="true" CloseAction="Hide" Html="Tab1">
                    <Listeners>
                        <Close Handler="#{ShowTab1}.setDisabled(false);#{CloseTab1}.setDisabled(true);" />
                    </Listeners>
                </ext:Panel>
                <ext:Panel ID="Tab2" Title="Tab2" runat="server" Closable="true" CloseAction="Hide" Html="Tab2">
                    <Listeners>
                        <Close Handler="#{ShowTab2}.setDisabled(false);" />
                    </Listeners>
                </ext:Panel>
                <ext:Panel ID="Tab3" Title="Tab3" runat="server" Closable="true" CloseAction="Hide" Html="Tab3">
                    <Listeners>
                        <Close Handler="#{ShowTab3}.setDisabled(false);" />
                    </Listeners>
                </ext:Panel>

                <ext:Panel ID="Tab4" Title="Tab4" runat="server" Closable="true" CloseAction="Hide" Html="Tab4">
                    <Listeners>
                        <Close Handler="#{ShowTab4}.setDisabled(false);" />
                    </Listeners>
                </ext:Panel>

                <ext:Panel ID="Tab5" Title="Tab5 - Close Event" runat="server" Closable="true" CloseAction="Destroy">
                    <Content>
                        Tab5 with CloseAction='Close' (after closing the tab can't be reshow)
                    </Content>
                    <Listeners>
                        <Close Handler="alert('Tab5 has been closed');" />
                    </Listeners>
                </ext:Panel>
            </Items>

            <Bin>
                <ext:Panel ID="Tab6" Title="Tab6" runat="server" Closable="true" CloseAction="Hide" Hidden="true" Html="PreHidden Tab6">
                    <Listeners>
                        <Close Handler="#{ShowTab6}.setDisabled(false);" />
                    </Listeners>
                </ext:Panel>
            </Bin>

            <BottomBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button ID="CloseTab1" runat="server" Text="Close Tab1">
                            <Listeners>
                                <Click Handler="#{TabPanel1}.closeTab(#{Tab1});this.setDisabled(true);#{ShowTab1}.setDisabled(false);" />
                            </Listeners>
                        </ext:Button>

                        <ext:ToolbarFill />
                        <ext:Button ID="ShowTab1" runat="server" Text="Show Tab1" Disabled="true">
                            <Listeners>
                                <Click Handler="#{TabPanel1}.addTab(#{Tab1});this.setDisabled(true);#{CloseTab1}.setDisabled(false);" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button ID="ShowTab2" runat="server" Text="Show Tab2" Disabled="true">
                            <Listeners>
                                <Click Handler="#{TabPanel1}.addTab(#{Tab2});this.setDisabled(true);" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button ID="ShowTab3" runat="server" Text="Show Tab3 at begin" Disabled="true">
                            <Listeners>
                                <Click Handler="#{TabPanel1}.addTab(#{Tab3}, 0);this.setDisabled(true);" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button ID="ShowTab4" runat="server" Text="Show Tab4 without activate" Disabled="true">
                            <Listeners>
                                <Click Handler="#{TabPanel1}.addTab(#{Tab4}, false);this.setDisabled(true);" />
                            </Listeners>
                        </ext:Button>

                        <ext:Button ID="ShowTab6" runat="server" Text="Show Tab6">
                            <Listeners>
                                <Click Handler="#{TabPanel1}.addTab(#{TabPanel1}.bin[0]);this.setDisabled(true);" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </BottomBar>
        </ext:TabPanel>
    </form>
</body>
</html>
