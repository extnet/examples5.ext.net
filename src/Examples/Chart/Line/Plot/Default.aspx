<%@ Page Language="C#" %>

<script runat="server">
    protected void Page_Load(object sender, EventArgs e)
    {
        if (!X.IsAjaxRequest)
        {
            this.Chart1.GetStore().DataSource = this.GetData();
        }
    }

    private static List<Func<double, double>> fn = new List<Func<double, double>>
    {
        delegate (double x) { return Math.Sin(5 * x); },
        delegate (double x) { return x * x * 2 - 1; },
        delegate (double x) { return x * x * x; },
        delegate (double x) { return Math.Cos(10 * x); },
        delegate (double x) { return 2 * x; },
        delegate (double x) { return Math.Pow(x, -2); },
        delegate (double x) { return Math.Pow(x, -3); },
        delegate (double x) { return Math.Tan(5 * x); }
    };

    private object GetData()
    {
        var data = new List<object>();

        var delta = 0.02;
        var cap = 1000;
        var index = Convert.ToInt32(PlotFn.Text);
        PlotFn.Text = (index + 1).ToString();

        var f = fn[index % fn.Count];

        for (double x = -2; x <= 2; x += delta)
        {
            double y = f(x);
            if (y > cap)
            {
                y = cap;
            }

            data.Add(new
            {
                x = x,
                y = y
            });
        }

        return data;
    }

    protected void OnRefresh(object sender, DirectEventArgs e)
    {
        var store = this.Chart1.GetStore();
        store.DataSource = this.GetData();
        store.DataBind();
    }
</script>

<!DOCTYPE html>

<html>
<head runat="server">
    <title>Line Chart - Ext.NET Examples</title>
    <link href="/resources/css/examples.css" rel="stylesheet" />

    <script>
        function resetChart() {
            var chart = this.up('panel').down('cartesian'),
                axes = chart.getAxes();
            axes[0].setVisibleRange([0, 1]);
            axes[1].setVisibleRange([0, 1]);
            chart.redraw();
        }
    </script>
</head>
<body>
    <form runat="server">
        <ext:ResourceManager runat="server" />

        <h1>Line Chart Example</h1>

        <p>This example shows how to create a Plot chart with floating axes linked to each other
         <br/> at the origin. Floating axes can track a value on another axis running in the oppsosite
         <br/> direction. This is handy for visualizing mathematical functions. Try zooming and panning
         <br/> the chart to see the effect.
         <br/>
         <br/> To zoom the chart, use the pinch-in/pinch-out gestures, if you are on a mobile device.
         <br/> Or click and drag, if you are using a desktop browser. Click and drag also acts as a
         <br/> panning gesture on desktops. You can use the Pan/Zoom toggle in the upper-left corner
         <br/> of the chart to switch modes.</p>

        <ext:Hidden ID="PlotFn" runat="server" Text="0" />

        <ext:Panel
            runat="server"
            Width="650"
            Height="550"
            Layout="FitLayout">
            <Listeners>
                <AfterRender Handler="this.down('toolbar').add(this.down('cartesian').getInteractions()[0].getModeToggleButton());" />
            </Listeners>
            <TopBar>
                <ext:Toolbar runat="server">
                    <Items>
                        <ext:ToolbarFill runat="server" />

                        <ext:Button
                            runat="server"
                            Text="Refresh"
                            OnDirectClick="OnRefresh" />

                        <ext:Button
                            runat="server"
                            Text="Preview"
                            Handler="this.up('panel').down('chart').preview();" />

                        <ext:Button
                            runat="server"
                            Text="Reset pan/zoom"
                            Handler="resetChart" />
                    </Items>
                </ext:Toolbar>
            </TopBar>
            <Items>
                <ext:CartesianChart
                    ID="Chart1"
                    runat="server"
                    Padding="10"
                    InsetPadding="0">
                    <Store>
                        <ext:Store runat="server">
                            <Model>
                                <ext:Model runat="server">
                                    <Fields>
                                        <ext:ModelField Name="x" />
                                        <ext:ModelField Name="y" />
                                    </Fields>
                                </ext:Model>
                            </Model>
                        </ext:Store>
                    </Store>

                    <Background Fill="white" />

                    <Interactions>
                        <ext:PanZoomInteraction ZoomOnPanGesture="true" />
                    </Interactions>

                    <Axes>
                        <ext:NumericAxis
                            Position="Left"
                            Fields="y"
                            Grid="true"
                            TitleMargin="20"
                            Minimum="-4"
                            Maximum="4"
                            MinorTickSteps="3">
                            <TitleConfig Text="f(x)" FillStyle="rgb(255, 0, 136)" />
                            <Style MinorTricks="true" MinorTickSize="4" MajorTickSize="7" />
                            <FloatingConfig ValueInt="0" AlongAxisIndex="1" />
                        </ext:NumericAxis>

                        <ext:NumericAxis
                            Position="Bottom"
                            Fields="x"
                            Grid="true"
                            TitleMargin="6"
                            MinorTickSteps="3">
                            <TitleConfig Text="x" FillStyle="rgb(255, 0, 136)" />
                            <Style MinorTricks="true" MinorTickSize="4" MajorTickSize="7" />
                            <FloatingConfig ValueInt="0" AlongAxisIndex="0" />
                        </ext:NumericAxis>
                    </Axes>
                    <Series>
                        <ext:LineSeries
                            XField="x"
                            YField="y">
                            <StyleSpec>
                                <ext:Sprite LineWidth="2" StrokeStyle="rgb(0, 119, 204)" />
                            </StyleSpec>
                        </ext:LineSeries>
                    </Series>
                </ext:CartesianChart>
            </Items>
        </ext:Panel>
    </form>
</body>
</html>
