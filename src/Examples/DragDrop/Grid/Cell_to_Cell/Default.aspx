<%@ Page Language="C#" %>

<script runat="server">
    private object[] TestData
    {
        get
        {
            DateTime now = DateTime.Now;

            return new object[]
            {
                new object[] { "3m Co", "1/1 12:00am", "Up", 71.72, 0.02, 0.03, now },
                new object[] { "Alcoa Inc", "1/1 12:00am", "Up", 29.01, 0.42, 1.47, now },
                new object[] { "Altria Group Inc", "1/1 12:00am", "Up", 83.81, 0.28, 0.34, now },
                new object[] { "American Express Company", "1/1 12:00am", "Up", 52.55, 0.01, 0.02, now },
                new object[] { "American International Group, Inc.", "1/1 12:00am", "Up", 64.13, 0.31, 0.49, now },
                new object[] { "AT&T Inc.", "1/1 12:00am", "Down", 31.61, -0.48, -1.54, now },
                new object[] { "Boeing Co.", "1/1 12:00am", "Up", 75.43, 0.53, 0.71, now },
                new object[] { "Caterpillar Inc.", "1/1 12:00am", "Up", 67.27, 0.92, 1.39, now },
                new object[] { "Citigroup, Inc.", "1/1 12:00am", "Up", 49.37, 0.02, 0.04, now },
                new object[] { "E.I. du Pont de Nemours and Company", "1/1 12:00am", "Up", 40.48, 0.51, 1.28, now },
                new object[] { "Exxon Mobil Corp", "1/1 12:00am", "Down", 68.1, -0.43, -0.64, now },
                new object[] { "General Electric Company", "1/1 12:00am", "Down", 34.14, -0.08, -0.23, now },
                new object[] { "General Motors Corporation", "1/1 12:00am", "Up", 30.27, 1.09, 3.74, now },
                new object[] { "Hewlett-Packard Co.", "1/1 12:00am", "Down", 36.53, -0.03, -0.08, now },
                new object[] { "Honeywell Intl Inc", "1/1 12:00am", "Up", 38.77, 0.05, 0.13, now },
                new object[] { "Intel Corporation", "1/1 12:00am", "Up", 19.88, 0.31, 1.58, now },
                new object[] { "International Business Machines", "1/1 12:00am", "Up", 81.41, 0.44, 0.54, now },
                new object[] { "Johnson & Johnson", "1/1 12:00am", "Up", 64.72, 0.06, 0.09, now },
                new object[] { "JP Morgan & Chase & Co", "1/1 12:00am", "Up", 45.73, 0.07, 0.15, now },
                new object[] { "McDonald\"s Corporation", "1/1 12:00am", "Up", 36.76, 0.86, 2.40, now },
                new object[] { "Merck & Co., Inc.", "1/1 12:00am", "Up", 40.96, 0.41, 1.01, now },
                new object[] { "Microsoft Corporation", "1/1 12:00am", "Up", 25.84, 0.14, 0.54, now },
                new object[] { "Pfizer Inc", "1/1 12:00am", "Up", 27.96, 0.4, 1.45, now },
                new object[] { "The Coca-Cola Company", "1/1 12:00am", "Up", 45.07, 0.26, 0.58, now },
                new object[] { "The Home Depot, Inc.", "1/1 12:00am", "Up", 34.64, 0.35, 1.02, now },
                new object[] { "The Procter & Gamble Company", "1/1 12:00am", "Up", 61.91, 0.01, 0.02, now },
                new object[] { "United Technologies Corporation", "1/1 12:00am", "Up", 63.26, 0.55, 0.88, now },
                new object[] { "Verizon Communications", "1/1 12:00am", "Up", 35.57, 0.39, 1.11, now },
                new object[] { "Wal-Mart Stores, Inc.", "1/1 12:00am", "Up", 45.45, 0.73, 1.63, now }
            };
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.TestData;
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Cell to Cell Drag and Drop - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Drag and Drop from Cell to Cell within the same GridView</h1>
        <p>This illustrates how a custom plugin can enable a cell to cell drag and drop operation within the same GridView.</p>
        <p>This example only allows a drag and drop operation for cells with the same data type, although that is configurable. The custom plugin allows for other configs, please see the comments in the source.</p>

        <ext:GridPanel
            runat="server"
            Width="800"
            Height="400">
            <Store>
                <ext:Store
                    ID="Store1"
                    runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="company" Type="String" />
                                <ext:ModelField Name="firstChange" Type="Date" DateFormat="M/d hh:mmtt" />
                                <ext:ModelField Name="stock" />
                                <ext:ModelField Name="price" Type="Float" />
                                <ext:ModelField Name="change" Type="Float" />
                                <ext:ModelField Name="pctChange" Type="Float" />
                                <ext:ModelField Name="lastChange" Type="Date" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Company" DataIndex="company" Width="160" />
                    <ext:DateColumn runat="server" Text="First Updated" DataIndex="firstChange" Width="235" />
                    <ext:Column runat="server" Text="Price" DataIndex="price" Width="75" />
                    <ext:Column runat="server" Text="Stock " DataIndex="stock" Width="75" />
                    <ext:Column runat="server" Text="Change" DataIndex="change" Width="75" />
                    <ext:Column runat="server" Text="% Change" DataIndex="pctChange" Width="75" />
                    <ext:DateColumn runat="server" Text="Last Updated" DataIndex="lastChange" Width="235" />
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server">
                    <Plugins>
                        <ext:CellDragDrop runat="server" ApplyEmptyText="true" EnforceType="true" />
                    </Plugins>
                </ext:GridView>
            </View>
        </ext:GridPanel>
    </form>
</body>
</html>