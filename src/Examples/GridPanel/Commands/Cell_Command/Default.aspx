<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { "3m Co", 71.72, 0.02, 0.03},
                new object[] { "Alcoa Inc", 29.01, 0.42, 1.47},
                new object[] { "Altria Group Inc", 83.81, 0.28, 0.34},
                new object[] { "American Express Company", 52.55, 0.01, 0.02},
                new object[] { "American International Group, Inc.", 64.13, 0.31, 0.49},
                new object[] { "AT&T Inc.", 31.61, -0.48, -1.54},
                new object[] { "Boeing Co.", 75.43, 0.53, 0.71},
                new object[] { "Caterpillar Inc.", 67.27, 0.92, 1.39},
                new object[] { "Citigroup, Inc.", 49.37, 0.02, 0.04},
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28}
            };

            this.Store1.DataBind();
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Basic Row Command - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var template = '<span style="color:{0};">{1}</span>';

        var change = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value);
        };

        var pctChange = function (value) {
            return Ext.String.format(template, (value > 0) ? "green" : "red", value + "%");
        };

        var prepare = function (grid, command, record, row, col, value) {
            if (value < 0 && command.command == "Dollar") {
                command.hidden = true;
                command.hideMode = "visibility";
            }
        };

        var onCommand = function (column, command, record, recordIndex, cellIndex) {
            Ext.Msg.alert('Command', 'Command = '+ command + '<br/>'+ 'Column = ' + column.gridRef.columns[cellIndex].dataIndex);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Cell commands"
            Width="720"
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
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1">
                        <Commands>
                            <ext:ImageCommand CommandName="Edit" Icon="NoteEdit" Text="Edit">
                                <ToolTip Text="Edit" />
                            </ext:ImageCommand>
                        </Commands>
                        <Listeners>
                            <Command Fn="onCommand" />
                        </Listeners>
                    </ext:Column>
                    <ext:Column runat="server" Text="Price" Width="100" DataIndex="price" Align="End" RightCommandAlign="false">
                        <Renderer Format="UsMoney" />
                        <Commands>
                            <ext:ImageCommand CommandName="Dollar" Icon="MoneyDollar" />
                            <ext:ImageCommand CommandName="Euro" Icon="MoneyEuro" />
                        </Commands>
                        <Listeners>
                            <Command Fn="onCommand" />
                        </Listeners>
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" Width="100" DataIndex="change" Align="End" RightCommandAlign="false">
                        <Renderer Fn="change" />
                        <Commands>
                            <ext:ImageCommand CommandName="Dollar" Icon="MoneyDollar" />
                            <ext:ImageCommand CommandName="Euro" Icon="MoneyEuro" />
                        </Commands>
                        <PrepareCommand Fn="prepare" />
                        <Listeners>
                            <Command Fn="onCommand" />
                        </Listeners>
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" DataIndex="pctChange" Align="End">
                        <Renderer Fn="pctChange" />
                        <Commands>
                            <ext:ImageCommand CommandName="Chart" Icon="ChartBar" Style="margin-left:5px !important;" />
                        </Commands>
                        <Listeners>
                            <Command Fn="onCommand" />
                        </Listeners>
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <SelectionModel>
               <ext:RowSelectionModel runat="server" Mode="Multi" />
            </SelectionModel>
        </ext:GridPanel>
    </form>
</body>
</html>