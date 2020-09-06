<%@ Page Language="C#" %>

<%@ Import Namespace="System.Linq" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BindData(0);
        }
    }

    protected void AddRecords(object sender, StoreReadDataEventArgs e)
    {
        this.BindData(int.Parse(e.Parameters["count"] ?? "0"));
    }

    private void BindData(int count)
    {
        Store store = this.GridPanel1.GetStore();
        List<object> data = this.Data;

        store.DataSource = data.Skip(count).Take(5);
        store.DataBind();

        InfoLabel.Text = String.Format("Displaying {0} of {1}", Math.Min(count + 5, data.Count), data.Count);
        MoreButton.Disabled = (count + 5) >= data.Count;
        if (count != 0)
        {
            GridPanel1.UpdateLayout();
        }
    }

    private new System.Collections.Generic.List<object> Data
    {
        get
        {
            return new System.Collections.Generic.List<object>
            {
                new { company = "3m Co" },
                new { company = "Alcoa Inc"},
                new { company = "Altria Group Inc"},
                new { company = "American Express Company"},
                new { company = "American International Group, Inc."},
                new { company = "AT&T Inc."},
                new { company = "Boeing Co."},
                new { company = "Caterpillar Inc."},
                new { company = "Citigroup, Inc."},
                new { company = "E.I. du Pont de Nemours and Company"},
                new { company = "Exxon Mobil Corp"},
                new { company = "General Electric Company"},
                new { company = "General Motors Corporation"},
                new { company = "Hewlett-Packard Co."},
                new { company = "Honeywell Intl Inc"},
                new { company = "Intel Corporation"},
                new { company = "International Business Machines"},
                new { company = "Johnson & Johnson"},
                new { company = "JP Morgan & Chase & Co"},
                new { company = "McDonald\"s Corporation"},
                new { company = "Merck & Co., Inc."},
                new { company = "Microsoft Corporation"},
                new { company = "Pfizer Inc"},
                new { company = "The Coca-Cola Company"},
                new { company = "The Home Depot, Inc."},
                new { company = "The Procter & Gamble Company"},
                new { company = "United Technologies Corporation"},
                new { company = "Verizon Communications"},
                new { company = "Wal-Mart Stores, Inc."}
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Add mode of Store - Ext.NET Examples</title>
    <ext:ResourcePlaceHolder runat="server" Mode="Script" />
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Add mode of Store</h1>

        <ext:GridPanel ID="GridPanel1" runat="server" Title="Grid" Width="960">
            <Store>
                <ext:Store ID="Store1" runat="server" OnReadData="AddRecords" WarningOnDirty="false">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="company" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:RowNumbererColumn runat="server" Width="25" />
                    <ext:Column runat="server" ID="Company" Text="Company" Flex="1" DataIndex="company" />
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" ScrollOffset="0" />
            </View>
            <BottomBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button ID="MoreButton" runat="server" Text="More" Icon="Add">
                            <Listeners>
                                <Click Handler="#{Store1}.reload({addRecords:true, start: #{Store1}.getCount(), params : {count: #{Store1}.getCount()} });" />
                            </Listeners>
                        </ext:Button>
                        <ext:ToolbarFill runat="server" />
                        <ext:DisplayField ID="InfoLabel" runat="server" Width="105" />
                    </Items>
                </ext:Toolbar>
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>