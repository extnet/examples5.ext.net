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

    protected void Submit(object sender, DirectEventArgs e)
    {
        var selectedData = this.SpreadsheetSelectionModel1.SelectedData;

        if (!selectedData.IsEmpty())
        {
            if (selectedData.Rows.Count > 0)
            {
                this.OutputRows(selectedData.Rows);
            }
            else if (selectedData.Columns.Count > 0)
            {
                this.OutputColumns(selectedData.Columns);
            }
            else
            {
                this.OutputCells(selectedData);
            }
        }
        else
        {
            this.Label1.Html = "<h3>No selection</h3>";
        }
    }

    public void AddHeaderCell(StringBuilder sb, string value)
    {
        sb.Append("<td style='white-space:nowrap;font-weight:bold;'>");
        sb.Append(value);
        sb.Append("</td>");
    }

    public void AddCell(StringBuilder sb, string value)
    {
        sb.Append("<td style='white-space:nowrap;'>");
        sb.Append(value);
        sb.Append("</td>");
    }

    protected void OutputRows(SelectedRowCollection rows)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<table width='100%' cellspacing='5'>");
        bool addHeader = true;

        foreach (SelectedRow rowd in rows)
        {
            if (addHeader)
            {
                sb.Append("<tr>");
                this.AddHeaderCell(sb, "RecordID");
                this.AddHeaderCell(sb, "RowIndex");
                sb.Append("</tr>");

                addHeader = false;
            }

            sb.Append("<tr>");

            this.AddCell(sb, rowd.RecordID);
            this.AddCell(sb, rowd.RowIndex.ToString());

            sb.Append("</tr>");
        }

        sb.Append("</table>");
        this.Label1.Html = sb.ToString();
    }

    protected void OutputColumns(SelectedColumnCollection columns)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<table width='100%' cellspacing='5'>");
        bool addHeader = true;

        foreach (SelectedColumn columnd in columns)
        {
            if (addHeader)
            {
                sb.Append("<tr>");
                this.AddHeaderCell(sb, "ColumnID");
                this.AddHeaderCell(sb, "ColumnDataIndex");
                this.AddHeaderCell(sb, "ColumnIndex");
                sb.Append("</tr>");

                addHeader = false;
            }

            sb.Append("<tr>");

            this.AddCell(sb, columnd.ColumnID);
            this.AddCell(sb, columnd.ColumnDataIndex);
            this.AddCell(sb, columnd.ColumnIndex.ToString());

            sb.Append("</tr>");
        }

        sb.Append("</table>");
        this.Label1.Html = sb.ToString();
    }

    protected void OutputCells(SpreadsheetSelectedData selectedData)
    {
        StringBuilder sb = new StringBuilder();
        sb.Append("<table width='100%' cellspacing='5'>");

        sb.Append("<tr>");
        this.AddHeaderCell(sb, "Range");
        this.AddHeaderCell(sb, "RowIndex");
        this.AddHeaderCell(sb, "RecordID");
        this.AddHeaderCell(sb, "ColumnID");
        this.AddHeaderCell(sb, "ColumnDataIndex");
        this.AddHeaderCell(sb, "ColumnIndex");
        sb.Append("</tr>");

        sb.Append("<tr>");
        this.AddCell(sb, "Start");
        this.AddCell(sb, selectedData.RangeStart.RowIndex.ToString());
        this.AddCell(sb, selectedData.RangeStart.RecordID);
        this.AddCell(sb, selectedData.RangeStart.ColumnID);
        this.AddCell(sb, selectedData.RangeStart.ColumnDataIndex);
        this.AddCell(sb, selectedData.RangeStart.ColumnIndex.ToString());
        sb.Append("</tr>");

        sb.Append("<tr>");
        this.AddCell(sb, "End");
        this.AddCell(sb, selectedData.RangeEnd.RowIndex.ToString());
        this.AddCell(sb, selectedData.RangeEnd.RecordID);
        this.AddCell(sb, selectedData.RangeEnd.ColumnID);
        this.AddCell(sb, selectedData.RangeEnd.ColumnDataIndex);
        this.AddCell(sb, selectedData.RangeEnd.ColumnIndex.ToString());
        sb.Append("</tr>");

        sb.Append("</table>");
        this.Label1.Html = sb.ToString();
    }

    protected void SubmitWithValues(object sender, DirectEventArgs e)
    {
        string json = e.ExtraParams["Values"];

        Dictionary<string, string>[] values = JSON.Deserialize<Dictionary<string, string>[]>(json);

        if (values.Length > 0)
        {

            StringBuilder sb = new StringBuilder();
            sb.Append("<table width='100%' cellspacing='15'>");
            bool addHeader = true;

            foreach (Dictionary<string, string> row in values)
            {
                if (addHeader)
                {
                    sb.Append("<tr>");
                    foreach (KeyValuePair<string, string> keyValuePair in row)
                    {
                        sb.Append("<td style='white-space:nowrap;font-weight:bold;'>");

                        sb.Append(keyValuePair.Key);

                        sb.Append("</td>");
                    }
                    sb.Append("</tr>");

                    addHeader = false;
                }

                sb.Append("<tr>");

                foreach (KeyValuePair<string, string> keyValuePair in row)
                {
                    sb.Append("<td style='white-space:nowrap;'>");

                    sb.Append(keyValuePair.Value);

                    sb.Append("</td>");
                }

                sb.Append("</tr>");
            }

            sb.Append("</table>");
            this.Label1.Html = sb.ToString();
        }
        else
        {
            this.Label1.Html = "<h3>No selection</h3>";
        }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Spreadsheet Selection Model Submit - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Spreadsheet Selection Model Submit</h1>

        <p>The example demonstrates how to submit the SpreadsheetSelectionModel selected data</p>

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
                        <ext:Model runat="server">
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
                    />
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
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button runat="server" Text="Submit" OnDirectClick="Submit" />
                        <ext:Button runat="server" Text="Submit with values">
                            <DirectEvents>
                                <Click
                                    OnEvent="SubmitWithValues">
                                    <ExtraParams>
                                        <ext:Parameter
                                            Name="Values"
                                            Value="App.SpreadsheetSelectionModel1.getSubmitData({ excludeId: true })"
                                            Mode="Raw"
                                            Encode="true"
                                            />
                                    </ExtraParams>
                                </Click>
                            </DirectEvents>
                        </ext:Button>
                    </Items>
                </ext:Toolbar>
            </TopBar>
        </ext:GridPanel>

        <div style="width: 763px; border: 1px solid gray; padding: 5px; margin-top: 10px;">
            <ext:Label ID="Label1" runat="server" Html="<h3>Submitted data will be shown here</h3>" />
        </div>
    </form>
</body>
</html>
