<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        SiteMapNode siteNode = SiteMap.RootNode;
        Node root = this.CreateNode(siteNode);
        root.AllowDrag = false;
        root.Expanded = true;
        TreePanel1.Root.Add(root);
    }

    //static node creation with children
    private Node CreateNode(SiteMapNode siteMapNode)
    {
        Ext.Net.Node node = new Ext.Net.Node();

        node.NodeID = siteMapNode.Key;
        node.Text = siteMapNode.Title;
        node.Qtip = siteMapNode.Description;

        SiteMapNodeCollection children = siteMapNode.ChildNodes;

        if (children != null && children.Count > 0)
        {
            foreach (SiteMapNode mapNode in siteMapNode.ChildNodes)
            {
                node.Children.Add(this.CreateNode(mapNode));
            }
        }
        else
        {
            node.Leaf = true;
        }

        return node;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Drag and Drop ordering of TreePanel Nodes - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <script>
        var moveNode = function (item, oldParent, newParent, index, options) {
            var buf=[];
            buf.push("Node = " + item.data.text);
            buf.push("<br/>");
            buf.push("Old parent = " + oldParent.data.text);
            buf.push("<br/>");
            buf.push("New parent = " + newParent.data.text);
            buf.push("<br/>");
            buf.push("Index = " + index);

            Ext.Msg.alert("Node droped", buf.join(""));
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Drag and Drop ordering of TreePanel Nodes</h1>

        <p>This example shows basic drag and drop node moving in a tree. In this implementation there are no restrictions and
        anything can be dropped anywhere except appending to nodes marked "leaf".</p>

        <p>In order to demonstrate drag and drop insertion points, sorting was <b>not</b> enabled.</p>

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Height="300"
            Width="250"
            UseArrows="true">
            <Listeners>
                <ItemMove Fn="moveNode" Delay="1" />
            </Listeners>
            <View>
                <ext:TreeView runat="server">
                   <Plugins>
                       <ext:TreeViewDragDrop runat="server" ContainerScroll="true" />
                   </Plugins>
                </ext:TreeView>
            </View>
        </ext:TreePanel>
    </form>
</body>
</html>