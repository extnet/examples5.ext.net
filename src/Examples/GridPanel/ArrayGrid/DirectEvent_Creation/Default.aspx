<%@ Page Language="C#" %>

<%@ Import Namespace="Button=Ext.Net.Button" %>

<script runat="server">
    protected void Button1_Click(object sender, DirectEventArgs e)
    {
        this.BuildGridPanel().AddTo(this.Window1);

        // Reference Button by sender argument
        ((Button)sender).Disabled = true;

        // Reference Button by .Items Collection
        //this.Window1.TopBar.Toolbar.Items[0].Disabled = true;

        // Reference Button directly by .ID
        // this.Button1.Disabled = true;
    }

    private GridPanel BuildGridPanel()
    {
        return new GridPanel
        {
            Border = false,
            Store =
            {
                this.BuildStore()
            },
            SelectionModel =
            {
                new RowSelectionModel() { Mode = SelectionMode.Single }
            },
            ColumnModel =
            {
                Columns =
                {
                    new Column
                    {
                        Text = "Company",
                        DataIndex = "company",
                        Flex = 1
                    },
                    new Column
                    {
                        Text = "Price",
                        DataIndex = "price",
                        Renderer = { Format = RendererFormat.UsMoney }
                    },
                    new Column
                    {
                        Text = "Change",
                        DataIndex = "change",
                        Renderer = { Fn = "change" }
                    },
                    new Column
                    {
                        Text = "Change",
                        DataIndex = "pctChange",
                        Renderer = { Fn = "pctChange" }
                    },
                    new DateColumn
                    {
                        Text = "Last Updated",
                        DataIndex = "lastChange"
                    }
                }
            },
            View =
            {
               new Ext.Net.GridView()
               {
                    StripeRows = true,
                    TrackOver = true
               }
            }
        };
    }

    private Store BuildStore()
    {
        Store store = new Store
        {
            Model =
            {
                new Model
                {
                    Fields =
                    {
                        new ModelField("company"),
                        new ModelField("price", ModelFieldType.Float),
                        new ModelField("change", ModelFieldType.Float),
                        new ModelField("pctChange", ModelFieldType.Float),
                        new ModelField("lastChange", ModelFieldType.Date, "M/d hh:mmtt")
                    }
                }
            }
        };

        store.DataSource = this.Data;

        return store;
    }

    private object[] Data
    {
        get
        {
            return new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "American Express Company", 52.55, 0.01, 0.02, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "AT&T Inc.", 31.61, -0.48, -1.54, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Boeing Co.", 75.43, 0.53, 0.71, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Exxon Mobil Corp", 68.1, -0.43, -0.64, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "General Electric Company", 34.14, -0.08, -0.23, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "General Motors Corporation", 30.27, 1.09, 3.74, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Hewlett-Packard Co.", 36.53, -0.03, -0.08, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Honeywell Intl Inc", 38.77, 0.05, 0.13, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Intel Corporation", 19.88, 0.31, 1.58, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "International Business Machines", 81.41, 0.44, 0.54, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Johnson & Johnson", 64.72, 0.06, 0.09, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "McDonald\"s Corporation", 36.76, 0.86, 2.40, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Merck & Co., Inc.", 40.96, 0.41, 1.01, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Microsoft Corporation", 25.84, 0.14, 0.54, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Pfizer Inc", 27.96, 0.4, 1.45, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "The Coca-Cola Company", 45.07, 0.26, 0.58, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "The Home Depot, Inc.", 34.64, 0.35, 1.02, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "The Procter & Gamble Company", 61.91, 0.01, 0.02, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "United Technologies Corporation", 63.26, 0.55, 0.88, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Verizon Communications", 35.57, 0.39, 1.11, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Create GridPanel and Store during DirectEvent - Ext.NET Examples</title>
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

    <h1>Creation of a GridPanel and Store during a DirectEvent</h1>

    <ext:Window
        ID="Window1"
        runat="server"
        Title="Dynamic GridPanel"
        Layout="Fit"
        Height="720"
        Width="960">
        <TopBar>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:Button
                        runat="server"
                        Text="Add GridPanel"
                        Icon="Add">
                        <DirectEvents>
                            <Click OnEvent="Button1_Click">
                                <EventMask ShowMask="true"
                                    Target="CustomTarget"
                                    CustomTarget="Window1"
                                    />
                            </Click>
                        </DirectEvents>
                    </ext:Button>
                </Items>
            </ext:Toolbar>
        </TopBar>
    </ext:Window>
</form>
</body>
</html>