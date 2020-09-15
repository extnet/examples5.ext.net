<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Adding Tabs On The Fly - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <ext:XScript runat="server">
        <script>
            var addTab = function (tabPanel, id, url, menuItem) {
                var tab = tabPanel.getComponent(id);

                if (!tab) {
                    tab = tabPanel.add({
                        id       : id,
                        title    : url,
                        closable : true,
                        menuItem : menuItem,
                        loader   : {
                            url      : url,
                            renderer : "frame",
                            loadMask : {
                                showMask : true,
                                msg      : "Loading " + url + "..."
                            }
                        }
                    });

                    tab.on("activate", function (tab) {
                        #{MenuPanel1}.setSelection(tab.menuItem);
                    });
                }

                tabPanel.setActiveTab(tab);
            }
        </script>
    </ext:XScript>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:Window
            runat="server"
            Title="Adding tab"
            Width="720"
            Height="500"
            IconCls="x-md md-icon-link"
            Layout="Border">
            <Items>
                <ext:MenuPanel
                    ID="MenuPanel1"
                    runat="server"
                    Width="200"
                    Region="West">
                    <Menu runat="server">
                        <Items>
                            <ext:MenuItem runat="server" Text="Ext.NET">
                                <Listeners>
                                    <Click Handler="addTab(#{TabPanel1}, 'idClt', 'https://ext.net', this);" />
                                </Listeners>
                            </ext:MenuItem>

                            <ext:MenuSeparator />

                            <ext:MenuItem runat="server" Text="Ext.NET forums">
                                <Listeners>
                                    <Click Handler="addTab(#{TabPanel1}, 'idGgl', 'https://forums.ext.net', this);" />
                                </Listeners>
                            </ext:MenuItem>

                            <ext:MenuSeparator />

                            <ext:MenuItem runat="server" Text="Sencha">
                                <Listeners>
                                    <Click Handler="addTab(#{TabPanel1}, 'idExt', 'http://www.sencha.com', this);" />
                                </Listeners>
                            </ext:MenuItem>
                        </Items>
                    </Menu>
                </ext:MenuPanel>
                <ext:TabPanel ID="TabPanel1" runat="server" Region="Center" />
            </Items>
        </ext:Window>
    </form>
</body>
</html>
