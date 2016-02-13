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
                new object[] { "E.I. du Pont de Nemours and Company", 40.48, 0.51, 1.28, "9/1 12:00am" }
            };

            this.Store1.DataBind();

            this.ResourceManager1.RegisterIcon(Icon.Accept);
            this.ResourceManager1.RegisterIcon(Icon.MoneyEuro);
            this.ResourceManager1.RegisterIcon(Icon.MoneyAdd);
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Prepare Commands - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var prepareToolbar = function (grid, toolbar, rowIndex, record) {
            // for example hide 'Edit' button if price < 50
            if (record.get("price") < 50) {
                //hide separator
                toolbar.items.getAt(1).hide();
                //hide edit button
                toolbar.items.getAt(2).hide();
            } else {
                //otherwise add another button
                toolbar.add(new Ext.Button({
                    iconCls : "icon-accept",
                    command : "accept"
                }));

                toolbar.updateLayout();
            }
        };

        //in PrepareCommands we can modify commands collection
        var prepareCommands = function (grid, commands, record, row) {
            if (record.get("price") >= 50) {
                commands.push({
                        command : "accept",
                        iconCls : "icon-accept"
                });
            }
        };

        //in PrepareCommand we can modify command
        var prepareCommand = function (grid, command, record, row) {
            if (command.command == 'Edit' && record.get("price") < 50) {
                command.hidden = true;
                command.hideMode = 'display'; //you can try 'visibility' also
            }
        };

        var prepareCellCommand = function (grid, command, record, row, col, value) {
            if (command.command == 'Dollar' && record.get("price") < 50) {
                command.iconCls = "icon-moneyeuro";
            }
        };

        var prepareCellCommands = function (grid, commands, record, row, col, value) {
            if (record.get("price") >= 50) {
               commands.push({
                   iconCls : "icon-moneyadd",
                   command : "moneyadd"
               });
            }
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager ID="ResourceManager1" runat="server" />

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

        <ext:GridPanel
            runat="server"
            StoreID="Store1"
            Title="Row commands"
            Width="800"
            Height="300">
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="Company" DataIndex="company" Flex="1" />
                    <ext:Column runat="server" Text="Price" Width="100" DataIndex="price">
                        <Renderer Format="UsMoney" />

                        <Commands>
                            <ext:ImageCommand Icon="MoneyDollar" CommandName="Dollar" />
                        </Commands>

                        <PrepareCommand Fn="prepareCellCommand" />
                        <PrepareCommands Fn="prepareCellCommands" />

                        <Listeners>
                            <Command Handler="Ext.Msg.alert(command, record.data.company);" />
                        </Listeners>
                    </ext:Column>
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="change" />
                    <ext:Column runat="server" Text="Change" Width="75" DataIndex="pctChange" />
                    <ext:DateColumn runat="server" Text="Last Updated" Width="85" DataIndex="lastChange" />

                    <ext:ImageCommandColumn runat="server" Width="100" Text="Image Cmds">
                        <Commands>
                            <ext:ImageCommand Icon="Delete" CommandName="Delete">
                                <ToolTip Text="Delete" />
                            </ext:ImageCommand>
                             <ext:ImageCommand Icon="NoteEdit" CommandName="Edit">
                                <ToolTip Text="Edit" />
                            </ext:ImageCommand>
                        </Commands>
                        <PrepareCommand Fn="prepareCommand" />
                        <PrepareCommands Fn="prepareCommands" />
                        <Listeners>
                            <Command Handler="Ext.Msg.alert(command, record.data.company);" />
                        </Listeners>
                    </ext:ImageCommandColumn>

                    <ext:CommandColumn runat="server" Width="100" Text="Toolbar Cmds">
                        <Commands>
                            <ext:GridCommand Icon="Delete" CommandName="Delete">
                                <ToolTip Text="Delete" />
                            </ext:GridCommand>
                            <ext:CommandSeparator />
                            <ext:GridCommand Icon="NoteEdit" CommandName="Edit">
                                <ToolTip Text="Edit" />
                            </ext:GridCommand>
                        </Commands>
                        <PrepareToolbar Fn="prepareToolbar" />
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