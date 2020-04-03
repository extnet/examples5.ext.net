<%@ Page Language="C#" %>

<script runat="server">
    public class StockPrice
    {
        public DateTime Time { get; set; }
        public double Open { get; set; }
        public double High { get; set; }
        public double Low { get; set; }
        public double Close { get; set; }
    }

    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Session["seed"] = 1.4;
            this.Store1.Data = this.GenerateData();
        }
    }

    private double Random()
    {
        double seed = (double)this.Session["seed"];

        seed *= 42.7;
        seed -= Math.Floor(seed);
        this.Session["seed"] = seed;

        return seed * 2 - 1;
    }

    private List<StockPrice> GenerateData(int count = 1000)
    {
        List<StockPrice> data = new List<StockPrice>();
        StockPrice record = new StockPrice
        {
            Time = DateTime.Parse("Jan 1 2010"),
            Close = 600
        };

        for (int i = 0; i < count; i++)
        {
            var ohlc = new double[] { this.Random() * 25, this.Random() * 25, this.Random() * 25 };

            record = new StockPrice
            {
                Time = record.Time.AddHours(1),
                Open = record.Close,
                High = record.Close + Math.Max(Math.Max(ohlc[0], ohlc[1]), ohlc[2]),
                Low = record.Close + Math.Min(Math.Min(ohlc[0], ohlc[1]), ohlc[2]),
                Close = record.Close + ohlc[1]
            };

            if (record.Open < record.Low)
            {
                record.Low = record.Open;
            }
            else if (record.Open > record.High)
            {
                record.High = record.Open;
            }

            data.Add(record);
        }

        return data;
    }

    protected void Store1_ReadData(object sender, StoreReadDataEventArgs e)
    {
        this.Store1.Data = this.GenerateData();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>OHLC Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        var onBeforeRender = function () {
            var chart = this.down('cartesian'),
                panzoom = chart.getInteractions()[0];

            this.down('toolbar').add(panzoom.getModeToggleButton());
        };

        var refresh = function () {
            var chart = this.up('panel').down('cartesian'),
                store = chart.getStore();

            store.reload();
        };

        var toggle = function (segmentedButton, button, pressed) {
            var chart = this.up('panel').down('cartesian'),
                interactions = chart.getInteractions(),
                value = segmentedButton.getValue();

            interactions[0].setEnabled(value === 1);
            interactions[1].setEnabled(value === 0);
        };

        var reset = function () {
            var chart = this.up('panel').down('cartesian'),
                axes = chart.getAxes();

            axes[0].setVisibleRange([0, 1]);
            axes[1].setVisibleRange([0, 0.3]);
            chart.redraw();
        };
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>OHLC Chart Sample</h1>

        <p>
            This example shows how to create an OHLC chart. OHLC charts are financial charts that
            allow one to visualize the open/high/low/close values of a stock.
        </p>

        <p>
            The example makes use of two interactions: 'crosshair' (default) and 'panzoom'. The gear
            icon can be used to switch between the two.
        </p>

        <ext:Panel runat="server" Width="650" Layout="Fit">
            <Listeners>
                <BeforeRender Fn="onBeforeRender" />
            </Listeners>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />
                        <ext:Button runat="server" Text="Refresh" Handler="refresh" />
                        <ext:SegmentedButton runat="server" Width="200">
                            <Defaults>
                                <ext:Parameter Name="ui" Value="default-toolbar" Mode="Value" />
                            </Defaults>
                            <Items>
                                <ext:Button runat="server" Text="Crosshair" Pressed="true" />
                                <ext:Button runat="server" Text="Pan/Zoom" />
                            </Items>
                            <Listeners>
                                <Toggle Fn="toggle" />
                            </Listeners>
                        </ext:SegmentedButton>
                        <ext:Button runat="server" Text="Reset pan/zoom" Handler="reset" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart runat="server" Height="500" InsetPadding="20">
                    <Background Fill="white" />
                    <Store>
                        <ext:Store ID="Store1" runat="server" OnReadData="Store1_ReadData">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="time" Mapping="Time" Type="Date" />
                                        <ext:ModelField Name="open" Mapping="Open" Type="Float" />
                                        <ext:ModelField Name="high" Mapping="High" Type="Float" />
                                        <ext:ModelField Name="low" Mapping="Low" Type="Float" />
                                        <ext:ModelField Name="close" Mapping="Close" Type="Float" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>
                    <Interactions>
                        <ext:PanZoomInteraction Enabled="false" ZoomOnPan="false">
                            <Axes>
                                <LeftAxis AllowPan="false" AllowZoom="false" />
                                <BottomAxis AllowPan="true" AllowZoom="true" />
                            </Axes>
                        </ext:PanZoomInteraction>
                        <ext:CrosshairInteraction>
                            <Axes>
                                <Label FillStyle="white" />
                                <Rect FillStyle="#344459" Opacity="0.7" Radius="5" />
                            </Axes>
                        </ext:CrosshairInteraction>
                    </Interactions>
                    <Series>
                        <ext:CandleStick
                            XField="time"
                            OpenField="open"
                            HighField="high"
                            LowField="low"
                            CloseField="close">
                            <StyleSpec>
                                <ext:SeriesSprite BarWidth="10" Opacity="0.9" OhlcType="ohlc">
                                    <DropStyle FillStyle="rgb(237,123,43)" StrokeStyle="rgb(237,123,43)" />
                                    <RaiseStyle FillStyle="rgb(55,153,19)" StrokeStyle="rgb(55,153,19)" />
                                </ext:SeriesSprite>
                            </StyleSpec>
                        </ext:CandleStick>
                    </Series>
                    <Axes>
                        <ext:NumericAxis
                            Fields="open,high,low,close"
                            Position="Left"
                            Maximum="1000"
                            Minimum="0" />

                        <ext:TimeAxis Fields="time" Position="Bottom" VisibleRange="0,0.3" />
                    </Axes>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
