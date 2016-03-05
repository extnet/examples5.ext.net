<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Store1.DataSource = this.GetData();

            // The initially selected rows
            // You can set rows either by index or ID
            var thisYear = DateTime.Today.Year;
            var selectedData = this.SpreadsheetSelectionModel1.SelectedData;

            selectedData.Rows.Add(new SelectedRow { RowIndex = 0 });
            selectedData.Rows.Add(new SelectedRow { RowIndex = 1 });
            selectedData.Rows.Add(new SelectedRow { RecordID = thisYear.ToString() });

            // The initially selected columns
            // You can set columns either by index or ID or DataIndex
            selectedData = this.SpreadsheetSelectionModel2.SelectedData;

            selectedData.Columns.Add(new SelectedColumn { ColumnDataIndex = "mar" });
            selectedData.Columns.Add(new SelectedColumn { ColumnID = "JuneColumn" });
            selectedData.Columns.Add(new SelectedColumn { ColumnIndex = 7 }); // That is a client side index counting a checkbox and row numberer columns
            selectedData.Columns.Add(new SelectedColumn { ColumnDataIndex = "aug" });


            // The initially selected cells
            // You can set a cell's column either by index or ID or DataIndex
            // You can set a cell's row either by index or ID
            selectedData = this.SpreadsheetSelectionModel3.SelectedData;

            selectedData.RangeStart.ColumnDataIndex = "mar";
            selectedData.RangeStart.RowIndex = 1;

            selectedData.RangeEnd.ColumnDataIndex = "jul";
            selectedData.RangeEnd.RecordID = (thisYear - 1).ToString();
        }
    }

    public List<object> GetData()
    {
        var data = new List<object>();
        var thisYear = DateTime.Today.Year;
        var random = new Random();

        for (int year = thisYear - 4; year <= thisYear; ++year)
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
    <title>Spreadsheet Selection Model Initial Selection - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Spreadsheet Selection Model Initial Selection</h1>

        <p>The example demonstrates how to set up initial selection</p>

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

        <ext:GridPanel
            runat="server"
            StoreID="Store1"
            ColumnLines="true"
            Width="775"
            Title="With initially selected rows"
            Frame="true">
            <SelectionModel>
                <ext:SpreadsheetSelectionModel 
                    ID="SpreadsheetSelectionModel1" 
                    runat="server" 
                    ColumnSelect="true"
                    CheckboxSelect="true" />
            </SelectionModel>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" Text="Year" DataIndex="year" Flex="1" MinWidth="70" />
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
        </ext:GridPanel>

        <ext:GridPanel
            runat="server"
            StoreID="Store1"
            ColumnLines="true"
            Width="775"
            Title="With initially selected columns"
            Frame="true"
            MarginSpec="10 0">
            <SelectionModel>
                <ext:SpreadsheetSelectionModel ID="SpreadsheetSelectionModel2" runat="server" CheckboxSelect="true" />
            </SelectionModel>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" Text="Year" DataIndex="year" Flex="1" MinWidth="70" />
                    <ext:Column runat="server" Text="Jan" DataIndex="jan" Width="50" />
                    <ext:Column runat="server" Text="Feb" DataIndex="feb" Width="50" />
                    <ext:Column runat="server" Text="Mar" DataIndex="mar" Width="50" />
                    <ext:Column runat="server" Text="Apr" DataIndex="apr" Width="50" />
                    <ext:Column runat="server" Text="May" DataIndex="may" Width="50" />
                    <ext:Column ID="JuneColumn" runat="server" Text="Jun" DataIndex="jun" Width="50" />
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
        </ext:GridPanel>

        <ext:GridPanel
            runat="server"
            StoreID="Store1"
            ColumnLines="true"
            Width="775"
            Title="With initially selected cells"
            Frame="true">
            <SelectionModel>
                <ext:SpreadsheetSelectionModel ID="SpreadsheetSelectionModel3" runat="server" CheckboxSelect="true" />
            </SelectionModel>
            <ColumnModel>
                <Columns>
                    <ext:Column runat="server" Text="Year" DataIndex="year" Flex="1" MinWidth="70" />
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
        </ext:GridPanel>
    </form>
</body>
</html>
