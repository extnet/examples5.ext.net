<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Tree Custom Drop Logic - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var nodeDragOver = function (targetNode, position, dragData) {
            var rec = dragData.records[0],
                isFirst = targetNode.isFirst(),
                canDropFirst = rec.get('canDropOnFirst'),
                canDropSecond = rec.get('canDropOnSecond');

            return isFirst ? canDropFirst : canDropSecond;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Custom Tree Drop Logic</h1>
        <p>This example shows how to apply custom logic to valid dropping on nodes</p>
        <p>
            <ul>
                <li>Child 1 can be dropped on both nodes.</li>
                <li>Child 2 can be dropped only on the first node.</li>
                <li>Child 3 can be dropped only on the second node.</li>
                <li>Child 4 cannot be dropped on either node.</li>
            </ul>
        </p>

        <ext:Panel runat="server" Width="480" Height="180">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <Bin>
                <ext:Model runat="server" Name="Item">
                    <Fields>
                        <ext:ModelField Name="text" />
                        <ext:ModelField Name="canDropOnFirst" />
                        <ext:ModelField Name="canDropOnSecond" />
                    </Fields>
                </ext:Model>
            </Bin>
            <Items>
                <ext:TreePanel
                    runat="server"
                    RootVisible="false"
                    Flex="1"
                    Title="Source">
                    <Store>
                        <ext:TreeStore runat="server" ModelName="Item">
                            <Root>
                                <ext:Node Text="Root 1" Expanded="true">
                                    <Children>
                                        <ext:Node Text="Child 1" Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="canDropOnFirst" Value="true" />
                                                <ext:ConfigItem Name="canDropOnSecond" Value="true" />
                                            </CustomAttributes>
                                        </ext:Node>

                                        <ext:Node Text="Child 2" Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="canDropOnFirst" Value="true" />
                                                <ext:ConfigItem Name="canDropOnSecond" Value="false" />
                                            </CustomAttributes>
                                        </ext:Node>

                                        <ext:Node Text="Child 3" Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="canDropOnFirst" Value="false" />
                                                <ext:ConfigItem Name="canDropOnSecond" Value="true" />
                                            </CustomAttributes>
                                        </ext:Node>

                                        <ext:Node Text="Child 4" Leaf="true">
                                            <CustomAttributes>
                                                <ext:ConfigItem Name="canDropOnFirst" Value="false" />
                                                <ext:ConfigItem Name="canDropOnSecond" Value="false" />
                                            </CustomAttributes>
                                        </ext:Node>
                                    </Children>
                                </ext:Node>
                            </Root>
                        </ext:TreeStore>
                    </Store>

                    <View>
                        <ext:TreeView runat="server">
                            <Plugins>
                                <ext:TreeViewDragDrop runat="server" EnableDrag="true" EnableDrop="false" />
                            </Plugins>
                        </ext:TreeView>
                    </View>
                </ext:TreePanel>

                <ext:TreePanel
                    runat="server"
                    RootVisible="false"
                    Flex="1"
                    Title="Destination">
                    <Store>
                        <ext:TreeStore runat="server" ModelName="Item">
                            <Root>
                                <ext:Node Text="Root 2" Expanded="true">
                                    <Children>
                                        <ext:Node Text="Folder 1" Expanded="true" EmptyChildren="true" />
                                        <ext:Node Text="Folder 2" Expanded="true" EmptyChildren="true" />
                                    </Children>
                                </ext:Node>
                            </Root>
                        </ext:TreeStore>
                    </Store>
                    <View>
                        <ext:TreeView runat="server">
                            <Plugins>
                                <ext:TreeViewDragDrop runat="server" EnableDrag="false" EnableDrop="true" AppendOnly="true" />
                            </Plugins>
                        </ext:TreeView>
                    </View>
                    <Listeners>
                        <NodeDragOver Fn="nodeDragOver" />
                    </Listeners>
                </ext:TreePanel>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>