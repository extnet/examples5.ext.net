<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TabPanel with MenuTab - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var beforeMenu = function (pnl, tab, menu) {
            menu.items.get(0).setText(tab.title);

            var item = menu.getComponent(5),
                lastTab = pnl.items.get(pnl.items.getCount() - 1);

            if (tab.id == "customMenuTab") {
                item.show();

                if (lastTab.isTabMenuVisible()) {
                    item.setText("Hide Menu for last Tab");
                    item.handler = function () {
                        lastTab.hideTabMenu();
                    };
                } else {
                    item.setText("Show Menu for last Tab");
                    item.handler = function () {
                        lastTab.showTabMenu();
                    };
                }
            } else {
                item.hide();
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>TabPanel with TabMenu</h1>

        <h2>Simple TabMenu</h2>

        <ext:TabPanel ID="TabPanel1" runat="server" Height="100">
            <Items>
                <ext:Panel runat="server" Title="No Menu" />
                <ext:Panel runat="server" Title="Menu 1">
                    <TabMenu>
                        <ext:Menu runat="server">
                            <Items>
                                <ext:MenuItem runat="server" Text="Item 1" />
                                <ext:MenuItem runat="server" Text="Item 2" />
                                <ext:MenuSeparator runat="server" />
                                <ext:Label runat="server" Text="Rename Tab:" StyleSpec="padding-left:30px;" />
                                <ext:TextField
                                    ID="RenameField"
                                    runat="server"
                                    Text="New title"
                                    StyleSpec="margin-left:30px;">
                                    <Triggers>
                                        <ext:FieldTrigger IconCls="x-md md-icon-edit" QTip="Click to rename" />
                                    </Triggers>
                                    <Listeners>
                                        <TriggerClick Handler="var menu = this.up('menu'); menu.tab.setTitle(this.getValue());menu.hide();" />
                                    </Listeners>
                                </ext:TextField>
                            </Items>
                        </ext:Menu>
                    </TabMenu>
                </ext:Panel>

                <ext:Panel
                    ID="Tab3"
                    runat="server"
                    Title="Menu 2"
                    Closable="true"
                    BodyPadding="18">
                    <TabMenu>
                        <ext:ColorMenu runat="server">
                            <Listeners>
                                <Select Handler="#{TabPanel1}.setActiveTab(this.tab); this.tab.body.applyStyles(Ext.String.format('background-color:{0}', '#' + color));" />
                            </Listeners>
                        </ext:ColorMenu>
                    </TabMenu>
                </ext:Panel>
            </Items>
        </ext:TabPanel>

        <h2>Default TabMenu</h2>

        <ext:TabPanel ID="TabPanel2" runat="server" Height="100">
            <DefaultTabMenu>
                <ext:Menu runat="server">
                     <Items>
                         <ext:Label runat="server" StyleSpec="font-weight:bold;margin-left:30px;" />
                         <ext:MenuSeparator runat="server" />
                         <ext:MenuItem runat="server" Text="Item 1" />
                         <ext:MenuItem runat="server" Text="Item 2" />
                         <ext:MenuSeparator runat="server" />
                         <ext:MenuItem runat="server" Text="Hide Menu for last Tab" />
                     </Items>
                </ext:Menu>
            </DefaultTabMenu>
            <Listeners>
                <BeforeTabMenuShow Fn="beforeMenu" />
            </Listeners>
            <Items>
                <ext:Panel runat="server" TabMenuHidden="true" Title="No Menu" />
                <ext:Panel runat="server" Title="Default Menu" />
                <ext:Panel ID="customMenuTab" runat="server" Title="Default Menu +" />
                <ext:Panel runat="server" TabMenuHidden="true" Title="Default Menu" />
            </Items>
        </ext:TabPanel>
    </form>
</body>
</html>
