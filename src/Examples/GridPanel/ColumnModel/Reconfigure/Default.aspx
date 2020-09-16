<%@ Page Language="C#" %>

<%@ Import Namespace="Button=Ext.Net.Button" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.BindData();
        }
    }

    protected void AddColumn(object sender, DirectEventArgs e)
    {
        ((Button)sender).Disabled = true;

        ModelField field = new ModelField("pctChange", ModelFieldType.Float);

        //we need specify index because we use ArrayReader which parse data source by index

        this.Store1.AddField(field, 3);
        this.Store1.Model[0].Fields.Insert(3, field);

        this.BindData();

        Column col = new Column();
        col.Text = "Change %";
        col.Width = 75;
        col.Sortable = true;
        col.DataIndex = "pctChange";
        col.Renderer.Fn = "pctChange";

        ComboBox cb = new ComboBox();
        cb.Items.Add(new Ext.Net.ListItem("1", "1"));
        cb.Items.Add(new Ext.Net.ListItem("2", "2"));
        cb.Items.Add(new Ext.Net.ListItem("3", "3"));
        this.Controls.Add(cb);

        col.Editor.Add(cb);

        this.GridPanel1.AddColumn(col);
    }

    protected void InsertColumn(object sender, DirectEventArgs e)
    {
        ((Button)sender).Disabled = true;

        DateColumn col = new DateColumn
        {
            Text = "Last Updated",
            Width = 85,
            Sortable = true,
            DataIndex = "lastChange",
            Format = "M/d/yyyy"
        };

        this.GridPanel1.InsertColumn(1, col);
    }

    protected void Reconfigure(object sender, DirectEventArgs e)
    {
        ((Button)sender).Disabled = true;

        this.GridPanel1.ColumnModel.Columns.RemoveAt(1);
        this.GridPanel1.ColumnModel.Columns.RemoveAt(1);
        this.GridPanel1.Reconfigure();
    }

    private void BindData()
    {
        this.Store1.DataSource = this.Data;
        this.Store1.DataBind();
    }

    private object Data
    {
        get
        {
            return new List<object>
            {
               new { company = "3m Co", price = 71.72, change = 0.02, pctChange = 0.03, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Alcoa Inc", price = 29.01, change = 0.42, pctChange = 1.47, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Altria Group Inc", price = 83.81, change = 0.28, pctChange = 0.34, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "American Express Company", price = 52.55, change = 0.01, pctChange = 0.02, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "American International Group, Inc.", price = 64.13, change = 0.31, pctChange = 0.49, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "AT&T Inc.", price = 31.61, change = -0.48, pctChange = -1.54, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Boeing Co.", price = 75.43, change = 0.53, pctChange = 0.71, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Caterpillar Inc.", price = 67.27, change = 0.92, pctChange = 1.39, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Citigroup, Inc.", price = 49.37, change = 0.02, pctChange = 0.04, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "E.I. du Pont de Nemours and Company", price = 40.48, change = 0.51, pctChange = 1.28, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Exxon Mobil Corp", price = 68.1, change = -0.43, pctChange = -0.64, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "General Electric Company", price = 34.14, change = -0.08, pctChange = -0.23, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "General Motors Corporation", price = 30.27, change = 1.09, pctChange = 3.74, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Hewlett-Packard Co.",  price = 36.53, change = -0.03, pctChange = -0.08, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Honeywell Intl Inc",  price = 38.77, change = 0.05, pctChange = 0.13, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Intel Corporation",  price = 19.88, change = 0.31, pctChange = 1.58, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "International Business Machines",  price = 81.41, change = 0.44, pctChange = 0.54, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Johnson & Johnson",  price = 64.72, change = 0.06, pctChange = 0.09, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "JP Morgan & Chase & Co",  price = 45.73, change = 0.07, pctChange = 0.15, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "McDonald\"s Corporation",  price = 36.76, change = 0.86, pctChange = 2.40, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Merck & Co., Inc.",  price = 40.96, change = 0.41, pctChange = 1.01, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Microsoft Corporation",  price = 25.84, change = 0.14, pctChange = 0.54, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Pfizer Inc",  price = 27.96, change = 0.4, pctChange = 1.45, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "The Coca-Cola Company",  price = 45.07, change = 0.26, pctChange = 0.58, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "The Home Depot, Inc.",  price = 34.64, change = 0.35, pctChange = 1.02, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "The Procter & Gamble Company",  price = 61.91, change = 0.01, pctChange = 0.02, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "United Technologies Corporation",  price = 63.26, change = 0.55, pctChange = 0.88, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Verizon Communications",  price = 35.57, change = 0.39, pctChange = 1.11, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
               new { company = "Wal-Mart Stores, Inc.",  price = 45.45, change = 0.73, pctChange = 1.63, lastChange = DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Simple Array Grid - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value + "%");
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Modify ColumnModel during DirectEvent</h1>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Array Grid"
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
                                <ext:ModelField Name="lastChange" Type="Date" DateFormat="yyyy-MM-dd hh:mm:tt" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        runat="server"
                        Text="Company"
                        DataIndex="company"
                        Flex="1"
                        />
                    <ext:Column
                        runat="server"
                        Text="Price"
                        Width="75"
                        DataIndex="price">
                        <Renderer Format="UsMoney" />
                    </ext:Column>
                    <ext:Column
                        runat="server"
                        Text="Change"
                        Width="75"
                        DataIndex="change"
                        />
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Single" />
            </SelectionModel>
            <View>
                <ext:GridView runat="server" StripeRows="true" TrackOver="true" />
            </View>
            <BottomBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Add Column">
                             <DirectEvents>
                                <Click OnEvent="AddColumn" Single="true" />
                             </DirectEvents>
                        </ext:Button>
                        <ext:Button runat="server" Text="Insert Column">
                             <DirectEvents>
                                <Click OnEvent="InsertColumn" Single="true" />
                             </DirectEvents>
                        </ext:Button>
                         <ext:Button runat="server" Text="Reconfigure">
                             <DirectEvents>
                                <Click OnEvent="Reconfigure" Single="true" />
                             </DirectEvents>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>