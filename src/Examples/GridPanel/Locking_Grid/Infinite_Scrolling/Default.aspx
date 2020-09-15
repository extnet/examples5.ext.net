<%@ Page Language="C#" %>

<script runat="server">
    protected void Store_ReadData(object sender, StoreReadDataEventArgs e)
    {
        Store store = (Store)sender;
        List<StockQuotation> data = new List<StockQuotation>();

        int start = e.Start,
            limit = e.Limit;
        Random randow = new Random();
        DateTime now = DateTime.Now;

        bool desc = false;

        if (e.Sort.Length > 0 && e.Sort[0].Direction == Ext.Net.SortDirection.DESC)
        {
            desc = true;
        }

        for (int i = start + 1; i <= start + limit; i++)
        {
            StockQuotation qoute = new StockQuotation()
            {
                Company = "Company " + (desc ? 50000 - i + 1 : i),
                Price = randow.Next(0, 200),
                LastUpdate = now
            };

            data.Add(qoute);
        }

        store.Data = data;
        e.Total = 50000;
    }

    class StockQuotation
    {
        public string Company  { get; set; }
        public int Price { get; set; }
        public DateTime LastUpdate { get; set; }
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Infinite Scroll Grid with lockable columns - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" ScriptMode="Debug" SourceFormatting="true" />

        <h1>Infinite Scrolling</h1>

        <p>Introduced with Ext.Net 2, the Infinite Scrolling support for GridPanels enables you to load any number of records into a grid without paging.</p>
        <p>This grid uses a virtualized scrolling system to handle potentially infinite data sets without any impact on client side performance.</p>
        <p>The number of rendered rows is only just larger than the visible row count. As the edge of the rendered data scrolls towards being in
            view, the table is refreshed, and repositioned to maintain visual scroll position.</p>
        <p>It is not possible to lock or unlock <i>all</i> columns using the user interface. Each side, locked or unlocked must always contain at least one column.</p>

        <ext:GridPanel
            runat="server"
            Width="500"
            Height="500"
            DisableSelection="true"
            Title="Stock Price">
            <Store>
                <ext:Store
                    runat="server"
                    RemoteSort="true"
                    Buffered="true"
                    PageSize="100"
                    OnReadData="Store_ReadData">
                    <Proxy>
                        <ext:PageProxy>
                            <Reader>
                                <ext:JsonReader RootProperty="data" />
                            </Reader>
                        </ext:PageProxy>
                    </Proxy>
                    <Model>
                        <ext:Model runat="server">
                            <Fields>
                                <ext:ModelField Name="Company" />
                                <ext:ModelField Name="Price" />
                                <ext:ModelField Name="LastUpdate" />
                            </Fields>
                        </ext:Model>
                    </Model>
                    <Sorters>
                        <ext:DataSorter Property="Company" Direction="ASC" />
                    </Sorters>
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:RowNumbererColumn
                        runat="server"
                        Lockable="false"
                        Locked="true"
                        Width="50"
                        />
                    <ext:Column
                        runat="server"
                        Text="Company"
                        DataIndex="Company"
                        Width="170"
                        />
                    <ext:Column
                        runat="server"
                        Text="Price, $"
                        DataIndex="Price"
                        Width="170"
                        Sortable="false"
                        Align="Center"
                        />
                    <ext:Column
                        runat="server"
                        Text="Last Update"
                        DataIndex="LastUpdate"
                        Sortable="false"
                        Width="170">
                        <Renderer Format="Date" FormatArgs="'n/j/Y g:i:s A'" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <View>
                <ext:GridView runat="server" TrackOver="false" />
            </View>
            <SelectionModel>
                <ext:RowSelectionModel runat="server" PruneRemoved="false" Mode="Multi" />
            </SelectionModel>
        </ext:GridPanel>
    </form>
</body>
</html>