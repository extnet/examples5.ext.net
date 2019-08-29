<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>DragDrop from TreePanel to Div - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var notifyDrop = function (dd, e, data) {
            var msg = [];

            msg.push("<p><b>Node</b></p><ul>");
            msg.push("<li>text : " + data.records[0].get('text') + "</li>");
            msg.push("<li>leaf : " + data.records[0].get('leaf') + "</li>");
            msg.push("<li>data : " + data.records[0].get('data') + "</li>");
            msg.push("</ul>");

            Ext.get("drop-target").update(msg.join(""))
            return true;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>DragDrop from TreePanel to Div</h1>

        <ext:Panel
            runat="server"
            Width="600"
            Height="400"
            Layout="Border">
            <Items>
                <ext:TreePanel
                    runat="server"
                    EnableDrag="true"
                    DDGroup="tree2div"
                    Region="West"
                    Split="true"
                    MarginSpec="5 0 5 5"
                    Width="200"
                    Title="Tree"
                    Scrollable="Both"
                    Collapsible="true">
                    <Store>
                        <ext:TreeStore runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="data" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:TreeStore>
                    </Store>
                    <Root>
                        <ext:Node Text="Root" Expanded="true">
                            <Children>
                                <ext:Node Text="Folder 1">
                                    <CustomAttributes>
                                        <ext:ConfigItem Name="data" Value="Folder 1 data" Mode="Value" />
                                    </CustomAttributes>
                                    <Children>
                                        <ext:Node Text="Child 1" Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="data" Value="Folder 1 Child 1 data" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>

                                <ext:Node Text="Folder 2">
                                    <CustomAttributes>
                                        <ext:ConfigItem Name="data" Value="Folder 2 data" Mode="Value" />
                                    </CustomAttributes>
                                    <Children>
                                        <ext:Node Text="Child 2" Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="data" Value="Folder 2 Child 2 data" Mode="Value" />
                                            </CustomAttributes>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>

                                <ext:Node Text="Leaf 1" Leaf="true">
                                    <CustomAttributes>
                                        <ext:ConfigItem Name="data" Value="Leaf 1 data" Mode="Value" />
                                    </CustomAttributes>
                                </ext:Node>
                            </Children>
                        </ext:Node>
                    </Root>

                    <View>
                        <ext:TreeView runat="server">
                            <Plugins>
                                <ext:TreeViewDragDrop runat="server" EnableDrop="false" DragGroup="tree2div" />
                            </Plugins>
                        </ext:TreeView>
                    </View>
                </ext:TreePanel>

                <ext:Panel
                    runat="server"
                    Title="Target"
                    Region="Center"
                    MarginSpec="5 5 5 0">
                    <Content>
                        <div id="drop-target" style="border:1px silver solid;margin:20px;padding:8px;height:140px">
                            Drop Node Here
                        </div>
                    </Content>
                </ext:Panel>
            </Items>
        </ext:Panel>

        <ext:DropTarget runat="server" Target="drop-target" Group="tree2div">
            <NotifyDrop Fn="notifyDrop" />
        </ext:DropTarget>
    </form>
</body>
</html>