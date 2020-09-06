<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03, "Y" },
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, "Y" },
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, "N" },
                new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, "N" }
            };

            this.Store1.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Field Converter - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:GridPanel
            runat="server"
            Title="Grid"
            Width="960"
            Height="480">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="company" />
                                <ext:ModelField Name="price" Type="Float" />
                                <ext:ModelField Name="change" Type="Float" />
                                <ext:ModelField Name="pctChange" Type="Float" />
                                <ext:ModelField Name="active" Type="Boolean">
                                    <Convert Handler="return value === 'Y';" />
                                </ext:ModelField>
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1" />
                    <ext:Column runat="server" Text="Price" Width="75" DataIndex="price" />
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="change" />
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="pctChange" />
                    <ext:CheckColumn runat="server" Text="Active" Width="50" DataIndex="active" />
                </Columns>
            </ColumnModel>
        </ext:GridPanel>
    </form>
</body>
</html>