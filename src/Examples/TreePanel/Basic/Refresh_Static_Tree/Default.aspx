<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!IsPostBack && !X.IsAjaxRequest)
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
        root.Expanded = true;
        nodes.Add(root);

        string prefix = DateTime.Now.Second + "_";

        for (int i = 0; i < 10; i++)
        {
            Ext.Net.Node node = new Ext.Net.Node();
            node.Text = prefix + i;
            node.Leaf = true;
            root.Children.Add(node);
        }

        return nodes;
    }

    [DirectMethod]
    public string RefreshMenu()
    {
        Ext.Net.NodeCollection nodes = this.BuildTree(null);

        return nodes.ToJson();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Refresh Static Tree - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <script>
        var refreshTree = function (tree) {
            App.direct.RefreshMenu({
                success : function (result) {
                    var nodes = eval(result);
                    if (nodes.length > 0) {
                        tree.setRootNode(nodes[0]);
                    }
                    else {
                        tree.getRootNode().removeAll();
                    }
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Title="Tree"
            Icon="Anchor"
            Width="250"
            RootVisible="false"
            BodyPaddingSummary="0 0 0 10">
            <Tools>
                <ext:Tool Type="Refresh" Handler="refreshTree(#{TreePanel1});">
                    <ToolTips>
                        <ext:ToolTip runat="server" Html="Refresh" />
                    </ToolTips>
                </ext:Tool>
            </Tools>
         </ext:TreePanel>
    </form>
</body>
</html>