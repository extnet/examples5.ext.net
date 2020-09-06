<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Reorderable Tabs - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var tabCount = 4;
        var addTab = function () {
            tabCount++;

            this.up('tabpanel').add({
                xtype: 'panel',
                title: 'Tab ' + tabCount,
                html : 'Content for tab ' + tabCount,
                closable: true
            });
        }

        var toggleTabs = function () {
            this.up('tabpanel').tabBar.items.each(function (tab) {
                if (tab.disabled) {
                    tab.enable();
                } else {
                    tab.disable();
                }
            });
        }

        var removeTab2 = function () {
            var tabPanel = this.up('tabpanel'),
                item = tabPanel.items.items[1];

            if (item) {
                tabPanel.remove(item);
            }
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Reorderable Tabs</h1>

        <ext:TabPanel
            runat="server"
            Width="960"
            Height="480"
            BodyPadding="18">
            <Items>
                <ext:Panel runat="server" Title="Tab 1" Html="Test 1" Closable="true" />
                <ext:Panel runat="server" Title="Tab 2" Html="Test 2" Closable="true" />
                <ext:Panel runat="server" Title="Tab 3" Html="Test 3" Closable="true" />
                <ext:Panel runat="server" Title="Non Reorderable" Html="I can't be moved" Closable="true" Reorderable="false" />
                <ext:Panel runat="server" Title="Tab 4" Html="Test 4" Closable="true" />
            </Items>
            <Plugins>
                <ext:BoxReorderer runat="server" />
            </Plugins>
            <DockedItems>
                <ext:Toolbar runat="server" Dock="Bottom">
                    <Items>
                        <ext:Button runat="server" Text="Add an item" Handler="addTab" />
                        <ext:Button runat="server" Text="Toggle tabs enabled" Handler="toggleTabs" />
                        <ext:Button runat="server" Text="Remove 2nd item" Handler="removeTab2" />
                    </Items>
                </ext:Toolbar>
            </DockedItems>
        </ext:TabPanel>
    </form>
</body>
</html>