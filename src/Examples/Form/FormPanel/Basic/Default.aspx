<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
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

            this.Store1.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>FormPanel - Ext.NET Examples</title>
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

        <ext:FormPanel
            runat="server"
            Title="Data"
            Width="960"
            Height="480"
            ButtonAlign="Center"
            Layout="hbox">
            <LayoutConfig>
                <ext:HBoxLayoutConfig Align="Stretch" />
            </LayoutConfig>
            <Items>
                <ext:GridPanel
                    runat="server"
                    Title="Company Data"
                    Header="false"
                    Flex="3">
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
                                        <ext:ModelField Name="rating" Type="Int">
                                            <Convert Handler="var pct = record.get('pctChange'); if (pct < 0) return 2; if (pct < 1) return 1; return 0;" />
                                        </ext:ModelField>
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
                                Flex="2"
                                />
                            <ext:Column
                                runat="server"
                                Text="Price"
                                Width="75"
                                DataIndex="price"
                                Flex="1">
                                <Renderer Format="UsMoney" />
                            </ext:Column>
                            <ext:Column
                                runat="server"
                                Text="Change"
                                Width="75"
                                DataIndex="change"
                                Flex="1">
                                <Renderer Fn="change" />
                            </ext:Column>
                            <ext:Column
                                runat="server"
                                Text="Rating"
                                Width="50"
                                Sortable="true"
                                DataIndex="rating"
                                Flex="1">
                                <Renderer Handler="if (value == 0) return 'A'; if (value == 1) return 'B'; if (value == 2) return 'C';" />
                            </ext:Column>
                        </Columns>
                    </ColumnModel>
                    <Listeners>
                        <SelectionChange Handler="if (selected[0]) { this.up('form').getForm().loadRecord(selected[0]); }" />
                    </Listeners>
                </ext:GridPanel>

                <ext:FieldSet
                    runat="server"
                    Title="Details"
                    Flex="2"
                    MarginSpec="0 20 0 20"
                    ButtonAlign="Right">
                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="130" />
                    </Defaults>
                    <Items>
                        <ext:TextField Name="company" runat="server" FieldLabel="Name" />
                        <ext:TextField Name="price" runat="server" FieldLabel="Price" />
                        <ext:TextField Name="pctChange" runat="server" FieldLabel="Change" />
                        <ext:DateField
                            Name="lastChange"
                            runat="server"
                            FieldLabel="Last Updated"
                            Format="yyyy-MM-dd"
                            />
                        <ext:RadioGroup
                            runat="server"
                            FieldLabel="Rating"
                            ColumnsNumber="3"
                            AutomaticGrouping="false">
                            <Items>
                                <ext:Radio
                                    runat="server"
                                    Name="rating"
                                    InputValue="0"
                                    BoxLabel="A"
                                    ReadOnly="true"
                                    />
                                <ext:Radio
                                    runat="server"
                                    Name="rating"
                                    InputValue="1"
                                    BoxLabel="B"
                                    ReadOnly="true"
                                    />
                                <ext:Radio
                                    runat="server"
                                    Name="rating"
                                    InputValue="2"
                                    BoxLabel="C"
                                    ReadOnly="true"
                                    />
                            </Items>
                        </ext:RadioGroup>
                    </Items>
                </ext:FieldSet>
            </Items>
            <Buttons>
                <ext:Button runat="server" Text="Save To Grid">
                    <Listeners>
                        <Click Handler="var form = this.up('form'),
                                            r = form.getForm().getRecord();

                                        if (r) {
                                            form.getForm().updateRecord(form.down('grid').getSelectionModel().getLastSelected());
                                        }" />
                    </Listeners>
                </ext:Button>
                <ext:Button runat="server" Text="Reset Fields">
                    <Listeners>
                        <Click Handler="this.up('form').getForm().reset();" />
                    </Listeners>
                </ext:Button>
                <ext:Button runat="server" Text="Get Values...">
                    <Menu>
                        <ext:Menu runat="server" Plain="true">
                            <Items>
                                <ext:MenuItem runat="server" Text="Object">
                                    <Listeners>
                                        <Click Handler="alert(Ext.encode(this.up('form').getForm().getValues()));" />
                                    </Listeners>
                                </ext:MenuItem>
                                <ext:MenuItem runat="server" Text="String">
                                    <Listeners>
                                        <Click Handler="alert(this.up('form').getForm().getValues(true));" />
                                    </Listeners>
                                </ext:MenuItem>
                            </Items>
                        </ext:Menu>
                    </Menu>
                </ext:Button>
            </Buttons>
        </ext:FormPanel>
    </form>
</body>
</html>