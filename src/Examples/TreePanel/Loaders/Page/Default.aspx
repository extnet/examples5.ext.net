<%@ Page Language="C#" %>

<script runat="server">
    protected void NodeLoad(object sender, NodeLoadEventArgs e)
    {
        string prefix = e.ExtraParams["prefix"] ?? "";

        if (!string.IsNullOrEmpty(e.NodeID))
        {
            for (int i = 1; i < 6; i++)
            {
                Node asyncNode = new Node();
                asyncNode.Text = prefix + e.NodeID + i;
                asyncNode.NodeID = e.NodeID + i;
                e.Nodes.Add(asyncNode);
            }

            for (int i = 6; i < 11; i++)
            {
                Node treeNode = new Node();
                treeNode.Text = prefix + e.NodeID + i;
                treeNode.NodeID = e.NodeID + i;
                treeNode.Leaf = true;
                e.Nodes.Add(treeNode);
            }
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreePanel using PageProxy - Ext.NET Examples</title>

    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>TreePanel using PageProxy</h1>

        <p>Set custom node prefix:</p>

        <ext:TextField ID="TextField1" runat="server" Text="Node" Width="200" />

        <ext:TreePanel
            ID="TreePanel1"
            runat="server"
            Title="Tree"
            Width="200"
            Height="500"
            Border="false">
            <Store>
                <ext:TreeStore runat="server" OnReadData="NodeLoad">
                    <Proxy>
                        <ext:PageProxy />
                    </Proxy>
                    <Parameters>
                        <ext:StoreParameter Name="prefix" Value="#{TextField1}.getValue()" Mode="Raw" />
                    </Parameters>
                </ext:TreeStore>
            </Store>
            <Root>
                <ext:Node NodeID="0" Text="Root" />
            </Root>
            <ViewConfig LoadMask="false" />
        </ext:TreePanel>
    </form>
</body>
</html>