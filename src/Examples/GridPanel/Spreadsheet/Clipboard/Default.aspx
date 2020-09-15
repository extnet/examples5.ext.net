<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = new object[]
            {
                new object[] { "<b>3m Co</b>", 71.72, 0.02, 0.03, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "<b>Alcoa Inc</b>", 29.01, -0.42, -1.47, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "<b>Altria Group Inc</b>", 83.81, 0.28, 0.34, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "<b>American Express Company</b>", 52.55, -0.01, -0.02, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") },
                new object[] { "<b>American International Group, Inc.</b>", 64.13, 0.31, 0.49, DateTime.Now.ToString("yyyy-MM-dd hh:mm:tt") }
            };
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Spreadsheet Selection Model with Clipboard - Ext.NET Examples</title>
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

        var outputClipboardData = function () {
            var mode = App.RadioGroup1.getChecked()[0].inputValue;

            if (!App.SpreadsheetSelectionModel1.hasSelection()) {
                Ext.Msg.alert("No selection", "There is no selection");
                return;
            }

            App.Label1.setText(App.Clipboard1.getTextData(mode));
        };
    </script>
</head>
<body>
    <ext:ResourceManager runat="server" />

    <h1>Spreadsheet Selection Model with Clipboard</h1>

    <p>Select some cells in the GridPanel, then click the Output button.</p>

    <p>The Clipboard's output mode:</p>

    <ext:RadioGroup ID="RadioGroup1" runat="server" ColumnsNumber="1">
        <Items>
            <ext:Radio
                runat="server"
                BoxLabel="<b>cell</b> - Complete field data that can be matched to other grids using the same model regardless of column order"
                InputValue="cell"
                Checked="true"
                />

            <ext:Radio runat="server" BoxLabel="<b>text</b> - Cell content stripped of HTML tags." InputValue="text" />

            <ext:Radio runat="server" BoxLabel="<b>html</b> - Complete cell content, including any rendered HTML tags." InputValue="html" />

            <ext:Radio runat="server" BoxLabel="<b>raw</b> - Underlying field values based on dataIndex." InputValue="raw" />
        </Items>
    </ext:RadioGroup>

    <ext:GridPanel
        ID="GridPanel1"
        runat="server"
        Title="Array Grid"
        Width="720">
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
                <ext:DateColumn runat="server" Text="Last Updated" DataIndex="lastChange" Width="120" />
            </Columns>
        </ColumnModel>
        <SelectionModel>
            <ext:SpreadsheetSelectionModel ID="SpreadsheetSelectionModel1" runat="server" />
        </SelectionModel>
        <Plugins>
            <ext:Clipboard ID="Clipboard1" runat="server" />
        </Plugins>
        <Buttons>
            <ext:Button runat="server" Text="Output Clipboard's data" Handler="outputClipboardData" />
        </Buttons>
    </ext:GridPanel>

    <h2>Clipboard's data:</h2>

    <ext:Label ID="Label1" runat="server" />
</body>
</html>
