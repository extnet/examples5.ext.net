<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.GetData();
        }
    }

    public List<object> GetData()
    {
        var data = new List<object>();
        var thisYear = DateTime.Today.Year;
        var random = new Random();

        for (int year = 1900; year <= thisYear; ++year)
        {
            data.Add(new object[]
            {
                year,
                this.GetRandomNumber(-10, 100, random),
                this.GetRandomNumber(-10, 100, random),
                this.GetRandomNumber(-10, 200, random),
                this.GetRandomNumber(-10, 200, random),
                this.GetRandomNumber(-10, 200, random),
                this.GetRandomNumber(-10, 300, random),
                this.GetRandomNumber(-10, 300, random),
                this.GetRandomNumber(-10, 300, random),
                this.GetRandomNumber(-10, 600, random),
                this.GetRandomNumber(-10, 500, random),
                this.GetRandomNumber(-10, 200, random),
                this.GetRandomNumber(-10, 100, random)
            });
        }

        return data;
    }

    public int GetRandomNumber(int min, int max, Random r)
    {
        return (int)Math.Floor(r.NextDouble() * (max - min)) + min;
    }

    protected void ReloadData(object sender, DirectEventArgs e)
    {
        this.Store1.DataSource = this.GetData();
        this.Store1.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Spreadsheet Selection Model with Locking GridPanel - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var onSelectionChange = function (grid, selection) {
            var status = App.Status,
                message = '??',
                firstRowIndex,
                firstColumnIndex,
                lastRowIndex,
                lastColumnIndex;

            if (!selection) {
                message = 'No selection';
            } else if (selection.isCells) {
                firstRowIndex = selection.getFirstRowIndex();
                firstColumnIndex = selection.getFirstColumnIndex();
                lastRowIndex = selection.getLastRowIndex();
                lastColumnIndex = selection.getLastColumnIndex();

                message = 'Selected cells: ' + (lastColumnIndex - firstColumnIndex + 1) + 'x' + (lastRowIndex - firstRowIndex + 1) +
                    ' at (' + firstColumnIndex + ',' + firstRowIndex + ')';
            } else if (selection.isRows) {
                message = 'Selected rows: ' + selection.getCount();
            } else if (selection.isColumns) {
                message = 'Selected columns: ' + selection.getCount();
            }

            status.update(message);
        };

        var toggleRowSelect = function (button, pressed) {
            App.SpreadsheetSelectionModel1.setRowSelect(pressed);
        };

        var toggleCellSelect = function (button, pressed) {
            App.SpreadsheetSelectionModel1.setCellSelect(pressed);
        };

        var toggleColumnSelect = function (button, pressed) {
            App.SpreadsheetSelectionModel1.setColumnSelect(pressed);
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Spreadsheet Selection Model with Locking GridPanel</h1>

        <p>Supported features:</p>

        <ul>
            <li>Single / Range / Multiple individual row selection.</li>
            <li>Single / Range cell selection.</li>
            <li>Column selection by click selecting column headers.</li>
            <li>Select / deselect all by clicking in the top-left, header.</li>
            <li>Adds row number column to enable row selection.</li>
            <li>Selection extensibility using a drag gesture. Configured in this case to be up or down.</li>
            <li>Copy/paste to system clipboard using CTRL+C, CTRL+X and CTRL+V.</li>
        </ul>

        <ext:GridPanel
            runat="server"
            ColumnLines="true"
            Height="480"
            Width="775"
            Title="Spreadsheet"
            Frame="true">
            <Store>
                <ext:Store ID="Store1" runat="server">
                    <Model>
                        <ext:Model runat="server" IDProperty="year">
                            <Fields>
                                <ext:ModelField Name="year" />
                                <ext:ModelField Name="jan" />
                                <ext:ModelField Name="feb" />
                                <ext:ModelField Name="mar" />
                                <ext:ModelField Name="apr" />
                                <ext:ModelField Name="may" />
                                <ext:ModelField Name="jun" />
                                <ext:ModelField Name="jul" />
                                <ext:ModelField Name="aug" />
                                <ext:ModelField Name="sep" />
                                <ext:ModelField Name="oct" />
                                <ext:ModelField Name="nov" />
                                <ext:ModelField Name="dec" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Reader>
                        <ext:ArrayReader />
                    </Reader>
                </ext:Store>
            </Store>
            <SelectionModel>
                <ext:SpreadsheetSelectionModel
                    ID="SpreadsheetSelectionModel1"
                    runat="server"
                    ColumnSelect="true"
                    CheckboxSelect="true"
                    PruneRemoved="false"
                    Extensible="Y"
                    />
            </SelectionModel>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" Text="Year" DataIndex="year" Width="70" MinWidth="70" Locked="true" />
                    <ext:Column runat="server" Text="Jan" DataIndex="jan" Width="50" />
                    <ext:Column runat="server" Text="Feb" DataIndex="feb" Width="50" />
                    <ext:Column runat="server" Text="Mar" DataIndex="mar" Width="50" />
                    <ext:Column runat="server" Text="Apr" DataIndex="apr" Width="50" />
                    <ext:Column runat="server" Text="May" DataIndex="may" Width="50" />
                    <ext:Column runat="server" Text="Jun" DataIndex="jun" Width="50" />
                    <ext:Column runat="server" Text="Jul" DataIndex="jul" Width="50" />
                    <ext:Column runat="server" Text="Aug" DataIndex="aug" Width="50" />
                    <ext:Column runat="server" Text="Sep" DataIndex="sep" Width="50" />
                    <ext:Column runat="server" Text="Oct" DataIndex="oct" Width="50" />
                    <ext:Column runat="server" Text="Nov" DataIndex="nov" Width="50" />
                    <ext:Column runat="server" Text="Dec" DataIndex="dec" Width="50" />
                </Columns>
            </ColumnModel>
            <ViewConfig TrackOver="false" />
            <Tools>
                <ext:Tool Type="Refresh" ToolTip="Reload Data" OnDirectClick="ReloadData" />
            </Tools>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Component runat="server" Html="Selectable:" />

                        <ext:Button
                            runat="server"
                            Text="Rows"
                            EnableToggle="true"
                            ToggleHandler="toggleRowSelect"
                            Pressed="true"
                            />

                        <ext:Button
                            runat="server"
                            Text="Cells"
                            EnableToggle="true"
                            ToggleHandler="toggleCellSelect"
                            Pressed="true"
                            />

                        <ext:Button
                            runat="server"
                            Text="Columns"
                            EnableToggle="true"
                            ToggleHandler="toggleColumnSelect"
                            Pressed="true"
                            />

                        <ext:ToolbarFill runat="server" />

                        <ext:Component ID="Status" runat="server" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Listeners>
                <SelectionChange Fn="onSelectionChange" />
            </Listeners>
            <Plugins>
                <ext:Clipboard runat="server" />
                <ext:SelectionReplicator runat="server" />
            </Plugins>
        </ext:GridPanel>
    </form>
</body>
</html>
