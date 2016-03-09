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

    protected void SelectRows(object sender, DirectEventArgs e)
    {
        this.SpreadsheetSelectionModel1.SelectRows(new int[] { 0, 2, 4 });
    }

    protected void DeselectRows(object sender, DirectEventArgs e)
    {
        this.SpreadsheetSelectionModel1.DeselectRows(new int[] { 0, 2, 4 });
    }

    protected void SelectColumns(object sender, DirectEventArgs e)
    {
        this.SpreadsheetSelectionModel1.SelectColumn(new SelectedColumn { ColumnDataIndex = "feb" });
        this.SpreadsheetSelectionModel1.SelectColumn(new SelectedColumn { ColumnDataIndex = "apr" }, true);
        this.SpreadsheetSelectionModel1.SelectColumn("JuneColumn", true);
    }

    protected void DeselectColumns(object sender, DirectEventArgs e)
    {
        this.SpreadsheetSelectionModel1.DeselectColumn(new SelectedColumn { ColumnDataIndex = "feb" });
        this.SpreadsheetSelectionModel1.DeselectColumn(new SelectedColumn { ColumnDataIndex = "apr" });
        this.SpreadsheetSelectionModel1.DeselectColumn("JuneColumn");
    }

    protected void SelectCells(object sender, DirectEventArgs e)
    {
        this.SpreadsheetSelectionModel1.SelectCells(
            new SelectedCell { RowIndex = 1, ColumnDataIndex = "feb" },
            new SelectedCell { RowIndex = 3, ColumnID = "JuneColumn" }
        );
    }

    protected void DeselectAll(object sender, DirectEventArgs e)
    {
        this.SpreadsheetSelectionModel1.DeselectAll();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Spreadsheet Selection Model Select/Deselect Programmatically - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Spreadsheet Selection Model Select/Deselect Programmatically</h1>

        <p>The example is a showcase of API to select/deselect programmatically</p>

        <ext:GridPanel
            runat="server"
            ColumnLines="true"
            Width="775"
            Title="Spreadsheet"
            Frame="true"
            MarginSpec="0 0 10 0">
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
                    CheckboxSelect="true"
                    ColumnSelect="true" />
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
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Select rows" OnDirectClick="SelectRows" />
                        <ext:Button runat="server" Text="Deselect rows" OnDirectClick="DeselectRows" />
                        <ext:Button runat="server" Text="Select columns" OnDirectClick="SelectColumns" />
                        <ext:Button runat="server" Text="Deselect columns" OnDirectClick="DeselectColumns" />
                        <ext:Button runat="server" Text="Select cells" OnDirectClick="SelectCells" />
                        <ext:Button runat="server" Text="Deselect all" OnDirectClick="DeselectAll" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:GridPanel>
    </form>
</body>
</html>
