<%@ Page Language="C#" %>

<%@ Import Namespace="System.Collections.Generic" %>

 <script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        List<object> data = new List<object>();

        for (int i = 0; i < 10; i++)
        {
            data.Add(new
            {
                Name = "Record #" + i
            });
        }

        this.Store1.DataSource = data;
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Drag and Drop rows to reorganize - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Drag and Drop rows to reorganize</h1>

        <ext:GridPanel
            runat="server"
            MultiSelect="true"
            Title="Grid"
            Width="400"
            Height="300">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Name" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" Text="Record Name" Width="160" DataIndex="Name" Flex="1" />
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server">
                    <Plugins>
                        <ext:GridDragDrop runat="server" DragText="Drag and drop to reorganize"/>
                    </Plugins>
                </ext:GridView>
            </View>
        </ext:GridPanel>
    </form>
</body>
</html>