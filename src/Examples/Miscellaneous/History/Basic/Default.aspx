<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>
<%@ Import Namespace="System.Globalization" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        //Ext.History.Add("token here");
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>History - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        Ext.onReady(function () {
            if (window.parent.frames.length > 0) {
                window.open(window.location.pathname);
                window.location = "Warning.html";
            } else {
                App.onReady();
            }
        });

        var change = function (token) {
            if (token) {
                var parts = token.split(":"),
                    tabPanel = Ext.getCmp(parts[0]),
                    tabId = parts[1];

                if (tabPanel.id == "TabPanel2") {
                    App.TabPanel1.setActiveTab(0);
                }

                tabPanel.show();
                tabPanel.setActiveTab(tabId);
            } else {
                // This is the initial default state.  Necessary if you navigate starting from the
                // page without any existing history token params and go back to the start state.
                App.TabPanel1.setActiveTab(0);
                App.TabPanel2.setActiveTab(0);
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server">
            <App AutoInit="false" InitFnName="onReady" />
        </ext:ResourceManager>

        <p>Please review this example in the separate browser's window because the example can conflicts with History control of the Examples Explorer</p>

        <ext:History ID="History1" runat="server">
            <Listeners>
                <Change Fn="change" />
            </Listeners>
        </ext:History>

        <ext:TabPanel
            ID="TabPanel1"
            runat="server"
            Height="300"
            Width="600"
            ActiveTabIndex="0">
            <Items>
                <ext:Panel ID="Tab1" runat="server" Title="Tab1" Layout="Fit">
                    <Items>
                        <ext:TabPanel
                            ID="TabPanel2"
                            runat="server"
                            ActiveTabIndex="0"
                            TabPosition="Bottom">
                            <Items>
                                <ext:Panel ID="SubTab1" runat="server" Title="Sub-tab 1" />
                                <ext:Panel ID="SubTab2" runat="server" Title="Sub-tab 2" />
                                <ext:Panel ID="SubTab3" runat="server" Title="Sub-tab 3" />
                            </Items>
                            <Listeners>
                                <TabChange Handler="Ext.History.add(this.id + ':' + newTab.id);" />
                            </Listeners>
                        </ext:TabPanel>
                    </Items>
                </ext:Panel>

                <ext:Panel ID="Tab2" runat="server" Title="Tab 2" />
                <ext:Panel ID="Tab3" runat="server" Title="Tab 3" />
                <ext:Panel ID="Tab4" runat="server" Title="Tab 4" />
                <ext:Panel ID="Tab5" runat="server" Title="Tab 5" />
            </Items>
            <Listeners>
                <TabChange Handler="if (newTab.id != 'Tab1') {Ext.History.add(this.id + ':' + newTab.id);}" />
            </Listeners>
        </ext:TabPanel>
    </form>
</body>
</html>
