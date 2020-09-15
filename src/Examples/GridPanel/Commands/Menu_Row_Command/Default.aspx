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
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") }
            };

            this.Store1.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Menu Row Command - Ext.NET Examples</title>
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

        <h1>Menu Row Command</h1>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Menu Row Command"
            Width="720"
            Height="420">
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
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column
                        runat="server"
                        Text="Company"
                        Width="160"
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
                        DataIndex="change">
                        <Renderer Fn="change" />
                    </ext:Column>
                    <ext:Column
                        runat="server"
                        Text="Change"
                        Width="75"
                        DataIndex="pctChange">
                        <Renderer Fn="pctChange" />
                    </ext:Column>
                    <ext:DateColumn
                        runat="server"
                        Text="Last Updated"
                        Width="85"
                        DataIndex="lastChange"
                        />
                    <ext:CommandColumn runat="server" Width="120">
                        <Commands>
                            <ext:GridCommand IconCls="x-md md-icon-arrow-circle-down">
                                <Menu EnableScrolling="false">
                                    <Items>
                                        <ext:MenuCommand Text="Item1" IconCls="x-md md-icon-arrow-forward" CommandName="Item1" />
                                        <ext:MenuCommand Text="Submenu" IconCls="x-md md-icon-arrow-forward">
                                            <Menu EnableScrolling="false">
                                                <Items>
                                                    <ext:MenuCommand Text="Item11" IconCls="x-md md-icon-arrow-forward" CommandName="Item11" />
                                                    <ext:MenuCommand Text="Item12" IconCls="x-md md-icon-arrow-forward" CommandName="Item12" />
                                                </Items>
                                            </Menu>
                                        </ext:MenuCommand>
                                    </Items>
                                </Menu>
                                <ToolTip Text="Menu" />
                            </ext:GridCommand>

                            <ext:CommandSeparator />

                            <ext:SplitCommand IconCls="x-md md-icon-arrow-circle-down" CommandName="Split">
                                <Menu EnableScrolling="false">
                                    <Items>
                                        <ext:MenuCommand Text="Item" IconCls="x-md md-icon-arrow-forward" CommandName="Item" />
                                        <ext:MenuCommand Text="Submenu" IconCls="x-md md-icon-arrow-forward">
                                            <Menu EnableScrolling="false">
                                                <Items>
                                                    <ext:MenuCommand Text="Item" IconCls="x-md md-icon-arrow-forward" CommandName="Item" />
                                                    <ext:MenuCommand Text="Item" IconCls="x-md md-icon-arrow-forward" CommandName="Item" />
                                                </Items>
                                            </Menu>
                                        </ext:MenuCommand>
                                    </Items>
                                </Menu>
                                <ToolTip Text="Split" />
                            </ext:SplitCommand>
                        </Commands>
                        <Listeners>
                            <Command Handler="Ext.Msg.alert(command, record.data.company);" />
                        </Listeners>
                    </ext:CommandColumn>
                </Columns>
            </ColumnModel>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" Mode="Single" />
            </SelectionModel>
        </ext:GridPanel>
    </form>
</body>
</html>