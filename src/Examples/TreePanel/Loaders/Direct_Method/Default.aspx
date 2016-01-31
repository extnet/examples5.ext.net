<%@ Page Language="C#" %>

<script runat="server">
    [DirectMethod]
    public static string NodeLoad(string nodeID)
    {
        NodeCollection nodes = new Ext.Net.NodeCollection();

        if (!string.IsNullOrEmpty(nodeID))
        {
            for (int i = 1; i < 6; i++)
            {
                Node asyncNode = new Node();
                asyncNode.Text = nodeID + i;
                asyncNode.NodeID = nodeID + i;
                nodes.Add(asyncNode);
            }

            for (int i = 6; i < 11; i++)
            {
                Node treeNode = new Node();
                treeNode.Text = nodeID + i;
                treeNode.NodeID = nodeID + i;
                treeNode.Leaf = true;
                nodes.Add(treeNode);
            }
        }

        return nodes.ToJson();
    }
</script>
    
<!DOCTYPE html>

<html>
<head runat="server">
    <title>TreePanel using DirectMethod - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var nodeLoad = function (store, operation, options) {
            var node = operation.node;

            App.direct.NodeLoad(node.getId(), {
                success : function (result) {
                    node.set('loading', false);
                    node.set('loaded', true);
                    var data = Ext.decode(result);
                    node.appendChild(data, undefined, true);
                    node.expand();                    
                },

                failure : function (errorMsg) {
                    Ext.Msg.alert('Failure', errorMsg);
                }
            });

            return false;
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />
        
        <h1>TreePanel using DirectMethod</h1>         
        
        <ext:TreePanel 
            ID="TreePanel1" 
            runat="server" 
            Title="Tree" 
            Width="300"
            Height="450" 
            Border="false">
            <Root>
                <ext:Node NodeID="0" Text="Root" />
            </Root>
            <Listeners>
                <BeforeLoad Fn="nodeLoad" />
            </Listeners>
        </ext:TreePanel>       
    </form>
</body>
</html>