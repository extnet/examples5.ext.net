<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        SiteMapNode siteNode = SiteMap.RootNode;
        Node root = this.CreateNode(siteNode);
        root.AllowDrag = false;
        root.Expanded = true;

        this.TreeStore1.Root.Add(root);
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

    protected void OnSelectionChange(object sender, DirectEventArgs e)
    {
        var node = SiteMap.Provider.FindSiteMapNodeFromKey(Breadcrumb1.Selection);

        this.Panel1.Html = "Selected node: " + node.Title + "<br/>Selected url: " + node.Url;
        this.Panel1.Body.Highlight();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Breadcrumb - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Breadcrumb Example</h1>

        <ext:Panel
            ID="Panel1"
            runat="server"
            Title="Breadcrumb Toolbar"
            Height="400"
            Width="600"
            BodyPadding="20">
            <TopBar>
                <ext:Breadcrumb
                    ID="Breadcrumb1"
                    runat="server"
                    ShowIcons="true"
                    OverflowHandler="Scroller"
                    Selection="/examples/messagebox/notification/overview/">
                    <Store>
                        <ext:TreeStore ID="TreeStore1" runat="server" />
                    </Store>
                    <DirectEvents>
                        <SelectionChange OnEvent="OnSelectionChange" />
                    </DirectEvents>
                </ext:Breadcrumb>
            </TopBar>
        </ext:Panel>
    </form>
</body>
</html>