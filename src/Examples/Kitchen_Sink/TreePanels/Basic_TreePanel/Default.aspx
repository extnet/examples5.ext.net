<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Basic TreePanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <ext:ResourceManager runat="server" />

    <ext:TreeStore ID="TreeStore1" runat="server">
        <Root>
            <ext:Node Expanded="true">
                <Children>
                    <ext:Node Text="app">
                        <Children>
                            <ext:Node Text="Application.js" Leaf="true" />
                        </Children>
                    </ext:Node>
                    <ext:Node Text="button" Expanded="true">
                        <Children>
                            <ext:Node Text="Button.js" Leaf="true" />
                            <ext:Node Text="Cycle.js" Leaf="true" />
                            <ext:Node Text="Split.js" Leaf="true" />
                        </Children>
                    </ext:Node>
                    <ext:Node Text="container">
                        <Children>
                            <ext:Node Text="ButtonGroup.js" Leaf="true" />
                            <ext:Node Text="Container.js" Leaf="true" />
                            <ext:Node Text="Viewport.js" Leaf="true" />
                        </Children>
                    </ext:Node>
                    <ext:Node Text="core">
                        <Children>
                            <ext:Node Text="dom">
                                <Children>
                                    <ext:Node Text="Element.form.js" Leaf="true" />
                                    <ext:Node Text="Element.static-more.js" Leaf="true" />
                                </Children>
                            </ext:Node>
                        </Children>
                    </ext:Node>
                    <ext:Node Text="dd">
                        <Children>
                            <ext:Node Text="DD.js" Leaf="true" />
                            <ext:Node Text="DDProxy.js" Leaf="true" />
                            <ext:Node Text="DDTarget.js" Leaf="true" />
                            <ext:Node Text="DragDrop.js" Leaf="true" />
                            <ext:Node Text="DragDropManager.js" Leaf="true" />
                            <ext:Node Text="DragSource.js" Leaf="true" />
                            <ext:Node Text="DragTracker.js" Leaf="true" />
                            <ext:Node Text="DragZone.js" Leaf="true" />
                            <ext:Node Text="DragTarget.js" Leaf="true" />
                            <ext:Node Text="DragZone.js" Leaf="true" />
                            <ext:Node Text="Registry.js" Leaf="true" />
                            <ext:Node Text="ScrollManager.js" Leaf="true" />
                            <ext:Node Text="StatusProxy.js" Leaf="true" />
                        </Children>
                    </ext:Node>
                    <ext:Node Text="core">
                        <Children>
                            <ext:Node Text="Element.alignment.js" Leaf="true" />
                            <ext:Node Text="Element.anim.js" Leaf="true" />
                            <ext:Node Text="Element.dd.js" Leaf="true" />
                            <ext:Node Text="Element.fx.js" Leaf="true" />
                            <ext:Node Text="Element.js" Leaf="true" />
                            <ext:Node Text="Element.position.js" Leaf="true" />
                            <ext:Node Text="Element.scroll.js" Leaf="true" />
                            <ext:Node Text="Element.style.js" Leaf="true" />
                            <ext:Node Text="Element.traversal.js" Leaf="true" />
                            <ext:Node Text="Helper.js" Leaf="true" />
                            <ext:Node Text="Query.js" Leaf="true" />
                        </Children>
                    </ext:Node>
                    <ext:Node Text="Action.js" Leaf="true" />
                    <ext:Node Text="Component.js" Leaf="true" />
                    <ext:Node Text="Editor.js" Leaf="true" />
                    <ext:Node Text="Img.js" Leaf="true" />
                    <ext:Node Text="Layer.js" Leaf="true" />
                    <ext:Node Text="LoadMask.js" Leaf="true" />
                    <ext:Node Text="ProgressBar.js" Leaf="true" />
                    <ext:Node Text="Shadow.js" Leaf="true" />
                    <ext:Node Text="ShadowPool.js" Leaf="true" />
                    <ext:Node Text="ZIndexManager.js" Leaf="true" />
                </Children>
            </ext:Node>
        </Root>
    </ext:TreeStore>

    <ext:Viewport runat="server" MarginSpec="0 0 10 0">
        <LayoutConfig>
            <ext:VBoxLayoutConfig Align="Center" Pack="Center" />
        </LayoutConfig>
        <Items>
            <ext:Container runat="server">
                <LayoutConfig>
                    <ext:TableLayoutConfig Columns="2" />
                </LayoutConfig>
                <Items>
                    <ext:TreePanel
                        runat="server"
                        Title="TreePanel"
                        Width="480"
                        Height="180"
                        Margin="10"
                        RootVisible="false"
                        Lines="false"
                        UseArrows="false"
                        StoreID="TreeStore1"
                        />

                    <ext:TreePanel
                        runat="server"
                        Title="TreePanel with lines"
                        Width="480"
                        Height="180"
                        Margin="10"
                        RootVisible="false"
                        Lines="true"
                        UseArrows="false"
                        StoreID="TreeStore1"
                        />

                    <ext:TreePanel
                        runat="server"
                        Title="TreePanel with arrows"
                        Width="480"
                        Height="180"
                        Margin="10"
                        RootVisible="false"
                        Lines="false"
                        UseArrows="true"
                        StoreID="TreeStore1"
                        />
                </Items>
            </ext:Container>
        </Items>
    </ext:Viewport>
</body>
</html>