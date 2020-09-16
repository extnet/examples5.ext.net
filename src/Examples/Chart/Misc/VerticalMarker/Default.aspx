<%@ Page Language="C#" %>

<script runat="server">
    public object TimeData
    {
        get
        {
            DateTime date = DateTime.MinValue;
            int visits = 0;

            List<object> data = new List<object>(100);
            Random random = new Random();

            for (int i = 0; i < 100; i++)
            {
                date = i > 0 ? date.AddDays(1) : new DateTime(2011, 1, 1);
                visits = Math.Max(Convert.ToInt32(Math.Min(100, Math.Max(i > 0 ? (visits + (random.NextDouble() - 0.5) * 20) : random.NextDouble() * 100, 0))), 20);

                data.Add(new
                {
                    Date = date,
                    Visits = visits
                });
            }

            return data;
        }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        this.Chart1.GetStore().DataSource = this.TimeData;
        this.Chart2.GetStore().DataSource = Ext.Net.Examples.ChartData.GenerateData();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Line Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />
</head>
<body style="padding:60px;">
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>VerticalMarker plugin</h1>

        <p>This plugin supports line series only</p>

        <ext:Panel
            runat="server"
            Title="Chart with VerticalMarker"
            Width="960"
            Height="600"
            Layout="Fit">
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    StyleSpec="background:#fff;"
                    Animate="true">
                    <Plugins>
                        <ext:VerticalMarker runat="server" Buffer="200">
                            <XLabelRenderer Handler="return Ext.util.Format.date(value, 'd M Y');" />
                        </ext:VerticalMarker>
                    </Plugins>
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Date" Type="Date" />
                                        <ext:ModelField Name="Visits" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="Visits"
                            Title="Number of Hits"
                            Minimum="0"
                            Maximum="100">
                        </ext:NumericAxis>
                    </Axes>
                    <Series>
                        <ext:LineSeries
                            XField="Date"
                            YField="Visits"
                            Smooth="3"
                            ShowMarkers="false">
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>

        <br />

        <ext:Panel
            runat="server"
            Title="VerticalMarker with Snap and multiple series"
            Width="960"
            Height="600"
            Layout="Fit">
            <Items>
                <ext:CartesianChart
                    ID="Chart2"
                    runat="server"
                    StyleSpec="background:#fff;"
                    Shadow="true"
                    StandardTheme="Category1"
                    Animate="true">
                    <Plugins>
                        <ext:VerticalMarker runat="server" ShowXLabel="false" Snap="true" />
                    </Plugins>
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="Name" />
                                        <ext:ModelField Name="Data1" />
                                        <ext:ModelField Name="Data2" />
                                        <ext:ModelField Name="Data3" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="Data1,Data2,Data3"
                            Title="Number of Hits"
                            MinorTickSteps="1"
                            Minimum="0">
                            <GridConfig>
                                <Odd Opacity="1" FillStyle="#ddd" StrokeStyle="#bbb" LineWidth="0.5" />
                            </GridConfig>
                        </ext:NumericAxis>

                        <ext:CategoryAxis Position="Bottom" Fields="Name" Title="Month of the Year">
                            </ext:CategoryAxis>
                    </Axes>
                    <Series>
                        <ext:LineSeries XField="Name" YField="Data1">
                            <HighlightConfig>
                                <ext:CircleSprite Radius="7" />
                            </HighlightConfig>
                            <Marker>
                                <ext:Sprite SpriteType="Cross" Radius="4" LineWidth="0" />
                            </Marker>
                        </ext:LineSeries>

                        <ext:LineSeries Smooth="3" XField="Name" YField="Data2">
                            <HighlightConfig>
                                <ext:CircleSprite Radius="7" />
                            </HighlightConfig>
                            <Marker>
                                <ext:Sprite SpriteType="Circle" Radius="4" LineWidth="0" />
                            </Marker>
                        </ext:LineSeries>

                        <ext:LineSeries Smooth="3" XField="Name" YField="Data3">
                            <HighlightConfig>
                                <ext:CircleSprite Radius="7" />
                            </HighlightConfig>
                            <Marker>
                                <ext:Sprite SpriteType="Circle" Radius="4" LineWidth="0" />
                            </Marker>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>