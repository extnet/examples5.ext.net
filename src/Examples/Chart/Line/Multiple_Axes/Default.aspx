<%@ Page Language="C#" %>

<script runat="server">
    private List<object> GenerateData()
    {
        List<object> data = new List<object>();
        Random random = new Random();
        double p = (random.NextDouble() * 11) + 1;
        DateTime date = DateTime.Today;

        for (int i = 0; i < 15; i++)
        {
            data.Add(new
            {
                Date = date.AddDays(i),
                Data1 = Math.Round(random.NextDouble() * 10),
                Data2 = Math.Round(random.NextDouble() * 100)
            });
        }

        return data;
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Chart1.GetStore().DataSource = this.GenerateData();
        }
    }

    protected void ReloadData(object sender, DirectEventArgs e)
    {
        Store store = this.Chart1.GetStore();

        store.DataSource = GenerateData();
        store.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Line Chart With Multiple Axes - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var saveChart = function (btn) {
            Ext.MessageBox.confirm('Confirm Download', 'Would you like to download the chart as an image?', function (choice) {
                if (choice == 'yes') {
                    btn.up('panel').down('chart').download();
                }
            });
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Line Chart With Multiple Axes</h1>

        <p>Display 2 sets of random data in the two line series which are referring different axes (Y). Reload data will randomly generate a new set of data in the store. Click on the legend items to remove them from the chart.</p>

        <ext:Panel
            runat="server"
            Title="Line Chart"
            Width="960"
            Height="480"
            Layout="Fit">
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:Button
                            runat="server"
                            Text="Reload Data"
                            IconCls="x-md md-icon-refresh"
                            OnDirectClick="ReloadData"
                            />

                        <ext:Button
                            runat="server"
                            Text="Save Chart"
                            IconCls="x-md md-icon-save"
                            Handler="saveChart"
                            />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    Animate="true">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Date" Type="Date" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:TimeAxis
                            Title="Date"
                            Fields="Date"
                            Position="Bottom"
                            DateFormat="MMM dd"
                            FromDate="<%# DateTime.Today %>"
                            ToDate="<%# DateTime.Today.AddDays(14) %>"
                            AutoDataBind="true"
                            />

                        <ext:NumericAxis
                            Title="Data (blue)"
                            Fields="Data1"
                            Position="Left"
                            Maximum="10">
                            <TitleConfig FillStyle="#115fa6" />
                            <Label FillStyle="#115fa6" />
                        </ext:NumericAxis>

                        <ext:NumericAxis
                            Title="Data (green)"
                            Fields="Data2"
                            Position="Right"
                            Maximum="100">
                            <TitleConfig FillStyle="#94ae0a" />
                            <Label FillStyle="#94ae0a" />
                        </ext:NumericAxis>
                    </Axes>
                    <Series>
                        <ext:LineSeries
                            Titles="Blue Line"
                            XField="Date"
                            YField="Data1"
                            Smooth="3">
                            <HighlightConfig>
                                <ext:CircleSprite Radius="7" />
                            </HighlightConfig>
                            <Marker>
                                <ext:CircleSprite Radius="4" LineWidth="0" />
                            </Marker>
                        </ext:LineSeries>

                        <ext:LineSeries
                            Titles="Green Line"
                            XField="Date"
                            YField="Data2"
                            Smooth="3">
                            <HighlightConfig>
                                <ext:CircleSprite Radius="7" />
                            </HighlightConfig>
                            <Marker>
                                <ext:CircleSprite Radius="4" LineWidth="0" />
                            </Marker>
                        </ext:LineSeries>
                    </Series>
                    <Plugins>
                        <ext:VerticalMarker runat="server">
                            <XLabelRenderer Handler="return Ext.util.Format.date(value, 'M d');" />
                        </ext:VerticalMarker>
                    </Plugins>
                    <LegendConfig runat="server" Dock="Bottom" />
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>