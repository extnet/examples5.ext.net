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
            Title="Company data"
            Width="1000"
            BodyPadding="5"
            Layout="Column">

            <FieldDefaults LabelAlign="Left" MsgTarget="Side" />

            <Items>
                <ext:GridPanel
                    runat="server"
                    Title="Company Data"
                    ColumnWidth="0.6"
                    Height="400">
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
                            <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1" />
                            <ext:Column runat="server" Text="Price" Width="75" DataIndex="price">
                                <Renderer Format="UsMoney" />
                            </ext:Column>
                            <ext:Column runat="server" Text="Change" Width="75" DataIndex="change">
                                <Renderer Fn="change" />
                            </ext:Column>
                            <ext:Column runat="server" Text="Change" Width="75" DataIndex="pctChange">
                                <Renderer Fn="pctChange" />
                            </ext:Column>
                            <ext:DateColumn runat="server" Text="Last Updated" Width="95" DataIndex="lastChange" />
                            <ext:Column runat="server" Text="Rating" Width="50" Sortable="true" DataIndex="rating">
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
                    ColumnWidth="0.4"
                    Title="Company details"
                    MarginSpec="0 0 0 10"
                    ButtonAlign="Right">
                    <Defaults>
                        <ext:Parameter Name="LabelWidth" Value="115" />
                    </Defaults>
                    <Items>
                        <ext:TextField Name="company" runat="server" FieldLabel="Name" />
                        <ext:TextField Name="price" runat="server" FieldLabel="Price" />
                        <ext:TextField Name="pctChange" runat="server" FieldLabel="Change (%)" />
                        <ext:DateField Name="lastChange" runat="server" FieldLabel="Last Updated" />
                        <ext:RadioGroup runat="server" FieldLabel="Rating (read-only)" ColumnsNumber="3" AutomaticGrouping="false">
                            <Items>
                                <ext:Radio runat="server" Name="rating" InputValue="0" BoxLabel="A" ReadOnly="true" />
                                <ext:Radio runat="server" Name="rating" InputValue="1" BoxLabel="B" ReadOnly="true" />
                                <ext:Radio runat="server" Name="rating" InputValue="2" BoxLabel="C" ReadOnly="true" />
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
                        <ext:Menu runat="server">
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