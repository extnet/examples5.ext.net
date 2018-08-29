<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Multi Node Tree List built using markup - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script type="text/javascript">
        var syncSettings = function () {
            App.ExpanderOnlyToggle.setChecked(App.TreeList1.getExpanderOnly());
            App.SingleExpandToggle.setChecked(App.TreeList1.getSingleExpand());
            App.MicroToggleBtn.setPressed(App.TreeList1.getMicro());
        }

        var handleSEToggle = function (me) {
            if (me.checked) {
                // If setting Single Expand, collapse everyone to ensure only one
                // node ever gets expanded. Do not recurse into nodes, as manually
                // collapsing a node does not collapse its children.
                App.TreeList1.getStore().getRoot().collapseChildren(false);
            }

            App.TreeList1.setSingleExpand(me.checked);
        }

        var handleNavToggle = function (button, pressed) {
            var treelist = App.TreeList1,
                ct = treelist.ownerCt;

            treelist.setExpanderFirst(!pressed);
            treelist.setUi(pressed ? 'nav' : null);
            treelist.setHighlightPath(pressed);
            ct[pressed ? 'addCls' : 'removeCls']('treelist-with-nav');

            // If switching to Nav while already on Micro, adjust the width
            if (treelist.getMicro()) {
                ct.setWidth(treelist.toolsElement.getWidth())
            }

            if (Ext.isIE8) {
                this.repaintList(treelist);
            }
        }

        var handleMicroToggle = function (me) {
            var tl = App.TreeList1,
                ct = tl.ownerCt;
            App.TreeList1.setMicro(me.pressed);

            if (me.pressed) {
                tl.macroWidth = ct.getWidth();
                ct.setWidth(tl.toolsElement.getWidth());
            } else {
                if (tl.macroWidth === undefined) {
                    tl.macroWidth = 200;
                }
                ct.setWidth(tl.macroWidth);
            }
        }

        var handleTLSel = function (me, node) {
            var pane = App.SelectionPanel,
                cn = node,
                selPath = [];

            while (!cn.isRoot()) {
                selPath.push(cn.data.text);
                cn = cn.parentNode;
            }
            pane.setHtml("Selected: <br /><b>" + selPath.reverse().join(" > ") + "</b>");
        }
    </script>

    <%
        #region Set up font awesome if the current theme does not natively supports it.
        var manager = Ext.Net.ResourceManager.GetInstance(HttpContext.Current);
        var theme = manager.Theme;
        if (theme != Ext.Net.Theme.Triton && theme != Ext.Net.Theme.Graphite)
        {
    %>
    <link href="/resources/css/font-awesome.min.css" rel="stylesheet" />
    <style type="text/css">
        /* wraps over the x-fa CSS class to match the reference from the Triton/Graphite themes */
        .x-fa {
          display: inline-block;
          font: normal normal normal 14px/1 FontAwesome;
          font-size: inherit;
          text-rendering: auto;
          -webkit-font-smoothing: antialiased;
          -moz-osx-font-smoothing: grayscale;
        }
    </style>
    <%
        }
        #endregion Set up font awesome if the current theme does not natively supports it.
    %>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server">
            <Listeners>
                <DocumentReady Fn="syncSettings" />
            </Listeners>
        </ext:ResourceManager>

        <h1>Tree List Component Overview</h1>

        <p>
            The <b>TreeList</b> component is a simplified and lightweight version of the <b>TreePanel</b>, useful for simple and responsive navigation trees.
        </p>

        <ext:Window
            ID="Window1"
            runat="server"
            Title="TreeList"
            IconCls="x-fa fa-gears"
            Width="500"
            Height="450"
            Closable="False"
            Resizable="false"
            Layout="BorderLayout">
            <HeaderConfig runat="server">
                <Items>
                    <ext:Button runat="server" Text="Options">
                        <Menu>
                            <ext:Menu runat="server" ID="OptionsMenu">
                                <Items>
                                    <ext:CheckMenuItem
                                        ID="ExpanderOnlyToggle"
                                        runat="server"
                                        Text="Expander Only"
                                        Handler="App.TreeList1.setExpanderOnly(this.checked)" />
                                    <ext:CheckMenuItem ID="SingleExpandToggle" runat="server" Text="Single Expand">
                                        <Listeners>
                                            <CheckChange Fn="handleSEToggle" />
                                        </Listeners>
                                    </ext:CheckMenuItem>
                                </Items>
                            </ext:Menu>
                        </Menu>
                    </ext:Button>
                    <ext:Button
                        ID="NavToggleBtn"
                        runat="server"
                        Text="Nav"
                        EnableToggle="true">
                        <Listeners>
                            <Toggle Fn="handleNavToggle" />
                        </Listeners>
                    </ext:Button>
                    <ext:Button
                        ID="MicroToggleBtn"
                        runat="server"
                        Text="Micro"
                        EnableToggle="true">
                        <Listeners>
                            <Toggle Fn="handleMicroToggle" />
                        </Listeners>
                    </ext:Button>
                </Items>
            </HeaderConfig>
            <Items>
                <ext:Panel
                    ID="TreeListPanel"
                    runat="server"
                    Width="250"
                    Border="false"
                    Region="West"
                    Split="true"
                    Scrollable="Both">
                    <LayoutConfig>
                        <ext:VBoxLayoutConfig Align="Stretch" />
                    </LayoutConfig>
                    <Items>
                        <ext:TreeList runat="server" ID="TreeList1">
                            <Listeners>
                                <SelectionChange Fn="handleTLSel" />
                            </Listeners>
                            <Store>
                                <ext:TreeStore ID="TreeStore1" runat="server">
                                    <Root>
                                        <ext:Node Expanded="true">
                                            <Children>
                                                <ext:Node Text="Home" IconCls="x-fa fa-home">
                                                    <Children>
                                                        <ext:Node Text="Messages" IconCls="x-fa fa-inbox" Leaf="true" />
                                                        <ext:Node Text="Archive" IconCls="x-fa fa-database">
                                                            <Children>
                                                                <ext:Node Text="First" IconCls="x-fa fa-sliders" Leaf="true" />
                                                                <ext:Node Text="No Icon" IconCls="" Leaf="true" />
                                                            </Children>
                                                        </ext:Node>
                                                        <ext:Node Text="Music" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Video" IconCls="x-fa fa-film" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                                <ext:Node Text="Users" IconCls="x-fa fa-user">
                                                    <Children>
                                                        <ext:Node Text="Tagged" IconCls="x-fa fa-tag" Leaf="true" />
                                                        <ext:Node Text="Inactive" IconCls="x-fa fa-trash" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                                <ext:Node Text="Groups" IconCls="x-fa fa-group" Leaf="true" />
                                                <ext:Node Text="Settings" IconCls="x-fa fa-wrench">
                                                    <Children>
                                                        <ext:Node Text="Sharing" IconCls="x-fa fa-share-alt" Leaf="true" />
                                                        <ext:Node Text="Notifications" IconCls="x-fa fa-flag" Leaf="true" />
                                                        <ext:Node Text="Network" IconCls="x-fa fa-signal" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                            </Children>
                                        </ext:Node>
                                    </Root>
                                </ext:TreeStore>
                            </Store>
                        </ext:TreeList>
                    </Items>
                </ext:Panel>
                <ext:Panel
                    ID="SelectionPanel"
                    runat="server"
                    Region="Center"
                    BodyPadding="10" />
            </Items>
        </ext:Window>
    </form>
</body>
</html>