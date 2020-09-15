<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Multi Node TreePanel built using markup - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Multi Node TreePanel built using markup</h1>

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Width="480"
            Height="480"
            IconCls="x-md md-icon-arrow-menu-book"
            Title="Catalog"
            Scrollable="Both">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button ID="Button1" runat="server" Text="Expand All">
                            <Listeners>
                                <Click Handler="#{TreePanel1}.expandAll();" />
                            </Listeners>
                        </ext:Button>
                        <ext:Button ID="Button2" runat="server" Text="Collapse All">
                            <Listeners>
                                <Click Handler="#{TreePanel1}.collapseAll();" />
                            </Listeners>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Root>
                <ext:Node Text="Composers" Expanded="true">
                    <Children>
                        <ext:Node Text="Beethoven" IconCls="x-md md-icon-person">
                            <Children>
                                <ext:Node Text="Concertos">
                                    <Children>
                                        <ext:Node Text="No. 1 - C" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 2 - B-Flat Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 3 - C Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 4 - G Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 5 - E-Flat Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                    </Children>
                                </ext:Node>
                                <ext:Node Text="Quartets">
                                    <Children>
                                        <ext:Node Text="Six String Quartets" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Three String Quartets" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Grosse Fugue for String Quartets" IconCls="x-md md-icon-music-note" Leaf="true" />
                                    </Children>
                                </ext:Node>
                                <ext:Node Text="Sonatas">
                                    <Children>
                                        <ext:Node Text="Sonata in A Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="sonata in F Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                    </Children>
                                </ext:Node>
                                <ext:Node Text="Symphonies">
                                    <Children>
                                        <ext:Node Text="No. 1 - C Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 2 - D Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 3 - E-Flat Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 4 - B-Flat Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 5 - C Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 6 - F Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 7 - A Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 8 - F Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 9 - D Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                    </Children>
                                </ext:Node>
                            </Children>
                        </ext:Node>
                        <ext:Node Text="Brahms" IconCls="x-md md-icon-person">
                            <Children>
                                <ext:Node Text="Concertos">
                                    <Children>
                                        <ext:Node Text="Violin Concerto" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Double Concerto - A Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Piano Concerto No. 1 - D Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Piano Concerto No. 2 - B-Flat Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                    </Children>
                                </ext:Node>
                                <ext:Node Text="Quartets">
                                    <Children>
                                        <ext:Node Text="Piano Quartet No. 1 - G Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Piano Quartet No. 2 - A Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Piano Quartet No. 3 - C Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Piano Quartet No. 3 - B-Flat Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                    </Children>
                                </ext:Node>
                                <ext:Node Text="Sonatas">
                                    <Children>
                                        <ext:Node Text="Two Sonatas for Clarinet - F Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Two Sonatas for Clarinet - E-Flat Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                    </Children>
                                </ext:Node>
                                <ext:Node Text="Symphonies">
                                    <Children>
                                        <ext:Node Text="No. 1 - C Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 2 - D Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 3 - F Major" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="No. 4 - E Minor" IconCls="x-md md-icon-music-note" Leaf="true" />
                                    </Children>
                                </ext:Node>
                            </Children>
                        </ext:Node>
                        <ext:Node Text="Mozart" IconCls="x-md md-icon-person">
                            <Children>
                                <ext:Node Text="Concertos">
                                    <Children>
                                        <ext:Node Text="Piano Concerto No. 12" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Piano Concerto No. 17" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Clarinet Concerto" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Violin Concerto No. 5" IconCls="x-md md-icon-music-note" Leaf="true" />
                                        <ext:Node Text="Violin Concerto No. 4" IconCls="x-md md-icon-music-note" Leaf="true" />
                                    </Children>
                                </ext:Node>
                            </Children>
                        </ext:Node>
                    </Children>
                </ext:Node>
            </Root>
            <BottomBar>
                <ext:StatusBar ID="StatusBar1" runat="server" AutoClear="1500" />
            </BottomBar>
            <Listeners>
                <ItemClick
                    Handler="#{StatusBar1}.setStatus({text: 'Node Selected: <b>' + record.data.text + '<br />', clear: false});"
                    />
                <ItemExpand
                    Handler="#{StatusBar1}.setStatus({text: 'Node Expanded: <b>' + item.data.text + '<br />', clear: false});"
                    Buffer="30"
                    />
                <ItemCollapse
                    Handler="#{StatusBar1}.setStatus({text: 'Node Collapsed: <b>' + item.data.text + '<br />', clear: false});"
                    Buffer="30"
                    />
            </Listeners>
        </ext:TreePanel>
    </form>
</body>
</html>