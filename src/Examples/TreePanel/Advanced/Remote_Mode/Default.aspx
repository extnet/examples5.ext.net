<%@ Page Language="C#" ValidateRequest="false" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BuildTree(TreePanel1.Root);
        }
    }

    private Ext.Net.NodeCollection BuildTree(Ext.Net.NodeCollection nodes)
    {
        if (nodes == null)
        {
            nodes = new Ext.Net.NodeCollection();
        }

        Ext.Net.Node root = new Ext.Net.Node();
        root.Text = "Root";
        nodes.Add(root);

        string prefix = DateTime.Now.Second + "_";

        for (int i = 0; i < 10; i++)
        {
            Ext.Net.Node node = new Ext.Net.Node();
            node.NodeID = i.ToString();
            node.Text = prefix + i;
            node.CustomAttributes.Add(new ConfigItem("number", i.ToString(), ParameterMode.Raw));
            node.CustomAttributes.Add(new ConfigItem("date", JSON.Serialize(DateTime.Today.AddDays(i), JSON.ScriptConverters), ParameterMode.Raw));
            node.Leaf = true;
            root.Children.Add(node);
        }

        return nodes;
    }

    protected void RemoteEdit(object sender, RemoteEditEventArgs e)
    {
        e.Accept = true;

        foreach (RowChanges change in e.Changes)
        {
            if (change.Field == "text" && change.IsDirty<string>())
            {
                change.SetValue(change.Value<string>() + "_echo");
            }
            else if (change.Field == "number")
            {
                change.SetValue(change.Value<int>() * 10);
            }
            else if (change.Field == "date")
            {
                change.SetValue(change.Value<DateTime>().AddYears(10));
            }
        }

        //   You can refuse action
        //   e.Accept = false;
        //   e.RefusalMessage = "Error";
    }

    protected void RemoteRemove(object sender, RemoteRemoveEventArgs e)
    {
        e.Accept = true;
    }

    protected void RemoteAppend(object sender, RemoteAppendEventArgs e)
    {
        e.Accept = true;
        e.Attributes = new
        {
            text = e.Text + "_new"
        };
    }

    protected void RemoteMove(object sender, RemoteMoveEventArgs e)
    {
        e.Accept = true;
    }
</script>

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

        <h1>Remote mode</h1>

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
            Height="300"
            Width="450"
            AutoScroll="true"
            Animate="true"
            Mode="Remote"
            RootVisible="false"
            ContainerScroll="true"
            OnRemoteEdit="RemoteEdit"
            OnRemoteRemove="RemoteRemove"
            OnRemoteAppend="RemoteAppend"
            OnRemoteMove="RemoteMove">

            <Fields>
                <ext:ModelField Name="number" Type="Int" />
                <ext:ModelField Name="date" Type="Date" />
            </Fields>

            <ColumnModel>
                <Columns>
                    <ext:TreeColumn runat="server" DataIndex="text" Text="Text" Flex="1">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:TreeColumn>

                    <ext:Column runat="server" DataIndex="number" Text="Number">
                        <Editor>
                            <ext:NumberField runat="server" />
                        </Editor>
                    </ext:Column>

                    <ext:DateColumn
                        runat="server"
                        DataIndex="date"
                        Text="Date"
                        Format="dd/MM/yyyy"
                        Width="125">
                        <Editor>
                            <ext:DateField runat="server" Format="dd/MM/yyyy" />
                        </Editor>
                    </ext:DateColumn>
                </Columns>
            </ColumnModel>

            <SelectionSubmitConfig Encode="true" />

            <Listeners>
                <ItemContextMenu Fn="showMenu" StopEvent="true" />
                <RemoteActionRefusal Handler="Ext.Msg.alert('Action refusal', e.message);" />
            </Listeners>

            <View>
                <ext:TreeView runat="server">
                    <Plugins>
                        <ext:TreeViewDragDrop runat="server" AllowLeafDrop="true" />
                    </Plugins>
                </ext:TreeView>
            </View>

            <Plugins>
                <ext:CellEditing runat="server" />
                <%--<ext:RowEditing runat="server" />--%>
            </Plugins>
        </ext:TreePanel>
    </form>
</body>
</html>