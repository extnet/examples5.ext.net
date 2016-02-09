<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            SiteMapNode siteNode = SiteMap.RootNode;
            Node node = this.CreateNodeWithOutChildren(siteNode);
            node.AllowDrag = true;
            node.Expanded = true;
            TreePanel1.GetStore().Root.Add(node);
        }
    }

    //page tree node loader handler
    protected void LoadPages(object sender, NodeLoadEventArgs e)
    {
        if (!string.IsNullOrEmpty(e.NodeID))
        {
            SiteMapNode siteMapNode = SiteMap.Provider.FindSiteMapNodeFromKey(e.NodeID);
            
            if (siteMapNode == null)
            {
                return;
            }

            SiteMapNodeCollection children = siteMapNode.ChildNodes;

            if (children != null && children.Count > 0)
            {
                foreach (SiteMapNode mapNode in siteMapNode.ChildNodes)
                {
                    e.Nodes.Add(this.CreateNodeWithOutChildren(mapNode));
                }
            }
        }
    }

    //dynamic node creation
    private Node CreateNodeWithOutChildren(SiteMapNode siteMapNode)
    {
        Node treeNode;

        if (siteMapNode.ChildNodes != null && siteMapNode.ChildNodes.Count > 0)
        {
            treeNode = new Node();
        }
        else
        {
            treeNode = new Ext.Net.Node();
            treeNode.Leaf = true;
        }

        treeNode.NodeID = siteMapNode.Key;
        treeNode.Text = siteMapNode.Title;
        treeNode.Qtip = siteMapNode.Description;

        return treeNode;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Drag and Drop between two TreePanels - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
    <style>
        .tree {
    	    float  : left;
    	    margin : 20px;
    	    border : 1px solid #c3daf9;
        }
    </style>

    <script>
        
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>Drag and Drop between two TreePanels</h1>
        
        <p>The TreePanels have a TreeSorter applied in "folderSort" mode.</p>
        
        <p>Both TreePanels are in "appendOnly" drop mode since they are sorted.</p>
        
        <p>Drag along the edge of the tree to trigger auto scrolling while performing a drag and drop.</p>

        <p>The data for this tree is asynchronously loaded with a TreeStore.</p>
        
        <div class="tree">
            <ext:TreePanel 
                ID="TreePanel1"
                runat="server" 
                Border="false"
                Height="300"
                Width="250"
                UseArrows="true"
                Animate="true">
                <Store>
                    <ext:TreeStore 
                        runat="server" 
                        OnReadData="LoadPages"
                        FolderSort="true">                       
                        <Proxy>
                            <ext:PageProxy />
                        </Proxy>
                        <Sorters>
                            <ext:DataSorter Property="text" />
                        </Sorters>
                    </ext:TreeStore>
                </Store>                
                <View>
                    <ext:TreeView runat="server">
                       <Plugins>
                            <ext:TreeViewDragDrop runat="server" AppendOnly="true" ContainerScroll="true" />
                        </Plugins>
                    </ext:TreeView>
                </View>
            </ext:TreePanel>
        </div>
        
        <div class="tree">
            <ext:TreePanel 
                ID="TreePanel2"
                runat="server"
                Height="300"
                Width="250"
                Border="false"
                UseArrows="true"
                AutoScroll="true">
                <Store>
                    <ext:TreeStore 
                        runat="server" 
                        OnReadData="LoadPages" 
                        FolderSort="true">
                        <Proxy>
                            <ext:PageProxy />
                        </Proxy>
                        <Sorters>
                            <ext:DataSorter Property="text" />
                        </Sorters>
                        <Root>
                            <ext:Node Text="My Files" Icon="Folder" Expanded="true" EmptyChildren="true" />
                        </Root> 
                    </ext:TreeStore>
                </Store>
                <View>
                    <ext:TreeView runat="server">
                       <Plugins>
                            <ext:TreeViewDragDrop runat="server" AppendOnly="true" ContainerScroll="true" />
                        </Plugins>
                    </ext:TreeView>
                </View>                
            </ext:TreePanel>
        </div>
    </form>
</body>
</html>