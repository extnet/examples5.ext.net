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

        for (int i = start + 1; i <= start + limit; i++)
        {
            StockQuotation qoute = new StockQuotation()
            {
                Company = "Company " + i,
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
    <title>Infinite Scrolling - Ext.NET Examples</title>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Infinite Scrolling</h1>

        <p>Introduced with Ext.Net 2, the Infinite Scrolling support for GridPanels enables you to load any number of records into a grid without paging.</p>
        <p>The grid uses a virtualized scrolling system to handle potentially infinite data sets without any impact on client side performance.</p>
        <p>Also, a paging-aware Ext.data.BufferedStore makes the grid load only the required number of records to be shown in the grid view, respecting the leading and trailing records buffer for smoother scrolling..</p>

        <ext:GridPanel
            ID="GridPanel1"
            runat="server"
            Width="500"
            Height="500"
            DisableSelection="true"
            Title="Stock Price">
            <Store>
                <ext:Store
                    ID="Store1"
                    runat="server"
                    Buffered="true"
                    PageSize="200"
                    TrailingBufferZone="10"
                    LeadingBufferZone="10"
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
                </ext:Store>
            </Store>
            <ColumnModel runat="server">
                <Columns>
                    <ext:RowNumbererColumn
                        runat="server"
                        Width="50" />
                    <ext:Column
                        runat="server"
                        Text="Company"
                        DataIndex="Company"
                        Flex="1" />
                    <ext:Column
                        runat="server"
                        Text="Price, $"
                        DataIndex="Price"
                        Width="70"
                        Align="Center" />
                    <ext:Column
                        runat="server"
                        Text="Last Update"
                        DataIndex="LastUpdate"
                        Width="160">
                        <Renderer Format="Date" FormatArgs="'n/j/Y g:i:s A'" />
                    </ext:Column>
                </Columns>
            </ColumnModel>
            <ViewConfig TrackOver="false" />
        </ext:GridPanel>
    </form>
</body>
</html>