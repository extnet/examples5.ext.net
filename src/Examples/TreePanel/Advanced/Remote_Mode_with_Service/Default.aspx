<%@ Page Language="C#" %>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Remote mode - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .bold-text{
            font-weight:bold;
            padding-left: 32px;
            margin-bottom:2px;
            font-size:110%;
        }
    </style>

    <script>
        var showMenu = function (view, node, item, index, e) {
            var menu = App.TreeContextMenu;

            this.menuNode = node;
            menu.nodeName = node.get("text");
            view.getSelectionModel().select(node);

            menu.showAt([e.getXY()[0], e.getXY()[1]+10]);
            e.stopEvent();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Remote mode with Service</h1>

        <p>This example demomstrates remote mode of the TreePanel : remote confirmation of basic operations (rename, remove, append/insert, drag/drop)</p>

        <p>The remote mode is activating if set Mode="Remote"</p>

        <p>You can define particular action as local even if Mode="Remote" (LocalActions property)</p>

        <p>List of available values for LocalActions: rename, remove, append, insert, move</p>

         <ext:Menu ID="TreeContextMenu" runat="server">
            <Items>
                <ext:Label ID="NodeName" runat="server" Cls="bold-text" />
                <ext:MenuSeparator />
                <ext:MenuItem runat="server" Text="Edit" Icon="Pencil">
                    <Listeners>
                        <Click Handler="#{TreePanel1}.editingPlugin.startEdit(#{TreePanel1}.menuNode, 0);" />
                    </Listeners>
                </ext:MenuItem>

                <ext:MenuItem runat="server" Text="Rename to 'TEST'" Icon="Pencil">
                    <Listeners>
                        <Click Handler="#{TreePanel1}.editNode(#{TreePanel1}.menuNode, 'text', 'TEST');" />
                    </Listeners>
                </ext:MenuItem>

                <ext:MenuItem runat="server" Text="Remove" Icon="Delete">
                    <Listeners>
                        <Click Handler="#{TreePanel1}.removeNode(#{TreePanel1}.menuNode);" />
                    </Listeners>
                </ext:MenuItem>

                <ext:MenuItem runat="server" Text="Append child" Icon="Add">
                    <Listeners>
                        <Click Handler="#{TreePanel1}.appendChild(#{TreePanel1}.menuNode, 'New');" />
                    </Listeners>
                </ext:MenuItem>

                <ext:MenuItem runat="server" Text="Insert before this node" Icon="ArrowRight">
                    <Listeners>
                        <Click Handler="#{TreePanel1}.insertBefore(#{TreePanel1}.menuNode, 'New');" />
                    </Listeners>
                </ext:MenuItem>
            </Items>
            <Listeners>
                <Show Handler="#{NodeName}.setText(this.nodeName);" />
            </Listeners>
        </ext:Menu>


        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Height="480"
            Width="250"
            UseArrows="true"
            Scrollable="Both"
            Mode="Remote"
            RootVisible="false"
            RemoteJson="true"
            RemoteEditUrl="RemoteTree.asmx/RemoteEdit"
            RemoteRemoveUrl="RemoteTree.asmx/RemoteRemove"
            RemoteAppendUrl="RemoteTree.asmx/RemoteAppend"
            RemoteInsertUrl="RemoteTree.asmx/RemoteInsert"
            RemoteMoveUrl="RemoteTree.asmx/RemoteMove">
            <Editor>
                <ext:TextField runat="server" />
            </Editor>

            <Store>
                <ext:TreeStore runat="server">
                    <Proxy>
                        <ext:AjaxProxy Url="RemoteTree.asmx/GetNodes" Json="true">
                            <ActionMethods Read="POST" />
                            <Reader>
                                <ext:JsonReader RootProperty="d" />
                            </Reader>
                        </ext:AjaxProxy>
                    </Proxy>
                    <Root>
                        <ext:Node NodeID="Root" />
                    </Root>
                </ext:TreeStore>
            </Store>

            <DirectEventConfig Method="POST" />

            <Listeners>
                <ItemContextMenu Fn="showMenu" StopEvent="true" />
                <RemoteActionRefusal Handler="Ext.Msg.alert('Action refusal', e.message);" />
            </Listeners>

            <View>
                <ext:TreeView runat="server">
                    <Plugins>
                        <ext:TreeViewDragDrop runat="server" AllowLeafDrop="true" ContainerScroll="true" />
                    </Plugins>
                </ext:TreeView>
            </View>

            <Plugins>
                <ext:CellEditing runat="server" />
            </Plugins>
        </ext:TreePanel>
    </form>
</body>
</html>