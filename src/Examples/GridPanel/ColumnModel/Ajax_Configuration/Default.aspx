<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03, "9/1 12:00am" },
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, "9/1 12:00am" },
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, "9/1 12:00am" },
                new object[] { "American Express Company", 52.55, 0.01, 0.02, "9/1 12:00am" },
                new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49, "9/1 12:00am" },
                new object[] { "AT&T Inc.", 31.61, -0.48, -1.54, "9/1 12:00am" },
                new object[] { "Boeing Co.", 75.43, 0.53, 0.71, "9/1 12:00am" },
                new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39, "9/1 12:00am" },
                new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04, "9/1 12:00am" },
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, "9/1 12:00am" },
                new object[] { "Exxon Mobil Corp", 68.1, -0.43, -0.64, "9/1 12:00am" },
                new object[] { "General Electric Company", 34.14, -0.08, -0.23, "9/1 12:00am" },
                new object[] { "General Motors Corporation", 30.27, 1.09, 3.74, "9/1 12:00am" },
                new object[] { "Hewlett-Packard Co.", 36.53, -0.03, -0.08, "9/1 12:00am" },
                new object[] { "Honeywell Intl Inc", 38.77, 0.05, 0.13, "9/1 12:00am" },
                new object[] { "Intel Corporation", 19.88, 0.31, 1.58, "9/1 12:00am" },
                new object[] { "International Business Machines", 81.41, 0.44, 0.54, "9/1 12:00am" },
                new object[] { "Johnson & Johnson", 64.72, 0.06, 0.09, "9/1 12:00am" },
                new object[] { "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, "9/1 12:00am" },
                new object[] { "McDonald\"s Corporation", 36.76, 0.86, 2.40, "9/1 12:00am" },
                new object[] { "Merck & Co., Inc.", 40.96, 0.41, 1.01, "9/1 12:00am" },
                new object[] { "Microsoft Corporation", 25.84, 0.14, 0.54, "9/1 12:00am" },
                new object[] { "Pfizer Inc", 27.96, 0.4, 1.45, "9/1 12:00am" },
                new object[] { "The Coca-Cola Company", 45.07, 0.26, 0.58, "9/1 12:00am" },
                new object[] { "The Home Depot, Inc.", 34.64, 0.35, 1.02, "9/1 12:00am" },
                new object[] { "The Procter & Gamble Company", 61.91, 0.01, 0.02, "9/1 12:00am" },
                new object[] { "United Technologies Corporation", 63.26, 0.55, 0.88, "9/1 12:00am" },
                new object[] { "Verizon Communications", 35.57, 0.39, 1.11, "9/1 12:00am" },
                new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, "9/1 12:00am" }
            };
        }
    }

    protected void ToggleChange(object sender, DirectEventArgs e)
    {
        Ext.Net.Button button = sender as Ext.Net.Button;
        this.GridPanel1.ColumnModel.Columns[2].Hidden = button.Pressed;
        button.Text = button.Pressed ? "Show Change" : "Hide Change";
    }

    protected void ChangeHeader(object sender, DirectEventArgs e)
    {
        Ext.Net.Button button = sender as Ext.Net.Button;
        this.GridPanel1.ColumnModel.Columns[0].Text = "New label";
        button.Disabled = true;
    }

    protected void ChangeWidth(object sender, DirectEventArgs e)
    {
        Ext.Net.Button button = sender as Ext.Net.Button;
        this.GridPanel1.ColumnModel.Columns[1].Width = 100;
        button.Disabled = true;
    }

    protected void ChangeRenderer(object sender, DirectEventArgs e)
    {
        Ext.Net.Button button = sender as Ext.Net.Button;
        Renderer r = new Renderer();
        r.Fn = "change";
        this.GridPanel1.ColumnModel.Columns[2].Renderer = r;
        button.Disabled = true;
    }

    protected void SetNewPattern(object sender, DirectEventArgs e)
    {
        this.CompanyColumn.Pattern = "{value:ellipsis(20)}";
        this.GridPanel1.Refresh();
        (sender as Ext.Net.Button).Disabled = true;
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Configure Columns on the fly - Ext.NET Examples</title>
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

        <h1>Configuring GridPanel's Columns on the fly via DirectEvents</h1>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Array Grid"
            Width="600"
            Height="350">
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
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        ID="CompanyColumn"
                        runat="server"
                        Text="Company"
                        Width="160"
                        DataIndex="company"
                        Flex="1"
                        Pattern="{value:uppercase}"
                        />

                    <ext:Column
                        ID="PriceColumn"
                        runat="server"
                        Text="Price"
                        Width="75"
                        DataIndex="price">
                        <Renderer Format="UsMoney" />
                    </ext:Column>

                    <ext:Column
                        ID="ChangeColumn"
                        runat="server"
                        Text="Change"
                        Width="75"
                        DataIndex="change"
                        />

                    <ext:Column
                        ID="ChangePrtColumn"
                        runat="server"
                        Text="Change %"
                        Width="75"
                        DataIndex="pctChange"
                        />

                    <ext:DateColumn
                        ID="LastChangeColumn"
                        runat="server"
                        Text="Last Updated"
                        Width="85"
                        DataIndex="lastChange"
                        />
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" StripeRows="true" TrackOver="true" />
            </View>
            <BottomBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button
                            runat="server"
                            Text="Change Header">
                            <DirectEvents>
                                <Click OnEvent="ChangeHeader" Single="true" />
                            </DirectEvents>
                        </ext:Button>

                        <ext:Button
                            runat="server"
                            Text="Change Width">
                            <DirectEvents>
                                <Click OnEvent="ChangeWidth" Single="true" />
                            </DirectEvents>
                        </ext:Button>

                         <ext:Button
                            runat="server"
                            Text="Change Renderer">
                            <DirectEvents>
                                <Click OnEvent="ChangeRenderer" Success="#{GridPanel1}.getView().refresh(false);" />
                            </DirectEvents>
                        </ext:Button>

                        <ext:Button
                            runat="server"
                            Text="Hide 'Change'"
                            EnableToggle="true"
                            OnDirectClick="ToggleChange"
                            />

                         <ext:Button
                            runat="server"
                            Text="Set New Pattern"
                            OnDirectClick="SetNewPattern"
                            />
                    </Items>
                </ext:Toolbar>
            </BottomBar>
        </ext:GridPanel>
    </form>
</body>
</html>
