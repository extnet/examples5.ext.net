<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BuildTree(this.TreePanel1.Root);
        }
    }

    private NodeCollection BuildTree(NodeCollection nodes)
    {
        if (nodes == null)
        {
            nodes = new NodeCollection();
        }

        Node root = new Node();
        root.Text = "Root";
        nodes.Add(root);

        bool submit = true;

        for (int i = 0; i < 10; i++)
        {
            Node node = new Node();
            node.NodeID = (i + 1).ToString();
            node.Text = "Node" + (i + 1);
            node.Leaf = true;
            node.CustomAttributes.Add(new ConfigItem("submit", JSON.Serialize(submit), ParameterMode.Raw));
            root.Children.Add(node);
            submit = !submit;
        }

        return nodes;
    }

    protected void SubmitNodes(object sender, SubmitEventArgs e)
    {
        X.Msg.Alert("Submit", "You have submitted " + e.RootNode.Children.Count + " nodes").Show();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreePanel Submit - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>TreePanel Submit</h1>

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Icon="Anchor"
            Title="Tree"
            Width="550"
            RootVisible="false"
            OnSubmit="SubmitNodes">
            <Fields>
                <ext:ModelField Name="submit" Type="Boolean" />
            </Fields>
            <Buttons>
                <ext:Button runat="server" Text="Simple Submit">
                    <Listeners>
                        <Click Handler="#{TreePanel1}.submitNodes();" />
                    </Listeners>
                </ext:Button>

                <ext:Button runat="server" Text="Submit with Callback">
                    <Listeners>
                        <Click Handler="#{TreePanel1}.submitNodes({text : 'Submit finish', callback : function (o, success, r) { alert(o.text + ', Status : ' + success); }});" />
                    </Listeners>
                </ext:Button>

                <ext:Button runat="server" Text="Submit with Node Filter">
                    <Listeners>
                        <Click Handler="#{TreePanel1}.submitNodes({ nodeFilter : function (node) { return node.data.submit || node.isRoot();}});" />
                    </Listeners>
                </ext:Button>
            </Buttons>
         </ext:TreePanel>
    </form>
</body>
</html>