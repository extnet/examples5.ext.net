<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            object[] data = this.GetData();

            Store store1 = this.GridPanel1.GetStore();
            Store store2 = this.ComboBox1.GetStore();

            store1.DataSource = data;
            store1.DataBind();

            store2.DataSource = data;
            store2.DataBind();
        }
    }

    public object[] GetData()
    {
        return new object[] {
            new object[] { "3m Co", 71.72, 0.02, 0.03, "01/01/2008" },
            new object[] { "Alcoa Inc", 29.01, 0.42, 1.47, "02/01/2008" },
            new object[] { "Altria Group Inc", 83.81, 0.28, 0.34, "03/01/2008" },
            new object[] { "American Express Company", 52.55, 0.01, 0.02, "10/01/2008" },
            new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49, "09/01/2008" },
            new object[] { "AT&T Inc.", 31.61, -0.48, -1.54, "01/03/2008" },
            new object[] { "Boeing Co.", 75.43, 0.53, 0.71, "01/04/2008" },
            new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39, "01/01/2008" },
            new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04, "02/02/2008" },
            new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, "03/05/2008" },
            new object[] { "Exxon Mobil Corp", 68.1, -0.43, -0.64, "01/01/2008" },
            new object[] { "General Electric Company", 34.14, -0.08, -0.23, "01/01/2008" },
            new object[] { "General Motors Corporation", 30.27, 1.09, 3.74, "01/01/2008" },
            new object[] { "Hewlett-Packard Co.", 36.53, -0.03, -0.08, "01/01/2008" },
            new object[] { "Honeywell Intl Inc", 38.77, 0.05, 0.13, "01/01/2008" },
            new object[] { "Intel Corporation", 19.88, 0.31, 1.58, "01/01/2008" },
            new object[] { "International Business Machines", 81.41, 0.44, 0.54, "01/01/2008" },
            new object[] { "Johnson & Johnson", 64.72, 0.06, 0.09, "01/01/2008" },
            new object[] { "JP Morgan & Chase & Co", 45.73, 0.07, 0.15, "01/01/2008" },
            new object[] { "McDonald\"s Corporation", 36.76, 0.86, 2.40, "01/01/2008" },
            new object[] { "Merck & Co., Inc.", 40.96, 0.41, 1.01, "01/01/2008" },
            new object[] { "Microsoft Corporation", 25.84, 0.14, 0.54, "01/01/2008" },
            new object[] { "Pfizer Inc", 27.96, 0.4, 1.45, "01/01/2008" },
            new object[] { "The Coca-Cola Company", 45.07, 0.26, 0.58, "01/01/2008" },
            new object[] { "The Home Depot, Inc.", 34.64, 0.35, 1.02, "01/01/2008" },
            new object[] { "The Procter & Gamble Company", 61.91, 0.01, 0.02, "01/01/2008" },
            new object[] { "United Technologies Corporation", 63.26, 0.55, 0.88, "01/01/2008" },
            new object[] { "Verizon Communications", 35.57, 0.39, 1.11, "01/01/2008" },
            new object[] { "Wal-Mart Stores, Inc.", 45.45, 0.73, 1.63, "01/01/2008" }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>GridPanel with MultiHeader Row Filters - Ext.NET Examples</title>
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

    <ext:XScript runat="server">
        <script>

            var applyFilter = function (field) {
                var store = #{GridPanel1}.getStore();
                store.filterBy(getRecordFilter());
            };

            var clearFilter = function () {
                #{ComboBox1}.reset();
                #{PriceFilter}.reset();
                #{ChangeFilter}.reset();
                #{PctChangeFilter}.reset();
                #{LastChangeFilter}.reset();

                #{Store1}.clearFilter();
            }

            var filterString = function (value, dataIndex, record) {
                var val = record.get(dataIndex);

                if (typeof val != "string") {
                    return value.length == 0;
                }

                return val.toLowerCase().indexOf(value.toLowerCase()) > -1;
            };

            var filterDate = function (value, dataIndex, record) {
                var val = Ext.Date.clearTime(record.get(dataIndex), true).getTime();

                if (!Ext.isEmpty(value, false) && val != Ext.Date.clearTime(value, true).getTime()) {
                    return false;
                }
                return true;
            };

            var filterNumber = function (value, dataIndex, record) {
                var val = record.get(dataIndex);

                if (!Ext.isEmpty(value, false) && val != value) {
                    return false;
                }

                return true;
            };

            var getRecordFilter = function () {
                var f = [];

                f.push({
                    filter: function (record) {
                        return filterString(#{ComboBox1}.getValue()||"", "company", record);
                    }
                });

                f.push({
                    filter: function (record) {
                        return filterNumber(#{PriceFilter}.getValue(), "price", record);
                    }
                });

                f.push({
                    filter: function (record) {
                        return filterNumber(#{ChangeFilter}.getValue(), "change", record);
                    }
                });

                f.push({
                    filter: function (record) {
                        return filterNumber(#{PctChangeFilter}.getValue(), "pctChange", record);
                    }
                });

                f.push({
                    filter: function (record) {
                        return filterDate(#{LastChangeFilter}.getValue(), "lastChange", record);
                    }
                });

                var len = f.length;

                return function (record) {
                    for (var i = 0; i < len; i++) {
                        if (!f[i].filter(record)) {
                            return false;
                        }
                    }
                    return true;
                };
            };
        </script>
    </ext:XScript>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Array Grid"
            Width="625"
            Height="480">
            <ResizableConfig Handles="East" />
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="company" />
                                <ext:ModelField Name="price" Type="Float" />
                                <ext:ModelField Name="change" Type="Float" />
                                <ext:ModelField Name="pctChange" Type="Float" />
                                <ext:ModelField Name="lastChange" Type="Date" DateFormat="MM/dd/yyyy" />
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
                        Flex="1">
                        <Items>
                            <ext:ComboBox
                                ID="ComboBox1"
                                runat="server"
                                Icon="Magnifier"
                                TriggerAction="All"
                                QueryMode="Local"
                                DisplayField="company"
                                ValueField="company">
                                <Store>
                                    <ext:Store runat="server">
                                        <Model>
                                            <ext:Model runat="server">
                                                <Fields>
                                                    <ext:ModelField Name="company" />
                                                </Fields>
                                            </ext:Model>
                                        </Model>
                                    </ext:Store>
                                </Store>
                                <Listeners>
                                    <Change Handler="applyFilter(this);" Buffer="250" />
                                </Listeners>
                                <Plugins>
                                    <ext:ClearButton runat="server" />
                                </Plugins>
                            </ext:ComboBox>
                        </Items>
                    </ext:Column>
                    <ext:Column runat="server" Text="Price" Width="75" DataIndex="price">
                        <Renderer Format="UsMoney" />
                        <Items>
                            <ext:TextField ID="PriceFilter" runat="server">
                                <Listeners>
                                    <Change Handler="applyFilter(this);" Buffer="250" />
                                </Listeners>
                                <Plugins>
                                    <ext:ClearButton runat="server" />
                                </Plugins>
                            </ext:TextField>
                        </Items>
                    </ext:Column>
                    <ext:Column runat="server" Text="Changes">
                        <Columns>
                            <ext:Column runat="server" Text="Change" Width="75" DataIndex="change" HideTitleEl="true">
                                <Renderer Fn="change" />
                                <Items>
                                    <ext:TextField ID="ChangeFilter" runat="server">
                                        <Listeners>
                                            <Change Handler="applyFilter(this);" Buffer="250" />
                                        </Listeners>
                                        <Plugins>
                                            <ext:ClearButton runat="server" />
                                        </Plugins>
                                    </ext:TextField>
                                </Items>
                            </ext:Column>
                            <ext:Column runat="server" Text="Change %" Width="75" DataIndex="pctChange" HideTitleEl="true">
                                <Renderer Fn="pctChange" />
                                <Items>
                                    <ext:TextField ID="PctChangeFilter" runat="server">
                                        <Listeners>
                                            <Change Handler="applyFilter(this);" Buffer="250" />
                                        </Listeners>
                                        <Plugins>
                                            <ext:ClearButton runat="server" />
                                        </Plugins>
                                    </ext:TextField>
                                </Items>
                            </ext:Column>
                        </Columns>
                    </ext:Column>
                    <ext:DateColumn runat="server" Text="Last Updated" Width="120" DataIndex="lastChange">
                        <Items>
                            <ext:DateField ID="LastChangeFilter" runat="server" Editable="false">
                                <Listeners>
                                    <Change Handler="applyFilter(this);" />
                                </Listeners>
                                <Plugins>
                                    <ext:ClearButton runat="server" />
                                </Plugins>
                            </ext:DateField>
                        </Items>
                    </ext:DateColumn>
                    <ext:Column runat="server" Width="25" DataIndex="company" Sortable="false" MenuDisabled="true" Text="&nbsp;" Resizable="false">
                        <Renderer Handler="return '';" />
                        <Items>
                            <ext:Container runat="server">
                                <Items>
                                    <ext:Button ID="ClearFilterButton" runat="server" Icon="Cancel">
                                        <ToolTips>
                                            <ext:ToolTip runat="server" Html="Clear filter" />
                                        </ToolTips>

                                        <Listeners>
                                            <Click Handler="clearFilter(null);" />
                                        </Listeners>
                                    </ext:Button>
                                </Items>
                            </ext:Container>
                        </Items>
                    </ext:Column>
                </Columns>
            </ColumnModel>
        </ext:GridPanel>
    </form>
</body>
</html>