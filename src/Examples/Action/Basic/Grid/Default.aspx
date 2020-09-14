<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.Data;
            this.Store1.DataBind();
        }
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
    <title>Using Actions - Ext.NET Examples</title>

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
    <ext:ResourceManager runat="server" />

    <h1>Actions Example</h1>

    <p>This example shows how to create multiple active UI event handling widgets from a single Action definition.</p>

    <p>
        Both Buttons and MenuItems can be created from the same Action instance. Action's enable, disable, hide, show and
    setText methods affect every Component created from that Action.</p>

    <p>In this example, the Action is disabled when there is no grid selection, and this disables both Buttons and MenuItems.</p>

    <ext:Action
        ID="SellAction"
        runat="server"
        Icon="Delete"
        Text="Sell stock"
        Disabled="true"
        Handler="var rec = #{GridPanel1}.getSelectionModel().getSelection()[0]; if (rec) { Ext.Msg.alert('Sell', 'Sell ' + rec.get('company')); }"
        />

    <ext:Action
        ID="BuyAction"
        runat="server"
        Icon="Accept"
        Text="Buy stock"
        Disabled="true"
        Handler="var rec = #{GridPanel1}.getSelectionModel().getSelection()[0]; if (rec) { Ext.Msg.alert('Buy', 'Buy ' + rec.get('company')); }"
        />

    <ext:Menu ID="ContextMenu" runat="server">
        <Items>
            <ext:ActionRef runat="server" Action="#{BuyAction}" />
            <ext:ActionRef runat="server" Action="#{SellAction}" />
        </Items>
    </ext:Menu>

    <ext:GridPanel
        ID="GridPanel1"
        runat="server"
        ColumnLines="true"
        Title="Action Grid"
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
                            <ext:ModelField Name="lastChange" Type="Date" DateFormat="yyyy-MM-dd hh:mm:tt" />
                        </Fields>
                    </ext:Model>
                </Model>
            </ext:Store>
        </Store>
        <ColumnModel>
            <Columns>
                <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1" />
                <ext:Column runat="server" Text="Price" DataIndex="price">
                    <Renderer Format="UsMoney" />
                </ext:Column>
                <ext:Column runat="server" Text="Change" DataIndex="change">
                    <Renderer Fn="change" />
                </ext:Column>
                <ext:Column runat="server" Text="Change" DataIndex="pctChange">
                    <Renderer Fn="pctChange" />
                </ext:Column>
                <ext:DateColumn runat="server" Text="Last Updated" DataIndex="lastChange" />
            </Columns>
        </ColumnModel>
        <SelectionModel>
            <ext:RowSelectionModel runat="server">
                <Listeners>
                    <SelectionChange Handler="if (selected.length) { #{BuyAction}.enable(); #{SellAction}.enable(); } else { #{BuyAction}.disable(); #{SellAction}.disable(); }" />
                </Listeners>
            </ext:RowSelectionModel>
        </SelectionModel>
        <ViewConfig StripeRows="true">
            <Listeners>
                <ItemContextMenu Handler="e.stopEvent(); #{ContextMenu}.showAt(e.getXY()); return false;" />
            </Listeners>
        </ViewConfig>
        <DockedItems>
            <ext:Toolbar runat="server">
                <Items>
                    <ext:ActionRef runat="server" Action="#{BuyAction}" />
                    <ext:ActionRef runat="server" Action="#{SellAction}" />
                </Items>
            </ext:Toolbar>
        </DockedItems>
    </ext:GridPanel>
</body>
</html>
