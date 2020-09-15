<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        SiteMapNode siteNode = SiteMap.RootNode;
        Node root = new Node();
        root.AllowDrag = false;
        root.Expanded = true;
        root.Children.Add(this.CreateNode(siteNode));
        TreePanel1.Root.Add(root);
    }

    //static node creation with children
    private Node CreateNode(SiteMapNode siteMapNode)
    {
        Node treeNode = new Node();

        treeNode.NodeID = siteMapNode.Key;
        treeNode.Text = siteMapNode.Title;
        treeNode.Qtip = siteMapNode.Description;

        SiteMapNodeCollection children = siteMapNode.ChildNodes;

        if (children != null && children.Count > 0)
        {
            foreach (SiteMapNode mapNode in siteMapNode.ChildNodes)
            {
                treeNode.Children.Add(this.CreateNode(mapNode));
            }
        }
        else
        {
            treeNode.Leaf = true;
        }

        return treeNode;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Tree Filter - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var filterTree = function (tf, e) {
            var tree = App.TreePanel1,
                store = tree.store,
                logic = App.FilterLogic.getValue() ? tree : store,
                text = tf.getRawValue();

            logic.clearFilter();

            // This will ensure after clearing the filter the auto-expanded nodes will be collapsed again
            tree.collapseAll();

            if (Ext.isEmpty(text, false)) {
                return;
            }

            if (e.getKey() === e.ESC) {
                clearFilter();
            } else {
                // this will allow invalid regexp while composing, for example "(examples|grid|color)"
                try {
                    var re = new RegExp(".*" + text + ".*", "i");
                } catch (err) {
                    return;
                }

                logic.filterBy(function (node) {
                    return re.test(node.data.text);
                });

            }
        };

        var clearFilter = function () {
            var field = App.TriggerField1,
                tree = App.TreePanel1,
                store = tree.store,
                logic = App.FilterLogic.getValue() ? tree : store;

            field.setValue("");
            logic.clearFilter(true);
            tree.getView().focus();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Tree Filter</h1>
        <p>
            <b>Notice:</b> Deactivating the "Tree filtering" checkbox turns on the native ExtJS Store filtering logic that
            applies the search condition directly to the TreePanel's Store so its behavior is much different comparing
            with the native Ext.NET TreePanel filtering. A possible search condition for the native ExtJS Store filtering could be <b>examples|grid</b>.

        </p>

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            RootVisible="false"
            Height="480"
            Width="400"
            UseArrows="true">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarTextItem runat="server" Text="Filter:" />
                        <ext:ToolbarSpacer />
                        <ext:TextField
                            ID="TriggerField1"
                            runat="server"
                            EnableKeyEvents="true">
                            <Triggers>
                                <ext:FieldTrigger IconCls="x-md md-icon-clear" />
                            </Triggers>
                            <Listeners>
                                <KeyUp Fn="filterTree" Buffer="250" />
                                <TriggerClick Handler="clearFilter();" />
                            </Listeners>
                        </ext:TextField>
                        <ext:ToolbarSpacer />
                        <ext:Checkbox ID="FilterLogic" runat="server" BoxLabel="TreePanel filtering" Checked="true">
                            <ToolTips>
                                <ext:ToolTip runat="server" Html="If checked then tree logic filtering (instead store logic)" />
                            </ToolTips>
                        </ext:Checkbox>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:TreePanel>
    </form>
</body>
</html>