<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TabPanel with Close Tab Context Menus - Ext.NET Examples</title>
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

        <h1>TabPanel with TabCloseMenu plug in</h1>

        <p>Right-click the tab in the tab panels below to trigger the context menu enabled by TabCloseMenu.</p>

        <h2>Simple</h2>

        <p>The <b>TabCloseMenu</b> is a plugin for adding a close context menu to tabs.</p>

        <ext:TabPanel ID="TabPanel1" runat="server" Height="100">
            <Items>
                <ext:Panel runat="server" Title="Tab One" Closable="true" />
                <ext:Panel runat="server" Title="Tab Two" Closable="true" />
                <ext:Panel runat="server" Title="Tab Three" Closable="true" />
                <ext:Panel runat="server" Title="Tab Four" Closable="true" />
                <ext:Panel runat="server" Title="Tab Five" Closable="true" />
            </Items>
            <Plugins>
                <ext:TabCloseMenu runat="server" CloseAllTabsIcon="TabRed" CloseOtherTabsIcon="Delete" CloseTabIcon="TabDelete" />
            </Plugins>
        </ext:TabPanel>

        <h2>Some non-closable tabs</h2>

        <p> Note that the menu respects the closable configuration on the tab. As such, commands like remove others and remove all will not remove items that are not closable.</p>

        <ext:TabPanel ID="TabPanel2" runat="server" Height="100">
            <Items>
                <ext:Panel runat="server" Title="Tab One" Closable="true" />
                <ext:Panel runat="server" Title="Tab Two" Closable="true" />
                <ext:Panel runat="server" Title="Tab Three" Closable="false" />
                <ext:Panel runat="server" Title="Tab Four" Closable="true" />
                <ext:Panel runat="server" Title="Tab Five" Closable="false" />
            </Items>
            <Plugins>
                <ext:TabCloseMenu runat="server" />
            </Plugins>
        </ext:TabPanel>

        <h2>All non-closable tabs</h2>

        <p>When no closable tab is left, then the menu is displayed but all options grayed out.</p>

        <ext:TabPanel ID="TabPanel3" runat="server" Height="100">
            <Items>
                <ext:Panel runat="server" Title="Tab One" Closable="false" />
                <ext:Panel runat="server" Title="Tab Two" Closable="false" />
                <ext:Panel runat="server" Title="Tab Three" Closable="false" />
                <ext:Panel runat="server" Title="Tab Four" Closable="false" />
                <ext:Panel runat="server" Title="Tab Five" Closable="false" />
            </Items>
            <Plugins>
                <ext:TabCloseMenu runat="server" />
            </Plugins>
        </ext:TabPanel>
    </form>
</body>
</html>
