<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        this.GridPanel1.GetStore().DataSource = new object[]
        {
            new object[] { "Sample 1" },
            new object[] { "Sample 2" },
            new object[] { "Sample 3" },
            new object[] { "Sample 4" },
            new object[] { "Sample 5" },
            new object[] { "Sample 6" },
            new object[] { "Sample 7" },
            new object[] { "Sample 8" },
            new object[] { "Sample 9" },
            new object[] { "Sample 10" },
            new object[] { "Sample 11" },
            new object[] { "Sample 12" },
            new object[] { "Sample 13" },
            new object[] { "Sample 14" },
            new object[] { "Sample 15" }
        };
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Marking Records - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <style>
        .dirty-row .x-grid-cell, .dirty-row .x-grid-rowwrap-div {
            background-color: #FFFDD8 !important;
        }

        .new-row .x-grid-cell, .new-row .x-grid-rowwrap-div {
            background: #c8ffc8 !important;
        }
    </style>
</head>
<body>
    <form runat="server">
        <script>
            var getRowClass = function (record) {
                if (record.phantom) {
                    return "new-row";
                }

                if (record.dirty) {
                    return "dirty-row";
                }
            };

            var insertRecord = function () {
                var grid = <%= GridPanel1.ClientID %>;

                grid.store.insert(0, {});
                grid.getView().focusRow(0);
                grid.editingPlugin.startEdit(grid.store.getAt(0), grid.columns[0]);
            };
        </script>

        <ext:ResourceManager runat="server" />

        <h1>Marking Records</h1>

        <p>Demonstrates how to mark rows with custom colors. Edit any cell or insert new record.</p>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Title="Test Grid"
            Width="600"
            Height="350">
            <Store>
                <ext:Store runat="server">
                    <Model>
                        <ext:Model runat="server" IDProperty="TestCell">
                            <Fields>
                                <ext:ModelField Name="TestCell" />
                            </Fields>
                        </ext:Model>
                    </Model>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:Column runat="server" Text="TestCell" DataIndex="TestCell" Flex="1">
                        <Editor>
                            <ext:TextField runat="server" />
                        </Editor>
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" StripeRows="true">
                    <GetRowClass Fn="getRowClass" />
                </ext:GridView>
            </View>
            <Plugins>
                <ext:CellEditing runat="server" ClicksToEdit="1">
                    <Listeners>
                        <Edit Handler="e.grid.getView().refresh();" />
                    </Listeners>
                </ext:CellEditing>
            </Plugins>
            <Buttons>
                <ext:Button runat="server" Text="Insert record" Icon="Add">
                    <Listeners>
                        <Click Fn="insertRecord" />
                    </Listeners>
                </ext:Button>
            </Buttons>
        </ext:GridPanel>
    </form>
</body>
</html>