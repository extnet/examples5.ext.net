<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.Data;
        }
    }

    private object[] Data
    {
        get
        {
            return new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03, "9/1 12:00am", "9a2f3b" },
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, "9/1 12:00am", "76a8bb" },
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, "9/1 12:00am", "c7ab99" },
                new object[] { "American Express Company", 52.55, 0.01, 0.02, "9/1 12:00am", "00d8c7" },
                new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49, "9/1 12:00am", "bb802a" },
                new object[] { "AT&T Inc.", 31.61, -0.48, -1.54, "9/1 12:00am", "ab007f" },
                new object[] { "Boeing Co.", 75.43, 0.53, 0.71, "9/1 12:00am", "deadbe" },
                new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39, "9/1 12:00am", "beefed" },
                new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04, "9/1 12:00am", "baffed" },
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, "9/1 12:00am", "80fabe" },
                new object[] { "Exxon Mobil Corp", 68.1, -0.43, -0.64, "9/1 12:00am", "bead00" },
                new object[] { "General Electric Company", 34.14, -0.08, -0.23, "9/1 12:00am", "bade23" },
                new object[] { "General Motors Corporation", 30.27, 1.09, 3.74, "9/1 12:00am", "7fbaed" },
                new object[] { "Hewlett-Packard Co.", 36.53, -0.03, -0.08, "9/1 12:00am", "badabe" },
                new object[] { "Honeywell Intl Inc", 38.77, 0.05, 0.13, "9/1 12:00am", "3f9aff" },
                new object[] { "Intel Corporation", 19.88, 0.31, 1.58, "9/1 12:00am", "f00f2d" },
                new object[] { "International Business Machines", 81.41, 0.44, 0.54, "9/1 12:00am", "eabed0" },
                new object[] { "Johnson & Johnson", 64.72, 0.06, 0.09, "9/1 12:00am", "0b0d3f" },
                new object[] { "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, "9/1 12:00am", "31337f" },
                new object[] { "McDonald\"s Corporation", 36.76, 0.86, 2.40, "9/1 12:00am", "facada" },
                new object[] { "Merck & Co., Inc.", 40.96, 0.41, 1.01, "9/1 12:00am", "00face" },
                new object[] { "Microsoft Corporation", 25.84, 0.14, 0.54, "9/1 12:00am", "deface" },
                new object[] { "Pfizer Inc", 27.96, 0.4, 1.45, "9/1 12:00am", "feeded" },
                new object[] { "The Coca-Cola Company", 45.07, 0.26, 0.58, "9/1 12:00am", "9b87ff" },
                new object[] { "The Home Depot, Inc.", 34.64, 0.35, 1.02, "9/1 12:00am", "f3ab4d" },
                new object[] { "The Procter & Gamble Company", 61.91, 0.01, 0.02, "9/1 12:00am", "b0c9aa" },
                new object[] { "United Technologies Corporation", 63.26, 0.55, 0.88, "9/1 12:00am", "00007f" },
                new object[] { "Verizon Communications", 35.57, 0.39, 1.11, "9/1 12:00am", "7f0000" },
                new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, "9/1 12:00am", "ff7f00" }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Grid Panel using Color Field - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .x-grid-row-over .x-grid-cell-inner {
            font-weight: bold;
        }
    </style>

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
    <ext:ResourceManager runat="server" />

    <h1>Grid Panel using Color Field in Component Column</h1>

    <ext:GridPanel
        runat="server"
        Title="Array Grid"
        Width="800"
        Height="600">
        <Store>
            <ext:Store ID="Store1" runat="server">
                <Model>
                    <ext:Model runat="server">
                        <Fields>
                            <ext:ModelField Name="company" />
                            <ext:ModelField Name="price" Type="Float" />
                            <ext:ModelField Name="change" Type="Float" />
                            <ext:ModelField Name="pctChange" Type="Float" />
                            <ext:ModelField Name="lastChange" Type="Date" DateFormat="M/d hh:mmtt" />
                            <ext:ModelField Name="color" />
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel>
            <Columns>
                <ext:Column runat="server" Text="Company" DataIndex="company" Flex="4" />
                <ext:Column runat="server" Text="Price" DataIndex="price" Flex="1">
                    <Renderer Format="UsMoney" />
                </ext:Column>
                <ext:Column runat="server" Text="Change" DataIndex="change" Flex="1">
                    <Renderer Fn="change" />
                </ext:Column>
                <ext:Column runat="server" Text="Change" DataIndex="pctChange" Flex="1">
                    <Renderer Fn="pctChange" />
                </ext:Column>
                <ext:DateColumn runat="server" Text="Last Updated" DataIndex="lastChange" Width="120" />
                <ext:ComponentColumn runat="server" Text="Company Color" DataIndex="color" Flex="2">
                    <Component>
                        <ext:ColorField runat="server" />
                    </Component>
                    <Listeners>
                        <Bind Handler="cmp.setValue(record.get('color'));" />
                    </Listeners>
                </ext:ComponentColumn>
            </Columns>
        </ColumnModel>
        <SelectionModel>
            <ext:RowSelectionModel runat="server" />
        </SelectionModel>
    </ext:GridPanel>
</body>
</html>
