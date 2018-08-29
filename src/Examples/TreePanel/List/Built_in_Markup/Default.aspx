<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Multi Node Tree List built using markup - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

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
        <ext:ResourceManager runat="server" />

        <h1>Multi Node Tree List built using markup</h1>

        <p>
            This is the equivalent to the <b>TreePanel Built from Markup</b> example, using the <b>TreeList</b> component.
        </p>

        <ext:Panel
            ID="Panel1"
            runat="server"
            Width="400"
            Height="450"
            IconCls="x-fa fa-list"
            Title="Catalog"
            AutoScroll="true">
            <LayoutConfig>
                <ext:VBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button ID="Button1" runat="server" Text="Expand All">
                            <Listeners>
                                <Click Handler="#{TreeList1}.getStore().getRoot().expandChildren(true);" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="Button2" runat="server" Text="Collapse All">
                            <Listeners>
                                <Click Handler="#{TreeList1}.getStore().getRoot().collapseChildren(true);" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="Button3" runat="server" Text="Toggle Micro" EnableToggle="true">
                            <Listeners>
                                <Toggle Handler="#{TreeList1}.setMicro(this.pressed);" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <BottomBar>
                <ext:StatusBar ID="StatusBar1" runat="server" AutoClear="1500" />
            </BottomBar>
            <Items>
                <ext:TreeList
                    ID="TreeList1"
                    runat="server">
                    <Store>
                        <ext:TreeStore ID="TreeStore1" runat="server">
                            <Root>
                                <ext:Node Text="Composers" Expanded="true">
                                    <Children>
                                        <ext:Node Text="Beethoven" IconCls="x-fa fa-umbrella">
                                            <Children>
                                                <ext:Node Text="Concertos" IconCls="x-fa fa-book">
                                                    <Children>
                                                        <ext:Node Text="No. 1 - C" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 2 - B-Flat Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 3 - C Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 4 - G Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 5 - E-Flat Major" IconCls="x-fa fa-music" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                                <ext:Node Text="Quartets" IconCls="x-fa fa-book">
                                                    <Children>
                                                        <ext:Node Text="Six String Quartets" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Three String Quartets" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Grosse Fugue for String Quartets" IconCls="x-fa fa-music" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                                <ext:Node Text="Sonatas" IconCls="x-fa fa-book">
                                                    <Children>
                                                        <ext:Node Text="Sonata in A Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="sonata in F Major" IconCls="x-fa fa-music" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                                <ext:Node Text="Symphonies" IconCls="x-fa fa-book">
                                                    <Children>
                                                        <ext:Node Text="No. 1 - C Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 2 - D Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 3 - E-Flat Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 4 - B-Flat Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 5 - C Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 6 - F Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 7 - A Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 8 - F Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 9 - D Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                            </Children>
                                        </ext:Node>
                                        <ext:Node Text="Brahms" IconCls="x-fa fa-truck">
                                            <Children>
                                                <ext:Node Text="Concertos" IconCls="x-fa fa-book">
                                                    <Children>
                                                        <ext:Node Text="Violin Concerto" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Double Concerto - A Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Piano Concerto No. 1 - D Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Piano Concerto No. 2 - B-Flat Major" IconCls="x-fa fa-music" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                                <ext:Node Text="Quartets" IconCls="x-fa fa-book">
                                                    <Children>
                                                        <ext:Node Text="Piano Quartet No. 1 - G Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Piano Quartet No. 2 - A Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Piano Quartet No. 3 - C Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Piano Quartet No. 3 - B-Flat Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                                <ext:Node Text="Sonatas" IconCls="x-fa fa-book">
                                                    <Children>
                                                        <ext:Node Text="Two Sonatas for Clarinet - F Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Two Sonatas for Clarinet - E-Flat Major" IconCls="x-fa fa-music" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                                <ext:Node Text="Symphonies" IconCls="x-fa fa-book">
                                                    <Children>
                                                        <ext:Node Text="No. 1 - C Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 2 - D Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 3 - F Major" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="No. 4 - E Minor" IconCls="x-fa fa-music" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                            </Children>
                                        </ext:Node>
                                        <ext:Node Text="Mozart" IconCls="x-fa fa-magic">
                                            <Children>
                                                <ext:Node Text="Concertos" IconCls="x-fa fa-book">
                                                    <Children>
                                                        <ext:Node Text="Piano Concerto No. 12" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Piano Concerto No. 17" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Clarinet Concerto" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Violin Concerto No. 5" IconCls="x-fa fa-music" Leaf="true" />
                                                        <ext:Node Text="Violin Concerto No. 4" IconCls="x-fa fa-music" Leaf="true" />
                                                    </Children>
                                                </ext:Node>
                                            </Children>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                            </Root>
                        </ext:TreeStore>
                    </Store>

                    <Listeners>
                        <SelectionChange
                            Handler="#{StatusBar1}.setStatus({text: 'Node Selected: <b>' + record.data.text + '<br />', clear: false});"
                            />
                    </Listeners>
                </ext:TreeList>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>